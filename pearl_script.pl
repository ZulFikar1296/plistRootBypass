#!/usr/bin/perl
use strict;
use warnings;

print "Starting memory wipe (excluding active script)...\n";

# Function to zero out RAM
sub clear_ram {
    print "Clearing RAM...\n";
    system("sudo purge"); # Force macOS to release inactive memory
    system("sync; sudo sysctl -w vm.swapusage=0");
}

# Function to zero out unused disk space
sub clear_disk_space {
    print "Zeroing out free disk space...\n";
    system("diskutil secureErase 0 free");
}

# Get the currently executing script’s PID
my $pid = $$;
print "Preserving process ID: $pid\n";

# Get all running processes and kill everything except the script itself
my @processes = `ps -ax -o pid`;
foreach my $process (@processes) {
    chomp($process);
    next if $process == $pid;  # Skip the script itself
    system("sudo kill -9 $process");
}

# Run cleanup
clear_ram();
clear_disk_space();

print "Memory wipe complete. Rebooting to last macOS installation...\n";

# Reboot to last working macOS install
system("sudo bless --mount /System/Volumes/Data --setBoot --nextonly");
system("sudo reboot");