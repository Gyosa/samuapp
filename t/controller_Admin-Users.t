use strict;
use warnings;
use Test::More;


use Catalyst::Test 'SamuApp';
use SamuApp::Controller::Admin::Users;

ok( request('/admin/users')->is_success, 'Request should succeed' );
done_testing();
