Rem
	Copyright (c) 2010 Christiaan Kras
	
	Permission is hereby granted, free of charge, to any person obtaining a copy
	of this software and associated documentation files (the "Software"), to deal
	in the Software without restriction, including without limitation the rights
	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
	copies of the Software, and to permit persons to whom the Software is
	furnished to do so, subject to the following conditions:
	
	The above copyright notice and this permission notice shall be included in
	all copies or substantial portions of the Software.
	
	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
	THE SOFTWARE.
End Rem

Rem
	bbdoc: Process manager
End Rem
Type TProcessManager
	Field processList:TList
	
	Rem
		bbdoc: Constructor
	End Rem
	Method New()
		Self.processList = New TList
	End Method

	Rem
		bbdoc: Run through the list of processes and detach them
	End Rem
	Method Destroy()
		For Local process:TProc = EachIn Self.processList
			Self.Detach(process)
		Next
		Self.processList.Clear()
	End Method
	
	Rem
		bbdoc: Run through the list of processes and update them
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
		bbdoc: Gets a process to run
		about: Attaches a process to the process manager so it gets executed
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