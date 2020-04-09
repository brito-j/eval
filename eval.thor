require "thor"
require 'ruby-progressbar'

class EVAL < Thor

  PATH_TO_PHPLINT = "phplint/jsphplint.js"
  PATH_TO_OWASP = "owasp/attack-surface-detector-cli-1.3.5.jar"
  PATH_TO_CHECKSTYLE = "checkstyle/checkstyle-8.30-all.jar -c checkstyle/google_checks.xml"
  PATH_TO_OUTPUT = File.expand_path("output/output.txt")

  desc "analyze PATH", "run analysis on directory at PATH"
  def analyze(directory)
    progressbar = ProgressBar.create(:total => 50, format: "\e[0m%t: |%B|\e[0m")
    progressbar.progress += 1
    if File.file?(PATH_TO_OUTPUT)
      open(PATH_TO_OUTPUT, 'w') do |file|
        file << ""
      end
    end
    progressbar.progress += 7

    open(PATH_TO_OUTPUT, 'a') do |file|
      file.puts "PHPLINT"
      file.puts "-------"
    end
    system("node #{PATH_TO_PHPLINT} #{directory} >> #{PATH_TO_OUTPUT}")
    progressbar.progress += 7

    open(PATH_TO_OUTPUT, 'a') do |file|
      file.puts "CHURN"
      file.puts "-----"
    end
    system("cd #{directory} && churn >> #{PATH_TO_OUTPUT}")
    progressbar.progress += 7

    open(PATH_TO_OUTPUT, 'a') do |file|
      file.puts "RUBOCOP"
      file.puts "-------"
    end
    system("rubocop #{directory} >> #{PATH_TO_OUTPUT}")
    progressbar.progress += 7

    open(PATH_TO_OUTPUT, 'a') do |file|
      file.puts "\nOWASP"
      file.puts "-----"
    end
    system("java -jar #{PATH_TO_OWASP} #{directory} >> #{PATH_TO_OUTPUT}")
    progressbar.progress += 7

    open(PATH_TO_OUTPUT, 'a') do |file|
      file.puts "\nCHECKSTYLE"
      file.puts "----------"
    end
    system("java -jar #{PATH_TO_CHECKSTYLE} #{directory} >> #{PATH_TO_OUTPUT}")
    progressbar.progress += 7

    system("cd auth && ruby auth.rb")
    progressbar.progress += 6
    progressbar.format = "%t: |\e[32m%B\e[0m|"
    progressbar.increment
  end
end
