class OauthController < ActionController::Base

  def savetoken
    puts "KEES: params  is #{params.inspect}"
    if params[:code]
      # we need to return to this page as other pages are unauthorized.

      client_id = "bruvqhpp3rsp7fwr9vysc8yz"
      client_secret = "T4skBaDmAfkJkZjFg9jbfYHR" 
      @auth_code = params[:code]

      # use Faraday or HTTParty to make this redirect request and parse the json - use GET request

      conn = Faraday.new(:url => 'https://vrapi.verticalresponse.com') do |c|
        c.use Faraday::Request::UrlEncoded  # encode request params as "www-form-urlencoded"
        c.use Faraday::Response::Logger     # log request & response to STDOUT
        c.use Faraday::Adapter::NetHttp     # perform requests with Net::HTTP
      end

      response = conn.post "/api/v1/oauth/access_token", { client_id: client_id, client_secret: client_secret, code: @auth_code, redirect_uri: "https://vr-wix-widget.herokuapp.com/savetoken" } 
      foo = JSON.parse(response.body)

      puts "KEES: foo is #{foo.inspect}"

      #the below line is old and can be deleted - KEES 10/25
      #redirect_to "https://vrapi.verticalresponse.com/api/v1/oauth/access_token?client_id=#{client_id}&client_secret=#{client_secret}&code=#{@auth_code}&redirect_uri=https://vr-wix-widget.herokuapp.com/savetoken", :status => 302
    elsif params[:user_id]
      # save access token here!
    end

  end
end