class CreateContacts < ActiveRecord::Migration[6.0]
  def change
    create_table :contacts do |t|
      t.string :name
      t.string :number
      t.references :user, null: false, foreign_key: true
      t.index [:number, :user_id], unique: true

      t.timestamps
    end
  end
end
