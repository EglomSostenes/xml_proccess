# frozen_string_literal: true

require 'rails_helper'

describe ProccessNoteJob do
  describe '#perform' do
    subject { described_class.new.perform(note) }

    let(:note) { "#{Rails.root}/spec/note_test.xml" }

    before do
      allow(ProccessNote).to receive(:execute)
    end

    it 'should call DomainRepository' do
      subject
      expect(ProccessNote).to have_received(:execute).with(note)
    end
  end
end