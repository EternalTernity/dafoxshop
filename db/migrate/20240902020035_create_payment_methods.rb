class CreatePaymentMethods < ActiveRecord::Migration[7.2]
  def change
    create_table :payment_methods do |t|
      t.string :name
      t.string :fee_type
      t.decimal :fee_value

      t.timestamps
    end
  end
end
