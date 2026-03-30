class CreateSessions < ActiveRecord::Migration[8.1]
  def change
    create_table :sessions, id: false, primary_key: :access_token do |t|
      t.string :access_token
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
