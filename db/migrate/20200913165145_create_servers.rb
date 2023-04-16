class CreateServers < ActiveRecord::Migration[6.0]
  def change
    create_table :servers, id: :uuid do |t|
      t.string :name
      t.string :description
      t.string :hostname
      t.integer :port, default: 25565

      t.references :user, type: :uuid, foreign_key: {on_delete: :nullify}

      t.integer :locations_count

      t.timestamps

      t.index :name, unique: true
    end
  end
end
