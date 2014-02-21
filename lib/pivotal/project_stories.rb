class ProjectStories
  
  extend HttpHelper
  
  def self.request(project_id, params)
    url = "https://www.pivotaltracker.com/services/v5/projects/#{project_id}/stories"
    query_string = params.map { |k, v| "#{k}=#{URI.escape(v.to_s)}"}.join("&") 
    url << "?"
    url << query_string
    fetch_http(url)
  end

  def self.get(project_id)    
    # type: feature, Bug, Chore or Release.
    # state: unscheduled, unstarted, started, finished, delivered, accepted, or rejected
    params = { filter: "created_after:08/01/2013", limit: 20 }
    stories = request(project_id, params)
    out = []
    #features = data.select { |story| story['story_type'] == "bug"}
    stories.each do |story|
      out << OpenStruct.new(id: story["id"], created_at: story["created_at"], estimate: story["estimate"], name: story["name"])
    end
    out
  end
end