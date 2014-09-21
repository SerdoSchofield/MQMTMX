#Command prompt must include the filename of the input
# such as : c\>perl converter.pl file1.tmx
package MQMTMX::converter;

use utf8;
use feature 'say';
sub convert
{
	my ($self, $file, $path) =  @_;
	_process($file, $path);
	return 1;
}

sub _run
{
	my $fileName = $ARGV[0];
	my $path = $ARGV[0];
	open my $file, '<', $fileName or die $!;
	_process($file, $path);
}

sub _process
{
	my ($file, $path) = @_;
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

	while(<$file>)
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
			my $val = $1;
			$val=~s/\t+//;
			$target = $val;
			
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
	say $path;
	$outputName = $path;
	$outputName =~ s/.tmx$/-OUT.txt/;
	
	open OUT2, '>', $outputName or die "$! : $outputName";

	foreach(sort(@output))
	{
		my @arr = split('--', $_);
			print OUT2 "Label:$arr[1]:<br>$arr[2]\tLabel:$arr[1]:<br>$arr[3]\n";
	}

	close OUT2;
	return 1;
}
	
_run unless caller();