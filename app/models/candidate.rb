class Candidate < ActiveRecord::Base
  belongs_to :jam
  belongs_to :user
  belongs_to :instrument
end
