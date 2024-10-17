class AddStarRatingToProducts < ActiveRecord::Migration[7.2]
  def change
    add_column :products, :star_rating, :integer
  end
end
