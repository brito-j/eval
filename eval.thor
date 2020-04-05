require "thor"

class EVAL < Thor
  desc "analyze TOOL DIRECTORY", "run analysis with TOOL on DIRECTORY"
  def analyze(tool, directory)
    if tool == "phplint"
      system("node phplint/jsphplint.js #{directory}")
    elsif tool == "churn"
      system("cd #{directory} && churn")
    elsif tool == "rubocop"
      system("rubocop #{directory}")
    elsif tool == "owasp"
      system("java -jar owasp/attack-surface-detector-cli-1.3.5.jar #{directory}")
    elsif tool == "checkstyle"
      system("java -jar checkstyle/checkstyle-8.30-all.jar -c checkstyle/google_checks.xml #{directory}")
    end
  end

  desc "write", "write file test.txt to Google Drive"
  def write
    system("cd auth && ruby auth.rb")
  end
end
