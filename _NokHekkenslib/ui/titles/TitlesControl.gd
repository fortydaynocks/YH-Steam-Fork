extends VBoxContainer

onready var container = $"%TitleContainer"

var host = self.owner
var title_box = preload("res://_NokHekkenslib/ui/titles/HLKB-TitleBox.tscn")

#	========================================================================== >
func save_titles():
	host.refresh_file()
	
	var new_file = File.new()
	new_file.open(host.data_directory, new_file.READ)
	var json_data = JSON.parse(new_file.get_as_text())
	
	if !json_data.error:
		json_data = json_data.result
		new_file.close()
		new_file.open(host.data_directory, new_file.WRITE)
		
		if json_data is Dictionary:
			json_data["titles"] = {}
			
			for title_obj in container.get_children():
				if title_obj.get("consider") == true:
					var title = title_obj.get_titles()
					json_data.titles[title.target] = title.text
					
			new_file.store_string(JSON.print(json_data, "	"))
	else:
		$"%JSONError".visible = true
		
	new_file.close()

func load_titles():
	host.refresh_file()
	purge()
	
	var new_file = File.new()
	new_file.open(host.data_directory, new_file.READ)
	var json_data = JSON.parse(new_file.get_as_text())
	
	if !json_data.error:
		json_data = json_data.result
		if json_data is Dictionary:
			if json_data.has("titles"):
				for title in json_data.titles.keys():
					create_title_from_data(title, json_data.titles[title])
		
	else:
		$"%JSONError".visible = true
	
	new_file.close()

func fetch_title(chr):
	host.refresh_file()
	
	var new_file = File.new()
	new_file.open(host.data_directory, new_file.READ)
	var json_data = JSON.parse(new_file.get_as_text())
	
	if !json_data.error:
		json_data = json_data.result
		if json_data is Dictionary:
			if json_data.has("titles"):
				if json_data.titles.has(chr):
					return json_data.titles[chr]
	
	new_file.close()
	
	return null

#	========================================================================== >
func title_created():
	var title = title_box.instance()
	container.add_child(title)
	
	title.hklb = self.owner
	title.host = self
	
func create_title_from_data(target_name = "", title_text = ""):
	var title = title_box.instance()
	container.add_child(title)
	
	title.hklb = self.owner
	title.host = self
	
	title.set_title(target_name, title_text)

#	========================================================================== >
func purge():
	for child in container.get_children(): child.queue_free()

#	========================================================================== >
func _ready():
	host = self.owner
	
	$"%NewTitle".connect("pressed", self, "title_created")
