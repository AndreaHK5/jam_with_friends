class AddColumnToUser < ActiveRecord::Migration
  def change
    add_column :users, :pers_picture, :string
  end
end
