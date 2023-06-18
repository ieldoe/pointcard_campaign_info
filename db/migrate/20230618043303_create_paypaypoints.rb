class CreatePaypaypoints < ActiveRecord::Migration[7.0]
  def change
    create_table :paypaypoints do |t|
      t.text :p_info
      t.text :p_image
      t.text :p_link

      t.timestamps
    end
  end
end
