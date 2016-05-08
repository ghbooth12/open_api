class RenameNameAddPermissions < ActiveRecord::Migration
  def change
    rename_column :items, :name, :description
    add_column :lists, :private, :boolean, default: false
  end
end
