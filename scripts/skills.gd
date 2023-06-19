extends Container

signal select_skill(skill_data)

@onready var skill_class = preload("res://entities/skill.tscn")

var selected_node = null

func _ready() -> void:
	add_skill("Сила", 3)
	add_skill("Ловкость", 2)
	add_skill("Златоуст")
	var selected_skill = CharactersSystem.main_character.skills[2]
#	print("skill", selected_skill.id)
#	select_upgradable_skills()
	pass

func add_skill(skill_name : String, value := 0):
	var skill_data = CharactersSystem.main_character.add_skill(skill_name, value)
	var new_skill = skill_class.instantiate()
	add_child(new_skill)
	new_skill.size.y = new_skill.get_combined_minimum_size().y
	new_skill.size.x = get_combined_minimum_size().x
	new_skill.resized.connect(Callable(self, "set_childs_positions"))
	new_skill.set_skill_params(skill_data)
	new_skill.select.connect(Callable(self, "select_skill_node").bind(new_skill))
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
	pass

func deselect_all():
	var all_skills = get_children()
	for skill_node in all_skills:
		skill_node.set_select(false)
	pass

func clear_all_modulate():
	var all_skills = get_children()
	for skill_node in all_skills:
		var skill_size = skill_node.modulate_off()
	pass

func select_upgradable_skills():
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
			if next_broken_flag:
#				nex_broken_flag = false
				broken_skills.append(i)
				continue
			if i != 0 && (i != 1 && skills[i-1].size() - skills[i].size() < 0):
				broken_skills.append(i)
				pass
			elif i == 0 || (i != 0 && skills[i-1].size() - skills[i].size() >= 2):
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
	
	print(keys)
	pass

func _notification(what):
	if what == NOTIFICATION_SORT_CHILDREN:
		# Must re-sort the children
		set_childs_positions()
	pass

func drag_cell():
	var all_children = get_children()
	var childs_count = all_children.size()
	var counter = 0
	var step = all_children[0].get_combined_minimum_size()
#	print(step)
	for c in all_children:
		if c.dragged:
			var drag_position = (counter * step) + step - c.size.x/2 
#			prints(c.position.x, drag_position, counter)
			if  drag_position < c.position.x  && c.position.x - drag_position >= step/2:
#				print("move right")
				if counter < childs_count:
					move_child(c, counter + 1)
			elif c.position.x < drag_position && drag_position - c.position.x >= step/2:
#				print("move left")
				if counter > 0:
					move_child(c, counter - 1)
			return
		counter += 1
	set_childs_positions()
	pass

func set_childs_positions():
	var all_children = get_children()
	var childs_count = all_children.size()
	var counter = 0
	var step = all_children[0].get_combined_minimum_size()
#	var step = size.x/(childs_count + 1)
	for c in all_children:
#		if !c.dragged:
#			c.position.y = size.y/2 - c.size.y/2 
		c.size.y = c.get_combined_minimum_size().y
		c.size.x = get_combined_minimum_size().x
		c.position.x = 0
		c.position.y = (counter * step).y
		counter += 1
	
	pass

#get_minimum_size()
