class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.integer :number, :null => false
      t.integer :agency, :null => false
      t.decimal :balance, :precision => 10, :scale => 2, :default=> 0, :null => false
      t.integer :user_id, :null => false

      t.timestamps
    end
    add_index :accounts, :user_id
    add_index :accounts, [:number, :agency], :unique => true
  end
end
