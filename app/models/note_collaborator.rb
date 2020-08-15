class NoteCollaborator < ApplicationRecord

  belongs_to :note

  enum access: {view: 0, edit: 1}
  enum status: {inactive: 0, active: 1}

  validates :email, uniqueness: { case_sensitive: false, scope: [:note_id], message: "already a collaborator on this note" }, on: :create

  scope :for_note, -> (note) { where(note_id: note.id) }

  after_update_commit {NoteCollaboratorBroadcastJob.perform_now self}
end
