#!/usr/bin/perl -w

use Linux::Joystick;
use Proc::Daemon;

use warnings;
use strict;

die "DISPLAY not set!\n" unless $ENV{DISPLAY};

Proc::Daemon->new->Init;

while (1) {
    my $js;
    while (!($js = new Linux::Joystick("/dev/input/js0"))) {
        sleep 1;
    }
    print "Opened joystick\n";
    while ( $js and my $event = $js->nextEvent ) {
        if ($event->buttonUp(8)) {
            close $js->fileHandle;
            $js = undef;
            print "Starting Steam!\n";
            system("/usr/games/steam", "-bigpicture");
            print "Steam exited.\n";
        }
    }
}
