require "spec_helper"
require "fog/bin"
require "helpers/bin"

describe BareMetalCloud do
  include Fog::BinSpec

  let(:subject) { BareMetalCloud }

  describe "#services" do
    it "includes all services" do
      assert_includes BareMetalCloud.services, :compute
    end
  end

  describe "#class_for" do
    describe "when requesting storage service" do
      it "returns correct class" do
        assert_equal Fog::Compute::BareMetalCloud, BareMetalCloud.class_for(:compute)
      end
    end
  end
end
