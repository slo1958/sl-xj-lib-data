#tag Class
Protected Class cllibdataexample_18
Inherits clLibDataExample
	#tag CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit)) or  (TargetIOS and (Target64Bit)) or  (TargetAndroid and (Target64Bit))
	#tag Method, Flags = &h0
		Function describe() As string()
		  // Calling the overridden superclass method.
		  Dim returnValue() as string = Super.describe()
		  
		  returnValue.append("- create a  datatable")
		  returnValue.append("- create a view on the table")
		  returnValue.Append("- define display titles")
		  
		  return returnValue 
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function id() As integer
		  // Calling the overridden superclass method.
		  
		  return 18
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function run() As itf_table_column_reader()
		  
		  //  Example_004
		  //  - create a small table
		  //  - create a view on the table
		  //  
		  
		  
		  System.DebugLog("START "+CurrentMethodName)
		  
		  Dim table0 As New clDataTable("mytable without display title", serie_array( _
		  New clDataSerie("City",  "F1","F2","B1","F1","B2","I1") _
		  , New clDataSerie("Country", "FR","FR","BE","FR","BE","IT") _
		  , New clDataSerie("Year", 2000,2000,2000,2000,2000,2000) _
		  , New clDataSerie("Sales", 100,200,300,400,500,600) _
		  , New clDataSerie("Quantity", 51, 52,53,54, 55,56) _
		  ))
		  
		  Dim table1 As New clDataTable("mytable with display titles", serie_array( _
		  New clDataSerie("City",  "F1","F2","B1","F1","B2","I1") _
		  , New clDataSerie("Country", "FR","FR","BE","FR","BE","IT") _
		  , New clDataSerie("Year", 2000,2000,2000,2000,2000,2000) _
		  , New clDataSerie("Sales", 100,200,300,400,500,600) _
		  , New clDataSerie("Quantity", 51, 52,53,54, 55,56) _
		  ))
		  
		  
		  table1.get_column("City").display_title = "Ville"
		  table1.get_column("Country").display_title = "Pays"
		  table1.get_column("Year").display_title = "Année"
		  table1.get_column("Sales").display_title="Ventes"
		  table1.get_column("Quantity").display_title="Volume"
		  
		  
		  Dim view0 As clDataTable = table0.select_columns(array("Country", "City", "Sales"))
		  
		  Dim view1 As clDataTable = table1.select_columns(array("Country", "City", "Sales"))
		  
		  return array(table0, table1, view0, view1)
		  
		  
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
