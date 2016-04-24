class AddTypeToReport < ActiveRecord::Migration
  def change
    add_column :reports, :reporttype, :string
  end
end
