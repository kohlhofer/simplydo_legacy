class Todo < ActiveRecord::Base

  belongs_to :todo_list

  def self.find_by_list(todo_list, done = 0)
    Todo.find(:all, :conditions => ['todo_list_id = ? AND done = ?', todo_list, done])
  end

end
