json.array!(@issues) do |issue|
  json.extract! issue, :id, :subject, :body, :department_id, :user_id
  json.url issue_url(issue, format: :json)
end
