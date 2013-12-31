class AddColumnToInstrxp < ActiveRecord::Migration
  def change
    add_column :instrxps, :since, :fixnum
  end
end
