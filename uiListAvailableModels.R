## uiListAvailableModels.R
## App ListAvailableModels tab (client side)
## by Phil Ferriere

menuItemListAvailableModels = menuSubItem("List Available Models", tabName = "tabNameListAvailableModels")

tabItemListAvailableModels = tabItem(
  tabName = "tabNameListAvailableModels",

  fluidRow(column(width = 12, box(width = 12, title = "Quick Help", status = "warning", solidHeader = TRUE, collapsible = TRUE,

    includeMarkdown("uiListAvailableModelsHelpText.md")

  ))),

  fluidRow(column(width = 12, box(width = 12, title = "List Available Models", status = "primary", solidHeader = TRUE, align = "center",

    br(), actionButton(inputId = "buttonListAvailableModels", label = "Send Query", icon("paper-plane"), align = "center", width = NULL, style="color: #000; background-color: #337ab7; border-color: #2e6da4"), br(), br(), br(),

    bsAlert("errListAvailableModels"),

    fluidRow(column(width = 12, box(width = 12, status = "primary", align = "left",

      helpText("Results: "),
      div(formattableOutput("resultsListAvailableModels"), style = "font-size:75%")

    ))),
    fluidRow(column(width = 12, box(width = 12, status = "primary", align = "left",

      helpText("Request URL: "),
      tags$style(type='text/css', '#urlListAvailableModels {font-size: small;}'),
      verbatimTextOutput("urlListAvailableModels")

    ))),
    fluidRow(column(width = 12, box(width = 12, status = "primary", align = "left",

      helpText("JSON Response: "),
      tags$style(type='text/css', '#jsonListAvailableModels {font-size: small;}'),
      verbatimTextOutput("jsonListAvailableModels")

    )))

  )))
)
