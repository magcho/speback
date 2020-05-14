class SlidePagesJob < ApplicationJob
  queue_as :default

  def perform(slide_id)
    slide = Slide.find(slide_id)
    originfile_path = slide.originfile_path
    return unless originfile_path

    p originfile_path.path

    pdf = Grim.reap(originfile_path.path)
    # 切り出した画像の一時的な保存先を生成
    tmpPath = FileUtils.mkdir_p(Rails.root.join "tmp", "pdfs", slide_id.to_s).first

    pdf.each_with_index do |page, i|
      if page.save("#{tmpPath}/#{i}.png")
        file = File.open("#{tmpPath}/#{i}.png")
        page = slide.pages.build(page_num: i)
        File.open("#{tmpPath}/#{i}.png") do |f|
          page.img = f
        end
        page.save
        file.close
      end
    end
  end
end