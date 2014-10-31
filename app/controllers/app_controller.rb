require 'faraday' # only necessary if savetoken method is present
require 'json'    # only necessary if savetoken method is present

class AppController < ActionController::Base

  before_filter :require_instance
  before_filter :get_request_key

  skip_before_filter :require_instance, :only => [:savetoken, :preview]
  skip_before_filter :get_request_key, :only => [:savetoken, :preview]

  def preview
    @widget = @widget || Widget.create({ comp_id: "test", instance_id: "test" })
    @settings = @widget.to_json.html_safe
    render 'widget'
  end

  def widget
    # this loads first, before settings page.
    # let's create a widget object here.
    @widget = @widget || Widget.create({ comp_id: params[:compId], instance_id: params[:parsed_instance][:instance_id] })
    session[:widget_id] = @widget.id
    #value = Settings.find_or_create_by_key(@key).value || '{}'
    #@settings = value.html_safe
    
    # Return the properties from the Widget class instead of Settings class
    # TODO: this needs testing on wix editor, upon failure replace with the couple of commented lines above
    @settings = @widget.to_json.html_safe
  end
  
  def settings
    @instance = params[:instance]
    # we need to know a few things:
    # - is the user authenticated against oauth?
    # - if so, what are their contact lists?
    # - which contact list will the user want customers to sign up with

    if session[:user_id]
      @user = User.find(session[:user_id])

      conn = Faraday.new(:url => 'https://vrapi.verticalresponse.com') do |c|
        c.use Faraday::Request::UrlEncoded  
        c.use Faraday::Response::Logger     
        c.use Faraday::Adapter::NetHttp    
      end

      response = conn.get do |req|
        req.url "/api/v1/lists"
        req.headers['Authorization'] = "Bearer #{@user.access_token}"
      end
      response_json = JSON.parse(response.body)

      puts "KEES: inside SETTINGS - response_json is #{response_json}"
      
      @lists = @lists || []
      response_json["items"].each do |list|
        puts "KEES: inside SETTINGS loop - list is #{list.inspect}"
        @lists << List.new({ name: list["attributes"]["name"], is_public: list["attributes"]["is_public"], public_name: list["attributes"]["public_name"] })
      end
      puts "KEES: inside SETTINGS - @lists is #{@lists.inspect}"
    end      

    value = Widget.find_or_create_by_comp_id_and_instance_id(@comp_id, @instance_id).to_json
    @settings = value.html_safe
  end
  
  def settingsupdate
    @settings = Settings.find_or_create_by_key(@key)
    @settings.update_attributes(:value => params[:settings])
    
    render :json => {}, :status => 200
  end

  def savetoken

    if params[:code]
      # we need to return to this page as other pages are unauthorized.
      client_id = "bruvqhpp3rsp7fwr9vysc8yz"
      client_secret = "T4skBaDmAfkJkZjFg9jbfYHR" 
      @auth_code = params[:code]
      widget = Widget.find(session[:widget_id]) 

      conn = Faraday.new(:url => 'https://vrapi.verticalresponse.com') do |c|
        c.use Faraday::Request::UrlEncoded  
        c.use Faraday::Response::Logger     
        c.use Faraday::Adapter::NetHttp    
      end

      response = conn.post "/api/v1/oauth/access_token", { 
        client_id: client_id, 
        client_secret: client_secret, 
        code: @auth_code, redirect_uri: "https://vr-wix-widget.herokuapp.com/savetoken" # TODO: encode the redirect_uri per Esteban
      }
      response_json = JSON.parse(response.body)

      user = User.create({ vr_user_id: response_json['user_id'], access_token: response_json['access_token'] })
      session[:user_id] = user.id
      widget.update_attributes!(user_id: user.id)
    end
  end

  private

  def require_instance
    @instance = params[:parsed_instance]
  end
  
  def get_request_key
    @key = @instance['instance_id'] + ':'
    @instance_id = @instance['instance_id']
    
    if (params[:origCompId])
      @key = @key + params[:origCompId]
      @comp_id = params[:origCompId]
    else
      @key = @key + params[:compId]
      @comp_id = params[:compId]
    end
    @key
  end
  
end
