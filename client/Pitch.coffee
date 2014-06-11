class @Pitch
	
	# width: 0
	# height: 0
	
	constructor: (@width, @height) ->
		
	
	getWidth: () ->
		return @width
	
	getHeight: () ->
		return @height
	
	draw: (context, offsetX, offsetY, scale) ->
		
		# Draw the grass.
		context.fillStyle = 'green'
		x0 = offsetX + 0
		y0 = offsetY + 0
		width = @width*scale
		height = @height*scale
		context.fillRect(x0, y0, width, height)
		
		# Draw the lines.
		lineRadius = 0.5
		context.lineWidth = lineRadius*scale*2
		context.strokeStyle = 'white'
		
		# (the side lines)
		context.beginPath()
		context.moveTo(offsetX, offsetY+lineRadius*scale)
		context.lineTo(offsetX+@width*scale-lineRadius*scale, offsetY+lineRadius*scale)
		context.lineTo(offsetX+@width*scale-lineRadius*scale, offsetY+@height*scale-lineRadius*scale)
		context.lineTo(offsetX+lineRadius*scale, offsetY+@height*scale-lineRadius*scale)
		context.lineTo(offsetX+lineRadius*scale, offsetY+lineRadius*scale)
		context.stroke()
		
		# (middle line)
		context.beginPath()
		context.moveTo(offsetX,              offsetY+@height/2*scale)
		context.lineTo(offsetX+@width*scale, offsetY+@height/2*scale)
		context.stroke()
		
		# (circle in middle)
		x = offsetX+@width/2*scale
		y = offsetY+@height/2*scale
		radius = @width/7*scale
		context.beginPath()
		context.arc(x, y, radius, 0, 2*Math.PI)
		context.stroke()