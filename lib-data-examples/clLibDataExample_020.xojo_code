#tag Class
Protected Class clLibDataExample_020
Inherits clLibDataExample
	#tag CompatibilityFlags = ( TargetConsole and ( Target32Bit or Target64Bit ) ) or ( TargetWeb and ( Target32Bit or Target64Bit ) ) or ( TargetDesktop and ( Target32Bit or Target64Bit ) ) or ( TargetIOS and ( Target64Bit ) ) or ( TargetAndroid and ( Target64Bit ) )
	#tag Method, Flags = &h0
		Function describe() As string()
		  // Calling the overridden superclass method.
		  Dim returnValue() as string = Super.describe()
		  
		  returnValue.Add("- add a DataSerie, a NumberDataSerie, a StringDataSerie")
		  returnValue.Add("- for each serie, add a string, a number, a 'nil' value")
		  returnValue.Add("- check values returned by get_element, get_element_as_number, is_defined")
		  
		  return returnValue 
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function run(log as itf_logmessage_writer) As itf_table_column_reader()
		  
		  log.start_exec(CurrentMethodName)
		  
		  
		  dim c0 as new clDataSerie("Action")
		  dim c1 as new clDataSerie("DataSerie")
		  dim c2 as new clNumberDataSerie("NumberDataSerie", array(123.45, 123.45, 123.45))
		  dim c3 as new clStringDataSerie("StringDataSerie")
		  
		  c0.append_element("Add 'aaa'")
		  c1.append_element("aaa")
		  c2.append_element("aaa")
		  c3.append_element("aaa")
		  
		  c0.append_element("Add 123.45")
		  c1.append_element(123.45)
		  c2.append_element(123.45)
		  c3.append_element(123.45)
		  
		  c0.append_element("Add nil")
		  c1.append_element(nil)
		  c2.append_element(nil)
		  c3.append_element(nil)
		  
		  dim ret_tables() as clDataTable
		  
		  for each cc as clAbstractDataSerie in array(c1,c2,c3)
		    
		    dim c4 as new clDataSerie("get_element")
		    dim c5 as new clDataSerie("element_is_defined")
		    dim c6 as new clDataSerie("get_element_as_number")
		    
		    for i as integer = 0 to c1.upper_bound
		      
		      c4.append_element(cc.get_element(i))
		      c5.append_element(str(cc.element_is_defined(i)))
		      c6.append_element(str(c2.get_element_as_number(i)))
		      
		    next
		    
		    ret_tables.Add(new clDataTable(cc.name, serie_array(c0.clone,cc,c4,c5,c6)))
		    
		  next
		  
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
