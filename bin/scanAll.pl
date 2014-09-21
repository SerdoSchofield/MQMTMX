#!usr/bin/perl

use strict;
use warnings;
use File::Copy;
use feature 'say';
use MQMTMX::converter;
use utf8;
my $directory = $ARGV[0];

opendir (DIR, $directory) or die $!;

while (my $file = readdir(DIR))
{
	if ($file =~ /\.tmx/)
	{
		my $path = "$directory\\$file";
		open my $handle, '<', $path or die $!;
		MQMTMX::converter->convert($handle, $path);
	}
}

closedir DIR;

mkdir("$directory\\Converted");

opendir (DIR, $directory) or die $!;
while (my $file = readdir(DIR))
{
	if ($file =~ /\.txt/)
	{
		move("$directory\\$file","$directory\\Converted\\$file") or die "Copy failed: $!";
	}
}