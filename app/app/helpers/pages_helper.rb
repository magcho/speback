# coding: utf-8
module PagesHelper

  
  def get_dominant_color(img_path)
    Miro.options[:color_count] = 1
    rgb = Miro::DominantColors.new(img_path).to_hex
    rgb[0]
  end

  def ignore_current_slide_filter(slides, current_slide)

    new_slides = Array.new()
    slides.each do |slide|
      if slide.id != current_slide.id
        new_slides.push(slide)
      end
    end
    new_slides
  end


  # プレゼンターによる遠隔操作中にユーザーが操作した時に戻るボタンを表示するかどうか
  def presenter_page_back_button_style_display(mode, slide, page)
    return 'none' if slide.livecast == 1
    if mode == 'backward' and slide.current_presenter_page_num < page.page_num
      return 'block'
    elsif mode == 'forward' and slide.current_presenter_page_num > page.page_num
      return 'block'
    end

    return 'none'
  end


  
end
