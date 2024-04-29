storage = Google::Cloud::Storage.new(
  project_id: ENV["GOOGLE_CLOUD_PROJECT_ID"],
  credentials: 'config/gcp.json'
)

GOOGLE_STORAGE_BUCKET = storage.bucket(ENV["GOOGLE_STORAGE_BUCKET_NAME"])