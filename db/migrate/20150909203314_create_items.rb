class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :description
      t.string :comment
      t.belongs_to :event

      t.timestamps null: false
    end

    add_index :items, :event_id
  end
end
