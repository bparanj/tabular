class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :title
      t.string :city
      t.integer :age
      t.date :start_date
      t.string :salary

      t.timestamps
    end
  end
end
