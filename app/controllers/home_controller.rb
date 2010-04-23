class HomeController < ApplicationController
  require 'oauth'
  before_filter :login_check
  def index 
    @user = User.find session[:login_user_id]
    begin
      @post = Post.find(:first, :include => [:user],
        :conditions => ["users.name = ?", @user.name])
      raise unless @post
    rescue
      @post = Post.new
    end
  end

  def update
    @user = User.find session[:login_user_id]
    post = params[:post]
    post["id"] = "user_#{@user.id}"
    p post
    begin
      p = Post.find(:first, :include => [:user],
        :conditions => ["users.name = ?", @user.name])
      raise unless p
    rescue
      p = Post.new
    end
    p.memo = post["memo"]
    p.cost = post["cost"]
    p.address = post["address"]
    p.user_id = @user.id
    p.save
    redirect_to :action => :index
  end

  def post
    @user = User.find session[:login_user_id]
    access_token = OAuth::AccessToken.new(OauthController.consumer, @user.token, @user.secret_token)
    res = access_token.post('/statuses/update.json', {:status => "セフレ募集中です http://sokuhame.ssig33.com/user/#{@user.name}"})
    redirect_to :action => :index
  end
end
