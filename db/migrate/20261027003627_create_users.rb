class CreateUsers < ActiveRecord::Migration[8.1]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :email, null: false 
      t.string :password_digest, null: false
      t.string :status, default: "active"
      t.datetime :last_login_at
      t.string :job_position

      t.timestamps
    end
  end
end
