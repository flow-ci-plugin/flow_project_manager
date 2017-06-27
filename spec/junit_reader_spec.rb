require "spec_helper"
require 'utils/junit_reader'

RSpec.describe JunitReader do
  it "could read junit xml" do
    dict = JunitReader.build_json_from_juniter("#{__dir__}/example_files/report_2.junit")
    expect(dict["name"]).to eq "flowcicocopadUITests.xctest"
    expect(dict["testsuites"].count).to eq 2
    test_suite = dict["testsuites"].first
    expect(test_suite["name"]).to eq "flowcicocopadTests"
    expect(test_suite["testcases"].count).to eq 2
  end
end
