class @Player extends Circle
	
	# speed: 0
	# energy: 0
	# lastMoveDx: 0
	# lastMoveDy: 0
	# movementPoints: [{x: 0, y:0}]
	# currentMovepointIndex: 0
	
	constructor: (radius, @speed, @resilience, @movementPoints, @color) ->
		super(@movementPoints[0].x, @movementPoints[0].y, radius)
		@energy = 0
		@currentMovepointIndex = 0
	
	getColor: () ->
		return @color
	
	move: (dx, dy) ->
		super(dx, dy)
		@lastMoveDx = dx
		@lastMoveDy = dy
	
	moveAgainst: (x, y) ->
		
		dx = x - @x
		dy = y - @y
		
		# Only move if we're moving (avoiding division by 0).
		if dx != 0 or dy != 0
			distance = Math.sqrt(dx*dx + dy*dy)
			@move(dx/distance*@speed, dy/distance*@speed)
	
	getCurrentMovementPoint: () ->
		return @movementPoints[@currentMovepointIndex]
	
	changeToNextMovementPoint: () ->
		@currentMovepointIndex = (@currentMovepointIndex+1) % @movementPoints.length
	
	tick: (game) ->
		
		if game.isTeamPlayerNearestBall(@)
			
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
		context.fillStyle = @color
		context.beginPath()
		context.arc(@x, @y, @radius, 0, 2*Math.PI)
		context.fill()