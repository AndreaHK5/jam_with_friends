class RenameIuassociationToInstrxp < ActiveRecord::Migration
  def change
    rename_table :iuassociations, :instrxps
  end
end
