class CreateNoteCollaborators < ActiveRecord::Migration[6.0]
  def change
    create_table :note_collaborators do |t|

      t.references :note,	foreign_key: true
      t.references :user,	foreign_key: true
      t.integer :access
      t.integer :status, default: 0
      t.timestamps
    end
  end
end
