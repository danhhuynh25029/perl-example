#!/usr/bin/env perl

use strict;
use warnings;
use FindBin;
use lib "$FindBin::Bin/../lib";


# use this block if you don't need middleware, and only have a single target Dancer app to run here
use web::APP;

web::APP->to_app;

=begin comment
# use this block if you want to include middleware such as Plack::Middleware::Deflater

use web::APP;
use Plack::Builder;

builder {
    enable 'Deflater';
    web::APP->to_app;
}

=end comment

=cut

=begin comment
# use this block if you want to mount several applications on different path

use web::APP;
use web::APP_admin;

use Plack::Builder;

builder {
    mount '/'      => web::APP->to_app;
    mount '/admin'      => web::APP_admin->to_app;
}

=end comment

=cut

