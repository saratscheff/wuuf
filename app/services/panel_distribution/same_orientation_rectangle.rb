class PanelDistribution::SameOrientationRectangle
  attr_reader :roof_dimmension_x,
              :roof_dimmension_y,
              :solar_panel_dimmension_x,
              :solar_panel_dimmension_y

  def calculate_solar_panels_array
    solar_panels_regular = PanelDistribution::FixedOrientationRectangle.new(
      roof_dimmension_x: @roof_dimmension_x,
      roof_dimmension_y: @roof_dimmension_y,
      solar_panel_dimmension_x: @solar_panel_dimmension_x,
      solar_panel_dimmension_y: @solar_panel_dimmension_y
    ).calculate_solar_panels_array

    solar_panels_inverted = PanelDistribution::FixedOrientationRectangle.new(
      roof_dimmension_x: @roof_dimmension_x,
      roof_dimmension_y: @roof_dimmension_y,
      solar_panel_dimmension_x: @solar_panel_dimmension_y,
      solar_panel_dimmension_y: @solar_panel_dimmension_x
    ).calculate_solar_panels_array

    if solar_panels_regular.count >= solar_panels_inverted.count
      solar_panels_regular
    else
      solar_panels_inverted
    end
  end

  private

  def initialize(roof_dimmension_x:, roof_dimmension_y:, solar_panel_dimmension_x:, solar_panel_dimmension_y:)
    @roof_dimmension_x = roof_dimmension_x
    @roof_dimmension_y = roof_dimmension_y
    @solar_panel_dimmension_x = solar_panel_dimmension_x
    @solar_panel_dimmension_y = solar_panel_dimmension_y

    validate_dimmensions!
  end

  def validate_dimmensions!
    dimmensions = [
      @roof_dimmension_x,
      @roof_dimmension_y,
      @solar_panel_dimmension_x,
      @solar_panel_dimmension_y
    ]

    fail "All dimmensions need to be positive non-zero values" unless dimmensions.all?(&:positive?)
  end

  def solar_panel(position_x, position_y)
    SolarPanelPosition.new(
      position_x: position_x,
      position_y: position_y,
      width: @solar_panel_dimmension_x,
      height: @solar_panel_dimmension_y
    )
  end
end
