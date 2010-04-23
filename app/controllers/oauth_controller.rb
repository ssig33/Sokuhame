class OauthController < ApplicationController
  require 'oauth'
  require 'json'

  def self.consumer
    OAuth::Consumer.new("Token","Secret", {:site => "http://twitter.com"})
  end

  def verify
    request_token = OauthController.consumer.get_request_token(
      :oauth_callback => "http://#{request.host_with_port}/oauth/callback"
    )
    session[:request_token] = request_token.token
    session[:request_token_secret] = request_token.secret
    redirect_to request_token.authorize_url
    return
  end

  def callback
    request_token = OAuth::RequestToken.new(OauthController.consumer,
                                            session[:request_token],
                                            session[:request_token_secret])
    access_token = request_token.get_access_token({},
                                                  :oauth_token => params[:oauth_token],
                                                  :oauth_verifier => params[:oauth_verifier])

    # 認証
    res = OauthController.consumer.request(:get,
                                           '/account/verify_credentials.json',
                                            access_token, {:scheme => :query_string})
    case res
    when Net::HTTPSuccess
      user_info = JSON.parse(res.body)
      unless user_info['screen_name']
        flash[:notice] = "Twitterの認証に失敗しました。"
      else
        begin
          user = User.find_by_name user_info["screen_name"]
          raise unless user
        rescue
          user = User.new
        end
        user.service_type = "twitter"
        user.name = user_info['screen_name']
        user.token = access_token.token
        user.secret_token = access_token.secret
        user.save
        flash[:notice] = "Twitterの認証に成功しました"
        session[:login_user_id] = user.id
        redirect_to :controller => :home
      end
    else
      flash[:notice] = "Twitterの認証に失敗しました。"
    end
  end

end
