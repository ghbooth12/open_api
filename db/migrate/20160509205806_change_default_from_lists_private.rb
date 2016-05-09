class RemoveDefaultFromListsPrivate < ActiveRecord::Migration
  def change
    reversible do |dir|
      change_table :lists do |t|
        dir.up { t.change :private, :boolean, default: true }
        dir.down { t.change :private, :boolean, default: false }
      end
    end
  end
end
