require 'app/controllers/application.rb'

class TodosController < ApplicationController

  def index
    show
  end

  def show
    @todo_lists = TodoList.find(:all, :order => "name ASC")
    @todos = Todo.find_by_list(@todo_lists.first)
  end

end
