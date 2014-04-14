#Command prompt must include the filename of the input
# such as : c\>perl converter.pl file1.tmx
use utf8;
open IN, '<', $ARGV[0];
open LIST, '<', 'filesList.txt';

my %files;
my @source;
my @target;
my @ref;
my %crazy;
my @output;
$ref[0] = 'test';
my $all = 1;

my $n = 0;
while(<LIST>)
{
	chomp;
	$n++; 
	$files{$_} = 1;
	$ref[$n] = $_;
}

close LIST;

my $current;
my $label;
my $source;
my $target;

while(<IN>)
{
	if(/tuid="(.+?):(.+?)"/)
	{
		$current = $1;
		$label = $2;
	}
	elsif(/<tuv xml:lang="en-US"><seg>(.+?)<\/seg><\/tuv>/)
	{
		$1=~s/\t+//;
		$source = $1;
	}
	elsif(/<tuv xml:lang=".+?"><seg>(.+?)<\/seg><\/tuv>/)
	{
		$1=~s/\t+//;
		$target = $1;
		
		if($files{$current} || $all)
		{
			push(@source, $source);
			push(@target, $target);
			
			push(@output, "$current--$label--$source--$target");
			$current = "";
			
		}
	}
}

close IN;
#Code to rename the outputfile
$outputName = $ARGV[0];
$outputName=~s/.tmx$/-OUT.txt/;

open OUT2, '>', $outputName;


foreach(sort(@output))
{
	my @arr = split('--', $_);
		print OUT2 "Label:$arr[1]:<br>$arr[2]\tLabel:$arr[1]:<br>$arr[3]\n";
}


close OUT2;