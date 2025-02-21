#!/usr/bin/perl
use strict;
use warnings;

print "Starting memory wipe (excluding active script)...\n";

# Get the currently executing script’s PID
my $pid = $$;
print "Preserving process ID: $pid\n";

# Function to zero out RAM (no sudo needed in Recovery Mode)
sub clear_ram {
    print "Clearing RAM...\n";
    system("purge");  # macOS native memory cleaner (works in Recovery)
}

# Function to zero out unused disk space (Recovery Mode Compatible)
sub clear_disk_space {
    print "Zeroing out free disk space...\n";
    system("diskutil secureErase 0 free");  # Zeroes unused space
}

# Get all running processes and kill everything except this script
my @processes = `ps -ax -o pid`;
foreach my $process (@processes) {
    chomp($process);
    next if $process == $pid;  # Skip the script itself
    system("kill -9 $process");
}

# Run cleanup
clear_ram();
clear_disk_space();

print "Memory wipe complete. Rebooting to last macOS installation...\n";

# Reboot to last working macOS install
system("bless --mount /System/Volumes/Data --setBoot --nextonly");
system("reboot");