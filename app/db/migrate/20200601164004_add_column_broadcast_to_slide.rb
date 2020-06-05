class AddColumnBroadcastToSlide < ActiveRecord::Migration[6.0]
  def change
    add_column :slides, :livecast, :boolean, default: false
  end
end
