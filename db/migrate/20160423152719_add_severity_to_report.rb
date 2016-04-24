class AddSeverityToReport < ActiveRecord::Migration
  def change
    add_reference :reports, :severity, index: true, foreign_key: true
  end
end
