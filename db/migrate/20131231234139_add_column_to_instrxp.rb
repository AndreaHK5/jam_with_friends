class AddColumnToInstrxp < ActiveRecord::Migration
  def change
    add_column :instrxps, :since, :integer
  end
end
