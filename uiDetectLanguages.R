## uiDetectLanguages.R
## App DetectLanguages tab (client side)
## by Phil Ferriere

menuItemDetectLanguages = menuSubItem("Language Detection", tabName = "tabNameDetectLanguages")

defaultDetectLanguagesText <-
"The Louvre or the Louvre Museum is the world's largest museum.
Le musee du Louvre est un musee d'art et d'antiquites situe au centre de Paris.
El Museo del Louvre es el museo nacional de Francia.
Il Museo del Louvre a Parigi, in Francia, e uno dei piu celebri musei del mondo.
Der Louvre ist ein Museum in Paris."

tabItemDetectLanguages = tabItem(
  tabName = "tabNameDetectLanguages",

  fluidRow(column(width = 12, box(width = 12, title = "Quick Help", status = "warning", solidHeader = TRUE, collapsible = TRUE,

    includeMarkdown("uiDetectLanguagesHelpText.md")

  ))),

  fluidRow(column(width = 12, box(width = 12, title = "Language Detection", status = "primary", solidHeader = TRUE, align = "center",

    fluidRow(column(width = 12, box(width = 12, align = "left",

      tags$div(
        class = "form-group shiny-input-container",
        tags$label('for' = "wordsTextInputDetectLanguages", "Input Sentences:"),
        tags$textarea(id = "wordsTextInputDetectLanguages", class = "form-control", rows = 10, cols = 70, defaultDetectLanguagesText)
      )

    ))),

    actionButton(inputId = "buttonDetectLanguages", label = "Send Query", icon("paper-plane"), align = "center", width = NULL, style="color: #000; background-color: #337ab7; border-color: #2e6da4"), br(), br(), br(),

    bsAlert("errDetectLanguages"),

    fluidRow(column(width = 12, box(width = 12, status = "primary", align = "left",

      helpText("Results: "),
      formattableOutput("resultsDetectLanguages")

    ))),
    fluidRow(column(width = 12, box(width = 12, status = "primary", align = "left",

      helpText("Request URL: "),
      tags$style(type='text/css', '#urlDetectLanguages {font-size: small;}'),
      verbatimTextOutput("urlDetectLanguages")

    ))),
    fluidRow(column(width = 12, box(width = 12, status = "primary", align = "left",

      helpText("JSON Response: "),
      tags$style(type='text/css', '#jsonDetectLanguages {font-size: small;}'),
      verbatimTextOutput("jsonDetectLanguages")

    )))

  )))
)
