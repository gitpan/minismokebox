use strict;
use inc::Module::Install;
name 'minismokebox';
author 'Chris Williams <chris@bingosnet.co.uk>';
version_from 'lib/App/SmokeBox/Mini.pm';
abstract_from 'bin/minismokebox';
license 'perl';
perl_version '5.006';
build_requires 'Test::More' => 0.47;
build_requires 'Test::POE::Server::TCP' => 0.12;
requires 'Config::Tiny' => 2.12;
requires 'File::Spec' => 0;
requires 'Pod::Usage' => '1.00';
requires 'Time::Duration' => 1.06;
requires 'POE' => 1.0001;
requires 'POE::Component::SmokeBox' => 0.06;
requires 'POE::Component::SmokeBox::Recent' => 1.00;
requires 'POE::Component::SmokeBox::Dists' => 0.08;
if ( can_cc() ) {
print <<NOTICE;

\a--------------------------------------------------------------
Hey,

You appear to have a working compiler. I can include 'Event'
and 'POE::XS::Queue::Array' which will make POE work a lot 
faster.

--------------------------------------------------------------

NOTICE

my $prompt = prompt( 'Do you want to install \'Event\' and \'POE::XS::Queue::Array\' [Y/n]?', 'Y' );

if ( $prompt =~ /^Y/i ) {
  requires 'Event' => 1.11;
  requires 'POE::XS::Queue::Array' => 0.005;
}

}
install_script 'bin/minismokebox';
clean_files '.smokebox jobs.txt';
WriteAll();
