class AddForeignKeys < ActiveRecord::Migration
  def change
    add_foreign_key "accounts", "users", name: "accounts_user_id_fk"
    add_foreign_key "transactions", "users", name: "transactions_user_id_fk"
    add_foreign_key "transferences", "users", name: "transferences_from_user_id_fk", column: "from_user_id"
    add_foreign_key "transferences", "users", name: "transferences_to_user_id_fk", column: "to_user_id"
  end
end
