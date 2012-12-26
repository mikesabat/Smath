class AddTimingAndNotesToStock < ActiveRecord::Migration
  def change
    add_column :stocks, :timing, :string
    add_column :stocks, :notes, :text
  end
end
