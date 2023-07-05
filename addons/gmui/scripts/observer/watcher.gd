class_name Watcher extends RefCounted

var getter = null
var deps = []
var obj = Object()
var depIds = {}

func _init(getter):
	var watId = Values.watId
	Values.watId += 1
	self.depIds = {}
	self.getter = getter
	self._get_()

func _get_():
	Values.curWatcher = self
	self.getter.call()
	Values.curWatcher = null

func addDep(dep):
	if !depIds.has(dep.id):
		deps.append(dep)
		depIds[dep.id] = obj
		dep.addSub(self)

func update():
	self._get_()
