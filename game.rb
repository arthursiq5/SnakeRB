require 'gosu'

class Game < Gosu::Window
    WIDTH = 800
    HEIGHT = 600

    def initialize
        super WIDTH, HEIGHT
        self.caption = "SnakeRB"
        @font = Gosu::Font.new(20)
    end

    def update
    end

    def draw
        @font.draw_text 'olá, mundo', 10, 10, 10
    end

end

Game.new.show

