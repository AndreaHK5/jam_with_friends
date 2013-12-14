class CreateGuassociations < ActiveRecord::Migration
  def change
    create_table :guassociations do |t|
      t.belongs_to :user, index: true
      t.belongs_to :genere, index: true

      t.timestamps
    end
  end
end
