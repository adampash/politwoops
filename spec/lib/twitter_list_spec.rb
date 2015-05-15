require 'twitter_list'
require 'twitter'

describe TwitterList do

  it "fetches a twitter list" do
    users = TwitterList.write_list("BuzzFeed", "buzzfeed-editorial")
  end

  it "writes results to CSV" do
    users = [
      {
        first_name: "Adam",
        last_name: "Pash",
        screen_name: "adampash",
      },
      {
        first_name: "Sam",
        last_name: "Biddle",
        screen_name: "samfbiddle",
      },
    ]
    TwitterList.write_csv(users)
  end

  it "builds a user object for writing the CSV" do
    user = {
      screen_name: 'adampash',
      name: "Adam Pash",
    }
    processed = TwitterList.parse_user(user)
    expect(processed[:first_name]).to eq "Adam"
    expect(processed[:last_name]).to eq "Pash"
    expect(processed[:screen_name]).to eq "adampash"

    user = {
      screen_name: 'adampash',
      name: "Adam Olin Pash",
    }
    processed = TwitterList.parse_user(user)
    expect(processed[:first_name]).to eq "Adam"
    expect(processed[:last_name]).to eq "Olin Pash"
  end
end
