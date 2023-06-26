extends drag_container

signal select_skill(skill_data)
signal deselect_skill

@onready var skill_class = preload("res://entities/skill.tscn")

var selected_node = null
var active_dragging := false

func _ready() -> void:
	super._ready()
#	add_skill("Сила", 3)
#	add_skill("Ловкость", 2)
#	add_skill("Златоуст")
#	var selected_skill = CharactersSystem.main_character.skills[2]
#	print("skill", selected_skill.id)
#	select_upgradable_skills()
	pass

func add_skill(skill_name : String, value := 0):
	var skill_data = CharactersSystem.main_character.add_skill(skill_name, value)
	var new_skill = skill_class.instantiate()
	add_child(new_skill)
	new_skill.size.y = new_skill.get_combined_minimum_size().y
#	new_skill.size.x = get_combined_minimum_size().x
	new_skill.size.x = size.x
	print_debug(size.x)
	new_skill.resized.connect(set_childs_positions)
	new_skill.set_params(skill_data)
	new_skill.select.connect(select_skill_node.bind(new_skill))
	new_skill.dragging.connect(drag_cell)
	new_skill.start_dragging.connect(set_active_dragging_flag.bind(true))
	new_skill.end_dragging.connect(  set_active_dragging_flag.bind(false))
	new_skill.end_dragging.connect(set_childs_positions)
	new_skill.end_dragging.connect(update_indexes)
	skill_data.skill_index = new_skill.get_index()
	pass

func load_skill(skill_data : skill):
	var new_skill = skill_class.instantiate()
	add_child(new_skill)
	new_skill.size.y = new_skill.get_combined_minimum_size().y
#	new_skill.size.x = get_combined_minimum_size().x
	new_skill.size.x = size.x
	new_skill.resized.connect(set_childs_positions)
	new_skill.set_params(skill_data)
	new_skill.select.connect(select_skill_node.bind(new_skill))
	new_skill.dragging.connect(drag_cell)
	new_skill.start_dragging.connect(set_active_dragging_flag.bind(true))
	new_skill.end_dragging.connect(  set_active_dragging_flag.bind(false))
	new_skill.end_dragging.connect(set_childs_positions)
	new_skill.end_dragging.connect(update_indexes)
	move_child(new_skill, skill_data.skill_index)
	pass

func update_indexes():
	var all_children = get_children()
	for skill_ui in all_children:
		var skill_data = skill_ui.skill_params as skill
		skill_data.skill_index = skill_ui.get_index()
	pass

func set_active_dragging_flag(flag : bool):
	active_dragging = flag
	pass

func set_min_size():
	var min_size
	var all_skills = get_children()
	for skill_node in all_skills:
		var skill_size = skill_node.get_name_size()
		min_size = skill_size if skill_size > min_size else min_size
	
	for skill_node in all_skills:
		skill_node.set_name_size(min_size)
	pass

func select_skill_node(flag : bool, node : Node):
	if selected_node != null:
		selected_node.set_select(false)
#	print(flag, node.name)
	selected_node = null
	node.set_select(flag)
	if flag:
		selected_node = node
		select_skill.emit(node.skill_params)
	else:
		deselect_skill.emit()
	pass

func deselect_all():
	var all_skills = get_children()
	for skill_node in all_skills:
		skill_node.set_select(false)
	pass

func clear_all_modulate():
	var all_skills = get_children()
	for skill_node in all_skills:
		skill_node.update()
	pass

func select_upgradable_skills():
	if get_child_count() == 0:
		return
	var skills = {}
	var all_skills = get_children()
	for skill_node in all_skills:
		if skills.has(skill_node.skill_params.value):
			skills[skill_node.skill_params.value].append(skill_node)
		else:
			skills[skill_node.skill_params.value] = [skill_node]
	var keys = skills.keys()
	keys.sort()
	
	var broken_skills = []
	var upgradable_skills = []
	var next_broken_flag = false
	for i in range(0, keys[-1] + 1, 1):
		if skills.has(i):
#			if skills.has(i-1):
#				print_debug(i != 0, i != 1, skills[i-1].size() - skills[i].size())
			if next_broken_flag:
				next_broken_flag = false
				broken_skills.append(i)
				continue
			if i != 0 && (i != 1 && (skills[i-1].size() - skills[i].size()) < 0):
				broken_skills.append(i)
				pass
			elif i == 0 || (i != 0 && (skills[i-1].size() - skills[i].size()) >= 2):
				upgradable_skills.append(0 if i == 0 else i-1)
		else:
			next_broken_flag = true
#			pass
	
	for key in keys:
		for _skill in skills[key]:
			if broken_skills.has(key):
				_skill.set_label_modulate(Color.LIGHT_CORAL)
			elif upgradable_skills.has(key):
				_skill.set_label_modulate(Color.LIGHT_GREEN)
			else:
				_skill.set_label_modulate(Color.WHITE)
	
	print(keys)
	pass

func get_y_step():
	var childs_count = get_child_count()
	var y_size = get_parent().size.y
	return y_size/(childs_count + 1)
	pass
