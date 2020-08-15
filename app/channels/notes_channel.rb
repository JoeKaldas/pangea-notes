class NotesChannel < ApplicationCable::Channel

  def subscribed
    stream_from "note-#{params['note']}:notes"
  end

  def unsubscribed
    nc = NoteCollaborator.find_by(note_id: params["note"], email: current_user.email)
    nc.update(status: 0) if nc
  end

  def update_user_status(params)
    nc = NoteCollaborator.find_by(note_id: params["note_id"], email: params["email"])
    nc.update(status: params["status"]) if nc
  end
end
