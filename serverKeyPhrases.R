## serverKeyPhrases.R
## KeyPhrases server code
## by Phil Ferriere

serverKeyPhrases = function(input, output, session) {

  request <- eventReactive(input$buttonKeyPhrases, {
    tryCatch({
      
      inputWords = unlist(lapply(strsplit(input$wordsTextInputKeyPhrases, "\n"), function (x) gsub("^\\s+|\\s+$", "", x)))
      inputWords = head(inputWords, 10)
      if (input$languageSelectInputKeyPhrases == "English") {
        inputLanguage = "en"
      } else if (input$languageSelectInputKeyPhrases == "German") {
        inputLanguage = "de"
      } else if (input$languageSelectInputKeyPhrases == "Spanish") {
        inputLanguage = "es"
      } else if (input$languageSelectInputKeyPhrases == "French") {
        inputLanguage = "fr"
      } else if (input$languageSelectInputKeyPhrases == "Japanese") {
        inputLanguage = "ja"
      }
      results <- textaKeyPhrases(inputWords, rep(inputLanguage, length(inputWords)))
      results$results$keyPhrases <- sapply(results$results$keyPhrases, function(x) paste(x, collapse = ", "))
      results

    }, error = function(err) {

      createAlert(session, "errKeyPhrases", "alertKeyPhrases", content = geterrmessage(), style = "danger", append = FALSE)
      NULL

    })

  })

  output$resultsKeyPhrases <- renderFormattable({
    if (!is.null(request)) {
      if (!is.null(request()$results)) {
        formattable(request()$results)
      }
    }
  })

  output$urlKeyPhrases <- renderText({
    if (!is.null(request)) {
      return(request()$request$url)
    }
  })

  output$jsonKeyPhrases <- renderText({
    if (!is.null(request)) {
      return(request()$json)
    }
  })

}
