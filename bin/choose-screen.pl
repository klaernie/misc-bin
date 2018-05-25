#!/usr/bin/perl
use warnings;
use strict;
use Data::Dumper;
use Term::Choose;

$SIG{INT} = sub { die "aborted"; };

my $all = (grep { $_ eq '--all' } @ARGV) // 0;

chomp( my @screen_ls = qx/screen -ls/);

# There are screens on:
#	2158.pts-1.mainframe	(05/25/2018 09:40:30 PM)	(Attached)
#	21579.pts-23.mainframe	(02/12/2018 06:40:06 PM)	(Detached)
#	1114.kodi	(02/10/2018 01:52:30 PM)	(Detached)
#	27867.pts-16.mainframe	(02/03/2018 03:37:06 PM)	(Detached)
#	26606.pts-14.mainframe	(02/03/2018 03:25:52 PM)	(Detached)
#	14461.pts-3.mainframe	(01/29/2018 05:52:40 PM)	(Detached)
#	9960.pts-1.mainframe	(01/28/2018 05:02:50 PM)	(Detached)
# 7 Sockets in /run/screen/S-kandre.

my %screens;
my %state_of;

my $sockdir;
foreach (@screen_ls){
	next if m/There are screens on:/;
	next if m/\d+ Sockets in (.*)$/;
	next if m/^$/;

	my ( $screen, $state) = (split /\t/)[1,3];
	$state =~ s/[()]//g; # remove useless () around the state

	next unless $all || $state eq 'Detached';

	$state_of{$screen} = $state;
	$screens{$screen} = $_;
}

my @choices = values %screens;
my @choice_indx = keys %screens;

if( scalar @choices == 0 ){
	print "Nothing to reattach!\n";
	exit 0;
}

my $screen;
if( scalar @choices >1 ){
	my $selector = Term::Choose->new({
			prompt => 'Select screen session to restore:',
			layout => 3, # list underneath each other
			index => 1, # return the index instead of the element
		});
	my $selection = $selector->choose(\@choices);

	unless( defined $selection ){
		print "no selection made\n";
		exit 0;
	}

	$screen = $choice_indx[$selection];
} else {
	$screen = $choice_indx[0];
}

print "Choosen screen: $screen, which is $state_of{$screen}\n";

my $args = '-R';
if( $state_of{$screen} eq 'Attached' ){
	$args .= 'D'; # detach before attaching
}

exec 'screen', $args, $screen;



