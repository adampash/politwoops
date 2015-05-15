require 'twitter_list'
require 'csv'

namespace :list do
  desc 'Write a twitter list to CSV'
  task :to_csv, [:username, :list_name] => :environment do |t, args|
    puts "Fetching #{args[:list_name]} by #{args[:username]}"
    TwitterList.write_list(args[:list_name], args[:username])
    puts "Wrote to file: #{args[:username]}_#{args[:list_name]}.csv"
  end

  desc "Imports CSV of Twitter list URLs to a CSV of all of those users"
  task :mass_import => :environment do
    file = ENV['CSV']
    puts "Fetching list of lists from #{file}"
    CSV.foreach(file) do |list_url|
      username = list_url.first.match(/twitter.com\/(\w+)\//)[1]
      list_name = list_url.first.match(/twitter.com\/(\w+)\/lists\/([\w-]+)/)[2]
      puts "Fetching #{username} by #{list_name}"
      TwitterList.write_list(username, list_name)
      puts "Wrote to file: #{username}_#{list_name}.csv"
    end
  end
end

