SuperStrict

Rem
	bbdoc: htbaapub.process
EndRem
Module htbaapub.process
ModuleInfo "Name: htbaapub.process"
ModuleInfo "Version: 1.00"
ModuleInfo "Author: Christiaan Kras"
ModuleInfo "Author of C++ code: Mike McShaffry <a href='http://code.google.com/p/gamecode3/'>http://code.google.com/p/gamecode3/</a>"
ModuleInfo "Git repository: <a href='http://github.com/Htbaa/process.mod/'>http://github.com/Htbaa/process.mod/</a>"

Import brl.linkedlist

Rem
	bbdoc: Default process TypeId
End Rem
Const PROC_NONE:Int = 0
Rem
	bbdoc: TypeId for TWaitProcess
End Rem
Const PROC_WAIT:Int = 1

Include "processes.bmx"
Include "process_manager.bmx"