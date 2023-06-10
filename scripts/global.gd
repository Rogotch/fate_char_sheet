extends Node

enum ACTION_TYPE   {OVERCOME, ADVANTAGE, ATTACK, DEFEND}
enum OUTCOMES_TYPE {FAIL, TIE, SUCCEED, SUCCEED_STILE}

func get_outcome_type_by_value(result_value : int):
	
	var outcome_result
	if result_value <= -3:
		outcome_result = OUTCOMES_TYPE.FAIL
	elif result_value < 0:
		outcome_result = OUTCOMES_TYPE.FAIL
	elif result_value == 0:
		outcome_result = OUTCOMES_TYPE.TIE
	elif result_value < 3:
		outcome_result = OUTCOMES_TYPE.SUCCEED
	elif result_value >= 3:
		outcome_result = OUTCOMES_TYPE.SUCCEED_STILE
	return outcome_result
	pass

func get_action_key(action_type : ACTION_TYPE):
	var result_key = ""
	match action_type:
		ACTION_TYPE.OVERCOME:
			result_key = "OVERCOME"
		ACTION_TYPE.ADVANTAGE:
			result_key = "ADVANTAGE"
		ACTION_TYPE.ATTACK:
			result_key = "ATTACK"
		ACTION_TYPE.DEFEND:
			result_key = "DEFEND"
	return result_key
	pass

func delete_children(node : Node):
	var all_children = node.get_children()
	for i in all_children:
		i.queue_free()
	pass
