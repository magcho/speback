module PagesHelper

  
  def get_dominant_color(img_path)
    Miro.options[:color_count] = 1
    rgb = Miro::DominantColors.new(img_path).to_hex
    rgb[0]
  end
end
