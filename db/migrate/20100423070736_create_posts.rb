class CreatePosts < ActiveRecord::Migration
  def self.up
    create_table :posts do |t|
      t.string :memo
      t.string :cost
      t.string :address
      t.string :user_id
      t.timestamps
    end
  end

  def self.down
    drop_table :posts
  end
end
