class CreateUserTable < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :email_address
      t.boolean :confirmed
      t.datetime :time
      t.string :time_zone_string
      t.string :location_string
      t.integer :time_zone_offset
      t.integer :woeid
    end
  end

  def self.down
    drop_table :users
  end
end
