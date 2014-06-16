class @Game
	
	# finger Finger
	# time: 0
	# pitch: Pitch
	# ball: Ball
	# playersInTeam1: [Player]
	
	constructor: (@finger) ->
		
		# Game settings.
		pitchWidth = 100
		pitchHeight = 150
		goalWidth = pitchWidth/8
		ballRadius = 1.5
		playerRadius = 2
		team1StartPositions = [
			movementPoints: [
				x: pitchWidth*0.25
				y: pitchHeight*0.25
			,
				x: pitchWidth*0.75
				y: pitchHeight*0.75
			]
		,
			movementPoints: [
				x: pitchWidth*0.75
				y: pitchHeight*0.25
			,
				x: pitchWidth*0.25
				y: pitchHeight*0.75
			]
		,
			movementPoints: [
				x: pitchWidth*0.75
				y: pitchHeight*0.75
			,
				x: pitchWidth*0.75
				y: pitchHeight*0.25
			]
		,
			movementPoints: [
				x: pitchWidth*0.25
				y: pitchHeight*0.75
			,
				x: pitchWidth*0.25
				y: pitchHeight*0.25
			]
		]
		
		# Initialize the game.
		@time = 0
		@pitch = new Pitch(pitchWidth, pitchHeight, goalWidth)
		@ball = new Ball(pitchWidth*0.5, pitchHeight*0.9, ballRadius)
		@playersInTeam1 = (new Player(player.movementPoints[0].x, player.movementPoints[0].y, playerRadius, 0.5, 5, player.movementPoints) for player in team1StartPositions)
	
	getBall: () ->
		return @ball
	
	getPlayerNearestBall: () ->
		nearestDistance = Infinity
		nearestPlayer = null
		for player in @playersInTeam1
			distance = @ball.getDistanceTo(player.getX(), player.getY())
			if distance < nearestDistance
				nearestDistance = distance
				nearestPlayer = player
		return nearestPlayer
	
	isPlayerNearestBall: (player) ->
		return player == @getPlayerNearestBall()
	
	tick: () ->
		
		@time++
		
		playerHavingBall = null
		for player in @playersInTeam1
			if player.hasEnergy() and player.overlapsWith(@ball)
				playerHavingBall = player
				break
		
		if playerHavingBall == null
			
			# Make everything tick.
			@ball.tick()
			for player in @playersInTeam1
				
				player.tick(@)
				
				# If the player collides with another player, move him back.
				for otherPlayer in @playersInTeam1
					if player != otherPlayer and player.overlapsWith(otherPlayer)
						player.moveBack()
						break
			
			# Handle collisions.
			if @pitch.collidesWithLeftWall(@ball)
				@ball.flipXSpeedDirection()
			else if @pitch.collidesWithRightWall(@ball)
				@ball.flipXSpeedDirection()
			
			if @pitch.collidesWithTopWall(@ball)
				@ball.flipYSpeedDirection()
			else if @pitch.collidesWithBottomWall(@ball)
				@ball.flipYSpeedDirection()
		
		else
			
			# A player has the ball.
			x = @finger.getX()
			y = @finger.getY()
			
			if @pitchX0 <= x and x <= @pitchX1 and @pitchY0 <= y and y <= @pitchY1
				
				if @finger.isPressing()
					
					# Change the x and y to coordinates on the pitch.
					x = (x-@pitchX0)*@pitch.getWidth()/(@pitchX1-@pitchX0)
					y = (y-@pitchY0)*@pitch.getHeight()/(@pitchY1-@pitchY0)
					
					# Move the ball according to the fingers position.
					angle = Math.atan2(playerHavingBall.getY()-y, playerHavingBall.getX()-x)
					
					# (multiply by 0.95 so they surely overlap)
					newBallX = playerHavingBall.getX() + Math.cos(angle)*(@ball.getRadius()+playerHavingBall.getRadius())*0.95
					newBallY = playerHavingBall.getY() + Math.sin(angle)*(@ball.getRadius()+playerHavingBall.getRadius())*0.95
					@ball.setPosition(newBallX, newBallY)
					speed = 3
					@ball.setSpeed(Math.cos(angle)*speed, Math.sin(angle)*speed)
					
				else if @finger.wasPressing() and not @finger.isPressing()
					
					# The player is shooting!
					playerHavingBall.shoot()
	
	draw: (context, width, height) ->
		
		# Make sure to use the default transformation.
		context.setTransform(1, 0, 0, 1, 0, 0)
		
		# Draw background.
		context.fillStyle = 'gray'
		context.fillRect(0, 0, width, height)
		
		# Draw current time.
		context.font = '20px Georgia'
		context.fillStyle = 'black'
		context.fillText("Time: #{@time}", 10, 50)
		
		# Draw the pitch in the middle.
		scale = Math.min(width/@pitch.getWidth(), height/@pitch.getHeight())/1.1
		
		context.translate(width/2, height/2)
		context.scale(scale, scale)
		context.translate(-@pitch.getWidth()/2, -@pitch.getHeight()/2)
		
		@pitchX0 = width/2 - @pitch.getWidth()/2*scale
		@pitchX1 = width/2 + @pitch.getWidth()/2*scale
		@pitchY0 = height/2 - @pitch.getHeight()/2*scale
		@pitchY1 = height/2 + @pitch.getHeight()/2*scale
		
		@pitch.draw(context, scale)
		@ball.draw(context, scale)
		for player in @playersInTeam1
			player.draw(context, scale)