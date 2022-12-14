class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.string :country, null: false
      t.string :state
      t.string :city
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
