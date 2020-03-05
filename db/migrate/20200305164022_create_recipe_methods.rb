class CreateRecipeMethods < ActiveRecord::Migration[5.2]
  def change
    create_table :recipe_methods do |t|
      t.string :content
      t.references :recipe, foreign_key: true

      t.timestamps
    end
  end
end
