#tag Class
Protected Class clLibDataExample_025
Inherits clLibDataExample
	#tag CompatibilityFlags = ( TargetConsole and ( Target32Bit or Target64Bit ) ) or ( TargetWeb and ( Target32Bit or Target64Bit ) ) or ( TargetDesktop and ( Target32Bit or Target64Bit ) ) or ( TargetIOS and ( Target64Bit ) ) or ( TargetAndroid and ( Target64Bit ) )
	#tag Method, Flags = &h0
		Function describe() As string()
		  // Calling the overridden superclass method.
		  var returnValue() as string = Super.describe()
		  
		  
		  returnValue.Add("- create an empty datatable")
		  returnValue.Add("- apply filter functions to create two dataseries")
		  returnValue.Add("- operation on dataseries to create a new dataserie")
		  returnValue.Add("- customise formatting of boolean values")
		  returnValue.Add("- range formatting for number values, using another table")
		  
		  return returnValue
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function run(log as LogMessageInterface) As TableColumnReaderInterface()
		  
		  //  Example_025
		  //  - create an empty table
		  //  - fast append data
		  //  - apply filter function to create a dataserie 
		  //  
		  
		  
		  log.start_exec(CurrentMethodName)
		  
		  var c1 as new clStringDataSerie("Alpha")
		  
		  var baselist() as string = array(".123","123", "12.3", "1,23.4","1.23,4", "1,234,56.7")
		  
		  for each base as string in baselist
		    c1.AddElement(base)
		    c1.AddElement(base+"-")
		    c1.AddElement(base+"+")
		    c1.AddElement("-"+base)
		    c1.AddElement("+"+base)
		    
		  next
		  
		  c1.SetNumberParser(new clNumberParser)
		  var c2 as clNumberDataSerie = c1.ToNumber()
		  c2.Rename("C2")
		  var expected_c2 as  new clNumberDataSerie("Expected C2", array(0.123, -0.123, 0.123, -0.123, 0.123, 123.0, -123.0, 123.0, -123.0, 123.0, 12.3, -12.3, 12.3, -12.3, 12.3, 123.4, -123.4,123.4,-123.4,123.4, 0,0,0,0,0,123456.7,-123456.7,123456.7,-123456.7,123456.7))
		  
		  c1.SetNumberParser(new clNumberLocalParser)
		  var c3 as clNumberDataSerie = c1.ToNumber()
		  c3.Rename("C3")
		  var expected_c3 as new clNumberDataSerie("Expected C3", array(123.0, 123.0, 123.0, 123.0, 123.0, 123.0, 123.0, 123.0, 123.0, 123.0, 123.0, 123.0, 123.0, 123.0, 123.0, 0.0, 0.0, 0.0, 0.0, 0.0, 123.4, 123.4, 123.4, 123.4, 123.4, 0.0, 0.0, 0.0, 0.0, 0.0))
		  
		  var table0 as new clDataTable("Example", SerieArray(c1, c2, expected_c2, c3, expected_c3))
		  
		   
		  return array(table0)
		  
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
