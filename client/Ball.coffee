class @Ball
	
	# x: 0
	# y: 0
	# radius: 0
	
	constructor: (@x, @y, @radius) ->
		
	
	draw: (context, scale) ->
		
		# Draw it as a circle.
		context.fillStyle = 'yellow'
		context.beginPath()
		context.arc(@x, @y, @radius, 0, 2*Math.PI)
		context.fill()