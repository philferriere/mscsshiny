## serverSentiment.R
## Sentiment server code
## by Phil Ferriere

serverSentiment = function(input, output, session) {

  request <- eventReactive(input$buttonSentiment, {
    tryCatch({

      inputWords = unlist(lapply(strsplit(input$wordsTextInputSentiment, "\n"), function (x) gsub("^\\s+|\\s+$", "", x)))
      inputWords = head(inputWords, 10)
      if (input$languageSelectInputSentiment == "English") {
        inputLanguage = "en"
      } else if (input$languageSelectInputSentiment == "Spanish") {
        inputLanguage = "es"
      } else if (input$languageSelectInputSentiment == "French") {
        inputLanguage = "fr"
      } else if (input$languageSelectInputSentiment == "Portuguese") {
        inputLanguage = "pt"
      }
      textaSentiment(inputWords, rep(inputLanguage, length(inputWords)))

    }, error = function(err) {

      createAlert(session, "errSentiment", "alertSentiment", content = geterrmessage(), style = "danger", append = FALSE)
      NULL

    })

  })

  output$resultsSentiment <- renderFormattable({
    if (!is.null(request)) {
      if (!is.null(request()$results)) {
        formattable(request()$results,
          list(score = formatter("span", style = x ~ style(color = ifelse(x < 0.5, "red", "green")), x ~ icontext(ifelse(x > 0.5, "thumbs-up", "thumbs-down")), x ~ sprintf("%.4f", x)))
        )
      }
    }
  })

  output$urlSentiment <- renderText({
    if (!is.null(request)) {
      return(request()$request$url)
    }
  })

  output$jsonSentiment <- renderText({
    if (!is.null(request)) {
      return(request()$json)
    }
  })

}
