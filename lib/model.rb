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
  end
  
  def self.inherited(subclass)
    table_name = ActiveSupport::Inflector.tableize(subclass.name).to_sym
    Data.init_table(table_name)
    subclass.send(:attr_reader, :created_at, :updated_at)
  end

  def self.table
    table_name = ActiveSupport::Inflector.tableize(self.name).to_sym
    Data.get_table(table_name)
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
    @id = @@a.size + 1
    @created_at = Time.now
    @@a.push(self)
    true
  end
end
