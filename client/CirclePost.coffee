class @Post extends Circle
	
	draw: (context, scale) ->
		
		# Draw it as a circle.
		context.fillStyle = 'white'
		context.beginPath()
		context.arc(@x, @y, @radius, 0, 2*Math.PI)
		context.fill()