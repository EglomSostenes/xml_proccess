class ProccessNote
    def initialize(note)
        @note = note
    end

    def self.execute(note)
        new(note).save_to_report
    end

    def save_to_report
        doc = Nokogiri::XML(File.read(@note))
        note_generated = save_note(doc)
        proccess_products(doc, note_generated)
    end

    private

    def save_note(doc)
        note = Note.new
        note.codigo = doc.xpath("//xmlns:ide").search("cNF").text
        note.valor = doc.xpath("//xmlns:total").search("vNF").text.to_f
        note.icms = doc.xpath("//xmlns:total").search("vICMS").text.to_f
        note.ipi = doc.xpath("//xmlns:total").search("vIPI").text.to_f
        note.pis = doc.xpath("//xmlns:total").search("vPIS").text.to_f
        note.cofins = doc.xpath("//xmlns:total").search("vCOFINS").text.to_f
        note.total_valor_produtos = doc.xpath("//xmlns:total").search("vProd").text.to_f
        note.save
        note
    end

    def proccess_products(doc, note_generated)
        product_list = doc.xpath('//xmlns:det')
        product_list.each do |product|
            save_product(product, note_generated)
        end
    end

    def save_product(product, note_generated)
        product_generation = Product.new
        description = product.search("prod")
        details_product(product_generation, description)

        impostos = product.search("imposto")
        impostos_product(product_generation, impostos)
        
        product_generation.note = note_generated

        product_generation.save
    end

    def details_product(product_generation, description)
        product_generation.codigo = description.search("cProd").text
        product_generation.descricao = description.search("xProd").text
        product_generation.unidade_compra = description.search("uCom").text
        product_generation.quantidade_compra = description.search("qCom").text.to_f
        product_generation.valor_unitario = description.search("vUnCom").text.to_f
        product_generation.valor_compra = description.search("vProd").text.to_f
    end

    def impostos_product(product_generation, impostos)
        product_generation.icms = impostos.search('vICMS').text.to_f
        product_generation.ipi = impostos.search('vIPI').text.to_f
        product_generation.pis = impostos.search('vPIS').text.to_f
        product_generation.cofins = impostos.search('vCOFINS').text.to_f
    end
end
