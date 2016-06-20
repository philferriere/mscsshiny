## uiDocumentation.R
## App documentation tab (client side)
## by Phil Ferriere

menuItemDocumentation = menuItem("Documentation", tabName = "tabNameDocumentation", icon=icon("info-circle"))

tabItemDocumentation = tabItem(
  tabName = "tabNameDocumentation",

  fluidRow(column(width = 12, box(width = 12, title = "Documentation", status = "primary", solidHeader = TRUE,

    tabsetPanel(
      tabPanel(
        "App Instructions",
        includeMarkdown("uiAppInstructions.md")
      ),
      tabPanel(
        "Text Analytics API",
        includeMarkdown("uiDocTextAnalyticsAPI.md")
      ),
      tabPanel(
        "Web Language Model API",
        includeMarkdown("uiDocWebLanguageModelAPI.md")
      )
    )

  )))
)
