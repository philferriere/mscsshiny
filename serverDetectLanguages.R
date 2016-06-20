## serverDetectLanguages.R
## DetectLanguages server code
## by Phil Ferriere

serverDetectLanguages = function(input, output, session) {

  request <- eventReactive(input$buttonDetectLanguages, {
    tryCatch({

      inputWords = unlist(lapply(strsplit(input$wordsTextInputDetectLanguages, "\n"), function (x) gsub("^\\s+|\\s+$", "", x)))
      inputWords = head(inputWords, 10)
      textaDetectLanguages(inputWords)

    }, error = function(err) {

      createAlert(session, "errDetectLanguages", "alertDetectLanguages", content = geterrmessage(), style = "danger", append = FALSE)
      NULL

    })

  })

  output$resultsDetectLanguages <- renderFormattable({
    if (!is.null(request)) {
      if (!is.null(request()$results)) {
        formattable(request()$results)
      }
    }
  })

  output$urlDetectLanguages <- renderText({
    if (!is.null(request)) {
      return(request()$request$url)
    }
  })

  output$jsonDetectLanguages <- renderText({
    if (!is.null(request)) {
      return(request()$json)
    }
  })

}
