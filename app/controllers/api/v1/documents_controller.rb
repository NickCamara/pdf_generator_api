class Api::V1::DocumentsController < ApplicationController
  def create
    description = params[:description]
    document_data = params[:document_data]
    template = params[:template]

    html_content = substitute_placeholders(template, document_data)

    pdf_data = generate_pdf(html_content)

    pdf_url = upload_to_cloud_storage(pdf_data)

    document = Document.create!(
      uuid: SecureRandom.uuid,
      pdf_url: pdf_url,
      description: description,
      document_data: document_data
    )

    render json: document, status: :created
  rescue StandardError => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  def list
    @documents = Document.all
    render json: @documents
  end

  private

  def substitute_placeholders(template, data)
    template.gsub(/{{(.*?)}}/) { data[$1.strip] }
  end

  def generate_pdf(html_content)
    pdf = WickedPdf.new.pdf_from_string(html_content)
    pdf_data = StringIO.new(pdf)
    pdf_data
  end

  def upload_to_cloud_storage(pdf_data)
    file_name = "#{SecureRandom.uuid}.pdf"
    file = GOOGLE_STORAGE_BUCKET.create_file(pdf_data, file_name)

    file.acl.public!

    file.public_url
  end
end
