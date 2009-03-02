class HomeController < ApplicationController

  def index
    redirect_to :controller => 'todos' if logged_in? || !cookies[:temp_id].nil?
  end
  
end