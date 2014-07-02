class @Ball extends Circle
	
	# speedX: 0
	# speedY: 0
	# friction: 0
	
	constructor: (x, y, radius) ->
		super(x, y, radius)
		@speedX = 0
		@speedY = 0
		@friction = 0.95
	
	getDistanceTo: (x, y) ->
		dx = x - @x
		dy = y - @y
		return Math.sqrt(dx*dx + dy*dy)
	
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
		@speedX *= @friction
		@speedY *= @friction
	
	draw: (context, scale) ->
		
		# Draw it as a circle.
		context.fillStyle = 'yellow'
		context.beginPath()
		context.arc(@x, @y, @radius, 0, 2*Math.PI)
		context.fill()