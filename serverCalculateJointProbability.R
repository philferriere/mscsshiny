## serverCalculateJointProbability.R
## CalculateJointProbability server code
## by Phil Ferriere

serverCalculateJointProbability = function(input, output, session) {

  request <- eventReactive(input$buttonCalculateJointProbability, {
    tryCatch({

      inputWords = unlist(lapply(strsplit(input$wordsTextInputCalculateJointProbability, ","), function (x) gsub("^\\s+|\\s+$", "", x)))
      weblmCalculateJointProbability(inputWords, input$lmSelectInputCalculateJointProbability, as.integer(input$ngramSelectInputCalculateJointProbability))

    }, error = function(err) {

      createAlert(session, "errCalculateJointProbability", "alertCalculateJointProbability", content = geterrmessage(), style = "danger", append = FALSE)
      NULL

    })

  })

  output$resultsCalculateJointProbability <- renderFormattable({
    if (!is.null(request)) {
      formattable(request()$results,
        list(probability = color_tile("white", "orange"))
      )
    }
  })

  output$urlCalculateJointProbability <- renderText({
    if (!is.null(request)) {
      return(request()$request$url)
    }
  })

  output$jsonCalculateJointProbability <- renderText({
    if (!is.null(request)) {
      return(request()$json)
    }
  })

}

