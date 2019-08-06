class CreateCheckitems < ActiveRecord::Migration
  def change
    create_table :checkitems do |t|

      t.timestamps null: false
    end
  end
end
