#tag Class
Protected Class clLibDataExample_018
Inherits clLibDataExample
	#tag CompatibilityFlags = ( TargetConsole and ( Target32Bit or Target64Bit ) ) or ( TargetWeb and ( Target32Bit or Target64Bit ) ) or ( TargetDesktop and ( Target32Bit or Target64Bit ) ) or ( TargetIOS and ( Target64Bit ) ) or ( TargetAndroid and ( Target64Bit ) )
	#tag Method, Flags = &h0
		Function describe() As string()
		  // Calling the overridden superclass method.
		  var returnValue() as string = Super.describe()
		  
		  returnValue.Add("- create a  datatable")
		  returnValue.Add("- define display titles")
		  returnValue.Add("- create a table with the structure of the first table")
		  
		  return returnValue 
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function run(log as LogMessageInterface) As TableColumnReaderInterface()
		  
		  
		  log.start_exec(CurrentMethodName)
		  
		  var dct as Dictionary
		  
		  dct = new Dictionary
		  dct.value("Country") = array("France", "", "Belgique", "France", "USA")
		  dct.Value("City") = array("Paris", "Marseille", "Bruxelles", "Lille", "Chicago")
		  dct.Value("Sales") = array(900.0, 1200.0, 1400.0, 1600.0, 2900)
		  
		  var table0 As New clDataTable("mytable", dct ,AddressOf alloc_series_019)
		  
		  table0.GetColumn("City").DisplayTitle = "Ville"
		  table0.GetColumn("Country").DisplayTitle = "Pays"
		  table0.GetColumn("Sales").DisplayTitle="Ventes" 
		  
		  var struc0 as clDataTable = table0.GetStructureAsTable
		  var prop0 as clDataTable = table0.GetPropertiesAsTable
		  
		  return array(table0, struc0, prop0)
		  
		  
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
