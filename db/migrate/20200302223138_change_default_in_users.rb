class ChangeDefaultInUsers < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :no_meat_counter, :integer, default: 0
  end
end
