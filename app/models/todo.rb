class Todo < ActiveRecord::Base

  validates_presence_of :todo_list_id, :title

  belongs_to :todo_list

  def self.find_by_list(todo_list, done = 0)
    Todo.find(:all,
      :conditions => ['todo_list_id = ? AND done = ?', todo_list, done],
      :order => 'position ASC'
    )
  end

end
