require "thor"

class EVAL < Thor
  desc "analyze TOOL DIRECTORY", "run analysis with TOOL on DIRECTORY"
  def analyze(tool, directory)
    if tool == "PHP"
      system("node phplint/jsphplint.js #{directory}")
    elsif tool == "Churn"
      system("churn #{directory}")
    elsif tool == "Ruby"
      system("rubocop #{directory}")
    end
  end
end
