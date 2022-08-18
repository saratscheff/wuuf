require 'rails_helper'

RSpec.describe PanelDistribution::FreeOrientationOverlappedRectangles do
  def create_distribution
    described_class.new(
      roof_a_dimmension_x: roof_a_dimmension_x,
      roof_a_dimmension_y: roof_a_dimmension_y,
      roof_b_dimmension_x: roof_b_dimmension_x,
      roof_b_dimmension_y: roof_b_dimmension_y,
      roof_b_position_x: roof_b_position_x,
      roof_b_position_y: roof_b_position_y,
      solar_panel_dimmension_x: solar_panel_dimmension_x,
      solar_panel_dimmension_y: solar_panel_dimmension_y
    )
  end

  let(:roof_a_dimmension_x) { 3 }
  let(:roof_a_dimmension_y) { 5 }
  let(:roof_b_dimmension_x) { 4 }
  let(:roof_b_dimmension_y) { 4 }
  let(:roof_b_position_x) { 1 }
  let(:roof_b_position_y) { 3 }
  let(:solar_panel_dimmension_x) { 1.5 }
  let(:solar_panel_dimmension_y) { 2.5 }

  context "valid initialization" do
    let(:distribution_service) do
      create_distribution
    end

    it "returns some correct dimmensions" do
      expect(distribution_service.roof_a_dimmension_x).to eq 3
      expect(distribution_service.roof_b_dimmension_x).to eq 4
      expect(distribution_service.roof_b_position_y).to eq 3
      expect(distribution_service.solar_panel_dimmension_y).to eq 2.5
    end

    it "calculates position" do
      solar_panels = distribution_service.calculate_solar_panels_array

      expect(solar_panels.count).to eq(7)
      expect(solar_panels.last.position_x).to eq(2)
      expect(solar_panels.last.position_y).to eq(2)
    end

    context "should not rotate solar panels" do
      let(:solar_panel_dimmension_x) { 2 }
      let(:solar_panel_dimmension_y) { 1 }

      it "calculates position" do
        solar_panels = distribution_service.calculate_solar_panels_array

        expect(solar_panels.count).to eq(14)
        expect(solar_panels.last.position_x).to eq(0)
        expect(solar_panels.last.position_y).to eq(4)
      end
    end
  end

  context "negative numbers" do
    context "invalid negative dimmension" do
      let(:solar_panel_dimmension_x) { -2 }

      it "raises error" do
        expect { create_distribution }.to raise_error(RuntimeError, /All dimmensions need to be positive/)
      end
    end

    context "invalid roof b on the left side" do
      let(:roof_b_position_x) { -2 }

      it "raises error" do
        expect { create_distribution }.to raise_error(RuntimeError, /Roof B must be on the right/)
      end
    end

    context "valid negative position" do
      let(:roof_b_position_y) { -2 }

      it "raises error" do
        expect { create_distribution }.not_to raise_error
      end
    end
  end
end
