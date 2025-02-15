class CreateVotes < ActiveRecord::Migration[8.0]
  def change
    create_table :votes do |t|
      t.integer :value
      t.references :post, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true, unique: true

      t.timestamps
    end
  end
end
