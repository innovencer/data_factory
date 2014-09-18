require "spec_helper"

describe "Configuration" do
  before(:all) do
    DataFactory.configure do |config|
      config.http = true
      config.password = "my_password"
    end
  end

  it "should set the channels" do
    %w(fixture calendario posiciones goleadores ficha plantelxcampeonato).each do |x|
      expect(DataFactory.configuration.channels).to include(x)
    end
  end

  it "should set http flag" do
    expect(DataFactory.configuration.http).to eq(true)
  end

  it "should set password" do
    expect(DataFactory.configuration.password).to eq("my_password")
  end
end
