class NoteCollaboratorsController < ApplicationController
  before_action :authenticate_user!

  def new
    @note_collaborator = NoteCollaborator.new
  end

  def create
    @note_collaborator = NoteCollaborator.create(note_params)

    respond_to do |format|
      if @note_collaborator.valid?
        format.html { redirect_to notes_path, notice: 'Collaborator has been added successfully' }
        format.json { render json: {message: "Collaborator has been added successfully"}, status: :ok }
        format.js {}
      else
        format.html { redirect_to notes_path }
        format.json { render json: {error_messages: @note_collaborator.errors.full_messages}, status: :unprocessable_entity }
        format.js { render :new }
      end
    end
  end

  private
  def note_params
    params.require(:note_collaborator).permit(:note_id, :email, :access, :status)
  end
end
