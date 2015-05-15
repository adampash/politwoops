require 'twitter'
require 'csv'

cfg = YAML.load_file "#{Dir.pwd}/config/config.yml"
Twitter.configure do |config|
  config.consumer_key = cfg[:twitter][:consumer_key]
  config.consumer_secret = cfg[:twitter][:consumer_secret]
  config.oauth_token = cfg[:twitter][:oauth_token]
  config.oauth_token_secret = cfg[:twitter][:oauth_token_secret]
end

module TwitterList
  def self.write_list(username, list)
    users = []
    options = {count: 5000}
    i = 0
    while true
      puts "#{i += 1}"
      members = Twitter::list_members("BuzzFeed", "buzzfeed-editorial", options)
      members.attrs[:users].each do |user|
        users.push(parse_user user)
      end
      cursor = members.attrs[:next_cursor]
      break if cursor == 0
      options = {cursor: cursor, count: 5000}
    end
    write_csv users, "#{username}_#{list}"
    users
  end

  def self.write_csv(users, filename="users")
    CSV.open("#{filename}.csv", 'w') do |csv|
      users.each do |user|
        csv << [
          user[:first_name],
          user[:last_name],
          user[:screen_name],
        ]
      end
    end
  end

  def self.parse_user(user)
    name_split = user[:name].split(" ")
    first = name_split[0]
    last = name_split[1..-1].join(" ")
    {
      first_name: first,
      last_name: last,
      screen_name: user[:screen_name],
    }
  end

end
