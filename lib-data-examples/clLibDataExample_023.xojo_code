#tag Class
Protected Class clLibDataExample_023
Inherits clLibDataExample
	#tag CompatibilityFlags = ( TargetConsole and ( Target32Bit or Target64Bit ) ) or ( TargetWeb and ( Target32Bit or Target64Bit ) ) or ( TargetDesktop and ( Target32Bit or Target64Bit ) ) or ( TargetIOS and ( Target64Bit ) ) or ( TargetAndroid and ( Target64Bit ) )
	#tag Method, Flags = &h0
		Function describe() As string()
		  // Calling the overridden superclass method.
		  var returnValue() as string = Super.describe()
		  
		  
		  returnValue.Add("- create an empty datatable")
		  returnValue.Add("- load from a file with same structure")
		  returnValue.Add("- append from a file with same column names in different order")
		  returnValue.Add("- append from a file with different column name + mapping (field 'group' is not mapped)")
		  returnValue.Add("- load files in individual datatable for comparison")
		  
		  return returnValue
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function run(log as LogMessageInterface) As TableColumnReaderInterface()
		  
		  //  Example_023
		  //  - create an empty table
		  //  - fast append data
		  //  - apply filter function to create a dataserie 
		  //  
		  
		  
		  log.start_exec(CurrentMethodName)
		  
		  var fld_folder As New FolderItem
		  var fld_file1 As FolderItem
		  var fld_file2 As FolderItem
		  var fld_file3 As FolderItem
		  
		  fld_folder = fld_folder.Child("test-data")
		  
		  fld_file1 = fld_folder.Child("myfile4_A_tab.txt")
		  fld_file2  = fld_folder.Child("myfile4_B_tab.txt") 
		  fld_file3  = fld_folder.Child("myfile4_C_tab.txt") 
		  
		  var my_table as new clDataTable("consolidated")
		  call my_table.AddColumn(new clStringDataSerie("Alpha"))
		  call my_table.AddColumn(new clIntegerDataSerie("Beta"))
		  call my_table.AddColumn(new clNumberDataSerie("Delta"))
		  call my_table.AddColumn(new clNumberDataSerie("Gamma"))
		  call my_table.AddColumn(new clIntegerDataSerie("Group"))
		  call my_table.AddColumn(new clStringDataSerie(clDataTable.loaded_data_source_column))
		  
		  var dct_mapping_file3 as new Dictionary
		  dct_mapping_file3.value("Un") = "Alpha"
		  dct_mapping_file3.value("Deux") = "Beta"
		  dct_mapping_file3.value("Trois") = "Gamma"
		  dct_mapping_file3.value("Quatre") = "Delta"
		  dct_mapping_file3.value("Extra") = "New_col"
		  
		  var source_table1 as new clDataTable(new clTextReader(fld_file1, True, new clTextFileConfig(chr(9))))
		  var source_table2 as new clDataTable(new clTextReader(fld_file2, True, new clTextFileConfig(chr(9))))
		  var source_table3 as new clDataTable(new clTextReader(fld_file3, True, new clTextFileConfig(chr(9))))
		  
		  my_table.append_rows(new clTextReader(fld_file1, True, new clTextFileConfig(chr(9))))
		  
		  my_table.append_rows(new clTextReader(fld_file2, True, new clTextFileConfig(chr(9))))
		  
		  my_table.append_rows(new clTextReader(fld_file3, True, new clTextFileConfig(chr(9))),dct_mapping_file3)
		  
		  log.end_exec(CurrentMethodName)
		  
		  return array(my_table, source_table1, source_table2, source_table3)
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
