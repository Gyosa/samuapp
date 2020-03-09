use strict;
use warnings;

use SamuApp;

my $app = SamuApp->apply_default_middlewares(SamuApp->psgi_app);
$app;

