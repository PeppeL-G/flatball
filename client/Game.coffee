class @Game
	
	# time: 0
	# pitch: Pitch
	
	constructor: () ->
		
		# Game settings.
		pitchWidth = 100
		pitchHeight = 150
		
		# Initialize the game.
		@time = 0
		@pitch = new Pitch(pitchWidth, pitchHeight)
	
	tick: () ->
		@time++
	
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