class CreateShains < ActiveRecord::Migration
  def change
    create_table :shains do |t|
      t.string  :no,          :limit => 3, :index => true, :null => false
      t.string  :name
      t.string  :name_kana
      t.string  :login_id
      t.string  :login_pw
      t.string  :shain_kbn
      t.boolean :zaiseki_flg, :default => true
    end
  end
end
