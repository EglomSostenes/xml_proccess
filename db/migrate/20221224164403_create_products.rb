class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :codigo
      t.string :descricao
      t.string :unidade_compra
      t.decimal :quantidade_compra
      t.decimal :valor_unitario
      t.decimal :valor_compra
      t.decimal :icms
      t.decimal :ipi
      t.decimal :pis
      t.decimal :cofins
      t.decimal :outro
      t.references :note, null: false, foreign_key: true

      t.timestamps
    end
  end
end
