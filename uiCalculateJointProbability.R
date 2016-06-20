## uiCalculateJointProbability.R
## App CalculateJointProbability tab (client side)
## by Phil Ferriere

menuItemCalculateJointProbability = menuSubItem("Joint Probability", tabName = "tabNameCalculateJointProbability")

tabItemCalculateJointProbability = tabItem(
  tabName = "tabNameCalculateJointProbability",

  fluidRow(column(width = 12, box(width = 12, title = "Quick Help", status = "warning", solidHeader = TRUE, collapsible = TRUE,

    includeMarkdown("uiCalculateJointProbabilityHelpText.md")

  ))),

  fluidRow(column(width = 12, box(width = 12, title = "Calculate Joint Probability", status = "primary", solidHeader = TRUE, align = "center",

    fluidRow(column(width = 12, box(width = 12, align = "left",

      textInput(inputId = "wordsTextInputCalculateJointProbability", label = "Comma-separated Word Sequences:", value = "where, is, San, Francisco, where is, San Francisco, where is San Francisco", width = NULL, placeholder = "Hint: Enter comma-separated word sequences")

    ))),

    fluidRow(column(width = 6, box(width = 12, align = "left",

      selectInput(inputId = "lmSelectInputCalculateJointProbability", label = "Language Model", selected = "body", choices = c("title", "anchor", "query", "body"), width = NULL)

    )), column(width = 6, box(width = 12, align = "left",

      selectInput(inputId = "ngramSelectInputCalculateJointProbability", label = "N-gram Order", selected = 5, choices = 1:5, width = NULL)

    ))),

    actionButton(inputId = "buttonCalculateJointProbability", label = "Send Query", icon("paper-plane"), align = "center", width = NULL, style="color: #000; background-color: #337ab7; border-color: #2e6da4"), br(), br(), br(),

    bsAlert("errCalculateJointProbability"),

    fluidRow(column(width = 12, box(width = 12, status = "primary", align = "left",

      helpText("Results: "),
      formattableOutput("resultsCalculateJointProbability")

    ))),
    fluidRow(column(width = 12, box(width = 12, status = "primary", align = "left",

      helpText("Request URL: "),
      tags$style(type='text/css', '#urlCalculateJointProbability {font-size: small;}'),
      verbatimTextOutput("urlCalculateJointProbability")

    ))),
    fluidRow(column(width = 12, box(width = 12, status = "primary", align = "left",

      helpText("JSON Response: "),
      tags$style(type='text/css', '#jsonCalculateJointProbability {font-size: small;}'),
      verbatimTextOutput("jsonCalculateJointProbability")

    )))

  )))
)
