class CreateSessions < ActiveRecord::Migration[8.1]
  def change
    create_table :sessions, id: false do |t|
      t.string :access_token, null: false, primary_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
