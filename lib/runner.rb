class Runner

  def self.run
    stories = ProjectStories.get(PROJECT_ID)
    stories.each do |story|
      p story.id
      activity = StoryActivityData.get(story.id)
      p activity
      activity.marshal_dump.each do |key, value|
        story.send("#{key}=", value)
      end
    end

    csv_fields = %w(id name estimate accepted added_at started_at accepted_at lead_time cycle_time)
    CSV.open("pivotal_times_bugs_2.csv", 'wb', col_sep: ";", headers: stories.first.marshal_dump.keys, write_headers: true) do |csv|
      stories.each do |story|
        row = csv_fields.map { |field| story.send(field) }
        csv << row
      end
    end
  end
end