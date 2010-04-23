class SessionsController < ApplicationController
  def index
  end

  def create_with_twitter
    redirect_to :controller => :oauth, :action => :verify
  end
end
