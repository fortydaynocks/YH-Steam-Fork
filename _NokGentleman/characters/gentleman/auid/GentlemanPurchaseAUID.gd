extends ActionUIData

onready var itemList = $"%ItemList"
onready var price = $"%Price"
onready var nem = $"%NotEnoughMoney"

var selected_item = null

#	--
func on_button_selected():
	.on_button_selected()
	
	selected_item = null
	itemList.clear()

	if is_instance_valid(fighter):
		for item_key in fighter.items_in_store:
			var item_value = fighter.items_in_store[item_key]
			itemList.add_item(item_value.Name, item_value.Icon, true)

func get_data():
	if is_instance_valid(fighter) and selected_item:
		if fighter.money >= selected_item.Price:
			return selected_item.Name
	
	return null


func _on_ItemList_item_selected(index):
	
	emit_signal("data_changed")
	var item = fighter.items_in_store[fighter.items_in_store.keys()[index]]
	
	if is_instance_valid(fighter) and item:
		selected_item = item
		price.text = "Price = $" + str(item.Price)
		nem.visible = fighter.money < item.Price 
	
	
