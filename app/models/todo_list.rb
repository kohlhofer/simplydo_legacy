 class TodoList < ActiveRecord::Base

   validates_presence_of :name

   has_many :todo, :dependent => :destroy

end
