class SolarPanelPosition
  attr_reader :position_x,
              :position_y,
              :width,
              :height

  private

  def initialize(position_x:, position_y:, width:, height:)
    @position_x = position_x
    @position_y = position_y
    @width = width
    @height = height

    validate_input!
  end

  def validate_input!
    dimmensions = [@width, @height]
    position = [@position_x, @position_y]

    fail "Dimmensions need to be positive non-zero values" unless dimmensions.all?(&:positive?)
    fail "Positional values need to be zero or positive values" unless position.none?(&:negative?)
  end
end
