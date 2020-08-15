class NotesController < ApplicationController

  before_action :authenticate_user!
  before_action :set_note, only: [:show, :edit, :update, :destroy]

  def index
    respond_to do |format|
      format.html
      format.json { render json: NoteDatatable.new(params, view_context: view_context, current_user: current_user), status: :ok }
    end
  end

  def show
    if !@note
      return render :file => "#{Rails.root}/public/404", :layout => false, :status => :not_found
    end

    @edit = (NoteCollaborator.find_by(note_id: params[:id], email: current_user.email) and NoteCollaborator.find_by(note_id: params[:id], email: current_user.email).edit?)
  end

  def new
    @note = current_user.notes.new
  end

  def create
    @note = current_user.notes.create(note_params)

    respond_to do |format|
      if @note.valid?
        format.html { redirect_to notes_path, notice: 'Note has been created successfully' }
        format.json { render json: {message: "Note has been created successfully"}, status: :ok }
      else
        format.html { redirect_to new_note_path }
        format.json { render json: {error_messages: @note.errors.full_messages}, status: :unprocessable_entity }
      end
    end
  end

  def edit

  end

  def update
    @note.update(note_params)

    respond_to do |format|
      if @note.valid?
        format.html { redirect_to notes_path, notice: 'Note has been updated successfully' }
        format.json { render json: {message: "Note has been updated successfully"}, status: :ok }
      else
        format.html { redirect_to new_note_path }
        format.json { render json: {error_messages: @note.errors.full_messages}, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @note.destroy

    respond_to do |format|
      format.html { redirect_to notes_path, notice: 'Note has been deleted successfully' }
      format.json { render json: {message: "Note has been deleted successfully"}, status: :ok }
    end
  end

  private
  def set_note
    @note = Note.joins(:note_collaborators).where(id: params[:id]).find_by("note_collaborators.email =?", current_user.email)
  end

  def note_params
    params.require(:note).permit(:title, :body)
  end

end
