use strict;
use warnings;
use Test::More tests => 7;
use App::SmokeBox::Mini;
use File::Spec;
use Cwd;

$ENV{PERL5_SMOKEBOX_DIR} = cwd();
my $smokebox_dir = File::Spec->catdir( App::SmokeBox::Mini::_smokebox_dir(), '.smokebox' );

mkdir $smokebox_dir unless -d $smokebox_dir;
die "$!\n" unless -d $smokebox_dir;

open CONFIG, '> ' . File::Spec->catfile( $smokebox_dir, 'minismokebox' ) or die "$!\n";
print CONFIG <<EOF;
debug=1
perl=/MADE/UP/PATH/TO/perl
url=http://www.cpan.org/
backend=CPAN::YACSmoke
recent=1
indices=1
wtf=1
EOF
close CONFIG;

my %config = App::SmokeBox::Mini::_read_config();

ok( $config{debug},   'Debug flag' );
ok( $config{indices}, 'Indices flag' );
ok( $config{recent},  'Recent flag' );
ok( !$config{wtf},    'No wtf flag, good' );
ok( $config{backend} eq 'CPAN::YACSmoke', 'Backend defined' );
ok( $config{url} eq 'http://www.cpan.org/', 'URL defined' );
ok( $config{perl} eq '/MADE/UP/PATH/TO/perl', 'perl defined' );
