class Api::V1::NotesController < ApplicationController
  before_action :set_note, except: %i[index create]

  def index
    notes = Note.order(created_at: :desc)

    render json: notes
  end

  def show
    render json: @note
  end

  def create
    note = Note.new(note_params)

    if note.save!
      render json: note, status: 200
    else
      render json: note.errors, status: 400
    end
  end

  def update
    if @note.update!(note_params)
      render json: @note, status: 200
    else
      render json: @note.errors, status: 400
    end
  end

  def destroy
    if @note.destroy!(note_params)
      render json: @note, status: 200
    else
      render json: @note.errors, status: 400
    end
  end

  private

  def note_params
    params.require(:note).permit(:title, :description)
  end

  def set_note
    @note = Note.new(note_params)
  end
end
