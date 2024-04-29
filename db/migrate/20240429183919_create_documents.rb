class CreateDocuments < ActiveRecord::Migration[6.1]
  def change
    create_table :documents do |t|
      t.string :uuid
      t.string :pdf_url
      t.text :description
      t.json :document_data

      t.timestamps
    end
  end
end
