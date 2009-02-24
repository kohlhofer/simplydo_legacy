class AddUserToTodoList < ActiveRecord::Migration
  def self.up
    add_column :todo_lists, :user_id, :integer
  end

  def self.down
    remove_column :todo_lists, :user_id
  end
end
