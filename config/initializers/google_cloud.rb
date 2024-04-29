storage = Google::Cloud::Storage.new(
  project_id: 'fluted-expanse-421815',
  credentials: 'config/gcp.json'
)

GOOGLE_STORAGE_BUCKET = storage.bucket('docsales')