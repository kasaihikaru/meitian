class CreateThemes < ActiveRecord::Migration[5.2]
  def change
    create_table :themes do |t|
      t.references :user, index: true, foreign_key: true
      t.text  :theme
      t.date  :yearmonth
      t.timestamps
    end
  end
end
