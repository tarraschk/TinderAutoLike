class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :name
      t.string :fb_token
      t.string :fb_id
      t.string :tinder_token

      t.timestamps
    end
  end
end
