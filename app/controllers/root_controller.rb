class RootController < ApplicationController
  def index
    @title = "#Sokuhame"
    @posts = Post.find :all, :order => "updated_at desc"
  end

  def view
    @post = Post.find :first,
      :include => [:user],
      :conditions => ["users.name = ?", params[:id]]
    @title = "#Sokuhame - @#{@post.user.name}"
  end
end
