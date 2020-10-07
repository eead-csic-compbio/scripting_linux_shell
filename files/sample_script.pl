#!/usr/bin/env perl  

# published first at
# https://bioinfoperl.blogspot.com/2014/07/regenerando-dna-degenerado.html

use strict;  

my $degenerate_sequence = $ARGV[0] || 
	die "# usage: $0 <degenerate DNA sequence, example: GAYTST>\n";  

my $regenerated_seqs = regenerate($degenerate_sequence);  

foreach my $seq (@$regenerated_seqs){  
	print "$seq\n";  
}  



# This is a function that takes a scalar as parameter.
# It returns a ref to list of all DNA sequences implied in a degenerate oligo  
# Sdapted from http://sourceforge.net/projects/amplicon
sub regenerate { 
	
	# parse parameter of this function
	my ($primerseq) = @_;  

	my %IUPACdegen = (   
		# non-degenerate 1X
		'A'=>['A'],'C'=>['C'], 'G'=>['G'], 'T'=>['T'],   
		# 2X
		'R'=>['A','G'], 'Y'=>['C','T'], 'S'=>['C','G'], 
		'W'=>['A','T'], 'K'=>['G','T'], 'M'=>['A','C'],  
		# 3X
		'B'=>['C','G','T'], 'D'=>['A','G','T'], 
		'V'=>['A','C','G'], 'H'=>['A','C','T'],   
		# 4x
		'N'=>['A','C','G','T']   );  
										
	my @oligo = split(//,uc($primerseq));   
	my @grow = ('');  
	my @newgrow = ('');  
	my ($res,$degen,$x,$n,$seq);  
	foreach $res (0 .. $#oligo){  
		$degen = $IUPACdegen{$oligo[$res]};   
		if($#{$degen}>0){  # only degenerated letters
			$x = 0;  
			@newgrow = @grow;
			while($x<$#{$degen}){  
				push(@newgrow,@grow);  
				$x++;     
			}     
			
			@grow = @newgrow;  
		}  
		
		$n=$x=0;   
		foreach $seq (0 .. $#grow){  
			
			$grow[$seq] .= $degen->[$x];   
			$n++;  

			if($n == (scalar(@grow)/scalar(@$degen))){  
				$n=0;  
				$x++;

			} 
		}
	}  

	return \@grow; # reference to list @grow
}            
