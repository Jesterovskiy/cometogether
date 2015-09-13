class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string   :name, null: false
      t.string   :description
      t.string   :location
      t.datetime :date
      t.belongs_to :user

      t.timestamps null: false
    end

    add_index :events, :user_id
  end
end
