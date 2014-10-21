class OauthController < ActionController::Base

  def authenticate

    if params[:code]
      puts "KEES: inside #authenticate - params are #{params.inspect}"
      # we need to return to this page as other pages are unauthorized.
      @auth_code = params[:code]
      instance = params[:instance].split('.')
      client_id = @instance.first
      client_secret = @instance.last
      puts "KEES: @auth_code is #{@auth_code}"
      @post = "https://vrapi.verticalresponse.com/api/v1/oauth/access_token?client_id=#{client_id}&client_secret=#{client_secret}&redirect_uri=https://vr-wix-widget.herokuapp.com/settings?&code=#{@auth_code}"
      puts "KEES: redirecting to #{@post}"
      redirect_to @post, status: 302
    end
  end
end