class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :name
      t.string :picture_url
      t.decimal :initial_price
      t.decimal :final_price
      t.references :buyer, foreign_key: {to_table: :users}
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
