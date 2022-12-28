# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProccessNote, type: :service do
    describe '.save_to_report' do

        subject { described_class.new(note_file).save_to_report }

        context 'Create note and products' do
            let(:note_file) { "#{Rails.root}/spec/fixtures/note_test.xml" }

            let(:note_params) do
                {
                    codigo: subject.xpath("//xmlns:ide").search("cNF").text,
                    valor: subject.xpath("//xmlns:total").search("vNF").text.to_f,
                    icms: subject.xpath("//xmlns:total").search("vICMS").text.to_f,
                    ipi: subject.xpath("//xmlns:total").search("vIPI").text.to_f,
                    pis: subject.xpath("//xmlns:total").search("vPIS").text.to_f,
                    cofins: subject.xpath("//xmlns:total").search("vCOFINS").text.to_f,
                    total_valor_produtos: subject.xpath("//xmlns:total").search("vProd").text.to_f
                }
            end

            let!(:note_model) { create(:note, note_params)  }

            let(:product_list) { subject.xpath('//xmlns:det') }
            let(:description) { product_list[0].search("prod") }
            let(:impostos) { product_list[0].search("imposto") }

            let(:product_params) do
                {
                    note: note_model,
                    codigo: description.search("cProd").text,
                    descricao: description.search("xProd").text,
                    unidade_compra: description.search("uCom").text,
                    quantidade_compra: description.search("qCom").text.to_f,
                    valor_unitario: description.search("vUnCom").text.to_f,
                    valor_compra: description.search("vProd").text.to_f,
                    icms: impostos.search('vICMS').text.to_f,
                    ipi: impostos.search('vIPI').text.to_f,
                    pis: impostos.search('vPIS').text.to_f,
                    cofins: impostos.search('vCOFINS').text.to_f,
                }
            end

            let!(:product_model) { create(:product, product_params) }

            it 'Save new Note' do
                expect(Note.last.codigo).to eq '80038168'
            end

            it 'Save new Product' do
                expect(Product.last.codigo).to eq '28946'
            end

            it 'Product is from note created' do
                expect(Product.last.note.codigo).to eq '80038168'
            end
        end
    end
end
