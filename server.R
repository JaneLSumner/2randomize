library(shiny)
library(stringr)
shinyServer(function(input, output, session) {
  
  file <- reactive({
    ### new
    inFile <- input$file1
    
    if (is.null(inFile))
      return(NULL)

    headerTF <- ifelse(input$header=="Yes",T,F)

    to.randomize <- read.csv(inFile$datapath,stringsAsFactors=F,header=headerTF)

    names(to.randomize) <- "x"
    times <- input$times
    
    
    full.list <- rep(to.randomize$x,each=times)
    scrambled <- full.list[sample(c(1:length(full.list)),length(full.list),replace=F)]
    scrambled.formatted <- paste0('"',paste0(scrambled,collapse='", "'),'"')
    
    js <- paste0('
                 Qualtrics.SurveyEngine.addOnload(function()
                 {
                 
                 });
                 
                 Qualtrics.SurveyEngine.addOnReady(function()
                 {
                 
                 let items = [',scrambled.formatted,'];
                 let i = "REPLACETHIS";
                 var chosen = items[i]; //select a word
                 Qualtrics.SurveyEngine.setEmbeddedData( "item", chosen); // sets embedded data, called item
                 document.getElementById("item").innerHTML = chosen; //show the word to respondents
                 
                 });
                 
                 Qualtrics.SurveyEngine.addOnUnload(function()
                 {
                 /*Place your JavaScript here to run when the page is unloaded*/
                 
                 });')

    # writeLines(js,"js.js")
    
    quotalength <- length(scrambled)
    return(list(js=js,quota.length=quotalength))
    
  })
  output$downloadData <- downloadHandler(
    filename <- function(){ paste0("myjs.txt") },
    content <- function(file){ writeLines(file()$js,con=file) }

  )
  # output$yourcode <- renderText({
  #   file()$js
  # })
  output$quota <- renderText({
    paste("Your quota size is:",file()$quota.length,sep=" ")
  })
  
  
})
