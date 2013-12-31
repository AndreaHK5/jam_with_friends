class RenameIuassociationToInstrexp < ActiveRecord::Migration
  def change
    rename_table :iuassociations, :instrexps
  end
end
