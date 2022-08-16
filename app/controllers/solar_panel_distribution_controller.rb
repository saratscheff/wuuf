class SolarPanelDistributionController < ApplicationController
  MAX_NUMBER_OF_SOLAR_PANELS_FOR_SLOW_MODEL = 100

  def preview
  end

  def dimmensions_form
  end

  def dimmensions_form_submit
    solar_panels = distribution_service(params).calculate_solar_panels_array

    render :dimmensions_form, status: :ok, locals: {
      roof_dimmension_x: params[:dimmensions][:roof_dimmension_x],
      roof_dimmension_y: params[:dimmensions][:roof_dimmension_y],
      solar_panel_dimmension_x: params[:dimmensions][:solar_panel_dimmension_x],
      solar_panel_dimmension_y: params[:dimmensions][:solar_panel_dimmension_y],
      lock_rotation: params[:dimmensions][:lock_rotation] == "true",
      solar_panels: solar_panels
    }
  end

  private

  def distribution_service(params)
    arguments = {
      roof_dimmension_x: params[:dimmensions][:roof_dimmension_x].to_f,
      roof_dimmension_y: params[:dimmensions][:roof_dimmension_y].to_f,
      solar_panel_dimmension_x: params[:dimmensions][:solar_panel_dimmension_x].to_f,
      solar_panel_dimmension_y: params[:dimmensions][:solar_panel_dimmension_y].to_f
    }

    if params[:dimmensions][:lock_rotation] == "true" || too_big_for_model(arguments)
      PanelDistribution::SameOrientationRectangle.new(**arguments)
    else
      PanelDistribution::FreeOrientationRectangle.new(**arguments)
    end
  end

  def too_big_for_model(arguments)
    roof_area = arguments[:roof_dimmension_x] * arguments[:roof_dimmension_y]
    solar_panel_area = arguments[:solar_panel_dimmension_x] * arguments[:solar_panel_dimmension_y]

    roof_area/solar_panel_area > MAX_NUMBER_OF_SOLAR_PANELS_FOR_SLOW_MODEL
  end
end
