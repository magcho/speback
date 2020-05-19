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
end
