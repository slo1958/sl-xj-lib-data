#tag Class
Protected Class App
Inherits DesktopApplication
	#tag Event
		Sub Opening()
		  
		  self.testOnOpen
		  
		  Return
		  
		  
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Function PairToString(p as pair) As string
		  return p.Left.StringValue + ":" + p.Right.StringValue
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestDataChunk()
		  
		  const kSize as integer = 10000
		  const kLimit as integer = 10000000
		  
		  // basic case, data chunk without pre-allocation and can grow
		  var lg as new clLogManager
		  
		  var v1 as new clBaseDataChunkManager(addressof clIntegerDataChunk.Allocator, new clDataChunkManagerPolicy(kSize, clDataChunkManagerPolicy.mode.StaticAllocation))
		  var v2 as new clBaseDataChunkManager(addressof clIntegerDataChunk.Allocator, new clDataChunkManagerPolicy(kSize, clDataChunkManagerPolicy.mode.DynamicAllocation))
		  var v3() as integer
		  var c as clIntegerDataChunk
		  
		  
		  lg.StartTask("v3-array")
		  
		  for i as integer = 0 to kLimit
		    v3.Add(2*i)
		    
		  next
		  
		  lg.EndTaskAll()
		  
		  lg.StartTask("v1-static")
		  
		  for i as integer = 0 to kLimit
		    c = clIntegerDataChunk(v1.GetChunkWithFreeSpace)
		    
		    if c.canAddElement then call c.AddElement(2*i)
		    
		  next
		  
		  lg.EndTaskAll()
		  // 
		  // lg.StartTask("v2-dynamic")
		  // 
		  // for i as integer = 0 to kLimit
		  // c = clIntegerDataChunk(v2.GetChunkWithFreeSpace)
		  // 
		  // if c.canAddElement then call c.AddElement(2*i)
		  // 
		  // next
		  // 
		  // lg.EndTaskAll()
		  // 
		  
		  
		  v1.SummaryToLog(lg)
		  
		  system.DebugLog(v1.RowCount.ToString)
		  
		  system.DebugLog(v2.RowCount.ToString)
		  
		  
		   
		  
		  Return
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestDataChunkk()
		  
		  // basic case, data chunk without pre-allocation and can grow
		  var v1 as new clBaseDataChunkManager(addressof clIntegerDataChunk.Allocator, new clDataChunkManagerPolicy(5, clDataChunkManagerPolicy.mode.StaticAllocation))
		  var v2 as new clBaseDataChunkManager(addressof clIntegerDataChunk.Allocator, new clDataChunkManagerPolicy(6, clDataChunkManagerPolicy.mode.DynamicAllocation))
		  
		  var cnt1a as integer = v1.RowCount
		  var cnt2a as integer = v2.RowCount
		  
		  var c as clIntegerDataChunk
		  
		  for i as integer = 0 to 11
		    c = clIntegerDataChunk(v1.GetChunkWithFreeSpace)
		    
		    if c.canAddElement then call c.AddElement(12300+i)
		    
		    c = clIntegerDataChunk(v2.GetChunkWithFreeSpace)
		    
		    if c.canAddElement then call c.AddElement(12300+i)
		    
		  next
		  
		  var cnt1b as integer = v1.RowCount
		  var cnt2b as integer = v2.RowCount
		  
		  for i as integer = 0 to 12
		    var p1 as pair = v1.GetElementLocation(i)
		    
		    var p2 as pair = v2.GetElementLocation(i)
		    
		    System.DebugLog(str(i)+ "  " + PairToString(p1) + "   " + PairToString(p2))
		  next
		  
		  
		  Return
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub testOnOpen()
		  
		  
		  
		  
		  var testno as integer = 2
		  
		  select case testno
		    
		  case 1
		    var ct1 as new clDataTable("alpha", array("alpha","beta"))
		    
		    var ts as new clTableStructure(ct1, clTableStructure.Mode.ExtractStructure)
		    
		    var ct2 as clDataTable = ts
		    
		    var ct3 as new clDataTable("mytable", ts)
		    
		    
		    return
		    
		  case 2
		    TestDataChunk
		    
		  case else
		    // do not stop if nothing to see
		    return
		    
		  end select
		  
		  Return
		  
		End Sub
	#tag EndMethod


	#tag Note, Name = Integration with your project
		How to add the library to your project ?
		
		- copy the 'lib-data' folder  
		- paste to your project (this will copy all relevant components)
		
		
		If you want to use the user interface components (table viewer window, data pool viewer container control,..)
		
		- copy the 'lib-data-ui-support' folder 
		- paste to your project.
		
		
	#tag EndNote

	#tag Note, Name = License
		MIT License
		
		sl-xj-lib-data Data Handling Library
		Copyright (c) 2021-2025 slo1958
		
		Permission is hereby granted, free of charge, to any person obtaining a copy
		of this software and associated documentation files (the "Software"), to deal
		in the Software without restriction, including without limitation the rights
		to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
		copies of the Software, and to permit persons to whom the Software is
		furnished to do so, subject to the following conditions:
		
		The above copyright notice and this permission notice shall be included in all
		copies or substantial portions of the Software.
		
		THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
		IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
		FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
		AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
		LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
		OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
		SOFTWARE.
		
		
	#tag EndNote


	#tag Constant, Name = kEditClear, Type = String, Dynamic = False, Default = \"&Delete", Scope = Public
		#Tag Instance, Platform = Windows, Language = Default, Definition  = \"&Delete"
		#Tag Instance, Platform = Linux, Language = Default, Definition  = \"&Delete"
	#tag EndConstant

	#tag Constant, Name = kFileQuit, Type = String, Dynamic = False, Default = \"&Quit", Scope = Public
		#Tag Instance, Platform = Windows, Language = Default, Definition  = \"E&xit"
	#tag EndConstant

	#tag Constant, Name = kFileQuitShortcut, Type = String, Dynamic = False, Default = \"", Scope = Public
		#Tag Instance, Platform = Mac OS, Language = Default, Definition  = \"Cmd+Q"
		#Tag Instance, Platform = Linux, Language = Default, Definition  = \"Ctrl+Q"
	#tag EndConstant


	#tag ViewBehavior
		#tag ViewProperty
			Name="ProcessID"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=false
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=false
			Group="ID"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=false
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=false
			Group="Position"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=false
			Group="Position"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowAutoQuit"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowHiDPI"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="BugVersion"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Copyright"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Description"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LastWindowIndex"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="MajorVersion"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="MinorVersion"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="NonReleaseVersion"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="RegionCode"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="StageCode"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Version"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="_CurrentEventTime"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
