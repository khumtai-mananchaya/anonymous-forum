class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.integer :user_id
      t.string :username, limit: 15
      t.string :password_digest
      t.string :email

      t.timestamps
    end
  end
end
