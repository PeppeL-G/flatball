class @Pitch
	
	# width: 0
	# height: 0
	# goalWidth: 0
	# lineRadius: 0
	# middlePost: Goalpost
	# topLeftGoalpost: Goalpost
	# topRightGoalpost: Goalpost
	# bottomLeftGoalpost: Goalpost
	# bottomRightGoalpost: Goalpost
	
	constructor: (@width, @height, @lineRadius, @goalWidth) ->
		@middlePost = new Post(@width/2,  @height/2, @width/6)
		@topLeftGoalpost = new Post((@width-@goalWidth)/2, @lineRadius, @lineRadius)
		@topRightGoalpost = new Post((@width+@goalWidth)/2, @lineRadius, @lineRadius)
		@bottomLeftGoalpost = new Post((@width-@goalWidth)/2, @height-@lineRadius, @lineRadius)
		@bottomRightGoalpost = new Post((@width+@goalWidth)/2, @height-@lineRadius, @lineRadius)
	
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
	
	getCollidedGoalpost: (circle) ->
		if circle.overlapsWith(@middlePost)
			return @middlePost
		if circle.overlapsWith(@topLeftGoalpost) and @topLeftGoalpost.getX() < circle.getX()
			return @topLeftGoalpost
		if circle.overlapsWith(@topRightGoalpost) and circle.getX() < @topRightGoalpost.getX()
			return @topRightGoalpost
		if circle.overlapsWith(@bottomLeftGoalpost) and @bottomLeftGoalpost.getX() < circle.getX()
			return @bottomLeftGoalpost
		if circle.overlapsWith(@bottomRightGoalpost) and circle.getX() < @bottomRightGoalpost.getX()
			return @bottomRightGoalpost
		return null
	
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
		
		# The goalposts.
		@middlePost.draw(context, scale)
		@topLeftGoalpost.draw(context, scale)
		@topRightGoalpost.draw(context, scale)
		@bottomLeftGoalpost.draw(context, scale)
		@bottomRightGoalpost.draw(context, scale)