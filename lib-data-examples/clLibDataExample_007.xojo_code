#tag Class
Protected Class clLibDataExample_007
Inherits clLibDataExample
	#tag CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit)) or  (TargetIOS and (Target64Bit)) or  (TargetAndroid and (Target64Bit))
	#tag Method, Flags = &h0
		Function describe() As string()
		  // Calling the overridden superclass method.
		  Dim returnValue() as string = Super.describe()
		  
		  returnValue.Add("- create an empty datatable")
		  returnValue.Add("- fast append data")
		  returnValue.Add("- create a dataserie  by applying a simple operation between columns")
		  returnValue.add(" - show behviour with and without explicit name for the new column")
		  
		  return returnValue 
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function run(log as LogMessageInterface) As TableColumnReaderInterface()
		  
		  //  Example_007
		  //  - create an empty table
		  //  - fast append data
		  //  - create a dataserie  by applying a simple operation between columns
		  //  
		  
		  
		  
		  log.start_exec(CurrentMethodName)
		  
		  
		  Dim table0 As New clDataTable("mytable")
		  
		  
		  call table0.add_column(new clDataSerie("name"))
		  call table0.add_column(new clNumberDataSerie("quantity"))
		  call table0.add_column(new clNumberDataSerie("unit_price"))
		  
		  table0.append_row(Array("alpha",50, 6.5))
		  table0.append_row(Array("beta", 20, 18))
		  table0.append_row(Array("gamma", 10, 50))
		  
		  
		  dim s1 as clAbstractDataSerie = table0.add_column(table0.get_number_column("unit_price") * table0.get_number_column("quantity")).rename("sales")
		  
		  dim s2 as clAbstractDataSerie = table0.add_column(clNumberDataSerie(table0.get_column("unit_price")) * clNumberDataSerie(table0.get_column("quantity")))
		  return Array(table0)
		  
		  
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
