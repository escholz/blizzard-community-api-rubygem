require "rspec_helper"
require "../lib/api_request"

include WOW

describe ApiRequest do
  describe "::new" do
    it "should create an instance of ApiRequest" do
      request = ApiRequest.new()
      request.should be_a(ApiRequest)
    end
  end
  describe "#query" do
    it "should be initialized to an empty hash" do
      request = ApiRequest.new()
      request.query.should == {}
    end
  end
  describe "#locale" do
    it "should be initialized to configuration defaults" do
      request = ApiRequest.new()
      request.locale.should == Configuration.default_locale
    end
    it "should be modifiable via constructor options" do
      request = ApiRequest.new(:locale => API_LOCALES[1])
      request.locale.should == API_LOCALES[1]
    end
  end
  describe "#last_modified" do
    it "should be initialized to min time" do
      request = ApiRequest.new()
      request.last_modified.should == Time.at(0)
    end
    it "should be modifiable via constructor options" do
      now = Time.now
      request = ApiRequest.new(:last_modified => now)
      request.last_modified.should == now
    end
  end
  describe "#scheme" do
    it "should be http" do
      request = ApiRequest.new()
      request.scheme.should == "http"
    end
  end
  describe "#hostname" do
    it "should be initialized to the default locale" do
      request = ApiRequest.new()
      request.hostname.should == API_HOST_NAMES[Configuration.default_locale]
    end
    it "should change with locale change" do
      request = ApiRequest.new(:locale => API_LOCALES[1])
      request.hostname.should == API_HOST_NAMES[API_LOCALES[1]]
    end
  end
  describe "#uri" do
    it "should be initialized to the scheme hostname and api root" do
      request = ApiRequest.new()
      request.uri.should == URI.parse("#{request.scheme}://#{API_HOST_NAMES[request.locale]}#{API_ROOT_PATH}")
    end
    it "should be changed by locale" do
      request = ApiRequest.new(:locale => API_LOCALES[1])
      request.uri.should == URI.parse("#{request.scheme}://#{API_HOST_NAMES[API_LOCALES[1]]}#{API_ROOT_PATH}")
    end
  end
  describe "#headers" do
    it "should contain default headers" do
      request = ApiRequest.new()
      request.headers["Date"].should_not be_nil
      DateTime.parse(request.headers["Date"]).should < DateTime.now
      request.headers["If-Modified-Since"].should_not be_nil
      DateTime.parse(request.headers["If-Modified-Since"]).to_time.should == Time.at(0).utc
    end
    it "should change with the last_modified option" do
      last_modified = Time.now.utc
      request = ApiRequest.new(:last_modified => last_modified)
      DateTime.parse(request.headers["If-Modified-Since"]).to_time.utc.to_i.should == last_modified.to_i
    end
  end
  describe "#invoke", :live => true do
    require "../lib/character_profile_request"
    it "should return a json response" do
      request = CharacterProfileRequest.new("Aven","Draenor")
      request.invoke.should be_a(Hash)
    end
    it "should return cached value on subsequent calls" do
      request = CharacterProfileRequest.new("Aven","Draenor")
      obj_id_1 = request.invoke.object_id
      obj_id_2 = request.invoke.object_id
      obj_id_1.should == obj_id_2
    end
    it "should force refresh with option[:force_refresh => true]" do
      request = CharacterProfileRequest.new("Aven","Draenor")
      obj_id_1 = request.invoke.object_id
      obj_id_2 = request.invoke(:force_refresh => true).object_id
      obj_id_1.should_not == obj_id_2
    end
  end
end