class CreateKintais < ActiveRecord::Migration
  def change
    create_table :kintais do |t|
      t.string :shain_no,     :null => false
      t.string :yyyy,         :null => false
      t.string :mm,           :null => false
      t.string :dd,           :null => false
      t.string :kintai_kbn_cd
      t.time :start_time
      t.time :end_time
      t.decimal :normal_hours,  :precision => 3, :scale => 1, :default => 7.5
      t.decimal :break_hours ,  :precision => 3, :scale => 1, :default => 1.0
    end
    add_index :kintais, [:shain_no, :yyyy, :mm, :dd], :unique => true
  end
end
