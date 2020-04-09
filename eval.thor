# eval: Code Review Report Generator
# Vanderbilt University School of Engineering
# Team Members: Jason Brito, Tony Lin, Lawrence Kwok, Nick Michuda
# Sponsor: Dave Lane of Inventiv

require "thor"
require 'ruby-progressbar'

# Class for running all available tools on a provided directory and generating a code review report.
# After analysis, eval sends output to a Google Drive Doc.
# Tools: Phplint, Churn, Rubocop, OWASP, Checkstyle.
class EVAL < Thor

  NUMBER_OF_STEPS = 7
  PROGRESS_UPDATE_VALUE = 7
  PROGRESS_TOTAL = NUMBER_OF_STEPS * PROGRESS_UPDATE_VALUE + 2

  PATH_TO_PHPLINT = "phplint/jsphplint.js"
  PATH_TO_OWASP = "owasp/attack-surface-detector-cli-1.3.5.jar"
  PATH_TO_CHECKSTYLE = "checkstyle/checkstyle-8.30-all.jar -c checkstyle/google_checks.xml"
  PATH_TO_OUTPUT = File.expand_path("output/output.txt") # Create and save path to output file.

  desc "analyze PATH", "analyze directory at provided PATH and generate code review report"
  def analyze(directory)
    progressbar = ProgressBar.create(:total => PROGRESS_TOTAL, format: "\e[0m%t: |%B|\e[0m")
    progressbar.increment
    # Write to the .txt output file.
    if File.file?(PATH_TO_OUTPUT)
      open(PATH_TO_OUTPUT, 'w') do |file|
        file << ""
      end
    end
    progressbar.progress += PROGRESS_UPDATE_VALUE

    # Indicate start of Phplint analysis in the output file.
    open(PATH_TO_OUTPUT, 'a') do |file|
      file.puts "PHPLINT"
      file.puts "-------"
    end
    # Call Phplint to run on the user directory and send analysis to the output file.
    system("node #{PATH_TO_PHPLINT} #{directory} >> #{PATH_TO_OUTPUT}")
    progressbar.progress += PROGRESS_UPDATE_VALUE

    # Indicate start of Churn analysis in the output file.
    open(PATH_TO_OUTPUT, 'a') do |file|
      file.puts "CHURN"
      file.puts "-----"
    end
    # Call Churn to run on the user directory and send analysis to the output file.
    system("cd #{directory} && churn >> #{PATH_TO_OUTPUT}")
    progressbar.progress += PROGRESS_UPDATE_VALUE

    # Indicate start of Rubocop analysis in the output file.
    open(PATH_TO_OUTPUT, 'a') do |file|
      file.puts "RUBOCOP"
      file.puts "-------"
    end
    # Call Rubocop to run on the user directory and send analysis to the output file.
    system("rubocop #{directory} >> #{PATH_TO_OUTPUT}")
    progressbar.progress += PROGRESS_UPDATE_VALUE

    # Indicate start of OWASP analysis in the output file.
    open(PATH_TO_OUTPUT, 'a') do |file|
      file.puts "\nOWASP"
      file.puts "-----"
    end
    # Call OWASP to run on the user directory and send analysis to the output file.
    system("java -jar #{PATH_TO_OWASP} #{directory} >> #{PATH_TO_OUTPUT}")
    progressbar.progress += PROGRESS_UPDATE_VALUE

    # Indicate start of Checkstyle analysis in the output file.
    open(PATH_TO_OUTPUT, 'a') do |file|
      file.puts "\nCHECKSTYLE"
      file.puts "----------"
    end
    # Call Checkstyle to run on the user directory and send analysis to the output file.
    system("java -jar #{PATH_TO_CHECKSTYLE} #{directory} >> #{PATH_TO_OUTPUT}")
    progressbar.progress += PROGRESS_UPDATE_VALUE

    # Call to create Google Doc from output.txt.
    system("cd auth && ruby auth.rb")
    progressbar.progress += PROGRESS_UPDATE_VALUE
    progressbar.format = "%t: |\e[32m%B\e[0m|"
    progressbar.increment
  end
end
