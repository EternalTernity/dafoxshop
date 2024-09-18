class AddIsPublishedToReviews < ActiveRecord::Migration[7.2]
  def change
    add_column :reviews, :is_published, :boolean
  end
end
