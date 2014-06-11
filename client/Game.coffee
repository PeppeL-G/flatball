class @Game
	
	# time: 0
	# pitch: Pitch
	
	constructor: () ->
		
		# Settings.
		pitchWidth = 100
		pitchHeight = 200
		
		# Initialize the game.
		@time = 0
		@pitch = new Pitch(pitchWidth, pitchHeight)
	
	tick: () ->
		@time++
	
	draw: (context, width, height) ->
		
		# Make sure the context use the default transformation (identity matrix).
		context.setTransform(1, 0, 0, 1, 0, 0)
		
		# Draw background.
		context.fillStyle = 'gray'
		context.fillRect(0, 0, width, height)
		
		# Draw current time.
		context.font = '20px Georgia'
		context.fillStyle = 'black'
		context.fillText("Time: #{@time}", 10, 50)
		
		# Draw the pitch in the middle.
		context.translate(width/2, height/2)                                      # Move origo to center
		scale = Math.min(width/@pitch.getWidth(), height/@pitch.getHeight())      # Scale it to the size of the pitch.
		context.scale(scale, scale)
		context.translate(-@pitch.getWidth()/2, -@pitch.getHeight()/2)            # Move it so origo is the upper left corner of the pitch.
		@pitch.draw(context)