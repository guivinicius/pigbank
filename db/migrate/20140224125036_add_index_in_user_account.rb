class AddIndexInUserAccount < ActiveRecord::Migration
  def change
    add_index :users, [:agency_number, :account_number], :unique => true
  end
end
