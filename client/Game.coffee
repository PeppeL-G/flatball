class @Game
	
	# time: 0
	# pitch: Pitch
	# ball: Ball
	# playersInTeam1: [Player]
	
	constructor: () ->
		
		# Game settings.
		pitchWidth = 100
		pitchHeight = 150
		ballRadius = 1.5
		playerRadius = 2
		team1StartPositions = [
			x: 25
			y: 25
		,
			x: 75
			y: 75
		]
		
		# Initialize the game.
		@time = 0
		@pitch = new Pitch(pitchWidth, pitchHeight)
		@ball = new Ball(pitchWidth/2, pitchHeight/2, ballRadius)
		@playersInTeam1 = (new Player(player.x, player.y, playerRadius, 0.5) for player in team1StartPositions)
	
	tick: () ->
		
		@time++
		
		# Make everything tick.
		@ball.tick()
		for player in @playersInTeam1
			player.tick(@ball)
		
		# Handle collisions.
		if @pitch.collidesWithLeftWall(@ball)
			@ball.flipXSpeedDirection()
		else if @pitch.collidesWithRightWall(@ball)
			@ball.flipXSpeedDirection()
		
		if @pitch.collidesWithTopWall(@ball)
			@ball.flipYSpeedDirection()
		else if @pitch.collidesWithBottomWall(@ball)
			@ball.flipYSpeedDirection()
	
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
		
		@pitch.draw(context, scale)
		@ball.draw(context, scale)
		for player in @playersInTeam1
			player.draw(context, scale)