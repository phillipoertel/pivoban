require 'open-uri'
require 'json'

module HttpHelper

  def fetch_http(url, headers = {})
    headers.merge!("X-TrackerToken" => TOKEN)
    response = open(url, headers)
    if (response.status.first.to_i != 200)
      p "received non-200 status code:"
      p response
      p response.read
      return {}
    else
      JSON.parse(response.read)
    end
  rescue => e
    puts "Failed to fetch #{url} with headers #{headers.inspect}:"
    puts "#{e.class}: #{e}"
  end

end