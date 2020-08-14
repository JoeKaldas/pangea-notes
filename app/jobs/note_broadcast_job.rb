class NoteBroadcastJob < ApplicationJob
  queue_as :default

  def perform(note)
    ActionCable.server.broadcast "note-#{note.id}:notes", {note_id: note.id, title: note.title, body: note.body}
  end
end
