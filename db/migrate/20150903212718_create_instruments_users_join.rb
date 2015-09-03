class CreateInstrumentsUsersJoin < ActiveRecord::Migration
  def change
    create_table(:instruments_users) do |t|
      t.column(:instrument_id, :integer)
      t.column(:user_id, :integer)

      t.timestamps
    end
  end
end
