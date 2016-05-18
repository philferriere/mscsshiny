## uiCalculateConditionalProbability.R
## App CalculateConditionalProbability tab (client side)
## by Phil Ferriere

menuItemCalculateConditionalProbability = menuSubItem("Conditional Probability", tabName = "tabNameCalculateConditionalProbability")

tabItemCalculateConditionalProbability = tabItem(
  tabName = "tabNameCalculateConditionalProbability",

  fluidRow(column(width = 12, box(width = 12, title = "Quick Help", status = "warning", solidHeader = TRUE, collapsible = TRUE,

    includeMarkdown("uiCalculateConditionalProbabilityHelpText.md")

  ))),

  fluidRow(column(width = 12, box(width = 12, title = "Calculate Conditional Probability", status = "primary", solidHeader = TRUE, align = "center",

    fluidRow(column(width = 6, box(width = 12, align = "left",
                                   
      textInput(inputId = "precedingWordsTextInputCalculateConditionalProbability", label = "Preceding Words:", value = "hello world wide", width = NULL, placeholder = "Hint: Enter preceding words")
                                   
    )), column(width = 6, box(width = 12, align = "left",
                              
      textInput(inputId = "continuationsTextInputCalculateConditionalProbability", label = "Comma-separated Continuations:", value = "web, range, open", width = NULL, placeholder = "Hint: Enter comma-separated continuations")
                              
    ))),

    fluidRow(column(width = 6, box(width = 12, align = "left",

      selectInput(inputId = "lmSelectInputCalculateConditionalProbability", label = "Language Model", selected = "body", choices = c("title", "anchor", "query", "body"), width = NULL)

    )), column(width = 6, box(width = 12, align = "left",

      selectInput(inputId = "ngramSelectInputCalculateConditionalProbability", label = "N-gram Order", selected = 5, choices = 1:5, width = NULL)

    ))),

    actionButton(inputId = "buttonCalculateConditionalProbability", label = "Send Query", icon("paper-plane"), align = "center", width = NULL, style="color: #000; background-color: #337ab7; border-color: #2e6da4"), br(), br(), br(),

    bsAlert("errCalculateConditionalProbability"),

    fluidRow(column(width = 12, box(width = 12, status = "primary", align = "left",

      helpText("Results: "),
      formattableOutput("resultsCalculateConditionalProbability")

    ))),
    fluidRow(column(width = 12, box(width = 12, status = "primary", align = "left",

      helpText("Request URL: "),
      verbatimTextOutput("urlCalculateConditionalProbability")

    ))),
    fluidRow(column(width = 12, box(width = 12, status = "primary", align = "left",

      helpText("JSON Response: "),
      verbatimTextOutput("jsonCalculateConditionalProbability")

    )))

  )))
)
