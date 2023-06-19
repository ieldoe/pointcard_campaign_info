class CreatePaypayimages < ActiveRecord::Migration[7.0]
  def change
    create_table :paypayimages do |t|
      t.text :p_src

      t.timestamps
    end
  end
end
