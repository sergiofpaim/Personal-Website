class UpdatePostContent < ActiveRecord::Migration[8.1]
  def change
    change_column :posts, :content, :text
  end
end
