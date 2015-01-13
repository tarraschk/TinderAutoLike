class CreateAccountFbs < ActiveRecord::Migration
  def change
    create_table :account_fbs do |t|
      t.string :login
      t.string :password

      t.timestamps
    end
  end
end
