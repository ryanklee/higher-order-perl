sub total_size {
    my ($top) = @_;
    my $total = -s $top;
    my $DIR;

    return $total if -f $top;
    unless (opendir $DIR, $top) {
        warn "Can't open directory $top: $!; skipping.\n";
        return $total;
    }

    my $file;
    while ($file = readdir $DIR) {
        next if $file =~ /^\.\.?$/;
        $total += total_size("$top/$file");
    }

    closedir $DIR;
    return $total;
}