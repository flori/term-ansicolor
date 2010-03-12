#!/usr/bin/env ruby

puts "Creating documentation."
system "rdoc --title 'Term::ANSIColor' --main README -d README #{Dir['lib/**/*.rb'] * ' '}"
