class CreateInvites < ActiveRecord::Migration
  def change
    create_table :invites do |t|
      t.belongs_to :jam, index: true
      t.belongs_to :user, index: true
      t.belongs_to :instrument, index: true

      t.timestamps
    end
  end
end
