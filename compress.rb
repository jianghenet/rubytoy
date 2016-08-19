
class Bpack
  def compress(file_path, dist_file=nil)
    data = File.read(file_path)
    data_base64_encoded  =  Base64.encode64(data)
    data_compressed = Zlib::Deflate.deflate(data_base64_encoded)
    unless dist_file
      dist_file = file_path + '.bdat'
    end
    
    File.open(dist_file, "w+"){|file|
      file.write(data_compressed)
    }
  end
  
  def uncompress(file_path, dist_file=nil)
    data_compressed = File.read(file_path)
    uncompressed_data = Zlib::Inflate.inflate(data_compressed)
    original_data = Base64.decode64(uncompressed_data)
    unless dist_file
      dist_file = file_path + '.bsrc'
      File.open(dist_file, "w+"){|file|
        file.write(original_data)
      }
    end
  end
end








