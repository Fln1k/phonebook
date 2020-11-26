require 'rails_helper'

RSpec.describe Contact, :type => :model do
	subject {
    described_class.new(name: "example",
                        number: "+375441111111",
                        user_id: 1)
  }

  it "is valid with valid attributes" do
  	user = User.create!(:name => "example",:email => "example@example.com",:password => "example123")
  	subject.user_id = user.id
	  expect(subject).to be_valid
  end

  it "is not valid without a name" do
	  subject.name = nil

	  expect(subject).to_not be_valid
  end

  it "is not valid without a number" do
	  subject.number = nil

	  expect(subject).to_not be_valid
  end

  it "is not valid with wrong phone code format" do
	  subject.number = "+7441111111"
	  expect(subject).to_not be_valid
  end

  it "is not valid with wrong phone code zone" do
	  subject.number = "+375111111111"

	  expect(subject).to_not be_valid
  end

  it "is valid with all available codes and code zones" do
		codes_formats = ["80","+375"]
		codes_zones = ["44","29","17"]
		user = User.create!(:name => "example",:email => "example@example.com",:password => "example123")
  	subject.user_id = user.id
  	
		codes_formats.each{|code|
			codes_zones.each{|codes_zone|
				subject.number = "#{code}#{codes_zone}1111111"
				expect(subject).to be_valid
			}
		}
  end
end