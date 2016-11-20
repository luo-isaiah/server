package My::Suite::XtraBackup;

@ISA = qw(My::Suite);
use My::Find;
use File::Basename;
use strict;

return "Not run for embedded server" if $::opt_embedded_server;

my $xtrabackup_exe=
::mtr_exe_maybe_exists(
  "$::bindir/storage/xtradb/xtrabackup/src$::opt_vs_config/xtrabackup",
  "$::path_client_bindir/xtrabackup");

return "No xtrabackup" if !$xtrabackup_exe;


$ENV{XTRABACKUP}= $xtrabackup_exe;

$ENV{XBSTREAM}= ::mtr_exe_maybe_exists(
      "$::bindir/storage/xtradb/xtrabackup/src$::opt_vs_config/xbstream",
      "$::path_client_bindir/xbstream");
	  
my $tar_version = `tar --version 2>&1`;
$ENV{HAVE_TAR} = $! ? 0: 1;
my $xtrabackup_help=`$xtrabackup_exe --help 2>&1`;
$ENV{HAVE_XTRABACKUP_TAR_SUPPORT} =  (index($xtrabackup_help,"'tar'") == -1) ? 0 : 1;

sub is_default { 1 }

bless { };

