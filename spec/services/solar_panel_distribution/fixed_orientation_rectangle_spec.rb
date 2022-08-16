require 'rails_helper'

RSpec.describe PanelDistribution::FixedOrientationRectangle do
  def create_distribution
    described_class.new(
      roof_dimmension_x: roof_dimmension_x,
      roof_dimmension_y: roof_dimmension_y,
      solar_panel_dimmension_x: solar_panel_dimmension_x,
      solar_panel_dimmension_y: solar_panel_dimmension_y
    )
  end

  let(:roof_dimmension_x) { 3 }
  let(:roof_dimmension_y) { 5 }
  let(:solar_panel_dimmension_x) { 1 }
  let(:solar_panel_dimmension_y) { 2 }

  context "valid initialization" do
    let(:distribution_service) do
      create_distribution
    end

    it "returns correct dimmensions" do
      expect(distribution_service.roof_dimmension_x).to eq 3
      expect(distribution_service.roof_dimmension_y).to eq 5
      expect(distribution_service.solar_panel_dimmension_x).to eq 1
      expect(distribution_service.solar_panel_dimmension_y).to eq 2
    end

    it "calculates position" do
      solar_panels = distribution_service.calculate_solar_panels_array

      expect(solar_panels.count).to eq(6)
      expect(solar_panels.last.position_x).to eq(2)
      expect(solar_panels.last.position_y).to eq(2)
    end

    context "should not rotate solar panels" do
      let(:solar_panel_dimmension_x) { 2 }
      let(:solar_panel_dimmension_y) { 1 }

      it "calculates position" do
        solar_panels = distribution_service.calculate_solar_panels_array

        expect(solar_panels.count).to eq(5)
        expect(solar_panels.last.position_x).to eq(0)
        expect(solar_panels.last.position_y).to eq(4)
      end
    end
  end

  context "invalid initialization" do
    let(:roof_dimmension_x) { -2 }

    it "raises error" do
      expect {create_distribution}.to raise_error(RuntimeError, /All dimmensions need to be positive/)
    end
  end
end
