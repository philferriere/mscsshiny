## serverDetectTopics.R
## DetectTopics server code
## by Phil Ferriere
## Customized progress bar style, courtesy of Jack Olney (http://jackolney.github.io/2016/shiny/)
## References:
## http://shiny.rstudio.com/reference/shiny/latest/Progress.html
## http://stackoverflow.com/questions/18237987/show-that-shiny-is-busy-or-loading-when-changing-tab-panels
## http://stackoverflow.com/questions/31990447/r-shiny-progress-bar-for-pblapply-functions
## http://stackoverflow.com/questions/35299597/r-shiny-app-progress-indicator-for-loading-data

serverDetectTopics = function(input, output, session) {

   shinyjs::disable("resultsPollIntervalTextInputDetectTopics")
   shinyjs::disable("resultsTimeoutTextInputDetectTopics")

  request <- eventReactive(input$buttonDetectTopics, {
    tryCatch({

      # Prevent parallel execution of multiple text detection operations
      shinyjs::disable("buttonDetectTopics")

      # Create a progress object we can use to show status updates
      resultsTimeout <- 600L
      progress <- shiny::Progress$new(session, min = 1L, max = resultsTimeout)
      on.exit(progress$close())
      progress$set(message = "Sending documents to servers")

      # Collect input params
      documents <- unlist(lapply(strsplit(input$documentsTextInputDetectTopics, "\n"), function (x) gsub("^\\s+|\\s+$", "", x)))
      documents <- head(documents, 100)
      stopWords <- unlist(lapply(strsplit(input$stopWordsTextInputDetectTopics, ","), function (x) gsub("^\\s+|\\s+$", "", x)))
      if (length(stopWords) == 0)
        stopWords <- NULL
      topicsToExclude <- unlist(lapply(strsplit(input$topicsToExcludeTextInputDetectTopics, ","), function (x) gsub("^\\s+|\\s+$", "", x)))
      if (length(topicsToExclude) == 0)
        topicsToExclude <- NULL
      minDocumentsPerWord <- as.integer(input$minDocumentsPerWordTextInputDetectTopics)
      if (is.na(minDocumentsPerWord))
        minDocumentsPerWord <- NULL
      maxDocumentsPerWord <- as.integer(input$maxDocumentsPerWordTextInputDetectTopics)
      if (is.na(maxDocumentsPerWord))
        maxDocumentsPerWord <- NULL

      # Start topic detection in async mode
      operation <- textaDetectTopics(
        documents = documents,                      # At least 100 docs/sentences
        stopWords = stopWords,                      # Stop word list (optional)
        topicsToExclude = topicsToExclude,          # Topics to exclude (optional)
        minDocumentsPerWord = minDocumentsPerWord,  # Threshold to exclude rare topics (optional)
        maxDocumentsPerWord = maxDocumentsPerWord,  # Threshold to exclude ubiquitous topics (optional)
        resultsPollInterval = 0L
      )

      # Poll the servers until the work completes or until we time out
      resultsPollInterval <- 60L
      startTime <- Sys.time()
      originTime <- startTime
      endTime <- startTime + resultsTimeout
      topics <- NULL
      while (Sys.time() <= endTime) {
        sleepTime <- startTime + resultsPollInterval - Sys.time()
        if (sleepTime > 0) {
          progress$set(
            value = as.integer(difftime(Sys.time(), originTime, units = "secs")),
            message = "Operation in progress ",
            detail = sprintf(
                "[Sleeping for %d s, timeout in %d s...]\n",
                as.integer(as.difftime(sleepTime, units = "secs")),
                as.integer(difftime(endTime, Sys.time(), units = "secs"))
              )
          )
          Sys.sleep(sleepTime)
        }
        startTime <- Sys.time()

        # Poll for results
        progress$set(detail = "[Querying servers for update...]")
        topics <- textaDetectTopicsStatus(operation)
        if (topics$status != "NotStarted" && topics$status != "Running")
          break;
      }

      if (is.null(topics) || topics$status != "Succeeded") {
        createAlert(session, "errDetectTopics", "alertDetectTopics", content = "Topic detection failed to complete in time!", style = "danger", append = FALSE)
      }

      # Results
      shinyjs::enable("buttonDetectTopics")
      topics

    }, error = function(err) {

      createAlert(session, "errDetectTopics", "alertDetectTopics", content = geterrmessage(), style = "danger", append = FALSE)
      shinyjs::enable("buttonDetectTopics")
      NULL

    })

  })

  output$resultsDetectTopics <- renderFormattable({
    if (!is.null(request)) {
      if (!is.null(request()$topics)) {
        topicsRedux <- request()$topics[with(request()$topics, order(-score)),c(3,2)]
        row.names(topicsRedux) <- NULL
        formattable(
          topicsRedux,
          list(score = color_tile("white", "orange"))
        )
      }
    }
  })

  output$urlDetectTopics <- renderText({
    if (!is.null(request)) {
      return(request()$originalRequest$url)
    }
  })

  output$jsonDetectTopics <- renderText({
    if (!is.null(request)) {
      return(request()$json)
    }
  })

}
