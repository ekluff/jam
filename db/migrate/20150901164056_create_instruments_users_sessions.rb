class CreateInstrumentsUsersSessions < ActiveRecord::Migration
  def change
    create_table(:instruments) do |t|
      t.column(:name, :string)

      t.timestamps
    end
    create_table(:users) do |t|
      t.column(:first_name, :string)
      t.column(:last_name, :string)
      t.column(:username, :string)
      t.column(:password, :string)
      t.column(:password_confirm, :string)
      t.column(:phone, :string)
      t.column(:email, :string)
      t.column(:address, :string)
      t.column(:city, :string)
      t.column(:state, :string)
      t.column(:zip, :string)

      t.timestamps
    end
    create_table(:sessions) do |t|
      t.column(:instrument_id, :integer)
      t.column(:user_id, :integer)
      t.column(:address, :string)
      t.column(:city, :string)
      t.column(:state, :string)
      t.column(:zip, :string)
      t.column(:date, :date)
      t.column(:time, :time)
      t.column(:host_id, :integer)

      t.timestamps
    end
  end
end
