extends Control

onready var label = get_node("RichTextLabel")
onready var timer = get_node("Timer")

export (int) var time = 1000

enum TimeFormat {
    FORMAT_HOURS   = 1 << 0,
    FORMAT_MINUTES = 1 << 1,
    FORMAT_SECONDS = 1 << 2,
    FORMAT_DEFAULT = FORMAT_HOURS | FORMAT_MINUTES | FORMAT_SECONDS
}

func _process(delta):	

	var time2 = format_time(time, FORMAT_MINUTES | FORMAT_SECONDS)
	label.set_text(str(time2))

func _on_Timer_timeout():
	time -= 1
	if time <= 0:
		print("game over")
		get_tree().change_scene("res://UI/GameOver.tscn")
	pass # replace with function body
	
func format_time(time, format = FORMAT_DEFAULT, digit_format = "%02d"):
	var digits = []
	
	if format & FORMAT_HOURS:
		var hours = digit_format % [time / 3600]
		digits.append(hours)
	
	if format & FORMAT_MINUTES:
		var minutes = digit_format % [time / 60]
		digits.append(minutes)
	
	if format & FORMAT_SECONDS:
		var seconds = digit_format % [int(ceil(time)) % 60]
		digits.append(seconds)
	
	var formatted = String()
	var colon = ":"
	
	for idx in digits.size():
	    formatted += digits[idx]
	    if idx != digits.size() - 1:
	        formatted += colon
	
	return formatted