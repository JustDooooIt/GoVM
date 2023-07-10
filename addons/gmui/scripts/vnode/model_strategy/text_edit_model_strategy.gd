class_name TextEditModelStrategy extends RefCounted

var rnode:TextEdit
var vnode:VNode

func _init(rnode, vnode):
	self.rnode = rnode
	self.vnode = vnode
	
func operate():
	if vnode.model != null:
		var gmui:GMUI = vnode.gmui
		var model:Model = vnode.model
		rnode.set('text', gmui.data.rget(model.name))
		rnode.text_changed.connect(
			func(value):
				gmui.data.rset(vnode.model.name, value, true, true)
		)
		gmui.data.setted.connect(
			func(key, value, oldValue): 
				if key == vnode.model.name:
					gmui.data.emit_signal('watch', key, value, oldValue)
					rnode.text = value
					var col = value.length()
					var row = value.count('\n')
					rnode.set_caret_column(col)
					rnode.set_caret_line(row)
		)
