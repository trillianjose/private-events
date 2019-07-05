class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :title
      t.datetime :schedule
      t.text :description

      t.timestamps
    end
  end
end
