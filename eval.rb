require "thor"

class CLI < Thor
  desc "analyze LANGUAGE", "run analysis in LANGUAGE"
  def analyze(language)
    if language == "PHP"
      system("ruby phplint/phplint.rb")
    end
  end
end

CLI.start(ARGV)
