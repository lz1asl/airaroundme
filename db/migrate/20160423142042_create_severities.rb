class CreateSeverities < ActiveRecord::Migration
  def change
    create_table :severities do |t|
      t.string :label

      t.timestamps null: false
    end
  end
end
