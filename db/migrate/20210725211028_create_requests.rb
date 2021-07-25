class CreateRequests < ActiveRecord::Migration[6.1]
  def change
    create_table :requests do |t|
      t.references :user, null: false, foreign_key: true
      t.references :requestable, polymorphic: true, null: false
      t.integer :method

      t.timestamps
    end
  end
end
