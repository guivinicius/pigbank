class AddFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :balance, :decimal, :precision => 10, :scale => 2, :default => 0
    add_column :users, :agency_number, :integer
    add_column :users, :account_number, :integer
    add_column :users, :uid, :string
    add_column :users, :name, :string

    add_index :users, :uid, :unique => true
  end
end
