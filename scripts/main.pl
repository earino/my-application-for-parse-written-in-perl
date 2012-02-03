#!/usr/bin/env perl

use 5.14.2;
use warnings;
use strict;

use FindBin;
use File::Slurp;
use JSON;

my $url_file = "$FindBin::Bin/../data/urls.txt";
my $uri = 'https://www.parse.com/jobs/apply';

die "Unable to use $url_file, reason: $!\n" unless -r $url_file;

my @urls = read_file $url_file;

my %application_data = (
	'name' => 'Eduardo Ariño de la Rubia',
	'email' => 'earino+parse@gmail.com',
	'about' => 'I am an quality developer who thinks mobile backend as a service is an awesome problem to solve, and I have relevant experience.',
	'urls' => \@urls,
);

my $json = to_json @urls;

print $json;
exit;

my $json = '{"username":"foo","password":"bar"}';
my $req = HTTP::Request->new( 'POST', $uri );
$req->header( 'Content-Type' => 'application/json' );
$req->content( $json );

