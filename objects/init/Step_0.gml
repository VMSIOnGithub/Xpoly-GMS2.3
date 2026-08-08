/// @description Insert description here
// You can write your code in this editor
if(keyboard_check_pressed(ord("Q"))){
	debug_logger_toggle()
	debug_logger_push("[User] poped Logger at " + date_time_string(date_current_datetime()))
}