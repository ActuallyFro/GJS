#https://godotengine.org/article/godot-web-progress-report-9
extends Node
var _permission_callback = JavaScript.create_callback(self, "_on_permissions")

func _ready():
	# Retrieve the `window.console` object.
	var console = JavaScript.get_interface("console")
	# Call the `window.console.log()` method.
	console.log("test")

	# Call the JavaScript `new` operator on the `window.Array` object.
	# Passing 10 as argument to the constructor:
	# JS: `new Array(10);`
	var arr = JavaScript.create_object("Array", 10)
	# Set the first element of the JavaScript array to the number 42.
	arr[0] = 42
	# Call the `pop` function on the JavaScript array.
	arr.pop()
	# Print the value of the `length` property of the array (9 after the pop).
	print(arr.length)

	# Get the `window.Notification` JavaScript object.
	var notification = JavaScript.get_interface("Notification")
	# Call the `window.Notification.requestPermission` method which returns a JavaScript
	# Promise, and bind our callback to it.
	notification.requestPermission().then(_permission_callback)

func _on_permissions(args):
	# The first argument of this callback is the string "granted" if the permission is granted.
	var permission = args[0]
	if permission == "granted":
		print("Permission granted, sending notification.")
		# Create the notification: `new Notification("Hi there!")`
		JavaScript.create_object("Notification", "Hi there!")
	else:
		print("No notification permission.")
