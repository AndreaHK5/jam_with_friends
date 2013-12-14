class CreateIuassociations < ActiveRecord::Migration
  def change
    create_table :iuassociations do |t|
      t.belongs_to :user, index: true
      t.belongs_to :instrument, index: true

      t.timestamps
    end
  end
end
