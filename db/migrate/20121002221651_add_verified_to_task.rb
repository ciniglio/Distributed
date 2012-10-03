class AddVerifiedToTask < ActiveRecord::Migration
  def change
    add_column :tasks, :verified, :boolean
  end
end
