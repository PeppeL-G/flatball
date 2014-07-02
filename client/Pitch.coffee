class @Pitch
	
	# width: 0
	# height: 0
	# goalWidth: 0
	# lineRadius: 0
	# topLeftGoalpost: Goalpost
	# topRightGoalpost: Goalpost
	# bottomLeftGoalpost: Goalpost
	# bottomRightGoalpost: Goalpost
	
	constructor: (@width, @height, @lineRadius, @goalWidth) ->
		@topLeftGoalpost = new Goalpost((@width-@goalWidth)/2, @lineRadius, @lineRadius)
		@topRightGoalpost = new Goalpost((@width+@goalWidth)/2, @lineRadius, @lineRadius)
		@bottomLeftGoalpost = new Goalpost((@width-@goalWidth)/2, @height-@lineRadius, @lineRadius)
		@bottomRightGoalpost = new Goalpost((@width+@goalWidth)/2, @height-@lineRadius, @lineRadius)
	
	getWidth: () ->
		return @width
	
	getHeight: () ->
		return @height
	
	getLeftLineRight: () ->
		return @lineRadius*2
	
	getRightLineLeft: () ->
		return @width - @lineRadius*2
	
	getTopLineBottom: () ->
		return @lineRadius*2
	
	getBottomLineTop: () ->
		return @height - @lineRadius*2
	
	getLeftGoalpostX: () ->
		return @width/2 - @goalWidth/2
	
	getRightGoalpostX: () ->
		return @width/2 + @goalWidth/2
	
	isCircleWithinGoalX: (circle) ->
		return @getLeftGoalpostX() < circle.getLeft() and circle.getRight() < @getRightGoalpostX()
	
	collidesWithLeftLine: (circle) ->
		return circle.getLeft() < @getLeftLineRight()
	
	collidesWithRightLine: (circle) ->
		return @getRightLineLeft() < circle.getRight()
	
	collidesWithTopLine: (circle) ->
		return not @isCircleWithinGoalX(circle) and circle.getTop() < @getTopLineBottom()
	
	collidesWithBottomLine: (circle) ->
		return not @isCircleWithinGoalX(circle) and @getBottomLineTop() < circle.getBottom()
	
	draw: (context, scale) ->
		
		# Draw the grass.
		context.fillStyle = 'green'
		x0 = 0
		y0 = 0
		width = @width
		height = @height
		context.fillRect(x0, y0, width, height)
		
		# Draw the lines.
		lineRadius = @lineRadius
		context.lineWidth = lineRadius*2
		context.strokeStyle = 'white'
		
		# (the side lines)
		context.beginPath()
		context.moveTo(0, lineRadius)
		context.lineTo(@getLeftGoalpostX(), lineRadius)
		context.moveTo(@getRightGoalpostX(), lineRadius)
		context.lineTo(@width-lineRadius, lineRadius)
		context.lineTo(@width-lineRadius, @height-lineRadius)
		context.lineTo(@getRightGoalpostX(), @height-lineRadius)
		context.moveTo(@getLeftGoalpostX(), @height-lineRadius)
		context.lineTo(lineRadius, @height-lineRadius)
		context.lineTo(lineRadius, lineRadius)
		context.stroke()
		
		# (middle line)
		context.beginPath()
		context.moveTo(0     , @height/2)
		context.lineTo(@width, @height/2)
		context.stroke()
		
		# (circle in middle)
		x = @width/2
		y = @height/2
		radius = @width/7
		context.beginPath()
		context.arc(x, y, radius, 0, 2*Math.PI)
		context.stroke()
		
		# The goalposts.
		@topLeftGoalpost.draw(context, scale)
		@topRightGoalpost.draw(context, scale)
		@bottomLeftGoalpost.draw(context, scale)
		@bottomRightGoalpost.draw(context, scale)