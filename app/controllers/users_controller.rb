class UsersController < ApplicationController
  # Be sure to include AuthenticationSystem in Application Controller instead
  include AuthenticatedSystem
  

  # render new.rhtml
  def new
    @user = User.new
  end
 
  def create
    logout_keeping_session!
    @user = User.new(params[:user])
    success = @user && @user.save
    if success && @user.errors.empty?
      # Protects against session fixation attacks, causes request forgery
      # protection if visitor resubmits an earlier form using back
      # button. Uncomment if you understand the tradeoffs.
      # reset session
      self.current_user = @user # !! now logged in

      add_todolists_to_account(cookies[:temp_id], self.current_user)

      cookies.delete(:temp_id)

      redirect_back_or_default('/')
      flash[:notice] = "Thanks for signing up!  We're sending you an email with your activation code."
    else
      flash[:error]  = "We couldn't set up that account, sorry.  Please try again, or contact an admin (link is above)."
      render :action => 'new'
    end
  end

  protected
  def add_todolists_to_account(temp_id, user)
    unless temp_id.nil?
      todo_lists = TodoList.find(:all, :conditions => ['temp_id = ?', temp_id])

      todo_lists.each do |todo_list|
        todo_list.user_id = user.id
        todo_list.temp_id = nil
        todo_list.save
      end
    end
  end
end
