module Puppet::Parser::Functions
  newfunction(:hash_merge, :type => :rvalue, :doc => <<-EOS

*Examples:*
  $ddd = {'t1' => 'aa', 't2' => 'ab'}
  $ttt = {
     'key_1' => { 't3' => 'a1'},
     'key_2' => { 't1' => 'zz', 't3' => 'a8' }
  }
  hash_merge($ttt, $ddd)

Would result in: "
  {
    'key_1' => { 't3' => 'a1', 't1' => 'aa', 't2' => 'ab' }, 
    'key_2' => { 't1' => 'zz', 't3' => 'a8', 't2' => 'ab' }
  }
"
    EOS
  ) do |arguments|
      
     # Technically we support two arguments but only first is mandatory ...
     raise(Puppet::ParseError, "hash_merge(): Wrong number of arguments " +
       "given (#{arguments.size} for 1)") if arguments.size < 1
    
     res = arguments[0]
    
     unless res.is_a?(Hash)
       raise Puppet::ParseError, "hash_merge(): The argument must be a hash"
     end

     if arguments.size == 2
       t_hash = arguments[1] || {}
       res.each_key do |k|
         t_hash.each_key do |t|
           res[k][t] = t_hash[t] unless res[k].key?(t) 
         end 
       end
     end
     
     return res
  end
end
# vim: set ts=2 sw=2 et :
