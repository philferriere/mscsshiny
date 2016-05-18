## serverCalculateConditionalProbability.R
## CalculateConditionalProbability server code
## by Phil Ferriere

serverCalculateConditionalProbability = function(input, output, session) {

  request <- eventReactive(input$buttonCalculateConditionalProbability, {
    tryCatch({

      precedingWords = input$precedingWordsTextInputCalculateConditionalProbability
      continuations = unlist(lapply(strsplit(input$continuationsTextInputCalculateConditionalProbability, ","), function (x) gsub("^\\s+|\\s+$", "", x)))
      weblmCalculateConditionalProbability(precedingWords, continuations, input$lmSelectInputCalculateConditionalProbability, as.integer(input$ngramSelectInputCalculateConditionalProbability))

    }, error = function(err) {

      createAlert(session, "errCalculateConditionalProbability", "alertCalculateConditionalProbability", content = geterrmessage(), style = "danger", append = FALSE)
      NULL

    })

  })

  output$resultsCalculateConditionalProbability <- renderFormattable({
    if (!is.null(request)) {
      formattable(request()$results,
        list(probability = color_tile("white", "orange"))
      )
    }
  })

  output$urlCalculateConditionalProbability <- renderText({
    if (!is.null(request)) {
      return(request()$request$url)
    }
  })

  output$jsonCalculateConditionalProbability <- renderText({
    if (!is.null(request)) {
      return(request()$json)
    }
  })

}

