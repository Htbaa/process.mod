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

SuperStrict

Rem
	bbdoc: htbaapub.process
EndRem
Module htbaapub.process
ModuleInfo "Name: htbaapub.process"
ModuleInfo "Version: 1.01"
ModuleInfo "License: MIT"
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