require 'gosu'

class Keyboard
    attr_accessor :x, :y

    def initialize
        @x = 1
        @y = 0
    end

    def press id
        case id
        when Gosu::KB_LEFT
            return if @x != 0
            @x = -1
            @y = 0
        when Gosu::KB_RIGHT
            return if @x != 0
            @x = 1
            @y = 0
        when Gosu::KB_UP
            return if @y != 0
            @x = 0
            @y = -1
        when Gosu::KB_DOWN
            return if @y != 0
            @x = 0
            @y = 1
        end
    end

end

class Snake
    def initialize
        @cells = [{ x: 0, y: 0 }]
    end

    def ate? apple
        @cells.any? do |cell|
            cell[:x] == apple.x && cell[:y] == apple.y
        end
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

    def move keyboard
        tail = @cells.first

        to_move = @cells.pop
        to_move[:x] = tail[:x] + keyboard.x
        to_move[:y] = tail[:y] + keyboard.y

        @cells.unshift(to_move)

    end

    def grow
        @cells.push @cells.last.dup
    end

end

class Apple

    attr_accessor :x, :y    

    def initialize
        generate
    end

    def generate
        cw = Game::CELL_WIDTH
        width = Game::WIDTH
        height = Game::HEIGHT

        @x = ((rand * width - cw) / cw).round
        @y = ((rand * height - cw) / cw).round

    end

    def draw window
        cw = Game::CELL_WIDTH
        width = Game::WIDTH
        height = Game::HEIGHT

        window.draw_rect(@x * cw, @y * cw, cw, cw, Gosu::Color::YELLOW)

        window.draw_rect((@x * cw) + 1, (@y * cw) + 1, cw - 2, cw - 2, Gosu::Color::RED)

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
        @keyboard = Keyboard.new
        @last_tick = Time.now
        @apple = Apple.new
    end

    def update
        return if Time.now - @last_tick < 0.15
        @snake.move @keyboard

        if @snake.ate? @apple
            @apple.generate
            @snake.grow
        end

        @last_tick = Time.now
    end

    def button_down id
        @keyboard.press id
    end

    def draw
        @snake.draw self
        @apple.draw self
    end

end

Game.new.show

