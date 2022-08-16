require 'rails_helper'

RSpec.describe "SolarPanelDistributions", type: :request do
  describe "GET /preview" do
    it "returns http success" do
      get "/solar_panel_distribution/preview"
      expect(response).to have_http_status(:success)
    end
  end
end
