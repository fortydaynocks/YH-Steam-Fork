extends Node

func _init(modLoader = ModLoader):
	modLoader.installScriptExtension(
		"res://_NokHekkenslib/HKLB-Hook.gd")
	
	modLoader.installScriptExtension(
		"res://_NokHekkenslib/overrides/CharSelect.gd")

	install_hklb_network()


func install_hklb_network():
	var network_extension = install_script_extension(
		"res://_NokHekkenslib/overrides/HKLB-Network.gd")
	
	if not network_extension:
		return
	
	Network.set_script(network_extension)

# Borrowed from Codex (By Trimay).
func install_script_extension(child_path: String):
	var child_script = ResourceLoader.load(child_path)
	if not child_script:
		return null

	var parent_script = child_script.get_base_script()
	if not parent_script:
		return null

	var parent_path = parent_script.resource_path

	var temp_instance = child_script.new()
	if is_instance_valid(temp_instance):
		temp_instance.free()

	child_script.take_over_path(parent_path)
	return child_script

