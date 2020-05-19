class AddRelationEventToSlide < ActiveRecord::Migration[6.0]
  def change
    add_reference :slides, :event, index: true
  end
end
