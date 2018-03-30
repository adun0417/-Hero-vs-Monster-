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

class Champion < Hero
  def attack(enemy)
    #被創建的 Hero 的數量乘於 50
    #1.存取英雄數量
    #2.用.length +陣列計算英雄數量
  end
end
#----------------------執行過程----------------------#
champion = Champion.new("Peter", 100, 30)
hero1 = Hero.new("Roger", 100, 30)
hero2 = Hero.new("Ben", 100, 30)
monster = Monster.new("Bigfoot", 100, 30)

while hero.is_alive? && monster.is_alive?

  hero.attack(monster)
  if !monster.is_alive?
    break
  end

  monster.attack(hero)
end
