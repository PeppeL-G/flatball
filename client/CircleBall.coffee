class @Ball extends Circle
	
	# speedX: 0
	# speedY: 0
	# friction: 0
	
	constructor: (x, y, radius) ->
		super(x, y, radius)
		@speedX = 0
		@speedY = 0
		@friction = 0.95
	
	getSpeed: () ->
		return Math.sqrt(@speedX*@speedX + @speedY*@speedY)
	
	getSpeedX: () ->
		return @speedX
	
	getSpeedY: () ->
		return @speedY
	
	getSpeedAngle: () ->
		return Math.atan2(@speedY, @speedX)
	
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
	
	tick: (game) ->
		
		@x += @speedX
		@y += @speedY
		
		pitch = game.getPitch()
		
		# Handle collisions with outer lines.
		if pitch.collidesWithLeftLine(@)
			@setLeft(pitch.getLeftLineRight())
			@flipXSpeedDirection()
		else if pitch.collidesWithRightLine(@)
			@setRight(pitch.getRightLineLeft())
			@flipXSpeedDirection()
		
		if pitch.collidesWithTopLine(@)
			@setTop(pitch.getTopLineBottom())
			@flipYSpeedDirection()
		else if pitch.collidesWithBottomLine(@)
			@setBottom(pitch.getBottomLineTop())
			@flipYSpeedDirection()
		
		# Handle collisions with goalposts.
		collidedGoalpost = pitch.getCollidedGoalpost(@)
		if collidedGoalpost != null
			# Algorithm taken from: http://www.hoomanr.com/Demos/Elastic2/
			# c, as in Circle.
			c1 = @
			c2 = collidedGoalpost
			
			A = Math.atan2(c1.getY() - c2.getY(), c1.getX() - c2.getX())
			
			v1x = c1.getSpeed() * Math.cos(c1.getSpeedAngle() - A)
			v1y = c1.getSpeed() * Math.sin(c1.getSpeedAngle() - A)
			v2x = 0
			
			infiniteRadius = 100000000
			f1x = v1x*(c1.getRadius() - infiniteRadius)/(c1.getRadius() + infiniteRadius) + 2*infiniteRadius*v2x
			
			v1 = Math.sqrt(f1x*f1x + v1y*v1y)
			
			D1 = Math.atan2(v1y, f1x) + A
			
			c1.setSpeed(v1*Math.cos(D1), v1*Math.sin(D1))
			
			# Move the ball so it doesn't overlap.
			radius = c1.getRadius() + c2.getRadius() + 1
			c1.setPosition(
				c2.getX() + radius*Math.cos(A),
				c2.getY() + radius*Math.sin(A)
			)
		
		@speedX *= @friction
		@speedY *= @friction
	
	draw: (context, scale) ->
		
		# Draw it as a circle.
		context.fillStyle = 'yellow'
		context.beginPath()
		context.arc(@x, @y, @radius, 0, 2*Math.PI)
		context.fill()