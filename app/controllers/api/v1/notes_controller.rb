class Api::V1::NotesController < ApplicationController
  before_action :set_note, except: %i[index create]

  def index
    notes = Note.order(created_at: :desc)

    render json: NoteSerializer.new(notes)
  end

  def show
    render json: NoteSerializer.new(@note)
  end

  def create
    note = Note.new(note_params)

    if note.save
      render json: NoteSerializer.new(note)
    else
      render json: { errors: note.errors.messages }, status: 422
    end
  end

  def update
    if @note.update(note_params)
      render json: { status: 200 }
    else
      render json: { body: note.errors.full_messages, status: 422 }, status: 422
    end
  end

  def destroy
    if @note.destroy
      render json: { status: 200 }
    else
      render json: { body: note.errors.full_messages, status: 422 }, status: 422
    end
  end

  private

  def note_params
    params.require(:note).permit(:title, :description)
  end

  def set_note
    @note = Note.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { message: 'Not found', status: 404 }, status: 404
  end
end
