class OauthController < ActionController::Base

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
end