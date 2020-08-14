class NoteCollaborator < ApplicationRecord

  belongs_to :note
  belongs_to :user

  enum access: {view: 0, edit: 1}
  enum status: {inactive: 0, active: 1}

end
