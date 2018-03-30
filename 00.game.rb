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

  def die
    @alive = false
    puts "-----#{@name} 被打倒了!!-----"
    puts ""
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

#----------------------執行過程----------------------#

monster = Monster.new("Dr.boom",195,35)

hero = Hero.new("貪婪的冒險者",150,30)
holy_knight = HolyKnight.new("炸機勇士",150,35)
mage = Mage.new("珍娜",125,10,10)


while mage.is_alive? && monster.is_alive?

  mage.attack(monster)
  if !monster.is_alive?
    break
  end

  monster.attack(mage)
end

team = Hero.all # 會回傳 class variable：heroes

puts "You have #{Hero.count} in your team:"

team.each do |hero|
  puts "#{hero.name} - Class#{hero.class}, HP:#{hero.hp}"
end
