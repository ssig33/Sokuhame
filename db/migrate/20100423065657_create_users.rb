class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :name
      t.string :service_type
      t.string :token
      t.string :secret_token
      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
