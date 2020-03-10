class CreateNoMeatDays < ActiveRecord::Migration[5.2]
  def change
    create_table :no_meat_days do |t|
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
