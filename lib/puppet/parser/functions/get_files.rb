module Puppet::Parser::Functions
  newfunction(:get_files, :type => :rvalue, :doc => <<-EOS

*Examples:*
  ## bash code: 
# ls /path/dir
file1 file2

  ## puppet code
  $dir_path = '/path/dir' 
  get_files($dir_path)

Would result in: "
  ['file1','file2']
"
    EOS
  ) do |args|
      
    require 'puppet/util'

    unless args.length > 0 then
      raise(Puppet::ParseError, "get_files(): wrong number of arguments (#{args.length}; must be > 0)")
    end 

    path = args[0]
    unless Puppet::Util.absolute_path?(path, :posix)
      raise Puppet::ParseError, ("#{path.inspect} is not an absolute path.")
    end

    res = []
    Dir.foreach(path) do |p|
      res.push(p) if File.file?(path + '/' + p)
    end

    unless res.length != 0 then
      raise(Puppet::ParseError, "get_file(): #{res.length} not exist valid file") 
    end

    return res
  end
end
# vim: set ts=2 sw=2 et :
