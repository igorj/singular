require File.join(File.expand_path(File.dirname(__FILE__)), 'server')

$stdout.sync = true
run Singular::App
