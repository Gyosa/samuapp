use strict;
use warnings;
use Test::More;


use Catalyst::Test 'SamuApp';
use SamuApp::Controller::Admin:PlanningCreate;

ok( request('/admin:planningcreate')->is_success, 'Request should succeed' );
done_testing();
