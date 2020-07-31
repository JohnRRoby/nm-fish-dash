# this is server.r for public new mexico's fish dash


server <- function(input, output) {

	output$waterOutput <- renderUI({

	  selectInput("waterInput", "Choose water",
	              c("Scroll or start typing" = "", waterlist), selectize = TRUE)
	})

#this output is filtered by the water choice plus an "all" option
	output$fishOutput <- renderUI({

		#an if to handle (i.e. delay) empty input on first load
		if (is.null(input$waterInput)) {
		      return(NULL)
		  } 

	  selectInput("fishInput", "Choose fish",
	              {fishChoice <- report %>%
	              	filter(water == input$waterInput) %>%
	              	distinct(species) %>%
	              	arrange(species)
	              	fishChoice <- as.vector(c("All", fishChoice$species))
	              	fishChoice

				}, selected = "All")	  
		})


#complex if-else that accounts for all potential states of the selectors waterInput and fishInput. first is just the report object. second isn't really possible at this build because no use case for finding all waters where a kind of fish is stocked so it just catches the condition and selects "all" for fish input. third shows all fish for a water. fourth filters both fish and water.
#each statement includes code to arrange-descending dates in the weird date format that doesn't display right in renderTable(), then reformats them into character for proper display in the table.
	output$results <- renderTable({
		
		#two if's to handle (i.e. delay) empty inputs on first load
		if (is.null(input$waterInput)) {
		    return(NULL)
		  } 
		if (is.null(input$fishInput)) {
		      return(NULL)
		  } 

		#here's the meat of the if-else's
		if(input$waterInput == "All" & input$fishInput == "All"){
			filteredWater <- report %>%
			arrange(desc(date))
			filteredWater$date <- format(filteredWater$date, '%m-%d-%Y') #render the arranged dates back to readable
			filteredWater
		} else if(input$waterInput == "All"){
			filteredWater <- report %>%
				filter(species == input$fishInput) %>%
				arrange(desc(date))
			filteredWater$date <- format(filteredWater$date, '%m/%d/%Y') #render the arranged dates back to readable
			filteredWater
		} else if (input$fishInput == "All") {
			filteredWater <- report %>%
				filter(water == input$waterInput) %>%
				arrange(desc(date))
			filteredWater$date <- format(filteredWater$date, '%m/%d/%Y') #render the arranged dates back to readable
			filteredWater
		} else {
			filteredWater <- report %>%
				filter(water == input$waterInput & species == input$fishInput) %>%
					arrange(desc(date))
				filteredWater$date <- format(filteredWater$date, '%m/%d/%Y') #render the arranged dates back to readable
						filteredWater
		}


	}, striped = TRUE)#close renderTable


}#close server function

