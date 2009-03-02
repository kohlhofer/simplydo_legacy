class TodosController < ApplicationController

  layout 'application', :except => ['create', 'destroy', 'update_positions']

  def index
    show
    render :action => 'show'
  end

  def list
    show
    render :action => 'show'
  end

  def show

    @todo_lists = todo_lists()

    @can_create_new_list = (cookies[:temp_id].nil? || (!cookies[:temp_id].nil? && @todo_lists.size == 0)) ? true : false

    if @todo_lists.size == 0
      @open_todos = []
      @closed_todos = []
    else
      if params[:todo_list].nil?
        @todo_list = @todo_lists.first
      else
        @todo_list = @todo_lists.reject() { |todo_list| todo_list.id != params[:todo_list].to_i}.first
      end

      check_list(@todo_list.id)
      @todo = Todo.new(:todo_list => @todo_list)
      @open_todos, @closed_todos = todos(@todo_list)
    end
  end

  def create

    check_list(params[:todo][:todo_list_id])

    @todo = Todo.new(params[:todo])
    @todo.done = 0

    begin
      @todo.save!
      @open_todos = Todo.find(:all, :conditions => ['todo_list_id = ?',@todo.todo_list_id], :order => 'position ASC')
    rescue => e
      raise "unable to store todo! #{e.inspect}"
    end
  end

  def close
    @todo = Todo.find(params[:id])

    check_list(@todo.todo_list_id)

    @todo.update_attribute('done', 1)
  end

  def reopen
    @todo = Todo.find(params[:id])

    check_list(@todo.todo_list_id)

    @todo.update_attribute('done', 0)

    @open_todos = Todo.find(:all, :conditions => ['todo_list_id = ?', @todo.todo_list_id], :order => 'position ASC')
  end

  # TODO check for list owner
  def update_positions
    
    params[:openToDos].each_index do |i|
      todo = Todo.find(params[:openToDos][i])

      list = TodoList.find(todo.todo_list_id)

      if (logged_in? && list.user_id == current_user.id) || cookies[:temp_id] == list.temp_id
        todo.position = i
        todo.save
      end
    end

    render :nothing => true
  end

  def destroy
    todo = Todo.find(params[:id])
    check_list(todo.todo_list_id)
    @id = todo.id
    todo.destroy
  end

  protected
  def check_list(todo_list_id)
    # checking that list owner is ok
    list = TodoList.find(todo_list_id)

    if logged_in?
      raise "accessing list which is not yours!" unless list.user_id == current_user.id
    end
  end

  def todo_lists
    conditions = ['temp_id = ?', cookies[:temp_id]]

    if logged_in?
      conditions = ['user_id = ?', current_user.id]
    end

    TodoList.find(:all, :conditions => conditions, :order => 'name ASC')
  end
  
  def todos(todo_list)
    open_todos = []
    closed_todos = []

    unless todo_list.nil?
      open_todos = Todo.find(:all, :conditions => ['todo_list_id = ? AND done <> 1', todo_list.id], :order => 'position ASC')
      closed_todos = Todo.find(:all, :conditions => ['todo_list_id = ? AND done = 1', todo_list.id], :order => 'position ASC')
    end
    [open_todos, closed_todos]
  end

end
