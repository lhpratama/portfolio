shinyServer(function(input, output) {
    
  output$plot1_state <- renderPlotly({
    # Plot 1 State : Most Frequent Crime in a City (State)------------------------------------------------
    
    # data transformation--------------------------------------------
    
    police_city <- police %>% 
      filter(state==input$input_state)%>% 
      group_by(city) %>% 
      summarise(freq = n()) %>% 
      ungroup() %>% 
      arrange(-freq) %>% # arrange(desc(freq)) %>%
      head(20) 
    
    police_city <- police_city %>% 
      mutate(label = glue(
        "Crime Count: {freq}
    City : {city}"
      ))
    
    # Creating Static Plot
    plot_city <- ggplot(data = police_city, aes(x = freq,
                                                y = reorder(city, freq),# reorder A, by B
                                                text = label)) +
      geom_col(aes(fill = freq)) +
      scale_fill_gradient(low="gray", high="black") +
      labs(title = glue("Crime Count in Cities of {input$input_state}"),
           x = "Crime Frequency",
           y = NULL) +
      theme_minimal() +
      theme(legend.position = "none") 
    
    # membuat plot interaktif
    ggplotly(plot_city, tooltip = "text")
  })
  
  output$plot2_age <- renderPlotly({
    # Plot 2 State: Age------------------------------------------------------
    
    # data transformation
    police_age <- police %>% 
      filter(state==input$input_state)
    
    # Creating Static Plot    
    plot_age <- ggplot(police_age, aes(x = age, fill = ..density..)) +
      geom_histogram(binwidth = 1, color = "grey") +
      scale_fill_gradient(low = "gray", high = "black") +
      labs(title = "Age Distribution", x = "Age", y = "Frequency") +
      theme_minimal() +
      theme(legend.position = "none") 
    
    
    # membuat plot interaktif
    ggplotly(plot_age)
  })

  output$plot3_death <- renderPlotly({
  # Plot 3 Race: Manner of Death------------------------------------------------------   
    # data transformation
    police_death <- police %>% 
      filter(race==input$input_race)%>% 
      group_by(manner_of_death) %>% 
      summarise(freq = n()) %>% 
      ungroup() %>% 
      arrange(-freq) %>% # arrange(desc(freq)) %>%
      head(20) 
    
    police_death <- police_death %>% 
      mutate(label = glue(
        "Manner of Death : {manner_of_death}"
      ))
    
    police_death$fraction <- police_death$freq / sum(police_death$freq)
    police_death$ymax <- cumsum(police_death$fraction)
    police_death$ymin <- c(0, head(police_death$ymax, n=-1))
    
    # membuat plot statis - ggplot
    plot_mod <- plot_ly(police_death, labels = ~label, values = ~freq, type = 'pie', hole = 0.7) %>%
      add_pie(hole = 0.6, showlegend = FALSE, marker = list(colors = c("black", "grey"))) %>%
      layout(title = "Manner of Death")  %>%
      add_pie(hole = 0.6, showlegend = TRUE)
    
    # plot interaktif: ggplotly
    ggplotly(plot_mod,tooltip = "text")
  })
  
  output$plot4_armed <- renderPlotly({
    # Plot 4 Race: Armed------------------------------------------------------   
    # data transformation
    police_armed <- police %>% 
      filter(race==input$input_race)%>% 
      group_by(armed) %>% 
      summarise(freq = n()) %>% 
      ungroup() %>% 
      arrange(-freq) %>% # arrange(desc(freq)) %>%
      head(10) 
    
 
    police_armed <- police_armed %>% 
      mutate(label = glue(
        "Crime Count: {freq}
    Armed with : {armed}"
      ))
    
    # membuat plot statis - ggplot
    plot_armed <- ggplot(data = police_armed, aes(x = freq, y = reorder(armed, freq), text = label)) +
      geom_col(aes(fill = freq)) +
      scale_fill_gradient(low = "gray", high = "black") +
      labs(title = glue("Crime Count by Armed Incident Committed by {input$input_race}"),
           x = "Crime Frequency",
           y = NULL) +
      theme_minimal() +
      theme(legend.position = "none")
    
    # plot interaktif: ggplotly
    ggplotly(plot_armed, tooltip = "text")
  })
  
  output$plot5_gender <- renderPlotly({
    # Plot 5 Race: Gender------------------------------------------------------   
    # data transformation
    police_gender <- police %>%
      filter(race==input$input_race)%>% 
      group_by(gender) %>% 
      summarise(freq = n()) %>% 
      ungroup() %>% 
      arrange(-freq) 
    
    # menambahkan label untuk tooltip
    police_gender <- police_gender %>% 
      mutate(label = glue(
        "Gender : {gender}"
      ))
    
    
    police_gender$fraction <- police_gender$freq / sum(police_gender$freq)
    police_gender$ymax <- cumsum(police_gender$fraction)
    police_gender$ymin <- c(0, head(police_gender$ymax, n=-1))
    
    # membuat plot statis - ggplot
    plot_gender <- plot_ly(police_gender, labels = ~label, values = ~freq, type = 'pie', hole = 0.7) %>%
      add_pie(hole = 0.6, showlegend = FALSE, marker = list(colors = c("black", "grey"))) %>%
      layout(title = "Gender")  %>%
      add_pie(hole = 0.6, showlegend = TRUE)
    
    # plot interaktif: ggplotly
    ggplotly(plot_gender,tooltip = "text")
  })
  
  output$plot6_threat <- renderPlotly({
    # Plot 6 Race: Threat------------------------------------------------------   
    # data transformation
    police_threat <- police %>%
      filter(race==input$input_race)%>% 
      group_by(threat_level) %>% 
      summarise(freq = n()) %>% 
      ungroup() %>% 
      arrange(-freq) 
    
    police_threat <- police_threat %>% 
      mutate(label = glue(
        "Threat Level : {threat_level}"
      ))
    
    police_threat$fraction <- police_threat$freq / sum(police_threat$freq)
    police_threat$ymax <- cumsum(police_threat$fraction)
    police_threat$ymin <- c(0, head(police_threat$ymax, n=-1))
    
    # membuat plot statis - ggplot
    plot_threat <- plot_ly(police_threat, labels = ~label, values = ~freq, type = 'pie', hole = 0.7) %>%
      add_pie(hole = 0.6, showlegend = FALSE, marker = list(colors = c("black", "grey", "darkgrey"))) %>%
      layout(title = "Threat Level")  %>%
      add_pie(hole = 0.6, showlegend = TRUE)
    
    # plot interaktif: ggplotly
    ggplotly(plot_threat,tooltip = "text")
  })
  
  # Load the data from global.R
  data <- police
  
  # Define the output table
  output$policeTable <- renderDT({
    datatable(data)
  })
  
})