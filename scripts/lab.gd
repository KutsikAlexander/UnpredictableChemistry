class_name Lab

extends Node2D

static var N: int = 3
var testTubeTemplate: PackedScene = load("res://scenes/test_tube.tscn")
var testTubes: Array[TestTube]
var tubeHolderTemplate: PackedScene = load("res://scenes/stand/stand_constructor.tscn")
var tubeHolders: Array[Node2D]
@export var tubeHolderFluctuation: Rect2
var reactions: Array[Reaction]
var known_reaction: Array[Reaction]
@onready var mixer:Mixer = $Mixer/Acceptor

@onready var listUI:List = $CanvasLayer/List
@onready var menu:Control = $CanvasLayer/MainMenu

@onready var hide_button: Button = $CanvasLayer/HideButton
@onready var next_level_button: Button = $CanvasLayer/NextLevelButton

func _ready() -> void:
	# Generate reaction matrix
	for i:int in range(0, N):
		for j:int in range(i+1, N):
			var id: int = i*(N-1)+j
			reactions.append(Reaction.new([i,j],id, Color.from_hsv((id*1.0)/N/(N-1)/2.0, 1.0, 1.0)))

	print("All reactions:")
	print(reactions.size())
	for r:Reaction in reactions:
		r.print()

	known_reaction = generate_reaction_list()
	print("List:")
	for r:Reaction in known_reaction:
		r.print()

	#find all stand points
	for point in find_children("StandPoint*", "Marker2D"):
		if point.is_in_group("StandPoint"):
			var stand: StandConstructor = tubeHolderTemplate.instantiate()
			point.add_child(stand)
			stand.position.x = tubeHolderFluctuation.position.x+ randf_range(-tubeHolderFluctuation.size.x, tubeHolderFluctuation.size.x)
			stand.position.y = tubeHolderFluctuation.position.y+ randf_range(-tubeHolderFluctuation.size.y, tubeHolderFluctuation.size.y)
			stand.construct(3)
			for child in stand.get_children():
				for tubeHolder in child.find_children("*Holder*", "Marker2D"):
					if tubeHolder.is_in_group("Holder"):
						tubeHolders.append(tubeHolder)

	tubeHolders.shuffle()

	# Generate color for tubes
	var tubeColors: Array[Color] = []
	for i in range(0, N):
		tubeColors.append(Color.from_hsv((i*1.0)/N, 1.0, 1.0))

	tubeColors.shuffle()

	# Set test tubes
	for i in range(0, N):
		var testTube:TestTube = testTubeTemplate.instantiate()
		testTube.set_properties(i, tubeColors[i], N)
		testTube.value_changed.connect(check)
		testTubes.append(testTube)
		tubeHolders[i].add_child(testTube)
		testTube.global_scale = Vector2(1,1)
		# testTube.position = to_global(tubeHolders[i].position)
		# testTube.original_position = to_global(tubeHolders[i].position)

	# setup mixer
	mixer.reactions = reactions.duplicate()

	#setup UI List
	listUI.set_reactions(known_reaction)

func generate_reaction_list() -> Array[Reaction]:
	var matrix = reactions.duplicate(true)
	var list: Array[Reaction] = []
	while list.size() < N-1 and !matrix.is_empty():
		list.append(matrix.pop_at(randi()%matrix.size()))
	return list

func check() -> void:
	for testTube in testTubes:
		if testTube.n != testTube.m-1:
			next_level_button.disabled = true
			return
	next_level_button.disabled = false


func hide_list() -> void:
	if listUI.visible:
		hide_button.text = "Show list"
		listUI.visible = false
	else:
		hide_button.text = "Hide"
		listUI.visible = true
		menu.visible = false

func next_level() -> void:
	N+=1
	get_tree().reload_current_scene()

func go_to_main_menu() -> void:
	if menu.visible:
		menu.visible = false
	else:
		menu.visible = true
		listUI.visible = false
		hide_button.text = "Show list"
