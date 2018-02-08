json.extract! job, :id, :customer_name, :job_link, :created_at, :updated_at
json.url job_url(job, format: :json)
