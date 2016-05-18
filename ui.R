## ui.R
## Client-side UI code
## by Phil Ferriere

deps = c("shiny", "shinydashboard", "markdown", "formattable", "shinyBS", "mscsweblm4r")
for (dep in deps){
  if (dep %in% installed.packages()[,"Package"] == FALSE){
    install.packages(dep)
  }
}
for (dep in deps){
  library(dep, character.only = TRUE)
}

# Configure mscsweblm4r
Sys.setenv(MSCS_WEBLANGUAGEMODEL_CONFIG_FILE = "./data/.mscskeys.json")
weblmInit()

source("server.R")

# Import modules
source("uiListAvailableModels.R")
source("uiGenerateNextWords.R")
source("uiBreakIntoWords.R")
source("uiCalculateConditionalProbability.R")
source("uiCalculateJointProbability.R")
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
      menuItemContactInfo,
      id="sidebar"
    )
  ),
  dashboardBody(
    tags$style(type="text/css", ".shiny-output-error { visibility: hidden; }", ".shiny-output-error:before { visibility: hidden; }", ".box-header .box-title { font-size: 14px; font-style: italic; }"),
    tabItems(
      tabItemListAvailableModels,
      tabItemGenerateNextWords,
      tabItemBreakIntoWords,
      tabItemCalculateConditionalProbability,
      tabItemCalculateJointProbability,
      tabItemDocumentation,
      tabItemContactInfo
    )
  )
)
