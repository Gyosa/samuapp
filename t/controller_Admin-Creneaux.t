use strict;
use warnings;
use Test::More;


use Catalyst::Test 'SamuApp';
use SamuApp::Controller::Admin::Creneaux;

ok( request('/admin/creneaux')->is_success, 'Request should succeed' );
done_testing();