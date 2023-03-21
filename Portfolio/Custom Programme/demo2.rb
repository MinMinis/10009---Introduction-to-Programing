require 'rubygems'
require 'gosu'

SPEED = 5
HEIGHT = 800
WIDTH = 600
ROTATION_SPEED = 3
ACCELERATION = 2
FRICTION = 0.9
ENEMY_FREQUENCY = 0.05
class Player
  attr_reader :x, :y, :angle , :radius
  def initialize(window)
    @x = HEIGHT/2
    @y = WIDTH - 50
    @angle = 0
    @image = Gosu::Image.new('images/space1.png')
    @velocity_x = 0
    @velocity_y = 0
    @radius = 20
    @window = window

  end

  def draw
    @image.draw_rot(@x, @y,1,  @angle)
  end

  def turn_right
    @x += 10

  end

  def turn_left
    @x -= 10

  end


  def move
    @x += @velocity_x
    @y += @velocity_y
    @velocity_x *= FRICTION
    @velocity_y *= FRICTION
    if @x < @radius
      @velocity_x = 0
      @x = @radius + 20
    end
    if @x > @window.width - @radius
      @velocity_x = 0
      @x = @window.width - @radius - 30
    end


  end
end


class Enemy
  SPEED = 2
  def initialize(window)
    @radius = 20
    @x = rand(window.width - 2 * @radius) + @radius
    @y = 0
    @image = Gosu::Image.new('images/enemy.png')
    @window = window
  end
  def draw
    @image.draw(@x - @radius, @y - @radius, 1, 1)
  end
  def move
    @y += SPEED
  end
end

class Bullet

  def initialize(window, x, y, angle)
    @window = window
    @x = x
    @y = y
    @radius = 2
    @direction = angle
    @image = Gosu::Image.new('images/bullet.png')
  end

  def move
    @x += Gosu::offset_x(@direction, SPEED)
    @y += Gosu::offset_y(@direction, SPEED)
  end

  def draw
    @image.draw(@x - @radius, @y - @radius, 1)
  end

  def onscreen?
    right = @window.width + @radius
    left = - @radius,
    top = - @radius,
    bottom = @window.height + @radius
    @x > left && @x < right && @y > top && @y < bottom
  end

end




class MyGame < Gosu::Window
  def initialize (height=800, width=600)
    super
      self.caption = "My Game"
      @player = Player.new(self)
      @enemies = []
      @bullets = []
  end

  def draw
    @player.draw
    #draw out enemies
    @enemies.each do |enemy|
      enemy.draw
    end
    @bullets.each do |bullet|
    bullet.draw
      end
  end
end

  def update
    #control player
    @player.turn_left if button_down?(Gosu::KbLeft)
    @player.turn_right if button_down?(Gosu::KbRight)
    @player.move
    #control enemy movement
        if rand < ENEMY_FREQUENCY
        @enemies.push Enemy.new(self)
        end
        @enemies.each do |enemy|
        enemy.move
        end
        #control bullet movement
        @bullets.each do |bullet|
        bullet.move
        end

  end



  def button_down(id)
    if id == Gosu::KbSpace
      @bullets.push Bullet.new(self, @player.x, @player.y, @player.angle)
    end
  end


end






window = MyGame.new
window.show
