class CreateTexts < ActiveRecord::Migration
  def change
    create_table :texts do |t|
      t.string :title
      t.text :body
      t.text :description
      t.references :collection, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
