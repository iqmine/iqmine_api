class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :name
      t.integer :age
      t.string :email
      t.string :mobile
      t.string :city
      t.string :country

      t.timestamps
    end
  end
end
