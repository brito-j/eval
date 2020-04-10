# eval: Code Review Report Generator
# Vanderbilt University School of Engineering
# Team Members: Jason Brito, Tony Lin, Lawrence Kwok, Nick Michuda
# Sponsor: Dave Lane of Inventiv

require "thor"
require 'ruby-progressbar'

# perform code review using phplint, Churn, RuboCop, OWASP, and Checkstyle
# generate report using Google Drive API
class EVAL < Thor

  # set parameters of progress bar
  NUMBER_OF_STEPS = 9
  PROGRESS_UPDATE_VALUE = 9
  PROGRESS_TOTAL = NUMBER_OF_STEPS * PROGRESS_UPDATE_VALUE

  # set paths to FOSS
  PATH_TO_PHPLINT = "phplint/jsphplint.js"
  PATH_TO_OWASP = "owasp/attack-surface-detector-cli-1.3.5.jar"
  PATH_TO_CHECKSTYLE = "checkstyle/checkstyle-8.30-all.jar -c checkstyle/google_checks.xml"

  # set path to output file
  PATH_TO_OUTPUT = "output/output.txt"

  # perform code review and generate report
  desc "analyze PATH", "analyze directory at PATH"
  def analyze(directory)

    # create bar to track progress
    progressbar = ProgressBar.create(:total => PROGRESS_TOTAL, format: "\e[0m%t: |%B|\e[0m")
    progressbar.progress += PROGRESS_UPDATE_VALUE

    # overwrite output file
    if File.file?(PATH_TO_OUTPUT)
      open(PATH_TO_OUTPUT, 'w') do |file|
        file << ""
      end
    end
    progressbar.progress += PROGRESS_UPDATE_VALUE

    # run phplint and write output to file
    open(PATH_TO_OUTPUT, 'a') do |file|
      file.puts "PHPLINT"
      file.puts "-------"
    end

    system("node #{PATH_TO_PHPLINT} #{directory} >> #{PATH_TO_OUTPUT}")
    progressbar.progress += PROGRESS_UPDATE_VALUE

    # run Churn and write output to file
    open(PATH_TO_OUTPUT, 'a') do |file|
      file.puts "CHURN"
      file.puts "-----"
    end

    system("cd #{directory} && churn >> #{File.expand_path(PATH_TO_OUTPUT)}")
    progressbar.progress += PROGRESS_UPDATE_VALUE

    # run RuboCop and write output to file
    open(PATH_TO_OUTPUT, 'a') do |file|
      file.puts "RUBOCOP"
      file.puts "-------"
    end

    system("rubocop #{directory} >> #{PATH_TO_OUTPUT}")
    progressbar.progress += PROGRESS_UPDATE_VALUE

    # run OWASP and write output to file
    open(PATH_TO_OUTPUT, 'a') do |file|
      file.puts "\nOWASP"
      file.puts "-----"
    end

    system("java -jar #{PATH_TO_OWASP} #{directory} >> #{PATH_TO_OUTPUT}")
    progressbar.progress += PROGRESS_UPDATE_VALUE

    # run Checkstyle and write output to file
    open(PATH_TO_OUTPUT, 'a') do |file|
      file.puts "\nCHECKSTYLE"
      file.puts "----------"
    end

    system("java -jar #{PATH_TO_CHECKSTYLE} #{directory} >> #{PATH_TO_OUTPUT}")
    progressbar.progress += PROGRESS_UPDATE_VALUE

    # create file in Google Drive
    system("cd auth && ruby auth.rb")
    progressbar.progress += PROGRESS_UPDATE_VALUE

    # color progress bar green to mark completion
    progressbar.format = "%t: |\e[32m%B\e[0m|"
    progressbar.progress += PROGRESS_UPDATE_VALUE
  end
end
