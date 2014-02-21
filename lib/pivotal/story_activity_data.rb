class StoryActivityData
  extend HttpHelper

  def self.request(story_id)
    url = "https://www.pivotaltracker.com/services/v5/projects/#{PROJECT_ID}/stories/#{story_id}/activity"
    fetch_http(url)
  end

  def self.get(story_id)
    data = request(story_id)
    p data
    out  = OpenStruct.new(lead_time: nil, cycle_time: nil, accepted: false)

    # created
    # TODO find the moment when story was selected to be developed. "moved and scheduled?"
    added_data = data.find { |change| change["highlight"] == "added" }
    if added_data 
      out.added_at = Time.parse(added_data["occurred_at"])
      out.added_by = added_data["performed_by"]["name"]
    end

    # started
    start_data = data.select { |change| change["highlight"] == "started" }.last
    if start_data
      out.started_at = Time.parse(start_data["occurred_at"])
      out.started_by = start_data["performed_by"]["name"]
    end

    # accepted
    accept_data = data.select { |change| change["highlight"] == "accepted" }.first
    if accept_data
      out.accepted_at = Time.parse(accept_data["occurred_at"])
      out.accepted_by = accept_data["performed_by"]["name"]

      out.accepted   = true
      if out.started_at
        out.cycle_time = ((out.accepted_at - out.started_at) / SEC_TO_DAYS_MULTIPLIER).round
      end
      if out.added_at
        out.lead_time  = ((out.accepted_at - out.added_at) / SEC_TO_DAYS_MULTIPLIER).round 
      end
    end

    out
  end
end