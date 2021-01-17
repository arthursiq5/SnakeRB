require 'gosu'

class Snake
    def initialize
        @cells = [{ x: 0, y: 0 }]
    end

    def draw window

        cw = Game::CELL_WIDTH
        width = Game::WIDTH
        height = Game::HEIGHT

        @cells.each do |cell|

            window.draw_rect(cell[:x] * cw, cell[:y] * cw, cw, cw, Gosu::Color::BLACK)

            window.draw_rect((cell[:x] * cw) + 1, (cell[:y] * cw) + 1, cw - 2, cw - 2, Gosu::Color::YELLOW)
        
        end

    end

    def move
        direction = 1
        tail = @cells.first

        to_move = @cells.pop
        to_move[:x] = tail[:x] + direction
        to_move[:y] = 0

        @cells.unshift(to_move)

    end

end

class Game < Gosu::Window
    CELL_WIDTH = 20
    WIDTH = 800
    HEIGHT = 600

    def initialize
        super WIDTH, HEIGHT
        self.caption = "SnakeRB"
        @snake = Snake.new
       @last_tick = Time.now 
    end

    def update
        return if Time.now - @last_tick < 0.15
        @snake.move
        @last_tick = Time.now
    end

    def draw
        @snake.draw self
    end

end

Game.new.show

