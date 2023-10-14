shinyServer(function(input, output) {
  
  # --- plot 1------------------------------------------------------------------------------------------------------------------------------------
  output$plot1_a <- renderPlotly({
    # Plot 1 Bar: SDG Index Score
    # Creating Data
    
    index_top10 <- 
      index %>%
      filter(year=="2022") %>% 
      ungroup() %>% 
      arrange(-sdg_index_score) %>% 
      head(10) %>%
      mutate(
        label = glue("Country: {country}
                 SDG Index Score: {sdg_index_score}")
      )
    
    # Plot
    plot1 <- ggplot(index_top10, aes(x=reorder(country, sdg_index_score), y=sdg_index_score)) + 
      geom_segment(aes(x=country, 
                       xend=country, 
                       y=min(sdg_index_score), 
                       yend=max(sdg_index_score)), 
                   linetype="dashed", 
                   size=0.1) +   # Draw dashed lines
      geom_point(col="#00a8eb", size=3, aes(text = label), shape = 1, size = 2) +   # Draw points
      labs(title="Top Country by SDG Index score", 
           subtitle="Make Vs Avg. Mileage",
           x = NULL,
           y = "SDG Index Score") +  
      coord_flip()
    
    # plot interaktif: ggplotly
    ggplotly(plot1, tooltip = "text")
  })
  
  # Plot 3 --------------------------------------------------------------------------------------------------  
  output$plot3_a <- renderPlotly({
    # Plot 3 Line: Viewers Activity of Gaming Videos**
    
    # data transformation
    # Creating Data
    report_1 <- report %>%
      filter(region==input$input_region) %>% 
      ungroup() %>% 
      arrange(-overall_score) %>% 
      head(10) 
    
    # Renaming Columns 
    colnames(report_1)[colnames(report_1) == "goal_1_score"] <- "Goal 1 Score"
    colnames(report_1)[colnames(report_1) == "goal_2_score"] <- "Goal 2 Score"
    colnames(report_1)[colnames(report_1) == "goal_3_score"] <- "Goal 3 Score"
    colnames(report_1)[colnames(report_1) == "goal_4_score"] <- "Goal 4 Score"
    colnames(report_1)[colnames(report_1) == "goal_5_score"] <- "Goal 5 Score"
    colnames(report_1)[colnames(report_1) == "goal_6_score"] <- "Goal 6 Score"
    colnames(report_1)[colnames(report_1) == "goal_7_score"] <- "Goal 7 Score"
    colnames(report_1)[colnames(report_1) == "goal_8_score"] <- "Goal 8 Score"
    colnames(report_1)[colnames(report_1) == "goal_9_score"] <- "Goal 9 Score"
    colnames(report_1)[colnames(report_1) == "goal_10_score"] <- "Goal 10 Score"
    colnames(report_1)[colnames(report_1) == "goal_11_score"] <- "Goal 11 Score"
    colnames(report_1)[colnames(report_1) == "goal_12_score"] <- "Goal 12 Score"
    colnames(report_1)[colnames(report_1) == "goal_13_score"] <- "Goal 13 Score"
    colnames(report_1)[colnames(report_1) == "goal_14_score"] <- "Goal 14 Score"
    colnames(report_1)[colnames(report_1) == "goal_15_score"] <- "Goal 15 Score"
    colnames(report_1)[colnames(report_1) == "goal_16_score"] <- "Goal 16 Score"
    colnames(report_1)[colnames(report_1) == "goal_17_score"] <- "Goal 17 Score"
    
    # Cleaning Data
    report_1 <- report_1[,-c(1,4)]
    report_1 <- melt(report_1, id.vars = c("country", "region"))
    report_1 <- report_1 %>%
      mutate(
        label = glue("{variable}
              Score: {value}"))
    
    # Creating Plot
    plot3 <- ggplot(data = report_1, aes(x = value,
                                         y = reorder(country, variable),
                                         text = label,
                                         fill = variable) # Add fill aesthetic
    ) +
      geom_col(width = 0.5) +
      labs(title = glue("Top Countries Located in {input$input_region} according to SDG Score "),
           x = "Countries",
           y = NULL) +
      scale_fill_manual(values = c("Goal 1 Score" = "#d90a38", 
                                   "Goal 2 Score" = "#d8ae2b", 
                                   "Goal 3 Score" = "#299e33", 
                                   "Goal 4 Score" = "#bd052d", 
                                   "Goal 5 Score" = "#e23429", 
                                   "Goal 6 Score" = "#56bce3", 
                                   "Goal 7 Score" = "#f2cb03", 
                                   "Goal 8 Score" = "#9d063d", 
                                   "Goal 9 Score" = "#e86a26", 
                                   "Goal 10 Score" = "#d4005e", 
                                   "Goal 11 Score" = "#f0a613", 
                                   "Goal 12 Score" = "#b99319", 
                                   "Goal 13 Score" = "#2d7d3b", 
                                   "Goal 14 Score" = "#4c95cf", 
                                   "Goal 15 Score" = "#37b72f", 
                                   "Goal 16 Score" = "#336198", 
                                   "Goal 17 Score" = "#2b3e63")) +
      theme(panel.background = element_rect(, size = 1, linetype = "round"))
    
    
    # membuat plot interaktif
    ggplotly(plot3, tooltip = "text")
  })
  
  # --- plot 4------------------------------------------------------------------------------------------------------------------------------------
  output$plot4_a <- renderPlotly({
    # Plot 4 Bar: Region SDG Score

    # Creating Data
    
    report_2 <- report %>%
      group_by(region) %>% 
      summarise(mean_score = mean(goal_17_score)) %>% 
      ungroup() %>% 
      arrange(-mean_score) %>%
      mutate(
        label = glue("Region: {region}
                 Score: {mean_score}"))
    
    # Plot
    plot4 <- ggplot(report_2, aes(x=reorder(region, mean_score), y=mean_score)) + 
      geom_segment(aes(x=region, 
                       xend=region, 
                       y=min(mean_score), 
                       yend=max(mean_score)), 
                   linetype="dashed", 
                   size=0.1) +   # Draw dashed lines
      geom_point(col="#00a8eb", size=3, aes(text = label)) +   # Draw points
      labs(title="Region SDG Score", 
           subtitle="Make Vs Avg. Mileage",
           x = NULL,
           y = "SDG Index Score") +  
      coord_flip()
    
    # plot interaktif: ggplotly
    ggplotly(plot4, tooltip = "text")

  })
  
  # --- plot 5------------------------------------------------------------------------------------------------------------------------------------
  output$plot5_a <- renderPlotly({
    # Plot 5 Bar: World Map
    # world data
    
    world <- ne_countries(scale = "small", returnclass ="sf")
    # Data creation
    
    index_world <- 
      index %>%
      filter(year=="2022") %>% 
      ungroup() %>% 
      arrange(-sdg_index_score) %>% 
      mutate(
        label = glue("Country: {country}
                 SDG Index Score: {sdg_index_score}")
      )
    #join datasets 
    
    data_with_iso <- index_world %>%
      mutate(Iso3 = countrycode(
        sourcevar = country,
        origin = "country.name",
        destination = "iso3c"
      ))
    
    #Join datasets
    
    index_world_iso <- world %>%
      select(geometry, name, iso_a3) %>%
      left_join(data_with_iso, by = c("iso_a3"= "Iso3"))
    #Plot
    plot5 <- world %>%
      filter(admin != "Antartica") %>%
      st_transform(crs = "+proj=robin") %>%
      ggplot() +
      geom_sf(color = "white") +
      geom_sf(data = index_world_iso, aes(fill = sdg_index_score, text = label)) +
      scale_color_gradient(low = "black",
                           high = "#00a8eb") +
      theme_minimal() +
      theme(plot.title = element_text(face = "bold"),
            axis.text.x = element_blank()) +
      labs(title = "Index Score All Over the World",
           x = NULL, y = NULL)
    
    # plot interaktif: ggplotly    
    ggplotly(plot5, tooltip = "text")
  })
})