class Note < ApplicationRecord

  belongs_to :user
  has_many :note_collaborators

  after_update_commit {NoteBroadcastJob.perform_now self}

end
