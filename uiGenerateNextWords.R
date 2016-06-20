## uiGenerateNextWords.R
## App GenerateNextWords tab (client side)
## by Phil Ferriere

menuItemGenerateNextWords = menuSubItem("Generate Next Words", tabName = "tabNameGenerateNextWords")

tabItemGenerateNextWords = tabItem(
  tabName = "tabNameGenerateNextWords",

  fluidRow(column(width = 12, box(width = 12, title = "Quick Help", status = "warning", solidHeader = TRUE, collapsible = TRUE,

    includeMarkdown("uiGenerateNextWordsHelpText.md")

  ))),

  fluidRow(column(width = 12, box(width = 12, title = "Generate Next Words", status = "primary", solidHeader = TRUE, align = "center",

    fluidRow(column(width = 12, box(width = 12, align = "left",

      textInput(inputId = "wordsTextInputGenerateNextWords", label = "Preceding Words:", value = "how are you", width = NULL, placeholder = "Hint: Enter some text")

    ))),

    fluidRow(column(width = 4, box(width = 12, align = "left",

      selectInput(inputId = "lmSelectInputGenerateNextWords", label = "Language Model", selected = "title", choices = c("title", "anchor", "query", "body"), width = NULL)

    )), column(width = 4, box(width = 12, align = "left",

      selectInput(inputId = "ngramSelectInputGenerateNextWords", label = "N-gram Order", selected = 5, choices = 1:5, width = NULL)

    )), column(width = 4, box(width = 12, align = "left",

      selectInput(inputId = "candidatesSelectInputGenerateNextWords", label = "Max Candidates", selected = 5, choices = 1:10, width = NULL)

    ))),

    actionButton(inputId = "buttonGenerateNextWords", label = "Send Query", icon("paper-plane"), align = "center", width = NULL, style="color: #000; background-color: #337ab7; border-color: #2e6da4"), br(), br(), br(),
    
    bsAlert("errGenerateNextWords"),

    fluidRow(column(width = 12, box(width = 12, status = "primary", align = "left",

      helpText("Results: "),
      formattableOutput("resultsGenerateNextWords")

    ))),
    fluidRow(column(width = 12, box(width = 12, status = "primary", align = "left",

      helpText("Request URL: "),
      tags$style(type='text/css', '#urlGenerateNextWords {font-size: small;}'),
      verbatimTextOutput("urlGenerateNextWords")

    ))),
    fluidRow(column(width = 12, box(width = 12, status = "primary", align = "left",

      helpText("JSON Response: "),
      tags$style(type='text/css', '#jsonGenerateNextWords {font-size: small;}'),
      verbatimTextOutput("jsonGenerateNextWords")

    )))

  )))
)
