#
# path_to_array.rb
#
module Puppet::Parser::Functions
  newfunction(:path_to_array, :type => :rvalue, :doc => <<-EOS
This function split path into a array.

*Examples:*

   path_to_array('/aa/bb/cc/dd')
     Would result in: ['/aa/bb/cc/dd']

   path_to_array('/aa/bb/cc/dd', 1)
     Would result in: ['/aa/bb/cc/dd', '/aa/bb/cc']

   path_to_array('/aa/bb/cc/dd', 2)
     Would result in: ['/aa/bb/cc/dd', '/aa/bb/cc', '/aa/bb']
    EOS

  ) do |args|

    raise(Puppet::ParseError, "path_to_array(): Wrong number of arguments " +
      "given (#{args.size} for 1)") if args.size < 1

    array = []
    array.push(args[0])

    if args.size == 2 
      res = args[0]
      count_path = 0
      while res != '/' do
        res = File.dirname(res)
        if res != '/'
          count_path = count_path + 1
        end
      end
      if args[1] > count_path 
        raise(Puppet::ParseError, "path_to_array(): invalid argument (#{args[1]})")
      else 
        res = args[0]
        args[1].times do
          res  = File.dirname(res)
          array.push(res) if res != '/'
        end
      end
    end

    return array
  end
end

# vim: set ts=2 sw=2 et :
