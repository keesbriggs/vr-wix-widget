class OauthController < ActionController::Base

  def savetoken
    if params[:code]
      # we need to return to this page as other pages are unauthorized.

      client_id = "bruvqhpp3rsp7fwr9vysc8yz"
      client_secret = "T4skBaDmAfkJkZjFg9jbfYHR" 
      @auth_code = params[:code]
      redirect_to "https://vrapi.verticalresponse.com/api/v1/oauth/access_token?client_id=#{client_id}&client_secret=#{client_secret}&code=#{@auth_code}&redirect_uri=https://vr-wix-widget.herokuapp.com/saveaccesstoken", :status => 302
    end
  end

  def saveaccesstoken
    
    puts "KEES: params  is #{params.inspect}"
  end  
end