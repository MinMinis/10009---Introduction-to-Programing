require 'gosu'
require_relative 'explosion'
require_relative 'bullet'
require_relative 'player'
require_relative 'scenes'
require_relative 'enemy'
require_relative 'credit'

class MyGame < Gosu::Window
  def initialize (height=800, width=600)
    super
      self.caption = "My Game"


      @player = Player.new(self)
      @enemies = []
      @bullets = []


  end

  def draw_start
    @background_image.draw(0, 0, 0)
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
=begin
    @explosions.each do |explosion|
      explosion.draw
    end
=end
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


        #control explosion
        @enemies.dup.each do |enemy|
          @bullets.dup.each do |bullet|
            distance = Gosu.distance(enemy.x, enemy.y, bullet.x, bullet.y)
            if distance < enemy.radius + bullet.radius
              @enemies.delete enemy
              @bullets.delete bullet
              #@explosions.push Explosion.new(self, enemy.x, enemy.y)
            end
          end
        end


          @enemies.dup.each do |enemy|
            if enemy.y > 800 + enemy.radius
              @enemies.delete enemy
            end
          end
          @bullets.dup.each do |bullet|
            @bullets.delete bullet unless bullet.onscreen?
          end

          #end update
        end






  def button_down(id)
    if id == Gosu::KbSpace
      @bullets.push Bullet.new(self, @player.x, @player.y, @player.angle)
    end
  end


end






window = MyGame.new
window.show
