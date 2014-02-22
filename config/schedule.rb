# Use this file to easily define all of your cron jobs.
# Learn more: http://github.com/javan/whenever

every 1.minute do
  rake :fetch_data
  # command "/usr/bin/my_great_command"
end