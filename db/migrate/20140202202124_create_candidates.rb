class CreateCandidates < ActiveRecord::Migration
  def change
    drop_table :candidates
    create_table :candidates do |t|
      t.belongs_to :jam, index: true
      t.belongs_to :user, index: true
      t.belongs_to :instrument, index: true

      t.timestamps
    end
  end
end
