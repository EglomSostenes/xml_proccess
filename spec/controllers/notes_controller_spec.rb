require 'rails_helper'

RSpec.describe NotesController do
    describe "GET #index" do
        let!(:notes) { create_list(:note, 3) }
        before do
            get :index
        end
    
        it "JSON response status OK" do
            expect(response).to have_http_status :ok
        end
     
        it "returns all the notes" do
            expect(notes.count).to eq(3)
        end
    end

    describe "GET #report" do
        let!(:note) { create(:note) }
        
        it "Note found to report" do
            get :report, params: { id: note.id }
            assert_response :success
            expect(assigns(:note)).to eq(note)
        end
    end
end