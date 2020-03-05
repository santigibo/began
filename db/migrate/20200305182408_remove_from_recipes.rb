class RemoveFromRecipes < ActiveRecord::Migration[5.2]
  def change
    remove_column :recipes, :photo
  end
end
