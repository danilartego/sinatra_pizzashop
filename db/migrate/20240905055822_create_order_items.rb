class CreateOrderItems < ActiveRecord::Migration[7.2]
  def change
    create_table :order_items do |t|
      t.references :product
      t.references :order
      t.decimal :value

      t.timestamps
    end
  end
end
