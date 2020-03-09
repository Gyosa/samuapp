use strict;
use warnings;
use Test::More;


use Catalyst::Test 'SamuApp';
use SamuApp::Controller::Admin::Planning;

ok( request('/admin/planning')->is_success, 'Request should succeed' );
done_testing();
