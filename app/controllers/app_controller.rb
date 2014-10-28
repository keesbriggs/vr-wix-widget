class AppController < ActionController::Base

  skip_before_filter :require_instance, :only => :savetoken
  skip_before_filter :get_request_key, :only => :savetoken

  before_filter :require_instance
  before_filter :get_request_key
  
  def widget
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


