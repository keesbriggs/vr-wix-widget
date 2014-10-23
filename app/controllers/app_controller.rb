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


