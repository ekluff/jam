class CreateSessionsJoinTables < ActiveRecord::Migration
  def change
    create_table(:instruments_sessions) do |t|
      t.column(:instrument_id, :integer)
      t.column(:session_id, :integer)

      t.timestamps
    end
    create_table(:sessions_users) do |t|
      t.column(:session_id, :integer)
      t.column(:user_id, :integer)

      t.timestamps
    end
  end
end
