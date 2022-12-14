require 'rails_helper'

RSpec.describe "SolarPanelDistributions", type: :request do
  describe "GET /preview" do
    it "returns http success" do
      get "/solar_panel_distribution/preview"
      expect(response).to have_http_status(:success)
    end

    it "draws last solar panel in correct position" do
      post "/solar_panel_distribution/dimmensions_form_submit",
           params: {
            dimmensions: {
              roof_dimmension_x: 300,
              roof_dimmension_y: 500,
              solar_panel_dimmension_x: 100,
              solar_panel_dimmension_y: 200,
              lock_rotation: "true"
            }
           }

      expect(response).to have_http_status(:success)
      expect(response.body).to match(/transform=\"translate\(200\.0\,200\.0\)\">/)
    end
  end
end
