Rem
	bbdoc:
End Rem
Type TProcessManager
	Field processList:TList
	
	Rem
		bbdoc:
	End Rem
	Method New()
		Self.processList = New TList
	End Method

	Rem
		bbdoc: run through the list of processes and detach them
	End Rem
	Method Destroy()
		For Local process:TProc = EachIn Self.processList
			Self.Detach(process)
		Next
		Self.processList.Clear()
	End Method
	
	Rem
		bbdoc: run through the list of processes and update them
	End Rem
	Method UpdateProcesses(deltaTicks:Double)
		For Local process:TProc = EachIn Self.processList
			If process.IsDead()
				Local pNext:TProc = process.GetNext()
				If pNext
					process.SetNext(Null)
					Self.Attach(pNext)
				End If
				Self.Detach(process)
			Else If process.IsActive() And Not process.IsPaused()
				process.OnUpdate(deltaTicks)
			End If
		Next
	End Method
	
	Rem
		bbdoc: Are there any active processes of this type?
	End Rem
	Method IsProcessActive:Byte(typeId:Int)
		For Local process:TProc = EachIn Self.processList
			'Check for living processes. If they are dead, make sure no children
			'are attached as they will be brought to life on next cycle.
			If process.GetTypeId() = typeId And (process.IsDead() Or process.GetNext() <> Null)
				Return True
			End If
		Next
		Return False
	End Method
	
	Rem
		bbdoc: gets a process to run
	End Rem
	Method Attach(process:TProc)
		Self.processList.AddLast(process)
		process.SetAttached(True)
	End Method
	
	Rem
		bbdoc: Are there any processes at all?
	End Rem
	Method HasProcesses:Byte()
		If Self.processList.Count() > 0 Then Return True
		Return False
	End Method
	
	Rem
		bbdoc: Detach a process from the process list, but don't delete it
	End Rem
	Method Detach(process:TProc)
		Self.processList.Remove(process)
		process.SetAttached(False)
	End Method
End Type