class CreateChallengeRecipes < ActiveRecord::Migration[5.2]
  def change
    create_table :challenge_recipes do |t|
      t.references :recipe, foreign_key: true
      t.references :challenge, foreign_key: true

      t.timestamps
    end
  end
end
