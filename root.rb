class Root

  def initialize
    
  end
  
  
  def trade(payer, payee, amount)
    transaction = Transaction.new payee: payee, payer: payer, amount: amount
    transaction.save
    true
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
