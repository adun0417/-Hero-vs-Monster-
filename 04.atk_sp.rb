class Monster
  attr_accessor :name, :hp, :ap

  def initialize(name,hp,ap)
    @name = name
    @hp = hp
    @ap = ap
    @alive = true
    @sp = 3

    puts "遇到怪獸 #{@name}"
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

  def use_stamina
    @sp = @sp - 1
  end

  def attack(enemy)
    if @sp > 0
      use_stamina
      damage = rand(@ap/2..@ap)
      enemy.hp = enemy.hp - damage
    puts "#{@name} 發動攻擊！,剩下 #{@sp} sp"
    puts "#{enemy.name} 受到 #{damage} 點傷害！"
    puts "#{enemy.name} 剩下 #{enemy.hp} 點HP。"
    puts ""

    else
       puts "無法攻擊, 休息一回合，恢復 2 sp"
       @sp = @sp + 2
    end

    if enemy.hp < 1
      enemy.die
    end
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
    @sp = 3

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

  def use_stamina
    @sp = @sp - 1
  end

  def attack(enemy)
    if @sp > 0
      use_stamina
      damage = rand(@ap/2..@ap)
      enemy.hp = enemy.hp - damage

      puts "#{@name} 發動攻擊！,剩下 #{@sp} sp"
      puts "#{enemy.name} 受到 #{damage} 點傷害！"
      puts "#{enemy.name} 剩下 #{enemy.hp} 點HP。"
      puts ""
    else
      puts "無法攻擊, 休息一回合，恢復 2 sp"
      puts ""
      @sp = @sp + 2
    end

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

  def heal
     return @hp = @hp + 50
  end

  def attack(enemy)
    #補血為其中一種攻擊模式
    if @hp <= 25
      puts "----#{@name} 對自己使出治癒術！----"
      puts "#{@name} 恢復 50 點HP！"
      puts "#{@name} 剩下 #{@hp+50} 點HP。"
      puts""
    #實際執行補血的code
      heal
    #如果血量沒有少於20，則進攻
    else
      damage = rand(@ap..@ap*2)
      enemy.hp = enemy.hp- damage

      puts "#{@name} 發射聖光！"
      puts "#{enemy.name} 受到 #{damage} 點傷害！"
      puts "#{enemy.name} 剩下 #{enemy.hp} 點HP。"
      puts ""
    end

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
hero = Hero.new("Tim", 100, 30)
monster = Monster.new("Bigfoot", 100, 30)

while hero.is_alive? && monster.is_alive?

  hero.attack(monster)
  if !monster.is_alive?
    break
  end

  monster.attack(hero)
end
