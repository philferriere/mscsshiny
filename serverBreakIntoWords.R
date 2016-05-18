## serverBreakIntoWords.R
## BreakIntoWords server code
## by Phil Ferriere

serverBreakIntoWords = function(input, output, session) {

  request <- eventReactive(input$buttonBreakIntoWords, {
    tryCatch({

      weblmBreakIntoWords(input$wordsTextInputBreakIntoWords, input$lmSelectInputBreakIntoWords, as.integer(input$ngramSelectInputBreakIntoWords), as.integer(input$candidatesSelectInputBreakIntoWords))

    }, error = function(err) {

      createAlert(session, "errBreakIntoWords", "alertBreakIntoWords", content = geterrmessage(), style = "danger", append = FALSE)
      NULL

    })

  })

  output$resultsBreakIntoWords <- renderFormattable({
    if (!is.null(request)) {
      formattable(request()$results,
        list(probability = color_tile("white", "orange"))
      )
    }
  })

  output$urlBreakIntoWords <- renderText({
    if (!is.null(request)) {
      return(request()$request$url)
    }
  })

  output$jsonBreakIntoWords <- renderText({
    if (!is.null(request)) {
      return(request()$json)
    }
  })

}

