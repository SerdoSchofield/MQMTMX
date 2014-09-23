#!usr/bin/perl

use strict;
use warnings;
use File::Copy;
use feature 'say';
use MQMTMX::converter;
use utf8;
my $directory = $ARGV[0];
my $div;
opendir (DIR, $directory) or die $!;

if (-e ".\\$directory")
{
	$div = "\\";
}
else
{
	$div = "/";
}

while (my $file = readdir(DIR))
{
	if ($file =~ /\.tmx/)
	{
		my $path = "$directory$div$file";
		open my $handle, '<', $path or die $!;
		MQMTMX::converter->convert($handle, $path);
	}
}

closedir DIR;

mkdir($directory.$div."Converted");

opendir (DIR, $directory) or die $!;
while (my $file = readdir(DIR))
{
	if ($file =~ /\.txt/)
	{
		move("$directory$div$file",$directory.$div."Converted".$div.$file) or die "Copy failed: $!";
	}
}