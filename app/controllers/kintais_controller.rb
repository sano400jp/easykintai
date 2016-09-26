class KintaisController < ApplicationController
  before_action :set_kintai, only: [:show, :edit, :update, :destroy]

  # GET /kintais
  # GET /kintais.json
  def index
    # 画面データ連携用ハッシュ
    @mkintai = {}

    # ログイン社員番号
    @@shain_no = '007'
    
    # 処理対象年月取得
    now = Time.current
    @@yyyy = now.strftime("%Y")
    @@mm = now.strftime("%m")
    # 対象年月の月初月末日取得
    cur_day = now.beginning_of_month
    end_day = now.end_of_month

    # 対象年月の勤怠データ取得
    @kintais = Kintai.where(shain_no: @@shain_no, yyyy: @@yyyy, mm: @@mm)
    @tkintai = Hash[@kintais.map{|kintai| [kintai.dd, kintai.attributes]}]

    # 祭日取得
    holidays = Holiday.where(yyyy: @@yyyy, mm: @@mm)
    holidayname = Hash[holidays.map{|holiday| [holiday.dd, holiday.attributes]}]
    
    # サマリ項目
    @defoult_working_days_cnt = (end_day - cur_day).to_i/(60*60*24) + 1
    @working_days_cnt  = 0
    @working_hours_sum = 0
    @extra_hours_sum   = 0
    
    while(cur_day < end_day)
      id = ""
      dd = cur_day.strftime("%d")
      ww = cur_day.strftime("%w")
      dw = cur_day.strftime("%d(#{%w(日 月 火 水 木 金 土)[cur_day.wday]})")
      kintai_kbn = ""
      start_time = ""
      end_time = ""
      normal_hours = ""
      break_hours = ""
      working_hours = ""
      extra_hours = ""
      
      holiday_name = ""
      
      # 行背景カラー設定
      line_bk_color = ""
      # 土曜日
      if ww == "6" then
        line_bk_color = "aliceblue"
      end
      # 日曜日
      if ww == "0" then
        line_bk_color = "lavenderblush"
      end
      # 祭日
      if holidayname[dd] != nil then
        line_bk_color = "lavenderblush"
        holiday_name = holidayname[dd]["name"]
      end
      # 本日
      if cur_day.strftime("%Y%m%d") == now.strftime("%Y%m%d") then
        line_bk_color = "lightyellow"
      end
      
      # 要出勤日数算出
      if ww == "6" or ww == "0" then
        @defoult_working_days_cnt = @defoult_working_days_cnt - 1
      end

      # 勤怠登録がある日
      if @tkintai[dd] != nil
        # Table表文言作成
        id            = @tkintai[dd]["id"]
        kintai_kbn    = @tkintai[dd]["kintai_kbn_cd"]
        start_time    = @tkintai[dd]["start_time"] == nil ? "" : @tkintai[dd]["start_time"].strftime("%H:%M")
        end_time      = @tkintai[dd]["end_time"] == nil ? "" : @tkintai[dd]["end_time"].strftime("%H:%M")
        normal_hours  = @tkintai[dd]["normal_hours"]
        break_hours   = @tkintai[dd]["break_hours"]
        working_hours = (@tkintai[dd]["start_time"] == nil or @tkintai[dd]["end_time"] == nil) ? "" : (@tkintai[dd]["end_time"] - @tkintai[dd]["start_time"])/60/60 - @tkintai[dd]["break_hours"]
        extra_hours   = (@tkintai[dd]["start_time"] == nil or @tkintai[dd]["end_time"] == nil) ? "" : (@tkintai[dd]["end_time"] - @tkintai[dd]["start_time"])/60/60 - @tkintai[dd]["break_hours"] - @tkintai[dd]["normal_hours"]

        # 実績サマリ項目算出
        # 出勤日数
        if kintai_kbn == "0" then
          @working_days_cnt = @working_days_cnt + 1
        end
        # 合計勤務時間
        @working_hours_sum = @working_hours_sum + working_hours.to_f
        # 合計残業時間
        @extra_hours_sum = @extra_hours_sum + extra_hours.to_f
      end

      @mkintai[cur_day.strftime("%d")] = {
          "id"            => id \
        , "dd"            => dd \
        , "dw"            => dw \
        , "holiday_name"  => holiday_name \
        , "kintai_kbn"    => kintai_kbn \
        , "start_time"    => start_time \
        , "end_time"      => end_time \
        , "normal_hours"  => normal_hours \
        , "break_hours"   => break_hours \
        , "working_hours" => working_hours \
        , "extra_hours"   => extra_hours \
        , "line_bk_color" => line_bk_color \
      }
      cur_day += 1.day
    end

    @kintais = Kintai.all
  end

  # GET /kintais/1
  # GET /kintais/1.json
  def show
  end

  # GET /kintais/new
  def new
    @kintai = Kintai.new
  end

  # GET /kintais/1/edit
  def edit
  end

  # POST /kintais
  # POST /kintais.json
  def create
    @kintai = Kintai.new(kintai_params)

    respond_to do |format|
      if @kintai.save
        format.html { redirect_to @kintai, notice: 'Kintai was successfully created.' }
        format.json { render :show, status: :created, location: @kintai }
      else
        format.html { render :new }
        format.json { render json: @kintai.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /kintais/1
  # PATCH/PUT /kintais/1.json
  def update
    respond_to do |format|
      if @kintai.update(kintai_params)
        format.html { redirect_to @kintai, notice: 'Kintai was successfully updated.' }
        format.json { render :show, status: :ok, location: @kintai }
      else
        format.html { render :edit }
        format.json { render json: @kintai.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /kintais/1
  # DELETE /kintais/1.json
  def destroy
    @kintai.destroy
    respond_to do |format|
      format.html { redirect_to kintais_url, notice: 'Kintai was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_kintai
      @kintai = Kintai.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def kintai_params
      params.require(:kintai).permit(:shain_no, :yyyy, :mm, :dd, :kintai_kbn_cd, :start_time, :end_time, :normal_hours, :break_hours)
    end
end
