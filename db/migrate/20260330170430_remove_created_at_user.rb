class RemoveCreatedAtUser < ActiveRecord::Migration[8.1]
  def change
    remove_column :users, :createdAt
    remove_column :users, :datetime
  end
end
