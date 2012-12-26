#!/usr/bin/perl

# by entheon, do whatever the hell you want with this file

push(@arr,
     "[30m 00",
     "[31m 01",
     "[32m 02",
     "[33m 03",
     "[34m 04",
     "[35m 05",
     "[36m 06",
     "[37m 07",

     "[90m 90",
     "[91m 91",
     "[92m 92",
     "[93m 93",
     "[94m 94",
     "[95m 95",
     "[96m 96",
     "[97m 97",

     "[1m bright on",
     "[30m 00",
     "[31m 01",
     "[32m 02",
     "[33m 03",
     "[34m 04",
     "[35m 05",
     "[36m 06",
     "[37m 07",
     
     "[90m 90",
     "[91m 91",
     "[92m 92",
     "[93m 93",
     "[94m 94",
     "[95m 95",
     "[96m 96",
     "[97m 97"
    );  


print scalar @arr . "\n";
for( $dimone = 0; $dimone < scalar @arr; $dimone++ ) {
	print $arr[$dimone] . "\n";
}

print "\n";

print "0m";
exit;
