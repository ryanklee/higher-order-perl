hanoi($ARGV[0], $ARGV[1], $ARGV[2], $ARGV[3], \&print_instruction);

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