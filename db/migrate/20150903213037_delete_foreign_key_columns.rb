class DeleteForeignKeyColumns < ActiveRecord::Migration
  def change
    remove_column(:sessions, :instrument_id)
    remove_column(:sessions, :user_id)
  end
end
