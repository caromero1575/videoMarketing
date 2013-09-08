class AddDetailsToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :target_file, :string
    add_column :videos, :user_id, :integer
    add_column :videos, :state, :integer
  end
end
