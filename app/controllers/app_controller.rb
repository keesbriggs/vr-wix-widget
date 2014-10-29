require 'faraday' # only necessary if savetoken method is present
require 'json'    # only necessary if savetoken method is present

class AppController < ActionController::Base

  skip_before_filter :require_instance, :only => :savetoken
  skip_before_filter :get_request_key, :only => :savetoken

  before_filter :require_instance
  before_filter :get_request_key
  
  def widget
    # this loads first, before settings page.
    # let's create a widget object here.
    @widget = @widget || Widget.create({ comp_id: params[:compId], instance_id: params[:parsed_instance][:instance_id] })
    puts "KEES: inside widget - params are #{params.inspect}"
    value = Settings.find_or_create_by_key(@key).value || '{}'
    @settings = value.html_safe
  end
  
  def settings
    puts "KEES: inside settings - params are #{params.inspect}"
    @instance = params[:instance]
    # we need to know a few things:
    # - is the user authenticated against oauth?
    # - if so, what are their contact lists?
    # - which contact list will the user want customers to sign up with
    value = Settings.find_or_create_by_key(@key).value || '{}'
    @settings = value.html_safe
  end
  
  def settingsupdate
    puts "KEES: inside settingsupdate - params are #{params.inspect}"
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

      conn = Faraday.new(:url => 'https://vrapi.verticalresponse.com') do |c|
        c.use Faraday::Request::UrlEncoded  
        c.use Faraday::Response::Logger     
        c.use Faraday::Adapter::NetHttp    
      end

      response = conn.post "/api/v1/oauth/access_token", { 
        client_id: client_id, 
        client_secret: client_secret, 
        code: @auth_code, redirect_uri: "https://vr-wix-widget.herokuapp.com/savetoken" 
      }
      response_json = JSON.parse(response.body)
      user = User.create({ vr_user_id: response_json['user_id'], access_token: response_json['access_token'] })
    end
  end

  private

  def require_instance
    @instance = params[:parsed_instance]
  end
  
  def get_request_key
    @key = @instance['instance_id'] + ':'
    
    if (params[:origCompId])
      @key = @key + params[:origCompId]
    else
      @key = @key + params[:compId]
    end
    @key
  end
  
end


