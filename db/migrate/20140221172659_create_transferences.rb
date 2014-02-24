class CreateTransferences < ActiveRecord::Migration
  def change
    create_table :transferences do |t|
      t.integer :from_user_id, :null => false
      t.integer :to_user_id, :null => false
      t.decimal :amount, :precision => 10, :scale => 2, :default => 0, :null => false

      t.timestamps
    end
    add_index :transferences, :from_user_id
    add_index :transferences, :to_user_id
  end
end
