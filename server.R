## server.R
## Server-side code
## by Phil Ferriere

# Import modules
source("serverListAvailableModels.R")
source("serverGenerateNextWords.R")
source("serverBreakIntoWords.R")
source("serverCalculateConditionalProbability.R")
source("serverCalculateJointProbability.R")

source("serverSentiment.R")
source("serverDetectTopics.R")
source("serverDetectLanguages.R")
source("serverKeyPhrases.R")

shinyServer(function(input, output, session) {

  # ListAvailableModels tab code
  serverListAvailableModels(input, output, session)

  # GenerateNextWords tab code
  serverGenerateNextWords(input, output, session)

  # BreakIntoWords tab code
  serverBreakIntoWords(input, output, session)

  # CalculateConditionalProbability tab code
  serverCalculateConditionalProbability(input, output, session)

  # CalculateJointProbability tab code
  serverCalculateJointProbability(input, output, session)

  # Sentiment tab code
  serverSentiment(input, output, session)

  # DetectTopics tab code
  serverDetectTopics(input, output, session)

  # DetectLanguages tab code
  serverDetectLanguages(input, output, session)
   
  # KeyPhrases tab code
  serverKeyPhrases(input, output, session)
  
})
