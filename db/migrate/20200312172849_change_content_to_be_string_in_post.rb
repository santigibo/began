class ChangeContentToBeStringInPost < ActiveRecord::Migration[5.2]
  def change
    change_column :posts, :content, :string
  end
end
