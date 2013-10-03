ENV['RACK_ENV'] = 'test'

require './app' # <-- your sinatra app
require 'rspec'
require 'rack/test'
include Rack::Test::Methods


def app
  Sinatra::Application
end


describe 'Wine and Dash Homepage' do


 

  it "serves the index file" do
  	# puts last_request.inspect
    get '/'
    # puts last_request.inspect
    expect(last_response.status).to eq(200)
    expect(last_response).to be_ok
    # puts last_response.body 
    # puts last_response.class
    puts last_response.methods.sort.inspect

    # foo = erb :index
    expect(last_response.body).to eq('
<head>
<link rel="stylesheet" type="text/css" href="style.css">
<link rel="stylesheet" type="text/css" href="reset.css">
<title>Wine and Dash - The One Place to Plan your Wine Visits.</title>
</head>



<body>
	This is my layout page
</body>

<form action ="/" method="post">
	<input type="text" name="username" placeholder="username" required>
	<br>
	<input type="password" name="password" required>
	<br>
	<input type="submit" name="submit" value="click it!">	
</form>

')
  end
end


describe 'the user' do

	before do
  	User.destroy_all
  	@user = User.new(first_name: "test", last_name: "test", email: "test", username: "test", password: "test")
    @user.save
    @fakeuser = User.new(first_name: "test 2", last_name: "test 2", email: "test 2", username: "fake person", password: "not test")
    @fakeuser.save
  end

	it "should create a user" do 
    expect(@user.first_name).to eq("test")
  end

  it "should return false for a user with bad credentials using User.Authenticate" do 
    expect(User.authenticate("not a user","not a test")).to eql(false)
  end

  it "should redirect users with false passwords to /" do
  	post "/", {:username => "fake person", :password => "test"}
  	expect(last_response.status).to eq(302)
  	# expect(last_response.body).to eq("success")
  	follow_redirect!
  	expect(last_response.status).to eq(200)
  	expect("http://example.org/").to eql(last_request.url)
  end

  

  it "should auth a user with User.Authenticate" do 
    expect(User.authenticate("test","test")).to eql(@user)
  end


  it "should login users and redirect to home" do
  	post "/", {:username => "test", :password => "test"}
  	follow_redirect!
  	expect("http://example.org/home").to eql(last_request.url)
  end

  it "should redirect and display the persons username and email as stored in the session" do
  	post "/", {:username => "test", :password => "test"}
  	expect(last_response.status).to eq(302)
  	follow_redirect!
  	expect(last_response.status).to eq(200)
  	expect("http://example.org/home").to eql(last_request.url)
    expect(last_response.body.match('email: test').to_s).to eq("email: test")

  end



end