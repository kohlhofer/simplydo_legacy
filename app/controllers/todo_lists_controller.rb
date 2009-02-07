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

    if @todo_list.save!
      
    else
      flash[:notice] = 'must provide a title'
      render :partial => 'edit'
    end
  end

end
