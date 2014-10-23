class AppController < ActionController::Base

  skip_before_filter :require_instance, :only => :savetoken
  skip_before_filter :get_request_key, :only => :savetoken

  before_filter :require_instance
  before_filter :get_request_key
  
  def widget
    value = Settings.find_or_create_by_key(@key).value || '{}'
    @settings = value.html_safe
  end
  
  def settings
    puts "KEES: @key is #{@key.inspect}"
    puts "KEES: inside #settings - params are #{params.inspect}"
    @instance = params[:instance]
    value = Settings.find_or_create_by_key(@key).value || '{}'
    @settings = value.html_safe
  end
  
  def settingsupdate
    @settings = Settings.find_or_create_by_key(@key)
    @settings.update_attributes(:value => params[:settings])
    
    render :json => {}, :status => 200
  end

  # def savetoken
  #   puts "KEES: inside #savetoken - params are #{params.inspect}"
  #   #@settings = Settings.find_by_key(@key)
  #   puts "KEES: @settings is #{@settings.inspect}"
  #   value = @settings.value
  #   value = value.merge! params[:code] 
  #   @settings.update_attributes(:value => value)
  #   @settings = value.html_safe
  # end

  def savetoken
    if params[:code]
      puts "KEES: inside #savetoken - params are #{params.inspect}"
      # we need to return to this page as other pages are unauthorized.
      client_id = "139aadd7-8703-adde-c4f9-afbb8c7bd505"
      client_secret = "c82ef042-6c35-4ed6-a438-84cdc2a7c119"
      @auth_code = params[:code]
      @post = "https://vrapi.verticalresponse.com/api/v1/oauth/access_token?client_id=#{client_id}&client_secret=#{client_secret}&redirect_uri=https://vr-wix-widget.herokuapp.com/savetoken?&code=#{@auth_code}"
      puts "KEES: redirecting to #{@post}"
      redirect_to @post, status: 302
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


