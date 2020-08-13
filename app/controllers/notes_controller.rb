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
    @note.update_attributes(note_params)

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
    @note = current_user.notes.find_by(id: params[:id])
  end

  def note_params
    params.require(:note).permit(:title, :body)
  end

end
