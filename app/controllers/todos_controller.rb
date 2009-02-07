require 'app/controllers/application.rb'

class TodosController < ApplicationController

  layout 'application', :except => ['create', 'update_positions']

  def index
    show
  end

  def show
    @todo_lists = TodoList.find(:all, :order => 'name ASC')
    @todo_list = @todo_lists.first
    @open_todos = Todo.find_by_list(@todo_list)
    @closed_todos = Todo.find_by_list(@closed_list)

    @todo = Todo.new(:todo_list => @todo_list)
    #@todo.list = @todo_list.id
  end

  def list
    @todo_lists = TodoList.find(:all, :order => 'name ASC')
    @todo_list = @todo_lists.reject() { |todo_list| todo_list.id != params[:todo_list].to_i}.first
    @open_todos = Todo.find_by_list(params[:todo_list])
    @closed_todos = Todo.find_by_list(params[:todo_list], 1)
    @todo = Todo.new(:todo_list => @todo_list)

    render :action => 'show'
  end

  def create
    @todo = Todo.new(params[:todo])
    @todo.done = 0
    
    unless @todo.save!
      
    end
  end

  def close
    @todo = Todo.find(params[:id])
    @todo.update_attribute('done', 1)
  end

  def reopen
    @todo = Todo.find(params[:id])
    @todo.update_attribute('done', 0)
  end

  def update_positions
    params[:openToDos].each_index do |i|
      item = Todo.find(params[:openToDos][i])
      item.position = i
      item.save
    end
    @open_todos = Tods.find_by_list()
    render :layout => false, :action => :list
  end
end
