class CreateNotes < ActiveRecord::Migration[7.0]
  def change
    create_table :notes do |t|
      t.string :codigo
      t.decimal :valor
      t.decimal :icms
      t.decimal :ipi
      t.decimal :pis
      t.decimal :cofins
      t.decimal :total_valor_produtos
      t.timestamps
    end
  end
end
