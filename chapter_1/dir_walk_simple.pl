sub dir_walk {
    my ($top, $callback) = @_;
    my $DIR;

    $callback->($top);

    if (-d $top) {
        my $file;
        unless (opendir $DIR, $top) {
            warn "Can't open directory $top: $!; skipping.\n";
            return;
        }
        while ($file = readdir $DIR) {
            next if $file =~ /^\.\.?$/;
            dir_walk("$top/$file", $callback);
        }
    }
}