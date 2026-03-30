class UpdatePosts < ActiveRecord::Migration[8.1]
  def change
    add_column :posts, :title, :string
    add_column :posts, :overview, :string
  end
end
