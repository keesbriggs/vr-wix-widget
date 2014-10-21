class OauthController < ActionController::Base

  def authenticate
    if params[:code]
      # we need to return to this page as other pages are unauthorized.
      @auth_code = params[:code]
      puts "KEES: @auth_code is #{@auth_code}"
      @post = "https://vrapi.verticalresponse.com/api/v1/oauth/access_token?client_id=abcdh2wvxxdrw5zanb6wryhc&client_secret=abbcRjmGDCYqRGuyWAs5yJ4C&redirect_uri=https://vr-wix-widget.herokuapp.com/settings?&code=#{@auth_code}"
      puts "KEES: redirecting to #{@post}"
      redirect_to @post, status: 302
    end
  end
end