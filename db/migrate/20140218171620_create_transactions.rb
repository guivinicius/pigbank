class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.integer :activity_type, :null => false
      t.decimal :amount, :precision => 10, :scale => 2, :default => 0, :null => false
      t.integer :user_id, :null => false
      t.string :description

      t.timestamps
    end

    add_index :transactions, :user_id
  end
end
