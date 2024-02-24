extends Node
class_name GoldManager

signal gold_value_changed(new_value: int)

var gold_value = 0

func get_value():
	return gold_value;
	
func increase_gold(value: int):
	gold_value += value
	gold_value_changed.emit(gold_value)
	
func decrease_gold(value:int) -> bool:
	if gold_value >= value:
		gold_value -= value		
		gold_value_changed.emit(gold_value)
		return true
		
	return false
