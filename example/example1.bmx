Import htbaapub.process

'Our own process identifiers
Const PROC_TEST1:Int = 2
Const PROC_TEST2:Int = 3

'A process that says Ladida! and then kills itself
Type TTestProc1 Extends TProc
	Method OnUpdate(deltaTicks:Double)
		Super.OnUpdate(deltaTicks)
		Print "Ladida!"
		Self.Kill()
	End Method
End Type

'A process that says Shalala! and then kills itself
Type TTestProc2 Extends TProc
	Method OnUpdate(deltaTicks:Double)
		Super.OnUpdate(deltaTicks)
		Print "Shalala!"
		Self.Kill()
	End Method
End Type

'Create a process manager
Local pm:TProcessManager = New TProcessManager
'Create several process
Local p1:TTestProc1 = TTestProc1(New TTestProc1.Create(PROC_TEST1))
Local p2:TTestProc1 = TTestProc1(New TTestProc1.Create(PROC_TEST1))
Local p3:TTestProc2 = TTestProc2(New TTestProc2.Create(PROC_TEST2))
Local p4:TTestProc2 = TTestProc2(New TTestProc2.Create(PROC_TEST2))
Local p5:TTestProc2 = TTestProc2(New TTestProc2.Create(PROC_TEST2))
'This process can be used to create a delay between process execution
Local p6:TWaitProc = New TWaitProc
p6.SetWait(5000) 'Wait for 5 seconds - Please note that due to not using delta timing in this example the duration will take longer

'Attach p1 and p2 to the process manager
pm.Attach(p1)
pm.Attach(p2)

'Now it's time to chain some processes
'This says: After p1, execute p6. After p6 execute p5
p1.SetNext(p6).SetNext(p5)
'This says: After p2, execute p4. After p4, execute p3
p2.SetNext(p4).SetNext(p3)

'Our main loop
While True
	'Use proper deltatiming here. I've left it out to keep this example simple
	Delay(1000)
	'Update all processes
	pm.UpdateProcesses(1000)
	'If no process exists anymore it's time to kill the loop
	If Not pm.HasProcesses()
		Exit
	End If
Wend