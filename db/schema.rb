# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121115234856) do

  create_table "banks", :force => true do |t|
    t.decimal  "start_amount"
    t.decimal  "end_amount"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "quotes", :force => true do |t|
    t.integer  "stock_id"
    t.date     "date"
    t.decimal  "day_neg1_open"
    t.decimal  "day_neg1_close"
    t.decimal  "day_zero_open"
    t.decimal  "day_zero_close"
    t.boolean  "win"
    t.string   "prediction"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "stocks", :force => true do |t|
    t.text     "symbol"
    t.decimal  "win_percentage"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.decimal  "bank"
    t.date     "Quarter_1_date"
  end

end
