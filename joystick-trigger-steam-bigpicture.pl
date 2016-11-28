#!/usr/bin/perl -w

use Linux::Joystick;
use Proc::Daemon;

use warnings;
use strict;

my $daemon = Proc::Daemon->new;

exit if $daemon->Init;

while (1) {
    eval {
        my $js = new Linux::Joystick;

        while ( my $event = $js->nextEvent ) {
            if ($event->buttonUp(8)) {
                system("/usr/games/steam", "-bigpicture");
                $js->flushEvents
            }
        }
    };
    sleep 1;
}
