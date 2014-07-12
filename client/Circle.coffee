class @Circle
	
	# x: 0
	# y: 0
	# radius: 0
	
	constructor: (@x, @y, @radius) ->
		
	
	getX: () ->
		return @x
	
	getY: () ->
		return @y
	
	getRadius: () ->
		return @radius
	
	getLeft: () ->
		return @x-@radius
	
	getRight: () ->
		return @x+@radius
	
	getTop: () ->
		return @y-@radius
	
	getBottom: () ->
		return @y+@radius
	
	overlapsWith: (circle) ->
		dx = circle.getX() - @x
		dy = circle.getY() - @y
		return Math.sqrt(dx*dx + dy*dy) < circle.getRadius() + @radius
	
	setLeft: (left) ->
		@x = left+@radius
	
	setRight: (right) ->
		@x = right-@radius
	
	setTop: (top) ->
		@y = top+@radius
	
	setBottom: (bottom) ->
		@y = bottom-@radius
	
	setPosition: (x, y) ->
		@x = x
		@y = y
	
	move: (dx, dy) ->
		@x += dx
		@y += dy