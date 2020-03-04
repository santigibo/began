class Droptablequizz < ActiveRecord::Migration[5.2]
  def change
    drop_table :quizzs
  end
end
