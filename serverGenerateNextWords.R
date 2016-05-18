## serverGenerateNextWords.R
## GenerateNextWords server code
## by Phil Ferriere

serverGenerateNextWords = function(input, output, session) {

  request <- eventReactive(input$buttonGenerateNextWords, {
    tryCatch({
      
      weblmGenerateNextWords(input$wordsTextInputGenerateNextWords, input$lmSelectInputGenerateNextWords, as.integer(input$ngramSelectInputGenerateNextWords), as.integer(input$candidatesSelectInputGenerateNextWords))

    }, error = function(err) {

      createAlert(session, "errGenerateNextWords", "alertGenerateNextWords", content = geterrmessage(), style = "danger", append = FALSE)
      NULL

    })

  })

  output$resultsGenerateNextWords <- renderFormattable({
    if (!is.null(request)) {
      formattable(request()$results,
        list(probability = color_tile("white", "orange"))
      )
    }
  })

  output$urlGenerateNextWords <- renderText({
    if (!is.null(request)) {
      return(request()$request$url)
    }
  })

  output$jsonGenerateNextWords <- renderText({
    if (!is.null(request)) {
      return(request()$json)
    }
  })


}

