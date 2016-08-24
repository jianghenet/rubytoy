require 'erb'
require 'active_support'

#DIST_PATH = the directory where to store migration files
#SCHEMA_FILE = the path to the schema file or you input as an arg.

class MigrationClass
  @@table_count = 0
  attr_reader :id
  def initialize(line)
    @@table_count = @@table_count + 1
    @id = @@table_count
    @table_name = line.match(/create_table \"(\w+)\", force: :cascade do \|t\|/)[1]
    @add_indexs = []
    @sqls = []
  end
  
  def file_name
    d = Time.now - @@table_count * 24 * 3600
    str = d.strftime("%Y%m%d%H%M%S")
    str + "_create_" + @table_name + '.rb'
  end
  
  def add_index_line(line)
    @add_indexs << line
  end
  
  def add_sql_line(line)
    @sqls << line
  end
  
  def file_path
    DIST_PATH + self.file_name
  end
  
  def klass_name
    "Create" + ActiveSupport::Inflector.camelize(@table_name)
  end
  
  def table_name
    @table_name
  end
  
  def body
    @sqls.join("\n  ")
  end
  
  def indexs
    if @add_indexs.length > 0
      @add_indexs.unshift("\n").join("\n  ")
    else
      ""
    end
  end
  
end

class TableDefinition
TEMPLATE = <<EOF
class <%= @migration.klass_name %> < ActiveRecord::Migration
  def change
  
  <%= @migration.body %>
  <%= @migration.indexs %>
  end
end
EOF
              
  def initialize(migration)
    @migration = migration
  end
  
  
  def to_ddl
    b = binding
    @template = ERB.new(TEMPLATE)
    @template.result(b)
  end
end

class SchemaFile
  def initialize(file_path)
    @data = File.read(file_path).split("\n")
    @length = @data.size
    @line_num = 0
    @create_table = false
    @add_index = false
    @process = 0
  end
  
  def next_line
    @line_num = @line_num + 1
  end
  
  def eof?
    @line_num >= @length
  end
  
  def prev_line
    if @line_num > 0
      @line_num = @line_num - 1
    else
      raise
    end
  end
  
  def read_line
    @data[@line_num]
  end
  
  def log
    @table_def = TableDefinition.new(@migration)
    puts @migration.file_path
    puts @table_def.to_ddl
    puts "\n\n ^"
  end
  
  def write
    @table_def = TableDefinition.new(@migration)
    puts @migration.id
    file = File.open(@migration.file_path, 'a+')
    file.puts @table_def.to_ddl
    file.close
  end
  
  def write_prev!
    return false if @process < 1
    write
  end
  
  def write_prev
    return false if @process < 1
    log  
  end
  
  def write_last!
    write
  end
  
  def write_last
    log
  end
  
  def dump
    while !eof?
      line = read_line
      if line =~ /create_table/
        write_prev!
        @create_table = true
        @process = 1
        @migration = MigrationClass.new(line)
        while @create_table
          @migration.add_sql_line(line)
          next_line
          line = read_line
          if line =~ /[\s]+end/
            @create_table = false
            @migration.add_sql_line(line)
            @process = 2
          end
        end
      elsif line =~ /add_index/
        @add_index = true
        @process = 3
        while @add_index
          @migration.add_index_line(line)
          next_line
          line = read_line
          unless line =~ /add_index/
            @add_index = false
            @migration.add_index_line(line)
            @process = 4
          end
        end
      else
        next_line
      end
    end
    write_last!
  end
end

if __FILE__ == $0
  schema_file = ARGV[0]
  if schema_file && File.file?(schema_file)
    SchemaFile.new(schema_file).dump
  end
end
