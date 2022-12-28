class NotesController < ApplicationController

    def index
        @notes = Note.all
    end

    def report
        @note = Note.find(params[:id])
    end

    def proccess_note
    end

    def import_notes
        current = 0
        current = Note.last.id + 1 if Note.count > 0
        file_xml_path = "#{Rails.root}/storage/notes_#{current}"
        File.write(file_xml_path, params[:note_file_xml].read)
        ProccessNoteJob.perform_later(file_xml_path)
        redirect_to notes_path
    end

end
