class RemoveAccountFieldsFromUsers < ActiveRecord::Migration
  def up
    remove_index :users, [:agency_number, :account_number]

    remove_column :users, :agency_number
    remove_column :users, :account_number
    remove_column :users, :balance
  end

  def down
    add_column :users, :agency_number, :integer, :null => false
    add_column :users, :account_number, :integer, :null => false
    add_column :users, :balance, :decimal, :precision => 10, :scale => 2, :default => 0, :null => false

    add_index :users, [:agency_number, :account_number], :unique => true
  end
end
