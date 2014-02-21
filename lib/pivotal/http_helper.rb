module HttpHelper

  def fetch_http(url, headers = {})
    headers.merge!("X-TrackerToken" => TOKEN)
    response = open(url, headers).read
    JSON.parse(response)
  rescue => e
    puts "Failed to fetch #{url} with headers #{headers.inspect}:"
    puts e.message
  end

end