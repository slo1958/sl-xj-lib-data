#tag Class
Protected Class clLibDataExample_020
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
		  
		  
		  var c0 as new clDataSerie("Action")
		  var c1 as new clDataSerie("DataSerie")
		  var c2 as new clNumberDataSerie("NumberDataSerie", array(123.45, 123.45, 123.45))
		  var c3 as new clStringDataSerie("StringDataSerie")
		  
		  c0.AddElement("Add 'aaa'")
		  c1.AddElement("aaa")
		  c2.AddElement("aaa")
		  c3.AddElement("aaa")
		  
		  c0.AddElement("Add 123.45")
		  c1.AddElement(123.45)
		  c2.AddElement(123.45)
		  c3.AddElement(123.45)
		  
		  c0.AddElement("Add nil")
		  c1.AddElement(nil)
		  c2.AddElement(nil)
		  c3.AddElement(nil)
		  
		  var ret_tables() as clDataTable
		  
		  for each cc as clAbstractDataSerie in array(c1,c2,c3)
		    
		    var c4 as new clDataSerie("get_element")
		    var c5 as new clDataSerie("ElementIsDefined(")
		    var c6 as new clDataSerie("get_element_as_number")
		    
		    for i as integer = 0 to c1.LastIndex
		      
		      c4.AddElement(cc.GetElement(i))
		      c5.AddElement(str(cc.ElementIsDefined(i)))
		      c6.AddElement(str(c2.GetElementAsNumber(i)))
		      
		    next
		    
		    ret_tables.Add(new clDataTable(cc.name, SerieArray(c0.clone,cc,c4,c5,c6)))
		    
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
