class DeleteColumn < ActiveRecord::Migration[7.0]
  def change
    remove_column :paypaypoints, :p_image, :text
  end
end
