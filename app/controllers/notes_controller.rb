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

  end

  def create

  end

  def edit

  end

  def update

  end

  def destroy

  end

  private
  def set_note
    @note = current_user.notes.find_by(id: params[:id])
  end

end
