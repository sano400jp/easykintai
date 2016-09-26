class ApplicationController < ActionController::Base

  def afnc_ymdw(istr_y,istr_m,istr_d)
    date_ymd = Date.strptime(istr_y + istr_m + istr_d,'%Y%m%d')
    return date_ymd.strftime("%Y/%m/%d(#{%w(日 月 火 水 木 金 土)[date_ymd.wday]})")
  end
  
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
end
