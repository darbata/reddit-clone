class CreateMemberships < ActiveRecord::Migration[8.0]
  def change
    create_table :memberships do |t|
      t.string :role, default: "member"
      t.references :user, null: false, foreign_key: true
      t.references :community, null: false, foreign_key: true

      t.timestamps
    end

    add_index :memberships, [:user_id, :community_id], unique: true
  end
end