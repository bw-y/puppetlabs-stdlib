module Puppet::Parser::Functions
  newfunction(:path_to_array, :type => :rvalue) do |args|

    res = args[0]
    
    array = []
    array.push(args[0])

    if args.size == 1 
      while res != '/' do
        res = File.dirname(res)
        array.push(res) if res != '/'
      end
    elsif args.size == 2 
      e_count = args[1] - 1
      e_count.times do
        res = File.dirname(res)
        array.push(res) if res != '/'
      end
    end

    return array
  end
end

# vim: set ts=2 sw=2 et :
