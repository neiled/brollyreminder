class AddConfirmGuidToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :confirm_guid, :string
  end

  def self.down
    remove_column :users, :confirm_guid
  end
end
