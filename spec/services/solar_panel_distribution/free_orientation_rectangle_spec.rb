require 'rails_helper'

RSpec.describe PanelDistribution::FreeOrientationRectangle do
  def create_distribution
    described_class.new(
      roof_dimmension_x: roof_dimmension_x,
      roof_dimmension_y: 5,
      solar_panel_dimmension_x: 2,
      solar_panel_dimmension_y: 1
    )
  end

  context "valid initialization" do
    let(:roof_dimmension_x) { 3 }
    let!(:distribution_service) do
      create_distribution
    end

    it "returns correct dimmensions" do
      expect(distribution_service.roof_dimmension_x).to eq 3
      expect(distribution_service.roof_dimmension_y).to eq 5
      expect(distribution_service.solar_panel_dimmension_x).to eq 2
      expect(distribution_service.solar_panel_dimmension_y).to eq 1
    end

    it "calculates position" do
      solar_panels = distribution_service.calculate_solar_panels_array

      expect(solar_panels.count).to eq(7)
      expect(solar_panels.last.position_x).to eq(2)
      expect(solar_panels.last.position_y).to eq(3)
      expect(solar_panels.last.width).to eq(1)
      expect(solar_panels.last.height).to eq(2)
    end
  end

  context "invalid initialization" do
    let(:roof_dimmension_x) { -2 }

    it "raises error" do
      expect {create_distribution}.to raise_error(RuntimeError, /All dimmensions need to be positive/)
    end
  end
end
