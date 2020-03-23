require "thor"

class EVAL < Thor
  desc "analyze TOOL DIRECTORY", "run analysis with TOOL on DIRECTORY"
  def analyze(tool, directory)
    if tool == "PHP"
      system("node phplint/jsphplint.js #{directory}")
    elsif tool == "Churn"
      system("cd #{directory} && churn")
    elsif tool == "Ruby"
      system("rubocop #{directory}")
    elsif tool == "OWASP"
      system("java -jar owasp/attack-surface-detector-cli-1.3.5.jar #{directory}")
    end
  end
end
