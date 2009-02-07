require 'app/controllers/application.rb'

class TodosController < ApplicationController

  layout 'application', :except => ['create']

  def index
    show
  end

  def show
    @todo_lists = TodoList.find(:all, :order => 'name ASC')
    @todo_list = @todo_lists.first
    @todos = Todo.find_by_list(@todo_list)
    @todo = Todo.new
  end

  def list
    @todo_lists = TodoList.find(:all, :order => 'name ASC')
    @todo_list = @todo_lists.reject() { |todo_list| todo_list.id != params[:todo_list].to_i}.first
    @todos = Todo.find_by_list(params[:list])
    @todo = Todo.new
    
    render :action => 'show'
  end

  def create
    @todo = Todo.new(params[:todo])

    unless @todo.save!
      
    end
  end

end
