json.extract! kintai, :id, :shain_no, :yyyy, :mm, :dd, :kintai_kbn_cd, :start_time, :end_time, :normal_hours, :break_hours, :created_at, :updated_at
json.url kintai_url(kintai, format: :json)