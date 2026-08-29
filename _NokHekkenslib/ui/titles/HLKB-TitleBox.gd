extends VBoxContainer

onready var delete = $"%DeleteButton"
onready var target = $"%TitleTarget"
onready var title = $"%TitleText"
onready var preview = $"%Preview"

var hklb = null
var host = null
var consider = true

#	========================================================================== >
func get_titles():
	return {"target": target.text, "text": title.text}
	
#	========================================================================== >
func set_title(target_name = "", title_text = ""):
	target.text = target_name
	title.text = title_text
	
	update()

func update(new_text = null):
	preview.bbcode_text = "[%s]" % ProfanityFilter.filter(title.text)
	
	host.save_titles()
	
func delete():
	consider = false
	hklb.save_titles()
	
	self.queue_free()

#	========================================================================== >
func _ready():
	delete.connect("pressed", self, "delete")
	target.connect("text_changed", self, "update")
	title.connect("text_changed", self, "update")
