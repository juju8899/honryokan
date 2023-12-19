class AddIsbnToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :isbn, :string
  end
end
