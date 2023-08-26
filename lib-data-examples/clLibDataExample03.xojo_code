#tag Class
Protected Class clLibDataExample03
Inherits clLibDataExample
	#tag Method, Flags = &h0
		Function describe() As string()
		  // Calling the overridden superclass method.
		  Dim returnValue() as string = Super.describe()
		  
		  returnValue.append("- create two datatables")
		  returnValue.append("- concatentate the tables")
		  
		  return returnValue
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function id() As integer
		  // Calling the overridden superclass method.
		  
		  return 3
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function run() As itf_table_reader()
		  '
		  ' Example 003
		  '
		  
		  System.DebugLog("START "+CurrentMethodName)
		  
		  
		  Dim table1 As New clDataTable("mytable1", serie_array( _
		  New clDataSerie("aaa",  123, 456, 789) _
		  , New clDataSerie("bbb",  "abc", "def","ghi") _
		  , New clDataSerie("ccc",  123.4,234.5,345.6) _
		  ))
		  
		  Dim table2 As New clDataTable("mytable2", serie_array( _
		  New clDataSerie("aaa",  123, 456, 789) _
		  , New clDataSerie("bbb",  "abc", "def","ghi") _
		  , New clDataSerie("zzz",  987.6,876.5, 765.4) _
		  ))
		  
		  dim table3 as clDataTable = table1.clone
		  
		  table3.append_rows_from_table(table2)
		  
		  return array (table1, table2, table3)
		  
		End Function
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
