hanoi($ARGV[0], $ARGV[1], $ARGV[2], $ARGV[3], $ARGV[4]);

sub hanoi {
    my ($n, $start, $end, $extra, $move_disk) = @_;
    if ($n == 1) {
        $move_disk->(1, $start, $end); 
    } else {
        hanoi($n-1, $start, $extra, $end, $move_disk);
        $move_disk->($n, $start, $end);
        hanoi($n-1, $extra, $end, $start, $move_disk);
    }
}

sub print_instruction {
    my ($disk, $start, $end) = @_;
    print "Move disk #$disk from $start to $end.\n";
}

@position = ('', ('A') x 3); # Disks are all initially on peg A

sub check_move { # some bug here, looks like it's in the original code. Will fish it out later. (Maybe!)
    my $i;
    my ($disk, $start, $end) = @_;

    if ($disk < 1 || $disk > $#position) {
        die "Bad disk number $disk. Should be 1..$#position.\n";
    }

    unless ($position[$disk] eq $start) {
        die "Tried to move disk $disk from $start, but it is on peg $position[$disk].\n";
    }

    for $i (1 .. $disk-1) {
        if ($position[$i] eq $end) {
            die "Can't move disk $disk from $start because $i is on top of it.\n";
        } elsif ($position[$i] eq $start) {
            die "Can't move disk $disk to $end because $i is already there.\n"
        }
    }

    print "Moving disk $disk from $start to $end.\n";
    $position[$disk] = $end;
}