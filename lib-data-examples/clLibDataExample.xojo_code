#tag Class
Protected Class clLibDataExample
Implements support_tests.LogMessageInterface
	#tag Method, Flags = &h0
		Function describe() As string()
		  var tmp() as string
		  
		  tmp.append("Example _"  + format(self.id, "000"))
		  
		  return tmp
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub end_exec(method as string)
		  WriteMessage("Done with " + method)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function get_all_examples() As clLibDataExample()
		  var ex() as clLibDataExample
		  
		  ex.Add(new clLibDataExample_001)
		  ex.Add(new clLibDataExample_002)
		  ex.Add(new clLibDataExample_003)
		  ex.Add(new clLibDataExample_004)
		  ex.Add(new clLibDataExample_005)
		  ex.Add(new clLibDataExample_006)
		  ex.Add(new clLibDataExample_007)
		  ex.Add(new clLibDataExample_008)
		  ex.Add(new clLibDataExample_009)
		  ex.Add(new clLibDataExample_010)
		  ex.Add(new clLibDataExample_011)
		  ex.Add(new clLibDataExample_012)
		  ex.Add(new clLibDataExample_014)
		  ex.Add(new clLibDataExample_015)
		  ex.Add(new clLibDataExample_016)
		  ex.Add(new clLibDataExample_017)
		  ex.Add(new clLibDataExample_018)
		  ex.Add(new clLibDataExample_019)
		  ex.Add(new clLibDataExample_020)
		  ex.Add(new clLibDataExample_021)
		  ex.Add(new clLibDataExample_022)
		  ex.Add(new clLibDataExample_023)
		  ex.Add(new clLibDataExample_024)
		  ex.Add(new clLibDataExample_025)
		  ex.Add(new clLibDataExample_026)
		  ex.Add(new clLibDataExample_027)
		  ex.Add(new clLibDataExample_028)
		  ex.Add(new clLibDataExample_029)
		  ex.Add(new clLibDataExample_030)
		  
		  return ex
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function id() As integer
		  
		  Var t As Introspection.TypeInfo
		  t = Introspection.GetType(self)
		  
		  return  val(t.Name.Right(3)) 
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function name() As string
		  
		  Var t As Introspection.TypeInfo
		  t = Introspection.GetType(self)
		  
		  return  t.name
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function run(log as LogMessageInterface) As TableColumnReaderInterface()
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub start_exec(method as string)
		  WriteMessage("Starting " + method)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub WriteMessage(msg as string)
		  // Part of the support_tests.LogMessageInterface interface.
		  
		  System.DebugLog(msg)
		  
		End Sub
	#tag EndMethod


	#tag ViewBehavior
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
