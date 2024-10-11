class CreateAddresses < ActiveRecord::Migration[7.2]
  def change
    create_table :addresses do |t|

      t.string :barangay
      t.integer :zip_code
      t.string :street
      t.integer :house_number
      t.belongs_to :order,null:false,foreign_key: true
      t.belongs_to :user
      t.timestamps
    end
  end
end
