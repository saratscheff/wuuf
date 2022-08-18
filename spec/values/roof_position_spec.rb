require 'rails_helper'

RSpec.describe RoofPosition do
  def create_roof
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
    let!(:roof) do
      create_roof
    end

    it "returns correct values" do
      expect(roof.position_x).to eq 2
      expect(roof.position_y).to eq 3
      expect(roof.width).to eq 1
      expect(roof.height).to eq 2
    end
  end

  context "invalid initialization" do
    context "negative position" do
      let(:position_x) { -2 }
      let(:width) { 1 }

      it "raises error" do
        expect { create_roof }.to raise_error(
          RuntimeError, /Positional values need to be zero or positive/
        )
      end
    end

    context "zero dimmension" do
      let(:position_x) { 2 }
      let(:width) { 0 }

      it "raises error" do
        expect { create_roof }.to raise_error(RuntimeError, /Dimmensions need to be positive/)
      end
    end
  end
end
