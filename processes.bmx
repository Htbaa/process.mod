Rem
	bbdoc: Process base type
End Rem
Type TProc
	Field typeId:Int = PROC_NONE
	Field killed:Byte
	Field active:Byte
	Field paused:Byte
	Field initialUpdate:Byte
	Field nextProcess:TProc
	Field processFlags:Int
	
	Const PROCESS_FLAG_ATTACHED:Int = %00000001
	
	Rem
		bbdoc: Constructor
	End Rem
	Method New()
		Self.killed = False
		Self.active = True
		Self.paused = False
		Self.initialUpdate = True
	End Method
	
	Rem
		bbdoc: Helper method to allow for setting the TypeId when creating the process
	End Rem
	Method Create:TProc(typeId:Int)
		Self.typeId = typeId
		Return Self
	End Method
	
	Rem
		bbdoc: Check if process has been marked as dead
	End Rem
	Method IsDead:Byte()
		Return Self.killed
	End Method
	
	Rem
		bbdoc: Retrieve process' TypeId
	End Rem
	Method GetTypeId:Int()
		Return Self.typeId
	End Method
	
	Rem
		bbdoc: Set process' TypeId
	End Rem
	Method SetTypeId(typeId:Int)
		Self.typeId = typeId
	End Method
	
	Rem
		bbdoc: Check if process is active
	End Rem
	Method IsActive:Byte()
		Return Self.active
	End Method
	
	Rem
		bbdoc: Activate or Deactivate a process
	End Rem
	Method SetActive(active:Byte)
		Self.active = active
	End Method
	
	Rem
		bbdoc: Is this process attached to the manager?
	End Rem
	Method IsAttached:Byte()
		Return Self.processFlags & PROCESS_FLAG_ATTACHED
	End Method
	
	Rem
		bbdoc: Marks it as attached. Called only by the manager
	End Rem
	Method SetAttached(wantAttached:Byte)
		If wantAttached
			Self.processFlags:|PROCESS_FLAG_ATTACHED
		Else
			'm_uProcessFlags &= ~PROCESS_FLAG_ATTACHED ??
			Self.processFlags:~PROCESS_FLAG_ATTACHED
		End If
	End Method
	
	Rem
		bbdoc: Check if process is paused
	End Rem
	Method IsPaused:Byte()
		Return Self.paused
	End Method
	
	Rem
		bbdoc: Check if process has been initialized
	End Rem
	Method IsInitialized:Byte()
		Return Not Self.initialUpdate
	End Method
	
	Rem
		bbdoc: Return process that will be executed after this one
	End Rem
	Method GetNext:TProc()
		Return Self.nextProcess
	End Method
	
	Rem
		bbdoc: Sets a process dependancy
		about: Means that nextProcess will wait to execute until the parent process is done
	End Rem
	Method SetNext:TProc(nextProcess:TProc)
		Self.nextProcess = nextProcess
		Return nextProcess
	End Method
	
	Rem
		bbdoc: Marks the process for cleanup
	End Rem
	Method Kill()
		Self.killed = True
	End Method
	
	Rem
		bbdoc: Pause execution of process
	End Rem
	Method TogglePause()
		Self.paused = Not Self.paused
	End Method
	
	Rem
		bbdoc: Any initialization code can go here
	End Rem
	Method OnInitialize()
	End Method
	
	Rem
		bbdoc: Update process
	End Rem
	Method OnUpdate(deltaTicks:Double)
		If Self.initialUpdate
			Self.OnInitialize()
			Self.initialUpdate = False
		End If
	End Method
End Type


Rem
	bbdoc: A process that does nothing but waiting
End Rem
Type TWaitProc Extends TProc
	Field start:Int
	Field stop:Int

	Rem
		bbdoc: Constructor
	End Rem
	Method New()
		Self.typeId = PROC_WAIT
		Self.start = 0
		Self.stop = 0
	End Method

	Rem
		bbdoc: Set time to wait
		about: When used with deltatiming set this value in milliseconds
	End Rem	
	Method SetWait(time:Int)
		Self.stop = time
	End Method

	Rem
		bbdoc: Update process
		about: After the set time has passed this process will kill itself
	End Rem
	Method OnUpdate(deltaTicks:Double)
		Super.OnUpdate(deltaTicks)
		If Self.IsActive()
			Self.start:+deltaTicks
			If Self.start >= Self.stop
				Self.Kill()
			End If
		End If
	End Method
End Type
