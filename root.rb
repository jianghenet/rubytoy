class Root

  def initialize

  end
    
  def trade
    transaction = Transaction.new payee: User.gggddd, payer: User.gggddd, amount: rand * 100000
    transaction.save    
    puts "#{transaction.payer.name} paid #{transaction.amount} to #{transaction.payee.name}"
  end
 
  def inspect
    "#<Root:#{self.__id__}>"
  end
  
  def to_s
    "#<Root:#{self.__id__}>"
  end
  
  def self.inspect
    "Root<Class>"
  end
  
  def self.to_s
    "Root<Class>"
  end
end
