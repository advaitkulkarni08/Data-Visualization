require(shiny)
require(dplyr)
require(shinydashboard)


shinyServer(function(input,output,session){
  
  
  
 yearinput <- reactive({
      df1 %>%
      filter(year == input$years)})
 
 years <- reactive({
   longdata %>%
     filter(year == input$yearslong)})
 
 selectfreedom <- reactive({
   years() %>%
     filter(freedom_factors == input$variable)})
 
 mapps <- reactive(
   {
     choromap %>%
       filter(year == input$mapslider)}
 )

 inputs <- reactive(
   {
     mapps() %>%
       filter(year == input$mapslider)}
 )
 
 
 
 
 #----------------------------------
    
  output$pfrank = renderValueBox(
      valueBox(round(mean(yearinput()$pf_score),1),
               subtitle = tags$p("Personal Freedom Score", style = "font-size: 135%;"),
               icon = icon("smile"))
     )
    output$efrank = renderValueBox(
      valueBox(round(mean(yearinput()$ef_score),1),
               subtitle = tags$p("Economic Freedom Score", style = "font-size: 135%;"),icon = icon("dollar-sign"))
    )
    x <- list(
      title = "Personal Freedom"
    )
    y <- list(
      title = "Economic Freedom"
    )
    output$plot1 = renderPlotly(
    p <-   plot_ly(yearinput(), x = yearinput()$pf_score, y = yearinput()$ef_score, text = yearinput()$countries, type = 'scatter', color = yearinput()$region, colors = 'Paired', mode = 'markers',marker = list( size = 10, opacity = 0.7 )) %>% config (displayModeBar = F)%>%
        layout(title = 'Personal Freedom vs Economical Freedom',
              # width = 900, height = 400,
               xaxis = x,
               yaxis = y,
               margin = list(l = 70, r = 70, b = 30, t = 56, pad = 4)
              )
    )
  
   
    output$plot2 <- renderPlotly(
    donut <- data.frame(selectfreedom() %>%
      group_by(year, region, value) %>%
      summarise(mean(value))) %>%
      plot_ly(labels = ~region, values = ~value) %>%
      add_pie(hole = 0.7)  %>% config (displayModeBar = F)%>%
      layout(title = "Trend of Freedom Factors in Different Regions of the World",  showlegend = T,
            # width = 720, height = 400,
             xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
             yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
             par(mar = c(l = 0, r = 50, b = 30, t = 56)))
    
    )
    
   
    
    output$Cart <- renderPlot({
      
      gtdMap <- joinCountryData2Map( inputs(),
                                     nameJoinColumn="countries",
                                     joinCode="NAME" )
      mapParams <- mapPolys(gtdMap,
                               nameColumnToPlot=input$mapinput,
                            oceanCol = 'light blue',
                            missingCountryCol = 'dark grey',
                               catMethod='fixedWidth',
                               numCats=100 ,
                            par(mar=c(5,1,1,1)))
      mtext("[Grey Color: No Data Available]", side = 1, line = -1)
               
    })
    
   output$corrout <- renderPlotly({
     if(input$selectcor == "corplots2008"){
       
      t2 <-  ggcorrplot(corplots2008,type = "upper", 
                  colors = c("#6D9EC1", "white", "#E46726"))+
         geom_tile(height=0.8, width=0.8)+
        theme(axis.text.x=element_text(size=10, angle=45, vjust=1, hjust=1, 
                                       margin=margin(-3,0,0,0)),
              axis.text.y=element_text(size=13, margin=margin(0,-3,3,0)))
       ggplotly(t2)%>% config(displayModeBar = F)
       
     }
       
     else if(input$selectcor == "corplots2012"){
       
       t3 <- ggcorrplot(corplots2012,type = "upper",
                  colors = c("#6D9EC1", "white", "#E46726"))+
         geom_tile(height=0.8, width=0.8)+
         theme(axis.text.x=element_text(size=10, angle=45, vjust=1, hjust=1, 
                                        margin=margin(-3,0,0,0)),
               axis.text.y=element_text(size=13, margin=margin(0,-3,3,0)))
       ggplotly(t3)%>% config(displayModeBar = F)
     }
     
     else if(input$selectcor == "corplots2016"){
       
       t4<- ggcorrplot(corplots2016,type = "upper",
                  colors = c("#6D9EC1", "white", "#E46726"))+
         geom_tile(height=0.8, width=0.8)+
         theme(axis.text.x=element_text(size=10, angle=45, vjust=1, hjust=1, 
                                        margin=margin(-3,0,0,0)),
               axis.text.y=element_text(size=13, margin=margin(3,-3,3,0)))
        ggplotly (t4) %>% config(displayModeBar = F)
     }
     
   })
    
    
})