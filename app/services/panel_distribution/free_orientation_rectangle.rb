class PanelDistribution::FreeOrientationRectangle
  attr_reader :roof_dimmension_x,
              :roof_dimmension_y,
              :solar_panel_dimmension_x,
              :solar_panel_dimmension_y

  def calculate_solar_panels_array
    @best_array = []

    add_rows_recursively([], 0, 0)

    @best_array
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

  def add_rows_recursively(solar_panels, index_x, index_y)
    add_regular_solar_panels_row(solar_panels.map(&:clone), index_x, index_y)
    add_inverted_solar_panels_row(solar_panels.map(&:clone), index_x, index_y)
  end

  def check_solution(solar_panels)
    return if @best_array.count >= solar_panels.count

    @best_array = solar_panels
  end

  def add_regular_solar_panels_row(solar_panels, index_x, index_y)
    if index_y + @solar_panel_dimmension_y > @roof_dimmension_y
      check_solution(solar_panels)
      return
    end

    while index_x + @solar_panel_dimmension_x <= @roof_dimmension_x
      solar_panels << regular_solar_panel(index_x, index_y)
      index_x += @solar_panel_dimmension_x
    end
    index_x = 0
    index_y = index_y + @solar_panel_dimmension_y
    add_rows_recursively(solar_panels, index_x, index_y)
  end

  def add_inverted_solar_panels_row(solar_panels, index_x, index_y)
    if index_y + @solar_panel_dimmension_x > @roof_dimmension_y
      check_solution(solar_panels)
      return
    end

    while index_x + @solar_panel_dimmension_y <= @roof_dimmension_x
      solar_panels << inverted_solar_panel(index_x, index_y)
      index_x += @solar_panel_dimmension_y
    end
    index_x = 0
    index_y = index_y + @solar_panel_dimmension_x
    add_rows_recursively(solar_panels, index_x, index_y)
  end

  def regular_solar_panel(position_x,position_y)
    SolarPanelPosition.new(
      position_x: position_x,
      position_y: position_y,
      width: @solar_panel_dimmension_x,
      height: @solar_panel_dimmension_y
    )
  end

  def inverted_solar_panel(position_x,position_y)
    SolarPanelPosition.new(
      position_x: position_x,
      position_y: position_y,
      width: @solar_panel_dimmension_y,
      height: @solar_panel_dimmension_x
    )
  end
end
