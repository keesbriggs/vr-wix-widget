require 'faraday'
require 'json'

class OauthController < ActionController::Base

  def savetoken
    if params[:code]
      # we need to return to this page as other pages are unauthorized.

      client_id = "bruvqhpp3rsp7fwr9vysc8yz"
      client_secret = "T4skBaDmAfkJkZjFg9jbfYHR" 
      @auth_code = params[:code]

      conn = Faraday.new(:url => 'https://vrapi.verticalresponse.com') do |c|
        c.use Faraday::Request::UrlEncoded  
        c.use Faraday::Response::Logger     
        c.use Faraday::Adapter::NetHttp    
      end

      response = conn.post "/api/v1/oauth/access_token", { 
        client_id: client_id, 
        client_secret: client_secret, 
        code: @auth_code, redirect_uri: "https://vr-wix-widget.herokuapp.com/savetoken" 
      }
      response_json = JSON.parse(response.body)

      p "KEES: response_json is #{response_json.inspect}"
      p "KEES: response_json.class is #{response_json.class.inspect}"
      p "KEES: response_json['user_id'] is #{response_json['user_id'].inspect}"
      p "KEES: response_json['access_token'] is #{response_json['access_token'].inspect}"
      user = User.create({ vr_user_id: response_json['user_id'], access_token: response_json['access_token'] })
    end
  end
end