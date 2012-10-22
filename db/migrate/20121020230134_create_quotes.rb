class CreateQuotes < ActiveRecord::Migration
  def change
    create_table :quotes do |t|
      t.integer :stock_id
      t.date :date
      t.decimal :day_neg1_open
      t.decimal :day_neg1_close
      t.decimal :day_zero_open
      t.decimal :day_zero_close
      t.boolean :win
      t.string :prediction

      t.timestamps
    end
  end
end
