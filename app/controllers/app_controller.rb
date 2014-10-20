class AppController < ActionController::Base

  before_filter :require_instance
  before_filter :get_request_key
  
  def widget
    value = Settings.find_or_create_by_key(@key).value || '{}'
    @settings = value.html_safe
  end
  
  def settings
    if params[:code]
      # we need to return to this page as other pages are unauthorized.
      @auth_code = params[:code]
      @post = "https://vrapi.verticalresponse.com/api/v1/oauth/access_token?client_id=abcdh2wvxxdrw5zanb6wryhc&client_secret=abbcRjmGDCYqRGuyWAs5yJ4C&redirect_uri=https://vr-wix-widget.herokuapp.com/settings&code=#{@auth_code}"
      redirect_to post_url(@post), status: 302
    end
    value = Settings.find_or_create_by_key(@key).value || '{}'
    @settings = value.html_safe
  end
  
  def settingsupdate
    @settings = Settings.find_or_create_by_key(@key)
    @settings.update_attributes(:value => params[:settings])
    
    render :json => {}, :status => 200
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


