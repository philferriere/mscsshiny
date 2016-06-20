## uiKeyPhrases.R
## App KeyPhrases tab (client side)
## by Phil Ferriere

menuItemKeyPhrases = menuSubItem("Key Phrase Extraction", tabName = "tabNameKeyPhrases")

defaultKeyPhrasesText <-
"Loved the food, service and atmosphere! We'll definitely be back.
Very good food, reasonable prices, excellent service.
It was a great restaurant.
If steak is what you want, this is the place.
The atmosphere is pretty bad but the food is quite good.
The food is quite good but the atmosphere is pretty bad.
I'm not sure I would come back to this restaurant.
The food wasn't very good.
While the food was good the service was a disappointment.
I was very disappointed with both the service and my entree."

tabItemKeyPhrases = tabItem(
  tabName = "tabNameKeyPhrases",

  fluidRow(column(width = 12, box(width = 12, title = "Quick Help", status = "warning", solidHeader = TRUE, collapsible = TRUE,

    includeMarkdown("uiKeyPhrasesHelpText.md")

  ))),

  fluidRow(column(width = 12, box(width = 12, title = "Key Phrase Extraction", status = "primary", solidHeader = TRUE, align = "center",

    fluidRow(column(width = 12, box(width = 12, align = "left",
                                    
      radioButtons(inputId = "languageSelectInputKeyPhrases", label = "Language", selected = "English", choices = c("English", "German", "Spanish", "French", "Japanese"), inline = TRUE, width = NULL)
                                    
    ))),
    
    fluidRow(column(width = 12, box(width = 12, align = "left",
                                    
      tags$div(
        class = "form-group shiny-input-container",
        tags$label('for' = "wordsTextInputKeyPhrases", "Input Sentences:"),
        tags$textarea(id = "wordsTextInputKeyPhrases", class = "form-control", rows = 10, cols = 70, defaultKeyPhrasesText)
      )

    ))),
                                  
    actionButton(inputId = "buttonKeyPhrases", label = "Send Query", icon("paper-plane"), align = "center", width = NULL, style="color: #000; background-color: #337ab7; border-color: #2e6da4"), br(), br(), br(),

    bsAlert("errKeyPhrases"),

    fluidRow(column(width = 12, box(width = 12, status = "primary", align = "left",

      helpText("Results: "),
      formattableOutput("resultsKeyPhrases")

    ))),
    fluidRow(column(width = 12, box(width = 12, status = "primary", align = "left",

      helpText("Request URL: "),
      tags$style(type='text/css', '#urlKeyPhrases {font-size: small;}'),
      verbatimTextOutput("urlKeyPhrases")

    ))),
    fluidRow(column(width = 12, box(width = 12, status = "primary", align = "left",

      helpText("JSON Response: "),
      tags$style(type='text/css', '#jsonKeyPhrases {font-size: small;}'),
      verbatimTextOutput("jsonKeyPhrases")

    )))

  )))
)
