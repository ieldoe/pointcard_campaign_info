class CreateDpoints < ActiveRecord::Migration[7.0]
  def change
    create_table :dpoints do |t|
      t.text :d_info
      t.text :d_image
      t.text :d_link
      t.text :d_timeline

      t.timestamps
    end
  end
end
