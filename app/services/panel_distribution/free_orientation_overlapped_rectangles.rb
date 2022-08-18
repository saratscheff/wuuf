class PanelDistribution::FreeOrientationOverlappedRectangles
  attr_reader :roof_a_dimmension_x,
              :roof_a_dimmension_y,
              :roof_b_dimmension_x,
              :roof_b_dimmension_y,
              :roof_b_position_x,
              :roof_b_position_y,
              :solar_panel_dimmension_x,
              :solar_panel_dimmension_y

  def calculate_solar_panels_array
    @best_array = []

    calculate_solar_panels_array_for_roof_a_cut_1_full_roof_b
    calculate_solar_panels_array_for_roof_a_cut_2_full_roof_b
    calculate_solar_panels_array_for_full_roof_a_roof_b_cut_1
    calculate_solar_panels_array_for_full_roof_a_roof_b_cut_2

    @best_array
  end

  private

  def initialize(
    roof_a_dimmension_x:, roof_a_dimmension_y:, roof_b_dimmension_x:, roof_b_dimmension_y:,
    roof_b_position_x:, roof_b_position_y:, solar_panel_dimmension_x:, solar_panel_dimmension_y:
  )
    @roof_a_dimmension_x = roof_a_dimmension_x
    @roof_a_dimmension_y = roof_a_dimmension_y
    @roof_b_dimmension_x = roof_b_dimmension_x
    @roof_b_dimmension_y = roof_b_dimmension_y
    @roof_b_position_x = roof_b_position_x
    @roof_b_position_y = roof_b_position_y
    @solar_panel_dimmension_x = solar_panel_dimmension_x
    @solar_panel_dimmension_y = solar_panel_dimmension_y

    validate_dimmensions!
  end

  def validate_dimmensions!
    dimmensions = [
      @roof_a_dimmension_x, @roof_a_dimmension_y,
      @roof_b_dimmension_x, @roof_b_dimmension_y,
      @solar_panel_dimmension_x, @solar_panel_dimmension_y
    ]

    raise "All dimmensions need to be positive non-zero values" unless dimmensions.all?(&:positive?)
    raise "Roof B must be on the right" unless @roof_b_position_x.positive?
  end

  def check_solution(solar_panels)
    return if @best_array.count >= solar_panels.count

    @best_array = solar_panels
  end

  def roof_cut_1a
  end

  def roof_cut_1b
  end

  def roof_cut_2a
  end

  def roof_cut_2b
  end

  def calculate_solar_panels_array_for_roof_a_cut_1_full_roof_b
    solar_panels_roof_a_cut_1a = PanelDistribution::FreeOrientationRectangle.new(
      **roof_a_cut_1a_args
    ).calculate_solar_panels_array

    solar_panels_roof_a_cut_1b = PanelDistribution::FreeOrientationRectangle.new(
      **roof_a_cut_1b_args
    ).calculate_solar_panels_array

    solar_panels_roof_b = PanelDistribution::FreeOrientationRectangle.new(
      **roof_b_args
    ).calculate_solar_panels_array

    check_solution(solar_panels)
  end

  def calculate_solar_panels_array_for_roof_a_cut_2_full_roof_b
  end

  def calculate_solar_panels_array_for_full_roof_a_roof_b_cut_1
  end

  def calculate_solar_panels_array_for_full_roof_a_roof_b_cut_2
  end
end
