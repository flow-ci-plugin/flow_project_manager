require "spec_helper"

RSpec.describe FlowProjectManager do
  it "has a version number" do
    expect(FlowProjectManager::VERSION).not_to be nil
  end
end
