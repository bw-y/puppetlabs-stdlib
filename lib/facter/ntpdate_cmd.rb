Facter.add(:ntpdate_cmd) do
  setcode do
     %x{which ntpdate}.chomp
  end
end
