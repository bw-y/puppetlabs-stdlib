Facter.add(:hwclock_cmd) do
  setcode do
     %x{which hwclock}.chomp
  end
end
