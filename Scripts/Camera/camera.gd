extends Node3D

class_name Camera

@onready var camera = $Camera

func _ready():
	Global.camera = self

	
func _process(delta):
	pass
