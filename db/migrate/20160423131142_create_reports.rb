class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.float :lat
      t.float :lon
      t.string :from
      t.string :note

      t.timestamps null: false
    end
  end
end
