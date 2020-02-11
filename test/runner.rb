ARGV.select do |argument|
  case argument
  when /\*/
    Dir.glob(argument).each do |file|
      require File.expand_path(file)
    end
  else
    require File.expand_path(argument)
  end
end
