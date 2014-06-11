class @Ball
	
	# x: 0
	# y: 0
	# radius: 0
	# speedX: 0
	# speedY: 0
	
	constructor: (@x, @y, @radius) ->
		@speedX = 1
		@speedY = 1.6
	
	tick: () ->
		@x += @speedX
		@y += @speedY
	
	draw: (context, scale) ->
		
		# Draw it as a circle.
		context.fillStyle = 'yellow'
		context.beginPath()
		context.arc(@x, @y, @radius, 0, 2*Math.PI)
		context.fill()