class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :name
      t.string :filename
      t.boolean :distributed
      t.boolean :finished
      t.text :result

      t.timestamps
    end
  end
end
