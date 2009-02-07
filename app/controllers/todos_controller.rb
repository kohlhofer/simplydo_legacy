require 'app/controllers/application.rb'

class TodosController < ApplicationController
  
  def index
    show
  end

  def show
    @todo_lists = TodoList.find(:all, :order => 'name ASC')
    @todos = Todo.find_by_list(@todo_lists.first)
  end

  def list

    @todo_lists = TodoList.find(:all, :order => 'name ASC')

    @todo_list = @todo_lists.reject() { |todo_list| todo_list.id != params[:todo_list].to_i}.first

    @todos = Todo.find_by_list(params[:list])

    render :action => 'show'
  end

end
