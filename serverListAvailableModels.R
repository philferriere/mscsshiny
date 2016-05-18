## serverListAvailableModels.R
## ListAvailableModels server code
## by Phil Ferriere

serverListAvailableModels = function(input, output, session) {

  request <- eventReactive(input$buttonListAvailableModels, {
    tryCatch({

      weblmListAvailableModels()

    }, error = function(err) {

      createAlert(session, "errListAvailableModels", "alertListAvailableModels", content = geterrmessage(), style = "danger", append = FALSE)
      NULL

    })

  })

  output$resultsListAvailableModels <- renderFormattable({
    if (!is.null(request)) {
      formattable(request()$results,
        list(
          calculateJointProbability = formatter("span", style = x ~ style(color = ifelse(x == "supported", "green", "red")), x ~ icontext(ifelse(x == "supported", "ok", "remove"), ifelse(x == "supported", "Supported", "Unsupported"))),
          calculateConditionalProbability = formatter("span", style = x ~ style(color = ifelse(x == "supported", "green", "red")), x ~ icontext(ifelse(x == "supported", "ok", "remove"), ifelse(x == "supported", "Supported", "Unsupported"))),
          breakIntoWords = formatter("span", style = x ~ style(color = ifelse(x == "supported", "green", "red")), x ~ icontext(ifelse(x == "supported", "ok", "remove"), ifelse(x == "supported", "Supported", "Unsupported"))),
          generateNextWords = formatter("span", style = x ~ style(color = ifelse(x == "supported", "green", "red")), x ~ icontext(ifelse(x == "supported", "ok", "remove"), ifelse(x == "supported", "Supported", "Unsupported")))
        )
      )
    }
  })

  output$urlListAvailableModels <- renderText({
    if (!is.null(request)) {
      return(request()$request$url)
    }
  })

  output$jsonListAvailableModels <- renderText({
    if (!is.null(request)) {
      return(request()$json)
    }
  })

}

