ARGV.select do |argument|
  case argument
  when /\*/ then
    Dir.glob(argument).each do |file|
      require File.expand_path(file)
    end
  else
    require File.expand_path(argument)
  end
end
