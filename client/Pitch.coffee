class @Pitch
	
	# width: 0
	# height: 0
	# goalWidth: 0
	
	constructor: (@width, @height, @goalWidth) ->
	
	getWidth: () ->
		return @width
	
	getHeight: () ->
		return @height
	
	getLeftGoalpostX: () ->
		return @width/2 - @goalWidth/2
	
	getRightGoalpostX: () ->
		return @width/2 + @goalWidth/2
	
	isCircleWithinGoalX: (circle) ->
		return @getLeftGoalpostX() < circle.getLeft() and circle.getRight() < @getRightGoalpostX()
	
	collidesWithLeftWall: (circle) ->
		return circle.getLeft() < 0
	
	collidesWithRightWall: (circle) ->
		return @width < circle.getRight()
	
	collidesWithTopWall: (circle) ->
		return not @isCircleWithinGoalX(circle) and circle.getTop() < 0
	
	collidesWithBottomWall: (circle) ->
		return not @isCircleWithinGoalX(circle) and @height < circle.getBottom()
	
	draw: (context, scale) ->
		
		# Draw the grass.
		context.fillStyle = 'green'
		x0 = 0
		y0 = 0
		width = @width
		height = @height
		context.fillRect(x0, y0, width, height)
		
		# Draw the lines.
		lineRadius = 0.1*scale
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
		context.moveTo(0,            @height/2)
		context.lineTo(@width, @height/2)
		context.stroke()
		
		# (circle in middle)
		x = @width/2
		y = @height/2
		radius = @width/7
		context.beginPath()
		context.arc(x, y, radius, 0, 2*Math.PI)
		context.stroke()