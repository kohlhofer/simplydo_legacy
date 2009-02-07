class CreateTodos < ActiveRecord::Migration
  def self.up
    create_table :todos do |t|
      t.integer :todo_list_id
      t.integer :user_id
      t.integer :done
      t.string :title

      t.timestamps
    end
  end

  def self.down
    drop_table :todos
  end
end
