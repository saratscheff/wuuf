class SolarPanelDistributionController < ApplicationController
  def preview
  end

  def dimmensions_form
  end

  def dimmensions_form_submit
    distribution_service = PanelDistribution::SameOrientationRectangle.new(
      roof_dimmension_x: params[:dimmensions][:roof_dimmension_x].to_f,
      roof_dimmension_y: params[:dimmensions][:roof_dimmension_y].to_f,
      solar_panel_dimmension_x: params[:dimmensions][:solar_panel_dimmension_x].to_f,
      solar_panel_dimmension_y: params[:dimmensions][:solar_panel_dimmension_y].to_f
    )

    solar_panels = distribution_service.calculate_solar_panels_array

    render :dimmensions_form, status: :ok, locals: {
      roof_dimmension_x: params[:dimmensions][:roof_dimmension_x],
      roof_dimmension_y: params[:dimmensions][:roof_dimmension_y],
      solar_panel_dimmension_x: params[:dimmensions][:solar_panel_dimmension_x],
      solar_panel_dimmension_y: params[:dimmensions][:solar_panel_dimmension_y],
      solar_panels: solar_panels
    }
  end
end
