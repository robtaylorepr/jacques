class NotesController < ApplicationController

  def index
    if current_user
      @notes = current_user.notes
      render json: @notes
    else
      @notes = Note.all
      render json: @notes
    end
  end

  def create
    @note = Note.new(note_params)
    if @note.save
      render json: @note
    else
      render json: {errors: @note.errors.full_messages.collect{ |e| {error: e}}}, status: 400
    end
  end

  def show
    @note = Note.find(note_params[:id])
    if @note
      render json: @note, include: ['notes.user', 'notes.tags']
    else
      render json: {errors: @note.errors.full_messages.collect{ |e| {error: e}}}, status: 400
    end
  end

  def by_tag_name
    @tags = Tag.find_by(name: params[:name])
    render json: @tags, include: ['notes.tags', 'notes.user']
  end

  private

  def note_params
    np = params.permit(:title, :body, :tags, :user, :id)
    tags = []
    np[:tags].split(/\s*,\s*/).each do |name|
      tags << Tag.find_or_create_by!(name: name)
    end
    np[:tags] = tags
    return np
  end

end
