#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(tidyverse)
library(lubridate)
library(scales)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

    output$distPlot <- renderPlot({
        num_pre_immune = input$portion_pre_immune * input$population_millions * 1e6
        
        # Adjust for vaccines given to people who are already immune.
        portion_at_risk = 1.0 - (num_pre_immune/1e6 + input$num_infected_100121_millions)/(input$population_millions)
        
        num_new_vaccine_immune = input$num_vaccinated_100121_millions*1e6*input$efficacy*portion_at_risk
        
        # Number immune at present
        present_num_immune = num_pre_immune + input$num_infected_100121_millions*1e6 + num_new_vaccine_immune
        herd_immunity_target = input$herd_immunity_portion*input$population_millions*1e6
        
        num_needed = herd_immunity_target - present_num_immune
        
        num_new_immune_per_day = input$vaccines_administered_daily_millions*1e6*portion_at_risk*input$efficacy
        
        days_to_herd_immunity = num_needed / num_new_immune_per_day
        
        dates <- seq.Date(ymd("2021-01-10"), ymd("2021-01-10") + days(floor(days_to_herd_immunity)) + days(14), by = "days")
        
        dfr <- tibble(date = dates, num_immune = rep(present_num_immune, length(dates)))
        
        for (i in 2:nrow(dfr)) {
            dfr$num_immune[i] = dfr$num_immune[(i-1)] + num_new_immune_per_day
            dfr$date[i] = dfr$date[i] + days(input$days_to_efficacy)
        }
        
        dfr %>%
            ggplot(aes(x = date, y = num_immune)) +
            geom_line() +
            geom_vline(xintercept = ymd("2021-01-10") + days(floor(days_to_herd_immunity)), colour = "red", size = 2) +
            labs(title = "Number immune by days (millions)",
                 subtitle = "Herd immunity date in red"
                 ) +
            scale_x_date(NULL) +
            scale_y_continuous(NULL, labels = scales::label_comma(scale = 1e-6))
        

        # # generate bins based on input$bins from ui.R
        # x    <- faithful[, 2]
        # bins <- seq(min(x), max(x), length.out = 30 + 1)
        # 
        # # draw the histogram with the specified number of bins
        # hist(x, breaks = bins, col = 'darkgray', border = 'white')

    })

})
