class_name Lab

extends Node2D

@export var N: int = 3
var testTubePrefab: PackedScene = load("res://scenes/test_tube.tscn")
var testTubes: Array[TestTube]
var tubeHolders: Array[Node2D]
var reactions: Array[Reaction]
var known_reaction: Array[Reaction]
@onready var mixer:Mixer = $Mixer/Acceptor
@onready var listUI:List = $CanvasLayer/List

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

	# find all tube holders
	for tubeHolder in find_children("*Holder*"):
		if tubeHolder.is_in_group("Holder"):
			tubeHolders.append(tubeHolder)
			print(tubeHolder.position)

	tubeHolders.shuffle()

	# Generate color for tubes
	var tubeColors: Array[Color] = []
	for i in range(0, N):
		tubeColors.append(Color.from_hsv((i*1.0)/N, 1.0, 1.0))

	tubeColors.shuffle()

	# Set test tubes
	for i in range(0, N):
		var testTube:TestTube = testTubePrefab.instantiate()
		testTube.set_properties(i, tubeColors[i])
		testTube.value_changed.connect(check)
		testTubes.append(testTube)
		tubeHolders[i].add_child(testTube)
		# testTube.position = to_global(.position)

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
			return
	print("You win")
