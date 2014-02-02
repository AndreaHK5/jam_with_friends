class CreateJams < ActiveRecord::Migration
  def change
    create_table :jams do |t|
      t.belongs_to :location, index: true
      t.belongs_to :user, index: true
      t.datetime :date

      t.timestamps
    end
  end
end
