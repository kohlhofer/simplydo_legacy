# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base

  include AuthenticatedSystem
  include ExceptionNotifiable

  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  filter_parameter_logging :password

  protected
  def add_todolists_to_account(user)

    temp_id = cookies[:temp_id]

    unless temp_id.nil?
      todo_lists = TodoList.find(:all, :conditions => ['temp_id = ?', temp_id])

      todo_lists.each do |todo_list|
        todo_list.user_id = user.id
        todo_list.temp_id = nil
        todo_list.save
      end
    end
    cookies.delete(:temp_id)
  end
end