extends Control

onready var endStory = get_node("endStory")

func _ready():
	var health = 100;
	var happy = 100;
	var items = 28
	var time = 2000 #2000
	
#	health = Global.values.player.hp;
#	happy = Global.values.player.happi
#	items = Global.countItems()
#	time = Global.time
	
	print(str(health) + " - " + str(happy) + " - " + str(items) + " - " + str(time))
	
	var endSeq = "You made to the end "
	
	if health >= 0 && health < 35:
		endSeq += "Even though you managed to get yourself to a safe location. You got extremely homesick and it made you fall into despair.  "
	if health > 50 && health <= 100:
		endSeq += "You managed to get to the safe haven! Even though you are still missing your house, you were able to bring memorabilia along to make any place feel like home! "
		
	if happy >= 0 && happy < 50:
		endSeq += "Regrettably, you forgot to take care of your health and are not feeling well. "
	if happy > 50 && happy <= 100:
		endSeq += "In addition, you took care of your health and feel better than ever. "
		
	if items >= 0 && items <= 14:
		endSeq += "Also, you did not bring enough items. You are unsure you can keep up with the changing world. "
	if items > 14 && items <= 100:
		 endSeq += "Luckily, you brought enough items. You are sure you can take on any challenge thrown at you. "
		
	if time >= 0 && time <= 1000:
		endSeq += "You was not in time to make it out of the save zone. "
	if time > 1000 && time <=2000:
		endSeq += "You was in time to make it to the save zone "
		
	endSeq += "the end"
	
	endStory.text = endSeq

func _on_Button_pressed():
	print("restart")
	get_tree().change_scene("res://UI/titlescreen2/titlescreen.tscn")