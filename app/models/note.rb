class Note < ApplicationRecord

  belongs_to :user
  has_many :note_collaborators, dependent: :delete_all

  after_create_commit {
    self.note_collaborators.create(email: self.user.email, access: 1)
  }
  after_update_commit {NoteBroadcastJob.perform_now self}

end
