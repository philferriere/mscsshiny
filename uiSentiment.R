## uiSentiment.R
## App Sentiment tab (client side)
## by Phil Ferriere

menuItemSentiment = menuSubItem("Sentiment Analysis", tabName = "tabNameSentiment")

defaultSentimentText <-
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

tabItemSentiment = tabItem(
  tabName = "tabNameSentiment",

  fluidRow(column(width = 12, box(width = 12, title = "Quick Help", status = "warning", solidHeader = TRUE, collapsible = TRUE,

    includeMarkdown("uiSentimentHelpText.md")

  ))),

  fluidRow(column(width = 12, box(width = 12, title = "Sentiment Analysis", status = "primary", solidHeader = TRUE, align = "center",

    fluidRow(column(width = 12, box(width = 12, align = "left",
                                    
      radioButtons(inputId = "languageSelectInputSentiment", label = "Language", selected = "English", choices = c("English", "Spanish", "French", "Portuguese"), inline = TRUE, width = NULL)
                                    
    ))),
    
    fluidRow(column(width = 12, box(width = 12, align = "left",

      tags$div(
        class = "form-group shiny-input-container",
        tags$label('for' = "wordsTextInputSentiment", "Input Sentences:"),
        tags$textarea(id = "wordsTextInputSentiment", class = "form-control", rows = 10, cols = 70, defaultSentimentText)
      )

      
    ))),

    actionButton(inputId = "buttonSentiment", label = "Send Query", icon("paper-plane"), align = "center", width = NULL, style="color: #000; background-color: #337ab7; border-color: #2e6da4"), br(), br(), br(),

    bsAlert("errSentiment"),

    fluidRow(column(width = 12, box(width = 12, status = "primary", align = "left",

      helpText("Results: "),
      formattableOutput("resultsSentiment")

    ))),
    fluidRow(column(width = 12, box(width = 12, status = "primary", align = "left",

      helpText("Request URL: "),
      tags$style(type='text/css', '#urlSentiment {font-size: small;}'),
      verbatimTextOutput("urlSentiment")

    ))),
    fluidRow(column(width = 12, box(width = 12, status = "primary", align = "left",

      helpText("JSON Response: "),
      tags$style(type='text/css', '#jsonSentiment {font-size: small;}'),
      verbatimTextOutput("jsonSentiment")

    )))

  )))
)
