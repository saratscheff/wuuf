class PanelDistribution::FixedOrientationRectangle
  attr_reader :roof_dimmension_x,
              :roof_dimmension_y,
              :solar_panel_dimmension_x,
              :solar_panel_dimmension_y

  def calculate_solar_panels_array
    solar_panels = []

    index_x = 0; index_y = 0
    while index_y + @solar_panel_dimmension_y <= @roof_dimmension_y
      while index_x + @solar_panel_dimmension_x <= @roof_dimmension_x
        solar_panels << solar_panel(index_x, index_y)
        index_x += @solar_panel_dimmension_x
      end
      index_y += @solar_panel_dimmension_y
      index_x = 0
    end

    solar_panels
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

  def solar_panel(position_x,position_y)
    SolarPanelPosition.new(
      position_x: position_x,
      position_y: position_y,
      width: @solar_panel_dimmension_x,
      height: @solar_panel_dimmension_y
    )
  end
end
