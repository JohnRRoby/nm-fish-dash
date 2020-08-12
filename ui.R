# this is ui.r for public new mexico's fish dash

ui <- fluidPage(theme = shinytheme("sandstone"),
	titlePanel("New Mexico Stocked Waters Explorer"),#titles webpage also
	
	# shinythemes::themeSelector(),  # inline shiny theme selector

	fluidRow(
		column(12,
			h4("A free tool for anglers courtesy of", tags$a(href="http://publicnewmexico.com/", "Public New Mexico", target="_blank")),
			br(),
			p("Use this interface to look up a water you want to fish and see what has been stocked in it recently."),
			p(strong("Last update"),": 12 August 2020."),
			p(strong("To begin: "), "Select a water in the 'Choose water' box. You can use the 'Choose fish' box to refine your selection. If a water is not shown, that means the state has not stocked it in the past 12 months.")
			)#close column
		),#close fluidRow

	hr(),

	#choose the water module
	fluidRow(
		column(5,
			uiOutput("waterOutput")
			),#close column
		), #close fluidRow
	#choose the fish module
	fluidRow(
		column(5,
			uiOutput("fishOutput")
			)#close column
		),#close fluidRow

	#the table, an hr and then the bottom matter.
	tableOutput("results"),
	hr(),
	fluidRow(
		column(11, 
			p(tags$small("This tool is updated from New Mexico Department of Game & Fish data when they become available, usually twice a month. It is written in R using the Shiny framework, and is maintained by John R. Roby. You can", tags$a(href="https://github.com/JohnRRoby/nm-fish-finder", "see and fork the code on GitHub.", target="_blank"), br(), "Questions? Email PublicNewMexico 'at' gmail.com."))
			) #close column
		) #close fluidRow
)#close fluidPage


