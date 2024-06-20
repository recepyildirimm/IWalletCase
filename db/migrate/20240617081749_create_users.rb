class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :username
      t.string :email
      t.string :phone
      t.string :website
      t.json :address
      t.json :company
      t.string :photo_url

      t.timestamps
    end
  end
end
