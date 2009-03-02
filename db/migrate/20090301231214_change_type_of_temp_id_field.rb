class ChangeTypeOfTempIdField < ActiveRecord::Migration
  def self.up
    change_column(:todo_lists, :temp_id, :string)
  end

  def self.down
    change_column(:todo_lists, :temp_id, :integer)
  end
end
