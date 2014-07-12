class @Game
	
	# finger Finger
	# time: 0
	# pitch: Pitch
	# ball: Ball
	# playersInTeam1: [Player]
	# playersInTeam2: [Player]
	
	constructor: (@finger) ->
		
		# Game settings.
		pitchWidth = 100
		pitchHeight = 150
		lineRadius = 1
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
		team2StartPositions = [
			movementPoints: [
				x: pitchWidth*0.50
				y: pitchHeight*0.25
			,
				x: pitchWidth*0.50
				y: pitchHeight*0.75
			]
		,
			movementPoints: [
				x: pitchWidth*0.25
				y: pitchHeight*0.50
			,
				x: pitchWidth*0.75
				y: pitchHeight*0.50
			]
		,
			movementPoints: [
				x: pitchWidth*0.10
				y: pitchHeight*0.90
			,
				x: pitchWidth*0.90
				y: pitchHeight*0.90
			]
		,
			movementPoints: [
				x: pitchWidth*0.10
				y: pitchHeight*0.10
			,
				x: pitchWidth*0.90
				y: pitchHeight*0.10
			]
		]
		
		# Initialize the game.
		@time = 0
		@pitch = new Pitch(pitchWidth, pitchHeight, lineRadius, goalWidth)
		@ball = new Ball(pitchWidth*0.5, pitchHeight*0.9, ballRadius)
		@teams = 
			'blue': (new Player(playerRadius, 0.5, 5, player.movementPoints, 'blue') for player in team1StartPositions)
			'red':  (new Player(playerRadius, 0.5, 5, player.movementPoints, 'red') for player in team2StartPositions)
		@players = @teams.blue.concat(@teams.red)
	
	getBall: () ->
		return @ball
	
	getPitch: () ->
		return @pitch
	
	getTeamPlayerNearestBall: (teamColor) ->
		nearestDistance = Infinity
		nearestPlayer = null
		for player in @teams[teamColor]
			distance = @ball.getDistanceTo(player.getX(), player.getY())
			if distance < nearestDistance
				nearestDistance = distance
				nearestPlayer = player
		return nearestPlayer
	
	isTeamPlayerNearestBall: (player) ->
		return player == @getTeamPlayerNearestBall(player.getColor())
	
	tick: () ->
		
		@time++
		
		playerHavingBall = null
		for player in @players
			if player.hasEnergy() and player.overlapsWith(@ball)
				playerHavingBall = player
				break
		
		if playerHavingBall == null
			
			# Make everything tick.
			@ball.tick(@)
			for player in @players
				
				player.tick(@)
				
				# If the player collides with another player, move him back.
				for otherPlayer in @players
					if player != otherPlayer and player.overlapsWith(otherPlayer)
						player.moveBack()
						break
		
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
		for player in @players
			player.draw(context, scale)