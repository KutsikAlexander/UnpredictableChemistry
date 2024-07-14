class_name CombinationChecker

extends Node

var testTubes: Array[TestTube]

func _ready() -> void:
	for marker in find_children("Mark*", "Mark"):
		if marker is Mark:
			marker.drop.connect(check)
	for testTube in find_children("TestTube*", "TestTube"):
		if testTube is TestTube:
			testTubes.append(testTube)
		

func check() -> void:
	for testTube in testTubes:
		if testTube.n != testTube.label.text.to_int()-1:
			return
	print("You win")