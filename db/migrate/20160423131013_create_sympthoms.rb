class CreateSympthoms < ActiveRecord::Migration
  def change
    create_table :sympthoms do |t|
      t.string :label

      t.timestamps null: false
    end
  end
end
