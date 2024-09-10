#tag Class
Protected Class clLibDataExample_011
Inherits clLibDataExample
	#tag CompatibilityFlags = ( TargetConsole and ( Target32Bit or Target64Bit ) ) or ( TargetWeb and ( Target32Bit or Target64Bit ) ) or ( TargetDesktop and ( Target32Bit or Target64Bit ) ) or ( TargetIOS and ( Target64Bit ) ) or ( TargetAndroid and ( Target64Bit ) )
	#tag Method, Flags = &h0
		Function describe() As string()
		  
		  var returnValue() as string = Super.describe()
		  
		  returnValue.Add("- create a datatable")
		  returnValue.Add("- create a second table with unique values from the first one")
		  
		  return returnValue
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function run(log as LogMessageInterface) As TableColumnReaderInterface()
		  
		  //  Example_011
		  //  - test basic 'unique'
		  //  
		  
		  
		  log.start_exec(CurrentMethodName)
		  
		  var table0 As New clDataTable("mytable")
		  
		  call table0.AddColumns(Array("country","city","sales"))
		  
		  table0.AddRow(Array("France","Paris",1100))
		  table0.AddRow(Array("","Marseille",1200))
		  table0.AddRow(Array("Belgique","",1300))
		  table0.AddRow(Array("France","Paris",2100))
		  table0.AddRow(Array("","Marseille",2200))
		  table0.AddRow(Array("Belgique","",2300))
		  table0.AddRow(Array("USA","NewYork",2400))
		  table0.AddRow(Array("Belgique","Bruxelles",2500))
		  table0.AddRow(Array("USA","Chicago",2600))
		  table0.AddRow(Array("USA","NewYork",1400))
		  table0.AddRow(Array("Belgique","Bruxelles",1500))
		  table0.AddRow(Array("USA","Chicago",1600))
		  
		  
		  var table1 As clDataTable = table0.unique(array("country", "city"))
		  
		  var ret() as TableColumnReaderInterface
		  ret.Add(table0)
		  ret.Add(table1)
		  return ret
		  
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
