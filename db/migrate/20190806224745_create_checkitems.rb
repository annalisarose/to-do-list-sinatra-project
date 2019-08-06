class CreateCheckitems < ActiveRecord::Migration
  def change
    create_table :checkitems do |t|
      t.string :contents
      t.integer :list_id
    end
  end
end
