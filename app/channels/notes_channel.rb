class NotesChannel < ApplicationCable::Channel

  def subscribed
    stream_from "note-#{params['note']}:notes"
  end
end
