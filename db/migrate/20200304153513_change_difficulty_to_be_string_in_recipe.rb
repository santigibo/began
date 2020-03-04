class ChangeDifficultyToBeStringInRecipe < ActiveRecord::Migration[5.2]
  def change
    change_column :recipes, :difficulty, :string
  end
end
