class CreateInstrxps < ActiveRecord::Migration
  def change
    create_table :instrxps do |t|
      t.belongs_to :user, index: true
      t.belongs_to :instrument, index: true

      t.timestamps
    end
  end
end
