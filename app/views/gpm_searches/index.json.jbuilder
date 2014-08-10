json.array!(@gpm_searches) do |gpm_search|
  json.extract! gpm_search, :id
  json.url gpm_search_url(gpm_search, format: :json)
end
