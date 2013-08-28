class AddImageUrlToPublications < ActiveRecord::Migration
  def change
    add_column :publications, :image_url, :string
  end
end
