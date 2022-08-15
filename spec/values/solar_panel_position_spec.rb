require 'rails_helper'

RSpec.describe SolarPanelPosition do
  def create_solar_panel
    described_class.new(
      position_x: position_x,
      position_y: 3,
      width: width,
      height: 2
    )
  end

  context "valid initialization" do
    let(:position_x) { 2 }
    let(:width) { 1 }
    let!(:solar_panel) do
      create_solar_panel
    end

    it "returns correct values" do
      expect(solar_panel.position_x).to eq 2
      expect(solar_panel.position_y).to eq 3
      expect(solar_panel.width).to eq 1
      expect(solar_panel.height).to eq 2
    end
  end

  context "invalid initialization" do
    context "negative position" do
      let(:position_x) { -2 }
      let(:width) { 1 }

      it "raises error" do
        expect {create_solar_panel}.to raise_error(
          RuntimeError, /Positional values need to be zero or positive/
        )
      end
    end
    context "zero dimmension" do
      let(:position_x) { 2 }
      let(:width) { 0 }

      it "raises error" do
        expect {create_solar_panel}.to raise_error(RuntimeError, /Dimmensions need to be positive/)
      end
    end
  end
end
