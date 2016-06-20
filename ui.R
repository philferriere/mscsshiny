## ui.R
## Client-side UI code
## by Phil Ferriere

# Use this if you're running this app locally or on your own Shiny server
deps = c("shiny", "shinydashboard", "shinyjs", "markdown", "formattable", "shinyBS", "mscsweblm4r", "mscstexta4r")
for (dep in deps){
  if (dep %in% installed.packages()[,"Package"] == FALSE){
    install.packages(dep)
  }
}
for (dep in deps){
  library(dep, character.only = TRUE)
}

# Use this is you're hosting this app on shinyapps.io -- they don't allow calls to install.packages()
# library(shiny)
# library(shinydashboard)
# library(shinyjs)
# library(markdown)
# library(formattable)
# library(shinyBS)
# library(mscsweblm4r)
# library(mscstexta4r)

# For some reason, can't publish .mscskeys.json to shinyapps.io but mscskeys.json works ok...
Sys.setenv(MSCS_WEBLANGUAGEMODEL_CONFIG_FILE = "./data/mscskeys.json")
Sys.setenv(MSCS_TEXTANALYTICS_CONFIG_FILE = "./data/mscskeys.json")
# Configure mscsweblm4r and mscstexta4r
weblmInit()
textaInit()

source("server.R")

# Import modules
source("uiListAvailableModels.R")
source("uiGenerateNextWords.R")
source("uiBreakIntoWords.R")
source("uiCalculateConditionalProbability.R")
source("uiCalculateJointProbability.R")

source("uiSentiment.R")
source("uiDetectTopics.R")
source("uiDetectLanguages.R")
source("uiKeyPhrases.R")

source("uiDocumentation.R")
source("uiContactInfo.R")

dashboardPage(skin = "blue",
  dashboardHeader(title = "MS Cognitive Services Shiny Test App", titleWidth = 380),
  dashboardSidebar(
    sidebarMenu(
      menuItemDocumentation,
      menuItem("Web Language Model API", icon = icon("book"),
        menuItemListAvailableModels,
        menuItemGenerateNextWords,
        menuItemBreakIntoWords,
        menuItemCalculateConditionalProbability,
        menuItemCalculateJointProbability
      ),
      menuItem("Text Analytics API", icon = icon("flask"),
        menuItemSentiment,
        menuItemDetectTopics,
        menuItemDetectLanguages,
        menuItemKeyPhrases
      ),
      menuItemContactInfo,
      id="sidebar"
    )
  ),
  dashboardBody(
    includeCSS("./www/styles.css"),
    useShinyjs(),
    # tags$style(type="text/css", ".shiny-output-error { visibility: hidden; }", ".shiny-output-error:before { visibility: hidden; }", ".box-header .box-title { font-size: 14px; font-style: italic; }"),
    # tags$style(type="text/css", ".shiny-output-error-validation { color: red; }", ".box-header .box-title { font-size: 14px; font-style: italic; }"),
    tabItems(
      tabItemListAvailableModels,
      tabItemGenerateNextWords,
      tabItemBreakIntoWords,
      tabItemCalculateConditionalProbability,
      tabItemCalculateJointProbability,
      tabItemSentiment,
      tabItemDetectTopics,
      tabItemDetectLanguages,
      tabItemKeyPhrases,
      tabItemDocumentation,
      tabItemContactInfo
    )
  )
)
