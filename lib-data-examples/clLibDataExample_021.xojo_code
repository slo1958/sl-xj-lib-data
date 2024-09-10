#tag Class
Protected Class clLibDataExample_021
Inherits clLibDataExample
	#tag CompatibilityFlags = ( TargetConsole and ( Target32Bit or Target64Bit ) ) or ( TargetWeb and ( Target32Bit or Target64Bit ) ) or ( TargetDesktop and ( Target32Bit or Target64Bit ) ) or ( TargetIOS and ( Target64Bit ) ) or ( TargetAndroid and ( Target64Bit ) )
	#tag Method, Flags = &h0
		Function describe() As string()
		  // Calling the overridden superclass method.
		  var returnValue() as string = Super.describe()
		  
		  returnValue.Add("- add a DataSerie, a NumberDataSerie, a StringDataSerie")
		  returnValue.Add("- for each serie, add a string, a number, a 'nil' value")
		  returnValue.Add("- check values returned by get_element, get_element_as_number, is_defined")
		  
		  return returnValue 
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function run(log as LogMessageInterface) As TableColumnReaderInterface()
		  
		  log.start_exec(CurrentMethodName)
		  
		  var c1 as new clDataSerie("DataSerie")
		  var c2 as new clNumberDataSerie("NumberDataSerie")
		  var c3 as new clStringDataSerie("StringDataSerie")
		  var c4 as new clIntegerDataSerie("IntegerDataSerie")
		  
		  var series() as clAbstractDataSerie = serie_array(c1, c2, c3, c4)
		  
		  for each cc as clAbstractDataSerie in series
		    cc.AddElement("aaa")
		    cc.AddElement(100)
		    cc.AddElement(119)
		    cc.AddElement(120)
		    cc.AddElement(nil)
		    cc.AddElement(0)
		    
		  next
		  
		  var ret_tables() as clDataTable 
		  
		  var data_table as new clDataTable("data", series)
		  var stat_table as clDataTable = data_table.get_statistics_as_table
		  var struc_table as clDataTable = data_table.get_structure_as_table
		  
		  call stat_table.get_column(clDataTable.statistics_average_column).round_values(2)
		  
		  ret_tables.Add(data_table)
		  ret_tables.add(stat_table)
		  ret_tables.Add(struc_table)
		  
		  return ret_tables
		  
		  
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
