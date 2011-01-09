class AddSecondsSinceMidnightToUserAndRemoveTime < ActiveRecord::Migration
  def self.up
    add_column :users, :seconds_since_midnight, :integer
    remove_column :users, :time
  end

  def self.down
    remove_column :users, :seconds_since_midnight
    add_column :users, :time, :datetime
  end
end
