## uiBreakIntoWords.R
## App BreakIntoWords tab (client side)
## by Phil Ferriere

menuItemBreakIntoWords = menuSubItem("Break Into Words", tabName = "tabNameBreakIntoWords")

tabItemBreakIntoWords = tabItem(
  tabName = "tabNameBreakIntoWords",

  fluidRow(column(width = 12, box(width = 12, title = "Quick Help", status = "warning", solidHeader = TRUE, collapsible = TRUE,

    includeMarkdown("uiBreakIntoWordsHelpText.md")

  ))),

  fluidRow(column(width = 12, box(width = 12, title = "Break Into Words", status = "primary", solidHeader = TRUE, align = "center",

    fluidRow(column(width = 12, box(width = 12, align = "left",

      textInput(inputId = "wordsTextInputBreakIntoWords", label = "Text To Break Into Words:", value = "testforwordbreak", width = NULL, placeholder = "Hint: Enter some text")

    ))),

    fluidRow(column(width = 4, box(width = 12, align = "left",

      selectInput(inputId = "lmSelectInputBreakIntoWords", label = "Language Model", selected = "body", choices = c("title", "anchor", "query", "body"), width = NULL)

    )), column(width = 4, box(width = 12, align = "left",

      selectInput(inputId = "ngramSelectInputBreakIntoWords", label = "N-gram Order", selected = 5, choices = 1:5, width = NULL)

    )), column(width = 4, box(width = 12, align = "left",

      selectInput(inputId = "candidatesSelectInputBreakIntoWords", label = "Max Candidates", selected = 5, choices = 1:10, width = NULL)

    ))),

    actionButton(inputId = "buttonBreakIntoWords", label = "Send Query", icon("paper-plane"), align = "center", width = NULL, style="color: #000; background-color: #337ab7; border-color: #2e6da4"), br(), br(), br(),

    bsAlert("errBreakIntoWords"),

    fluidRow(column(width = 12, box(width = 12, status = "primary", align = "left",

      helpText("Results: "),
      formattableOutput("resultsBreakIntoWords")

    ))),
    fluidRow(column(width = 12, box(width = 12, status = "primary", align = "left",

      helpText("Request URL: "),
      verbatimTextOutput("urlBreakIntoWords")

    ))),
    fluidRow(column(width = 12, box(width = 12, status = "primary", align = "left",

      helpText("JSON Response: "),
      verbatimTextOutput("jsonBreakIntoWords")

    )))

  )))
)
