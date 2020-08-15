class NoteCollaboratorBroadcastJob < ApplicationJob
  queue_as :default

  def perform(note_collaborator)
    ActionCable.server.broadcast "note-#{note_collaborator.note_id}:notes", {email: note_collaborator.email, status: note_collaborator.status}
  end
end
