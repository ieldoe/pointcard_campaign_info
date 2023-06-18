class CreateTpoints < ActiveRecord::Migration[7.0]
  def change
    create_table :tpoints do |t|
      t.text :t_info
      t.text :t_image
      t.text :t_link

      t.timestamps
    end
  end
end
