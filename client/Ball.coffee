class @Ball
	
	# x: 0
	# y: 0
	# radius: 0
	# speedX: 0
	# speedY: 0
	
	constructor: (@x, @y, @radius) ->
		@speedX = 1.6
		@speedY = 0.3
	
	getX: () ->
		return @x
	
	getY: () ->
		return @y
	
	getRadius: () ->
		return @radius
	
	getLeft: () ->
		return @x-@radius
	
	getRight: () ->
		return @x+@radius
	
	getTop: () ->
		return @y-@radius
	
	getBottom: () ->
		return @y+@radius
	
	setPosition: (x, y) ->
		@x = x
		@y = y
	
	setSpeed: (x, y) ->
		@speedX = x
		@speedY = y
	
	flipXSpeedDirection: () ->
		@speedX *= -1
	
	flipYSpeedDirection: () ->
		@speedY *= -1
	
	tick: () ->
		@x += @speedX
		@y += @speedY
	
	draw: (context, scale) ->
		
		# Draw it as a circle.
		context.fillStyle = 'yellow'
		context.beginPath()
		context.arc(@x, @y, @radius, 0, 2*Math.PI)
		context.fill()