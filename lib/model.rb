class Model
  class Data
    $data = {}
   
    def self.init_table(table_name)
      if $data[table_name].nil?
        $data[table_name] = []
      end
      $data[table_name]
    end
    
    def self.get_table(table_name)
      $data[table_name]
    end
    
    def self.count(table_name)
      $data[table_name].length
    end
    
    def self.push(table_name, instance)
      $data[table_name] << instance
    end
  end
  
  def self.inherited(subclass)
    table_name = ActiveSupport::Inflector.tableize(subclass.name).to_sym
    Data.init_table(table_name)
    subclass.send(:attr_reader, :created_at, :updated_at)
  end

  def self.table
    Data.get_table(self.default_table_name)
  end
  
  def self.default_table_name
    ActiveSupport::Inflector.tableize(self.name).to_sym
  end
  
  def self.count
    Data.count(self.default_table_name)
  end
  
  def self.table_push(instance)
    Data.push(self.default_table_name, instance)
  end
  
  def initialize(params={})
    params.each do |key, value|
      self.send :"#{key}=", value
    end
  end
  
  def id
    @id
  end
   
  def save
    @id = self.class.count + 1
    @created_at = Time.now unless @created_at
    @updated_at = Time.now
    self.class.table_push(self)
    true
  end
end
