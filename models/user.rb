class User < Model
  attr_accessor :name
  
  def self.gggddd
    _name = rndbool ? $name_database.random_latin_name : $name_database.random_chinese_name
    self.new(name: _name)
  end
end
