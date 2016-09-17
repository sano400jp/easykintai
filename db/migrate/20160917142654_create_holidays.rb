class CreateHolidays < ActiveRecord::Migration
  def change
    create_table :holidays do |t|
      t.string :yyyy ,   :null => false
      t.string :mm   ,   :null => false
      t.string :dd   ,   :null => false
      t.string :name
    end
    add_index :holidays, [:yyyy, :mm, :dd], :unique => true
  end
end
