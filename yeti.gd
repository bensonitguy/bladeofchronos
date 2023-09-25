extends CharacterBody2D

@onready var anim = get_node('AnimatedSprite2D')
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var player
var chase = false
var SPEED = 50
func _physics_process(delta):
	velocity.y += gravity * delta
	if chase == true:
		if anim.animation != "Death":
			player = get_node("../../Player/Player")
			anim.play("Patrol")
			var direction = (player.position - self.position).normalized()
			if direction.x > 0:
				get_node("AnimatedSprite2D").flip_h = false
			elif direction.x < 0:
				get_node("AnimatedSprite2D").flip_h = true
			velocity.x = direction.x * SPEED 
	else:
		if anim.animation != "Death":
			anim.play("Idle")
		velocity.x = 0
	move_and_slide()

func _on_playerdetection_body_entered(body):
	if body.name == "Player":
		chase = true
		


func _on_playerdetection_body_exited(body):
	if body.name == "Player":
		chase = false


func _on_player_death_body_entered(body):
	print("hello")
	if body.name == "Player":
		anim.play("Death")
		await anim.animation_finished
		self.queue_free()
