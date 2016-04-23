class AddSympthomToReport < ActiveRecord::Migration
  def change
    add_reference :reports, :sympthom, index: true, foreign_key: true
  end
end
