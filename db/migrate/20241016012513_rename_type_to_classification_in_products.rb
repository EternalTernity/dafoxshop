class RenameTypeToClassificationInProducts < ActiveRecord::Migration[7.2]
  def change
    rename_column :products, :type, :classification
  end
end
