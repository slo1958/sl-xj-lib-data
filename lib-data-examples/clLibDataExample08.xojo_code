#tag Class
Protected Class clLibDataExample08
Inherits clLibDataExample
	#tag Method, Flags = &h0
		Function describe() As string()
		  // Calling the overridden superclass method.
		  Dim returnValue() as string = Super.describe()
		  
		  
		  returnValue.append("- create an empty datatable")
		  returnValue.append("- fast append data")
		  returnValue.append("- apply filter functions to create two dataseries")
		  returnValue.append("- operation on dataseries to create a new dataserie")
		  
		  return returnValue
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function id() As integer
		  // Calling the overridden superclass method.
		  
		  return 8
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function run() As itf_table_reader()
		  
		  //  Example_008
		  //  - create an empty table
		  //  - fast append data
		  //  - apply filter function to create a dataserie 
		  //  
		  
		  System.DebugLog("START "+CurrentMethodName)
		  
		  
		  
		  Dim table0 As New clDataTable("mytable")
		  
		  call table0.add_columns(Array("country","city","sales"))
		  
		  table0.append_row(Array("France","Paris",1100))
		  table0.append_row(Array("France","Marseille",1200))
		  table0.append_row(Array("Belgique","Bruxelles",1300))
		  table0.append_row(Array("USA","NewYork",1400))
		  table0.append_row(Array("Belgique","Bruxelles",1500))
		  table0.append_row(Array("USA","Chicago",1600))
		  
		  dim is_france() as variant = table0.filter_apply_function(AddressOf field_filter,"country","France")
		  dim is_belgium() as variant =  table0.filter_apply_function(AddressOf field_filter, "country","Belgique")
		  dim is_europe() as variant
		  
		  for i as integer = 0 to is_france.Ubound
		    is_europe.Append(is_france(i).integerValue + is_belgium(i).integerValue)
		    
		  next
		  
		  call table0.add_column(new clIntegerDataSerie("is_france"))
		  call table0.add_column(new clIntegerDataSerie("is_belgium"))
		  call table0.add_column(new clIntegerDataSerie("is_europe"))
		  
		  call table0.set_column_values("is_france", is_france, false)
		  call table0.set_column_values("is_belgium", is_belgium, false)
		  call table0.set_column_values("is_europe", is_europe, false)
		  
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
