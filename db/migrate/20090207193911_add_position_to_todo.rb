class AddPositionToTodo < ActiveRecord::Migration
  def self.up
    add_column :todos, :postion, :integer
  end

  def self.down
    remove_column :todos, :postion
  end
end
