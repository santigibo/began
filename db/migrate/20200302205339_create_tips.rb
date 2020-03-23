class CreateTips < ActiveRecord::Migration[5.2]
  def change
    create_table :tips do |t|
      t.references :challenge, foreign_key: true
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
