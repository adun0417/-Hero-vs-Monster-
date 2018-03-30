class Monster
  attr_accessor :name, :hp, :ap

  def initialize(name,hp,ap)
    @name = name
    @hp = hp
    @ap = ap
    @alive = true

    puts "遇到怪獸 #{@name}"
    puts "生命力(HP) #{@hp}"
    puts "攻擊力(AP) #{@ap}"
    puts ""
  end

  def is_alive?
    return @alive
  end

  def attack(enemy)
    damage = rand(@ap/2..@ap)
    enemy.hp = enemy.hp - damage

    puts "#{@name}發動攻擊！"
    puts "#{enemy.name} 受到 #{damage} 點傷害！"
    puts "#{enemy.name} 剩下 #{enemy.hp} 點HP。"
    puts ""

    if enemy.hp < 1
      enemy.die
    end

  end

  def die
    @alive = false
    puts "-----#{@name} 被打倒了!!-----"
    puts ""
  end
end

class Hero

  @@heroes = []  #在class內定義class variable

  attr_accessor :name, :hp, :ap

  def initialize(name,hp,ap)
    @name = name
    @hp = hp
    @ap = ap
    @alive = true
    @@heroes << self # 把物件本身加入 class variable

    puts "召喚英雄:#{@name}"
    puts "生命力(HP) #{@hp}"
    puts "攻擊力(AP) #{@ap}"
    puts ""
  end

  def is_alive?
    return @alive
  end

  def die
    @alive = false
    puts "-----#{@name} 被打倒了!!-----"
    puts ""
  end

  def attack(enemy)
    damage = rand(@ap/2..@ap)
    enemy.hp = enemy.hp - damage

    puts "#{@name} 發動攻擊！"
    puts "#{enemy.name} 受到 #{damage} 點傷害！"
    puts "#{enemy.name} 剩下 #{enemy.hp} 點HP。"
    puts ""

    if enemy.hp < 1
      enemy.die
    end
  end



  def self.count
    return @@heroes.length
  end

  def self.all
    return @@heroes
  end

end

class HolyKnight < Hero
  def attack(enemy)

    damage = rand(@ap..@ap*2)
    enemy.hp = enemy.hp- damage

    puts "#{@name} 發射聖光！"
    puts "#{enemy.name} 受到 #{damage} 點傷害！"
    puts "#{enemy.name} 剩下 #{enemy.hp} 點HP。"
    puts ""

    if enemy.hp < 1
      enemy.die
    end
  end
end

class Mage < Hero

  def initialize(name,hp,ap,mp)
    @mp = mp
    super(name,hp,ap)
  end

  def fireball
    @mp = @mp-3
    return rand(@ap/2..@ap) + 50
  end

  def attack(enemy)
      if @mp >= 3
        damage = fireball
        enemy.hp = enemy.hp - damage

        puts "#{@name} 發射火球術！"
        puts "#{enemy.name} 受到 #{damage} 點傷害！"
        puts "#{enemy.name} 剩下 #{enemy.hp} 點HP。"
        puts "#{@name} 剩下 #{@mp} 點MP。"
        puts ""


        if enemy.hp < 1
          enemy.die
        end

      else
        super(enemy)  #call hero's attack
      end
  end

end


class Orc < Monster
  def attack(enemy)
    damage = rand(@ap..@ap*2)
    enemy.hp = enemy.hp - damage

    puts "#{@name} 使出斬擊！"
    puts "#{enemy.name} 受到 #{damage} 點傷害！"
    puts "#{enemy.name} 剩下 #{enemy.hp} 點HP。"
    puts ""

    if enemy.hp < 1
      enemy.die
    end
  end
end

class DarkMage < Monster
  def initialize(name,hp,ap,mp)
    @mp = mp
    super(name,hp,ap)
  end

  def dark_force
    @mp = @mp-3
    return rand(@ap/2..@ap) + 50
  end

  def attack(enemy)

    if @mp >= 3
      damage = dark_force
      enemy.hp = enemy.hp - damage
      puts "#{@name} 發射暗影箭!"
      puts "#{enemy.name} 受到 #{damage}傷害。"
      puts "#{enemy.name} 剩下 #{enemy.hp}HP。"
      puts "#{@name} 剩下 #{@mp}MP。"
      puts""

    else
      super(enemy)
    end


    if enemy.hp < 1
      enemy.die
    end
  end

end

#----------------------執行過程----------------------#

dark_mage = DarkMage.new("Morgana", 100, 30, 8)
mage = Mage.new("Merlin", 100, 20, 7)


while mage.is_alive? && dark_mage.is_alive?

  mage.attack(dark_mage)
  if !dark_mage.is_alive?
    break
  end

  dark_mage.attack(mage)
end
