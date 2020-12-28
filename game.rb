require 'gosu'

class Game < Gosu::Window
    WIDTH = 800
    HEIGHT = 600

    def initialize
        super WIDTH, HEIGHT
        self.caption = "SnakeRB"
    end

end

Game.new.show

