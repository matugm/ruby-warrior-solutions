
class Player
  attr_reader :warrior, :taking_dmg
  
  def initialize
    @state = Walk.new
    @hp    = 20
  end
  
  def new_state(state)
    @state = state.new
    @state.execute(self)
  end
  
  def play_turn(warrior)
    @warrior = warrior
    @taking_dmg = @warrior.health < @hp
    @state.execute(self)
    @hp = @warrior.health
  end
end

class Walk
  def execute(player)
    if player.warrior.feel.enemy?
      player.new_state(Attack)
    elsif player.warrior.feel.captive?
      player.warrior.rescue!
    else
      player.warrior.walk!
    end
  end
end

class Attack
  def execute(player)
    if !player.warrior.feel.enemy?
      player.new_state(Rest)
    else
      player.warrior.attack!
    end
  end
end

class Rest
  def execute(player)
    if player.warrior.health >= 20
      player.new_state(Walk)
    elsif player.taking_dmg
      player.warrior.walk!(:backward)
    else
      player.warrior.rest!
    end
  end
end
