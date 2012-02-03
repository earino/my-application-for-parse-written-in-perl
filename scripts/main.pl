#!/usr/bin/env perl

use 5.14.2;
use warnings;
use strict;

use Encode;
use FindBin;
use File::Slurp;
use HTTP::Request;
use JSON;
use LWP::UserAgent;

my $url_file = "$FindBin::Bin/../data/urls.txt";
my $uri = 'https://www.parse.com/jobs/apply';

die "Unable to use $url_file, reason: $!\n" unless -r $url_file;

my @urls = read_file $url_file;

my %application_data = (
	'name' => 'Eduardo Arino de la Rubia',
	'email' => 'earino+parse@gmail.com',
	'about' => 'I am an quality developer who thinks mobile backend as a service is an awesome problem to solve, and I have relevant experience.',
	'urls' => \@urls,
);

my $json = to_json \%application_data, { ascii  => 1, pretty => 1 };

my $req = HTTP::Request->new( 'POST', $uri );
$req->header( 'Content-Type' => 'application/json' );
$req->content( $json );

my $lwp = LWP::UserAgent->new;
my $res = $lwp->request( $req );
if ($res->is_success) {
	print "You have applied to a cool company.\n"
}
else {
	die "You may want to try that again. It failed: ".$res->status_line;
}
