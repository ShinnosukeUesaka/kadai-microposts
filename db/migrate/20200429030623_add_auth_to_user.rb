class AddAuthToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :auth, :boolean, default: false, null: false
  end
end
