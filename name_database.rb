
class NameQueryEngine
  def initialize(data)
    @data = data
  end

  def find(*args, &block)
    @data.find(*args, &block)
  end

  def find_by_regexp(reg)
    @data.find do |line|
      line =~ reg
    end
  end

  def find_all_by_regexp(reg)
    @data.find_all do |line|
      line =~ reg
    end
  end

  def random
    @data.sample
  end

  def inspect
    "#<NameQueryEngine:#{self.__id__}>"
  end

  def to_s
    "#<NameQueryEngine:#{self.__id__}>"
  end

  def self.inspect
    "NameQueryEngine<Class>"
  end

  def self.to_s
    "NameQueryEngine<Class>"
  end
end


class NameDatabase
  def initialize
    File.open("./DATAS/chinese_family_names.txt", 'r') do |file|
      @chinese_family_names = NameQueryEngine.new(file.map{|line| line.strip})
    end

    File.open("./DATAS/chinese_given_names.txt", 'r') do |file|
      @chinese_given_names = NameQueryEngine.new(file.map{|line| line.strip})
    end

    File.open("./DATAS//latin_family_names.txt", 'r') do |file|
      @latin_family_names = NameQueryEngine.new(file.map{|line| line.strip})
    end

    File.open("./DATAS/latin_given_names.txt", 'r') do |file|
      @latin_given_names = NameQueryEngine.new(file.map{|line| line.strip})
    end
  end

  def random_latin_name
    "#{@latin_given_names.random} #{@latin_family_names.random}"
  end

  def random_chinese_name
   "#{@chinese_family_names.random} #{@chinese_given_names.random}"
  end
end

