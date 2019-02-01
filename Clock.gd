extends Control

onready var label = get_node("RichTextLabel")
onready var timer = get_node("Timer")

var clockActive = false;

enum TimeFormat {
    FORMAT_HOURS   = 1 << 0,
    FORMAT_MINUTES = 1 << 1,
    FORMAT_SECONDS = 1 << 2,
    FORMAT_DEFAULT = FORMAT_HOURS | FORMAT_MINUTES | FORMAT_SECONDS
}

func _process(delta):	
	if clockActive:
		var time2 = format_time(Global.time, FORMAT_MINUTES | FORMAT_SECONDS)
		label.set_text(str(time2))
	visible = clockActive

func _on_Timer_timeout():
	Global.time -= 1
	if Global.time <= 0:
		print("game over")
		Global.gotoScene("res://UI/GameOver.tscn")
	
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