class DropPasswordConfirm < ActiveRecord::Migration
  def change
    remove_column(:users, :password_confirm)
  end
end
