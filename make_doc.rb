#!/usr/bin/env ruby

puts "Creating documentation."
system "rdoc --main doc-main.txt -d doc-main.txt #{Dir['lib/**/*.rb'] * ' '}"
