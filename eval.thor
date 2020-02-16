require "thor"

class EVAL < Thor
  desc "analyze LANGUAGE", "run analysis in LANGUAGE"
  def analyze(language, directory)
    if language == "PHP"
      system("cd phplint && ruby phplint.rb")
    elsif language == "Churn"
      system("churn #{directory}")
    end
  end
end
