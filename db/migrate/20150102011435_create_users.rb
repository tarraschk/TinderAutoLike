class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :firstname
      t.string :login
      t.string :password_digest
      t.string :remember_token
      t.boolean :is_active
      t.boolean :is_admin

      t.timestamps
    end
  end
end
