class TodoListsController < ApplicationController

  layout false

  def new
    @todo_list = TodoList.new
    render :partial => 'edit'
  end

  def cancel
    render :partial => 'todo_lists/add_todo_list'
  end

  def create

    @todo_list = TodoList.new(params[:todo_list])

    TodoList.transaction do
      if logged_in?
        @todo_list.user_id = current_user.id
      else
        uuid =  `uuidgen`.strip
        @todo_list.temp_id = uuid
        cookies[:temp_id] = uuid
      end

      if @todo_list.save!
        flash[:notice] = 'todolist saved'
      else
        render :partial => 'edit'
      end
    end
  end

  def destroy
    todo_list = TodoList.find(params[:id])
    if (logged_in? && todo_list.user_id == current_user.id) || todo_list.temp_id == cookies[:temp_id]
      todo_list.destroy
    end
    redirect_to :controller => 'todos'
  end

end
