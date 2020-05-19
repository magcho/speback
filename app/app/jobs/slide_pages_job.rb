class SlidePagesJob < ApplicationJob
  queue_as :default

  def perform(slide_id)
    slide = Slide.find(slide_id)
    originfile_path = slide.originfile_path
    return unless originfile_path


    pdf = Grim.reap(originfile_path.path)
    tmpPath = FileUtils.mkdir_p(Rails.root.join "tmp", "pdfs", slide_id.to_s).first

    Parallel.each(0..(pdf.count - 1)) do |i|
      if pdf[i].save("#{tmpPath}/#{i}.png")
        page = slide.pages.build(page_num: i)
        File.open("#{tmpPath}/#{i}.png") do |f|
          page.img = f
        end
        page.save
      end
    end

    FileUtils.remove_entry_secure(tmpPath)
  end
end