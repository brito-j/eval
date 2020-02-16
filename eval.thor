require "thor"

class EVAL < Thor
  desc "analyze LANGUAGE", "run analysis in LANGUAGE"
  def analyze(language, directory)
    if language == "PHP"
      system("node phplint/jsphplint.js #{directory}")
    elsif language == "Churn"
      system("churn #{directory}")
    elsif language == "Ruby"
      system("rubocop #{directory}")
    end
  end
end
