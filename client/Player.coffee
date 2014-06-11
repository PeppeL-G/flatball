class @Player
	
	# x: 0
	# y: 0
	# radius: 0
	# speed: 0
	
	constructor: (@x, @y, @radius, @speed) ->
		
	
	getLeft: () ->
		return @x-@radius
	
	getRight: () ->
		return @x+@radius
	
	getTop: () ->
		return @y-@radius
	
	getBottom: () ->
		return @y+@radius
	
	tick: (ball) ->
		
		# Move the player towards the ball.
		dx = ball.getX() - @x
		dy = ball.getY() - @y
		distance = Math.sqrt(dx*dx + dy*dy)
		@x += dx/distance*@speed
		@y += dy/distance*@speed
	
	draw: (context, scale) ->
		
		# Draw it as a circle.
		context.fillStyle = 'blue'
		context.beginPath()
		context.arc(@x, @y, @radius, 0, 2*Math.PI)
		context.fill()