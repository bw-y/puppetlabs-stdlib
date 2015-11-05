module Puppet::Parser::Functions
  newfunction(:last_str, :type => :rvalue, :doc => <<-EOS

*Examples:*

  $dir_1   = '/path/dir'
  $dir_2   = '/path/dir/'

  ####
    $path_dir1 = last_str($dir_1)
    $path_dir2 = last_str($dir_2)
  Would result in: 
    $path_dir1 = '/path/dir'
    $path_dir2 = '/path/dir'

  #### 
    $path_dir1 = last_str($dir_1, '/')
    $path_dir2 = last_str($dir_2, '/')
  Would result in: 
    $path_dir1 = '/path/dir/'
    $path_dir2 = '/path/dir/' 
    EOS
  ) do |arguments|
      
     require 'puppet/util'
     # Technically we support two arguments but only first is mandatory ...
     raise(Puppet::ParseError, "last_str(): Wrong number of arguments " +
       "given (#{arguments.size} for 1)") if arguments.size < 1
    
     path = arguments[0]
    
     unless Puppet::Util.absolute_path?(path, :posix)
       raise Puppet::ParseError, "last_str(): The first argument must be an absolute_path"
     end

     if arguments.size == 1
       path = path[0..-2] if path[-1] == '/' 
     elsif arguments.size == 2 
       arg = arguments[1] 
       path = path + arg if path[-1] != arg
     end
     
     return path   
  end
end
# vim: set ts=2 sw=2 et :
