require_relative '../display.rb'

class Player

    attr_accessor :color, :display

    def initialize(color,display)
        @color = color
        @display = display
    end

end