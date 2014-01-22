class AddAttachmentPhotoToInstruments < ActiveRecord::Migration
  def self.up
    change_table :instruments do |t|
      t.attachment :photo
    end
  end

  def self.down
    drop_attached_file :instruments, :photo
  end
end
