class CreateRelationships < ActiveRecord::Migration[6.0]
  def change
    create_table :relationships do |t|
      t.references :follower, foreign_key: { to_table: :users } #参照するfollowerテーブルがないからusersテーブルから参照している
      t.references :following, foreign_key: { to_table: :users } #上と同じ

      t.timestamps
    end
    #同じ相手に何回もフォローできないようにするため
    add_index :relationships, [:follower_id, :following_id], unique: true
  end
end
