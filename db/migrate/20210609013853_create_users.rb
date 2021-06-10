class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.serial :user_id
      t.text :username, limit: 15
      t.text :password
      t.text :email

      t.timestamps
    end
  end
end
