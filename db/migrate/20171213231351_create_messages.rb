class CreateMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :messages do |t|
      t.string :message_id

      t.references :user, foreign_key: { on_delete: :cascade }

      t.string :adress
      t.string :times
      t.date :end_date
      t.integer :price
      t.boolean :is_done, default: false

      t.timestamps
    end
  end
end
