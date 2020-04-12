use strict;
use warnings;
use Test::More;


use Catalyst::Test 'SamuApp';
use SamuApp::Controller::Admin::Group;

ok( request('/admin/group')->is_success, 'Request should succeed' );
done_testing();
