class CreateUsers < ActiveRecord::Migration[8.1]
  def change
    create_table :users do |t|
      t.string :nickname
      t.string :password
      t.string :picture
      t.string :role
      t.string :createdAt
      t.string :datetime

      t.timestamps
    end
  end
end
