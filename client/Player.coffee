class @Player
	
	# x: 0
	# y: 0
	# radius: 0
	# speed: 0
	# energy: 0
	# lastMoveDx: 0
	# lastMoveDy: 0
	# movementPoints: [{x: 0, y:0}]
	# currentMovepointIndex: 0
	
	constructor: (@x, @y, @radius, @speed, @resilience, @movementPoints) ->
		@energy = 0
		@currentMovepointIndex = 0
	
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
	
	overlapsWith: (circle) ->
		dx = circle.getX() - @x
		dy = circle.getY() - @y
		return Math.sqrt(dx*dx + dy*dy) < circle.getRadius() + @radius
	
	move: (dx, dy) ->
		@x += dx
		@y += dy
		@lastMoveDx = dx
		@lastMoveDy = dy
	
	moveAgainst: (x, y) ->
		
		dx = x - @x
		dy = y - @y
		
		# Only move if we're moving (avaioding division by 0).
		if dx != 0 or dy != 0
			distance = Math.sqrt(dx*dx + dy*dy)
			@move(dx/distance*@speed, dy/distance*@speed)
	
	getCurrentMovementPoint: () ->
		return @movementPoints[@currentMovepointIndex]
	
	changeToNextMovementPoint: () ->
		@currentMovepointIndex = (@currentMovepointIndex+1) % @movementPoints.length
	
	tick: (game) ->
		
		if game.isPlayerNearestBall(@)
			
			# Move against the ball.
			ball = game.getBall()
			@moveAgainst(ball.getX(), ball.getY())
			
		else
			
			# Move against the current movement point.
			point = @getCurrentMovementPoint()
			
			dx = point.x - @x
			dy = point.y - @y
			distanceLeft = Math.sqrt(dx*dx + dy*dy)
			
			if distanceLeft < @speed
				
				# The player gonna move past the point, change to next movement point.
				@changeToNextMovementPoint()
				
			
			@moveAgainst(point.x, point.y)
		
		@energy += @resilience
	
	moveBack: () ->
		@x -= @lastMoveDx
		@y -= @lastMoveDy
	
	shoot: () ->
		@energy = 0
	
	hasEnergy: () ->
		return 0 < @energy
	
	draw: (context, scale) ->
		
		# Draw it as a circle.
		context.fillStyle = 'blue'
		context.beginPath()
		context.arc(@x, @y, @radius, 0, 2*Math.PI)
		context.fill()