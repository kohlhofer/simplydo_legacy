class AddTempIdToTodoLists < ActiveRecord::Migration
  def self.up
    add_column :todo_lists, :temp_id, :integer
  end

  def self.down
    remove_column :todo_lists, :temp_id
  end
end
