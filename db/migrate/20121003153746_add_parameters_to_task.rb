class AddParametersToTask < ActiveRecord::Migration
  def change
    add_column :tasks, :parameters, :text
  end
end
