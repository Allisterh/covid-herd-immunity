#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("COVID Herd Immunity"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            sliderInput("population_millions", 
                         "Population (millions)",
                         1, 
                         1200, 
                         70),
            sliderInput("num_vaccinated_100121_millions", 
                         "Number vaccinated as of 10th January 2021 (millions)",
                         0, 
                         30, # Globally 25 million had been delivered by 10th https://ourworldindata.org/covid-vaccinations
                         2.2, # https://coronavirus.data.gov.uk/details/vaccinations 
                        ),
            sliderInput("num_infected_100121_millions", 
                        "Number infected as of 10th January 2021 (millions)",
                        0, 
                        70, 
                        3.1, # https://coronavirus.data.gov.uk/details/cases 
            ),
            sliderInput("efficacy",
                        "Efficacy of vaccine:",
                        min = 0,
                        max = 1,
                        value = 0.76  # https://papers.ssrn.com/sol3/papers.cfm?abstract_id=3777268
                        ),
            sliderInput("days_to_efficacy", 
                        "Number of days after vacccination that efficacy kicks in:", 
                        min = 0, 
                        max = 30, 
                        value = 22  # https://papers.ssrn.com/sol3/papers.cfm?abstract_id=3777268
                        ),
            sliderInput("herd_immunity_portion", 
                        "Herd immunity threshold:", 
                        min = 0.1, 
                        max = 1.0,
                        value = 0.70 #Value from John's blog post
            ), 
            sliderInput("portion_pre_immune", 
                        "Portion of the poputional already immune to COVID", 
                        min = 0.0, 
                        max = 1.0, 
                        value = 0.35 # https://www.bmj.com/content/370/bmj.m3563 )
            ), 
            sliderInput("vaccines_administered_daily_millions", 
                        "Number of vaccines administered daily (millions):",
                        min = 0.1, 
                        max = 5,
                        value = 0.5 # https://coronavirus.data.gov.uk/details/vaccinations 
                        )
        ),

        # Show a plot of the generated distribution
        mainPanel(
            plotOutput("distPlot")
        )
    )
))
