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
        temp_id = TodoList.maximum('temp_id')
        @todo_list.temp_id = (temp_id.nil?) ? 1 : temp_id
        cookies[:temp_id] = @todo_list.temp_id
      end

      if @todo_list.save!
        flash[:notice] = 'todolist saved'
      else
        render :partial => 'edit'
      end
    end
  end

  # TODO check for list owner
  def destroy

    todo_list = TodoList.find(params[:id])

    if todo_list.destroy

    else

    end
    
    redirect_to :controller => 'todos'
  end

end
