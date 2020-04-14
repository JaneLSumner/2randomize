library(shiny)
library(shinythemes)
library(DT)

shinyUI(fluidPage(
  tags$head(includeScript("google-analytics.js")),
  theme = shinytheme("yeti"),
  titlePanel("2Randomize: A Tool for Large-Scale Randomization in Qualtrics"),
  sidebarLayout(
    sidebarPanel(
      tags$b("Directions:"),
      p("(1) Upload a .csv file with the units you want to randomize. Select how many times you want each item to be assigned."),
      p("(2) Download the Javascript (txt) file by clicking the Download button."),
      p("(3) In your Qualtrics survey, click the settings (the gear image) for the first question, then click 'Add JavaScript'. Replace everything there with the content of the javascript file. Save."),
      p("(4) Go to Tools -> Quotas"),
      p("(a) + Add Quota"),
      p("(b) Simple Logic Quota (if given the choice, if not, don't worry)"),
      p("(c) When Embedded Data IPAddress Is Not Equal to 0"),
      p("(d) When the quota has been met, then: prevent all new survey sessions"),
      p("(e) Click on the 100, replace with the quota size listed on the right. Save"),
      p("(5) Go to Survey Flow."),
      p("(a) Add embedded data. Insert piped text -> quota -> New Quota -> Count."),
      p("(b) Copy and paste the string this creates (it'll look like ${qo://QO_QwMu0e7Q3f/QuotaCount}, but with different numbers)"),
      p("(c) Add another embedded data. Name it item. Set value to ${e://Field/item}. Save."),
      p("(6) Click on the js next to the question where you entered the JavaScript"),
      p("(a) Replace REPLACETHIS with the string from step 5b. Keep the quotation marks around it. Save."),
      p("(7) Any time you want to use the randomize item in your survey, you can call it like this:"),
      p("<span id=\"item\"></span>")
      ),
    mainPanel(
      h4("This website is designed to help you easily randomize a long list of things in Qualtrics. Its intended use is for crowdsourcing data."),
      p("See Sumner, Farris, and Holman (2019) for a discussion of how to use this to crowdsource reliable local data."),
      tags$i("(Note: Since publication of Sumner, Farris, and Holman (2019), Qualtrics changed their internal processes. We have developed an improved way of randomizing coders that adapts to these changes.)"),
      p("Please read the directions before proceeding, then:"),
      # br(),
      fileInput('file1', '(1) Choose .csv file of items to randomize.',
                accept=c('.csv', "csv",
                         'text/comma-separated-values,text/csv')),
      numericInput('times','(2) How many times should each item be assigned?',3,min=1,max=NA),
      selectInput('header','(3) Does this list have a header?',c("Yes","No"),selected="Yes",multiple=F),
      downloadButton('downloadData', 'Download Code!'),
      br(),
      h2(textOutput("quota")),
      # h2("Your Javascript code is:"),
      # tags$div(textOutput("yourcode"),style="height:120px;width:600px;border:1px solid #ccc;font:16px/26px Georgia, Garamond, Serif;overflow:auto;"),
      br(),
      p("Please cite as:"),
      p("Sumner, Jane Lawrence, Emily M. Farris, and Mirya R. Holman. \"Crowdsourcing reliable local data.\" Political Analysis (2019): 1-19."),
      br(),
      p("If you have any questions or comments, contact Jane Sumner (jlsumner@umn.edu)."),
      tags$p("For more advanced options, see:"),
      tags$a(href="https://thepoliticalmethodologist.com/2019/05/23/utilizing-javascript-in-qualtrics-for-survey-experimental-designs/","Justin de Benedictis-Kessner's TPM post.")
      
    )
  )
  
)
)
