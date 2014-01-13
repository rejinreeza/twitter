class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :url
      t.string :filename
	  t.integer :user_id
      t.timestamps
    end
	add_index :photos, :user_id
  end
end
