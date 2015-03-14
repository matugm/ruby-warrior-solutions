
class Player
  attr_reader :warrior

  def initialize
    @state = Walk.new
  end

  def new_state(state)
    @state = state.new
    @state.execute(self)
  end

  def play_turn(warrior)
    @warrior = warrior
    @state.execute(self)
  end
end

class Walk
  def execute(player)
    if player.warrior.feel.enemy?
      player.new_state(Attack)
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
    else
      player.warrior.rest!
    end
  end
end
