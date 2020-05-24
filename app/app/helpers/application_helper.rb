module ApplicationHelper


  # ページごとの完全なタイトルを返します。
  def full_title(page_title = '')
    base_title = "Speback"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end

  # datetime型を日本語っぽい形で日付表示
  def datetime_to_date_jp_fmt(origin_date)
    origin_date.strftime("%Y %m/%d")
  end

  # datetime型を日本語っぽい形で日時表示
  def datetime_to_time_jp(origin_date)
    origin_date.strftime("%m/%d %H:%M")
  end

  # datetime型から時間だけ表示
  def datetime_to_time(origin_date)
    origin_date.strftime("%H:%M")
  end

end
