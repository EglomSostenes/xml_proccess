class ProccessNoteJob < ApplicationJob
    queue_as :default
  
    def perform(note_file_xml)
        ProccessNote.execute(note_file_xml)
    end

end
