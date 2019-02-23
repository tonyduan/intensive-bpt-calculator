debug:
	R -e "shiny::runApp(port = 7260)"
deploy:
	R -e "rsconnect::deployApp('.')"

