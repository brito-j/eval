if ARGV.length != 1
  puts "Needs exactly one directory."
  exit
end

file = ARGV[0]

system("churn #{file}")