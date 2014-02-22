require_relative 'http_helper'

class StoryData

  extend HttpHelper

  def self.request(story_id)
    url = "https://www.pivotaltracker.com/services/v5/projects/#{PROJECT_ID}/stories/#{story_id}"
    fetch_http(url)
  end

  def self.get(story_id)
    request(story_id)
  end

end
