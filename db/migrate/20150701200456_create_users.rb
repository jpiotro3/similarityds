class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
        t.string  :email, null: false
        t.string  :password_digest, null: false
        t.string  :role, null: false, default: 'user'
        t.string  :first_name, null: false
        t.string  :last_name, null: false
        t.string  :nickname, null: false
        t.boolean :use_full_name, null: false
        t.boolean :incl_in_thesis, null: false
        t.boolean :incl_in_rankings, null: false
      t.timestamps null: false
    end
  end
end
