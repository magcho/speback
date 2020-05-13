class AddInfomationCoulmnToSlide < ActiveRecord::Migration[6.0]
  def change
    add_column :slides, :title, :string
    add_column :slides, :summary, :text
    add_column :slides, :draft, :boolean
  end
end
