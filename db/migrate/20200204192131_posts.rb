class Posts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.integer :user_id
      t.string :caption
      t.timestamps
    end
  end
end
