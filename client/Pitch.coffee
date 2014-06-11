class @Pitch
	
	# width: 0
	# height: 0
	
	constructor: (@width, @height) ->
		
	
	getWidth: () ->
		return @width
	
	getHeight: () ->
		return @height
	
	draw: (context) ->
		
		# Draw background.
		context.fillStyle = 'green'
		context.fillRect(0, 0, @width, @height)