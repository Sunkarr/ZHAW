# Demonstration Normalverteilung
# Autor: Martin Frey/Christoph Hofer/Anna Drewek
# Version: 1.1
# Datum: 19.4.2024
# #############################################
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny) ## muss installiert werden install.packages("shiny", dependencies = T)

# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("Demonstration Normalverteilung"),
   
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
      sidebarPanel(
         radioButtons("Verteilung", h3("Verteilung aus der gezogen wird"),
                      choices = list("Diskrete Gleichverteilung(N=10)" = 1, 
                                     "Bin(10, 0.1)" = 2, 
                                     "Pois(2)" = 3,
                                     "Unif(0,10)" =4,
                                     "Exp(0.5)" =5
                      ),
                      selected = 1),
         sliderInput("n",
                     "Anzahl Zufallszahlen pro Stichprobe (n)",
                     min = 1,
                     max = 50,
                     value = 1),
         numericInput("p", 
                      "Anzahl Stichproben (Anzahl Mittelwerte die gebildet werden)", 
                      value = 1000,
                      min=1,
                      max=100000)
      ),
   
      # Show a plot of the generated distribution
      mainPanel(
         plotOutput("distPlot"),
         plotOutput("MeanDistPlot")
      )
   )
)

# Define server logic required to draw the distribution
server <- function(input, output) {
   observe({
      N <- input$n*input$p
      if (input$Verteilung==1){samp <- sample(1:10, size=N, replace=T); title = 'Verteilung von X ~ Diskrete Gleichverteilung(N=10)'}
      if (input$Verteilung==2){samp <- rbinom(N, size=10, p=0.1); title = 'Verteilung von X ~ Bin(10, 0.1)'}
      if (input$Verteilung==3){samp <- rpois(N, lambda=2); title = 'Verteilung von X ~ Pois(2)'}
      if (input$Verteilung==4){samp <- runif(N, min=0, max=10); title = 'Verteilung von X ~ Unif(0,10)'}
      if (input$Verteilung==5){samp <- rexp(N, rate=0.5); title = expression(Verteilung~~von~~X~"~"~Exp(lambda~'='~0.5))}
      
      output$distPlot <- renderPlot({
         if (input$Verteilung %in% c(4, 5)) hist(samp, xlab="Zufallszahl x", ylab="Dichte", main=title, freq = FALSE, col = "grey95") 
         if (input$Verteilung %in% c(1)) hist(samp, xlab="Zufallszahl x", ylab="Dichte", main=title, freq = FALSE, col = "grey95", breaks=seq(0.5,10.5, 1))
         if (input$Verteilung %in% c(2)) hist(samp, xlab="Zufallszahl x", ylab="Dichte", main=title, freq = FALSE, col = "grey95", breaks=seq(-0.5,10.5, 1))
         if (input$Verteilung %in% c(3)) hist(samp, xlab="Zufallszahl x", ylab="Dichte", main=title, freq = FALSE, col = "grey95", breaks=seq(-0.5,max(samp)+0.5, 1))})
      
      output$MeanDistPlot <- renderPlot({
         m <- matrix(samp, ncol=input$n)
         mw <- apply(m, 1, FUN=mean)
         hist(mw, xlab=bquote(Zufallszahl~~bar(x)), ylab="Dichte", main=bquote(Verteilung~von~.(input$p)~~Mittelwerten~~bar(X)[.(input$n)]~~der~~Stichproben), freq = FALSE, 
              xlim=c(0,10), breaks=seq(max(floor(min(mw))-1,0), ceiling(max(mw)),
                                       length.out=ifelse(input$n>2, 21, 11)), col ="grey95")
      })
      
   })
}


# Run the application 
shinyApp(ui = ui, server = server)

