class CreateLocations < ActiveRecord::Migration[6.0]
  def change
    create_table :locations, id: :uuid do |t|
      t.string :name
      t.string :description
      t.integer :dimension, default: 0
      t.integer :x
      t.integer :y
      t.integer :z

      t.references :server, type: :uuid, null: false, foreign_key: { on_delete: :cascade }
      t.references :user, type: :uuid, foreign_key: { on_delete: :nullify }

      t.timestamps

      t.index [:server_id, :name], unique: true
    end
  end
end
