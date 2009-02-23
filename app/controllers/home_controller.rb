class HomeController < ApplicationController

  def index
    redirect_to :controller => 'todos' if logged_in?
  end
  
end