class CreateProductParts < ActiveRecord::Migration[6.1]
  def change
    create_table :product_parts do |t|
      t.string :name, null: false
      t.references :product, null: false, foreign_key: true

      t.timestamps
    end
  end
end
