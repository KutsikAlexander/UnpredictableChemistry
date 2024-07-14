extends Draggable

var ingredients: Array[int]
var clicks: int = 0
var N: int = 0
var reactions: Array[Reaction]
var collider: CollisionShape2D
var liquid: Sprite2D
var last_interactable_object: TestTube = null

func _ready() -> void:
	super._ready()
	area_entered.connect(_on_area_entered)
	area_exited.connect(_on_area_exited)
	collider = get_node("CollisionShape2D")
	liquid = get_node("Sprite2D")
	var testTubes: Array = get_parent().find_children("TestTube*", "TestTube", false)
	N = testTubes.size()
	
	# Generate reaction matrix
	for i:int in range(0, N):
		for j:int in range(i+1, N):
			var id: int = i*N+j-i
			reactions.append(Reaction.new([i,j],id, Color.from_hsv((id*1.0)/N/(N-1)/2.0, 1.0, 1.0)))

	print("All reactions:")
	print(reactions.size())
	for r:Reaction in reactions:
		r.print()

	print("List:")
	for r:Reaction in generate_reaction_list():
		r.print()

func _on_area_entered(other: Area2D) -> void:
	if other is TestTube:
		last_interactable_object = other
		last_interactable_object.drop.connect(_on_drop)
	if other.name == "Flush":
		flush()
		dragged = false

func _on_area_exited(other: Area2D) -> void:
	if other == last_interactable_object:
		last_interactable_object.drop.disconnect(_on_drop)
		last_interactable_object = null

func _on_drop() -> void:
	if last_interactable_object != null:
		mix(last_interactable_object.n, last_interactable_object._color)
		dragged = false

func mix(number: int, color: Color) -> void:
	print(number)
	match clicks:
		0:
			liquid.self_modulate = color
			ingredients.push_back(number)
			clicks+=1
		1:
			if(ingredients[0] != number):
				ingredients.push_back(number)
				ingredients.sort()
				clicks+=1
				print("Reaction")
				for r in reactions:
					if r.ingredients == ingredients:
						show_reaction(r)
						r.print()
						break
			else:
				print("Already there")
		_:
			print("Full")

func flush() -> void:
	liquid.self_modulate = Color.WHITE
	ingredients.clear()
	clicks = 0
	print("Mixer is clear")

func show_reaction(reaction: Reaction) -> void:
	liquid.self_modulate = reaction.color

func generate_reaction_list() -> Array[Reaction]:
	var matrix = reactions.duplicate(true)
	var list: Array[Reaction] = []
	while list.size() < N-1 and !matrix.is_empty():
		list.append(matrix.pop_at(randi()%matrix.size()))
	return list