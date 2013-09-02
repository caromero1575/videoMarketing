class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
    	 t.string :name
      	t.string :message
      	t.string :file

      	t.timestamps
    end
  end
end
