require "thor"

class EVAL < Thor
  desc "analyze LANGUAGE", "run analysis in LANGUAGE"
  def analyze(language)
    if language == "PHP"
      system("cd phplint && ruby phplint.rb")
    elsif language == "Churn"
      system("ruby churn/churn.rb")
    end
  end
end
