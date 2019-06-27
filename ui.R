require(shiny)
require(shinydashboard)

shinyUI(
  
  dashboardPage( 
    dashboardHeader(),
    dashboardSidebar(
      disable = T
    ),
    
    dashboardBody( h1("Human Freedom Index"), 
                   tags$head(tags$style(HTML(".small-box {height: 120px}"))),

                   header=tags$head(tags$style(type='text/css', ".irs-grid-text { font-size: 20pt; }")),

                   tags$head(tags$style(HTML('

                             /* body */
                             .content-wrapper, .right-side {
                             background-color: white;
                             }

                             '))),
                   
                   
                     fluidRow(
                       column(12,
                            box(sliderInput("years","Select Year:",
                                           min = min(df1$year),
                                           max = max(df1$year),
                                           value = min(df1$year),
                                           step = 1,
                                           animate = T), width = 3L,status  = "primary"),
                            
                            valueBoxOutput("pfrank", width=3L),
                            valueBoxOutput("efrank", width=3L)
                             
                       )
                     ),
                   
                   fluidRow(
                     column(6,
                           
                            box(status = "primary",
                                       plotlyOutput("plot1"), width = 20L)

                            
                     ),
                    
                     column(6, 
                    
                            box(status = "primary", width=20L, 
                            h2("Economic Freedom vs Personal Freedom"),
                          
                            h4("The adjacent graph represents the relationship of personal human freedom against economic human freedom in all countries. These are the most crucial factors which define human freedom. A country can only be called liberal, if the people are free in terms of actions and monetarily. Over the years, it can be witnessed that the countries in Sub-Saharan and Eastern Europe regions, which have been lacking behind in terms of fundamental personal and economical liberty, were gaining momentum. "),

                            h4("In addition, another significant thing which can be noticed since 2012 is that, Venenzuela has been consistently falling behind in terms of economic freedom. The reason was pretty obvious, since the country faced terrible level of inflation. Moreover, by 2016, many Middle-Eastern countries had tremendous decline in terms of Personal Freedom. The reason can be found in the map below as well, which was high amount of terrorism and less power of law. By 2016, Hong Kong was observed at the pinnacle of Economic Freedom, and Netherlands at Personal Freedom.  "),


                            h3("Please click 'Play' button below the Year slider for the dynamic effect"))
                     )
                     
                   ),
                   
                   fluidRow(
                     column(6,offset=6,
                            
                           box(sliderInput("yearslong","Select Year:",
                                         min = min(longdata$year),
                                         max = max(longdata$year),
                                         value = min(longdata$year),
                                         step = 1,
                                         animate = T), width = 6L,status  = "warning"),
                          box(
                            selectInput("variable","Select Freedom Factor:",
                                        c("Rule of Law"= "pf_rol",
                                          "Homicides Reported" = "pf_ss_homicide",
                                          "Deaths by Terrorism"="pf_ss_disappearances_fatalities",
                                          "Female Mutiliation"= "pf_ss_women_fgm",
                                          "Women Inheritance" = "pf_ss_women_inheritance",
                                          "Freedom of Religion" = "pf_religion",
                                          "Freedom of Sport" =  "pf_association_sport",
                                          "Forming political parties" =  "pf_association_political",
                                          "Inflecnce of  politics on internet"	= "pf_expression_internet",
                                          "Same sex Marriage" =  "pf_identity_sex",
                                          "Judicial System"	= "ef_legal_judicial",
                                          "Influence of Military in Administration " = "ef_legal_military",
                                          "Economic Growth" =  "ef_money_growth",
                                          "Revenue by trade"  = "ef_trade_tariffs_revenue",
                                          "Business Startups Recorded" =	"ef_regulation_business_start",
                                          "Level of Corruption" = "ef_regulation_business_bribes")), width = 6L, status ="warning")
                            
                            
                     )
                     
                   ),
                   
                   
                   fluidRow(
                     column(6,
                            
                            box(status = "warning", width=20L, 
                                h2("Rate of Freedom in Different Regions of the World"),
                              
                                h4("The donut chart represents regionwise distribution of Freedom Factors, from 2012 to 2016. In this chart, the more the value, less are the countries liberal in terms of different freedom factors"),
                                h4("Considering the most pressing issues in the world, like female mutiliation, same sex marriage, terrorism, it has been observed that countries in Sub-Saharan African region have been a bit orthodox, consequently having least value of freedom. If trends are closely observed, at some instances, the terrorism is rather witnessed increasing in thode countries rather than decreasing."),
                                h4("In most of the cases, countries in North-American, South-East Asian, Western Europe and Oceania regions have been consistently displaying high level of freedom. The same facts can be witnessed from the map below. Since most of the countries in these regions are far from developed, there are less homicides in those countries. Moreover, since the people from the aforementioned regions have very open ideologies, they are also lineant towards the concept same sex marriage "),
                                h3("Please choose any of the freedom factors from the drop-down above and click Play button to witness the trend of freedom factors")
                            
                     )
                            
                     ),
                     
                     column(6, 
                            
                            box(status = "warning",
                             plotlyOutput("plot2"),  width = 20L)
                   )),
                   

                   
                   fluidRow(
                     column(8,
                     box( sliderInput("mapslider","Select Year:",
                                      min = min(choromap$year),
                                      max = max(choromap$year),
                                      value = min(choromap$year),
                                      step = 1),width = 4L,status  = "danger"),
                     box(selectInput("mapinput","Select Freedom Factor:",
                                     c("Rule of Law"= "pf_rol",
                                       "Homicides Reported" = "pf_ss_homicide",
                                       "Deaths by Terrorism"="pf_ss_disappearances_fatalities",
                                       "Female Mutiliation"= "pf_ss_women_fgm",
                                       "Women Inheritance" = "pf_ss_women_inheritance",
                                       "Freedom of Religion" = "pf_religion",
                                       "Freedom of Sport" =  "pf_association_sport",
                                       "Forming political parties" =  "pf_association_political",
                                       "Inflecnce of  politics on internet"	= "pf_expression_internet",
                                       "Same sex Marriage" =  "pf_identity_sex",
                                       "Judicial System"	= "ef_legal_judicial",
                                       "Influence of Military in Administration " = "ef_legal_military",
                                       "Economic Growth" =  "ef_money_growth",
                                       "Revenue by trade"  = "ef_trade_tariffs_revenue",
                                       "Business Startups Recorded" =	"ef_regulation_business_start",
                                       "Level of Corruption" = "ef_regulation_business_bribes")),width = 4L, status  = "danger")),
                     column(4)
                     ),
                   fluidRow(
                     column(6, 
                     box(status = "danger", width=20L,
                         plotOutput("Cart"))),
                     
                     column(6,
                     box(status = "danger", width=20L,
                         h3("Changing Trends of Freedom Factors in the World"),
                    
                         h4("The Heat Map shows the world-wide effect of the Freedom Factors from 2008 to 2016. The data of some countries like Greenland, Congo and Somalia is not available. The countries with the darker shades of red, represent higher levels of Freedom Factors"),
                         h4("Irrespective of choosing any of the freedom factors from the drop-down list, it can be seen that countries like USA, Canada, Australia, UK, Sweden etc, show higher levels of Freedom. On the contrary, Countries in Middle East and Latin America and Africa show low levels of freedom, when it comes to Rule of Law, Growth of Money, Sports etc. It has been often witnessed that the Personal Freedom is mostly hampered, when a country is a victim of inflation, terrorism and orthodox mindsets. "),
                         h4("These staggering differences show, how much do the countries need to develop, in terms of different areas. This map is most certainly useful for the politicians or industrialists, in order plan whether it will beneficial for them to have relationships with other countries"),
                         h3("Please select the Freedom Factors from the drop-down list above and observe their trends over the years"))
                   )),
                   fluidRow(
                     column(6,offset=6,
                            
      box(selectInput("selectcor","Select Year:",
                      choices = c(  "Correlation in 2008" = "corplots2008" ,
                                    "Correlation in 2012" = "corplots2012" ,
                                   "Correlation in 2016" = "corplots2016")), width = 6L,status  = "success"))),
                   fluidRow(
                     column(6,
                            
                            box(status = "success", width=20L, 
                                h3("Correlation between Freedom Factors"),
                                
                                h4("The adjacent graph represents the correlation matrix of the freedom factors. Since the data is available from 2008 to 2016, significant changes amongst their correlation were easy to display by conidering only the years of 2008,2012,2016"),
                                h4("There has been a drastic change in relationship between the freedom factors in every interval of 4 years. For instance, in 2008, poltics and sports were strongly correlated with the freedom of internet usage. It was also observed that Rule of Law 'pf_rol' had a strong correlation with business bribes, money growth, judicial integrity and with revenue incurred by trade. Another noticably strong relationship was observed between homicides and religion. This suggests that the religion in some countries play a big part in multiple crimes.    "),
                                h4("In 2012, much of the relationhips faded beteen the freedom factors, yet the relationship of politics and sports with internet remained consistent. This suggests that the public outreach of the parliamentary discussions was mainly dependant on internet. In addition, since many fans follow sports clubs online, the relationship has remained strongly consistent. Judicial integrity and military power of the nations had a strong relationship with Rule of Law."),h4("Lastly in 2016, it was witnessed that the crime rate which was high due to religious disputes until 2016, narrowed down to -0.3. ")
                                
                            )
                            
                     ),
                     
                     column(6, 
                            
                            box(status = "success",
                                plotlyOutput("corrout"),  width = 20L,h4("** Kindly change the year back and forth if the graph is not visible"))
                     ))
    )             
  )
)


