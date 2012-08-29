class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :username
      t.string :password_hash
      t.string :password_salt
      t.string :persistence_token, :null => false, :default => true
      t.datetime :current_login_at
      t.datetime :last_login_at
      t.string :current_login_ip
      t.string :last_login_ip
      t.timestamps
    end

    User.new(
      :username => "admin",
      :password => "admin123"
    ).save!
  end

  def self.down
    drop_table :users
  end
end
