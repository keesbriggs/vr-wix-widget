class OauthController < ActionController::Base

def savetoken
    if params[:code]
      puts "KEES: inside #savetoken - params are #{params.inspect}"
      # we need to return to this page as other pages are unauthorized.

      client_id = "bruvqhpp3rsp7fwr9vysc8yz"
      client_secret = "T4skBaDmAfkJkZjFg9jbfYHR" # IF THIS IS THE WRONG SECRET THEN HOW DO I GET THE RIGHT ONE???
      @auth_code = params[:code]
      @post = "https://vrapi.verticalresponse.com/api/v1/oauth/access_token?client_id=#{client_id}&client_secret=#{client_secret}&redirect_uri=https://vr-wix-widget.herokuapp.com/savetoken"
      puts "KEES: redirecting to #{@post}"
      redirect_to @post, status: 302
    end
  end  
end