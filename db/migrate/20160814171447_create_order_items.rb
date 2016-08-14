class CreateOrderItems < ActiveRecord::Migration[5.0]
	def change
		create_table :order_items do |t|
			t.references :order, foreign_key: true
			t.references :item, foreign_key: true

			t.timestamps
		end
		add_index :order_items, [:item_id, :order_id]
	end
end
