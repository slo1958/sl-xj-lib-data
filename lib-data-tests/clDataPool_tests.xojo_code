#tag Module
Protected Module clDataPool_tests
	#tag Method, Flags = &h0
		Sub tests()
		  
		  System.DebugLog("START "+CurrentMethodName)
		  
		  test_001
		  test_002
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_001()
		  
		  dim my_data_pool as new clDataPool
		  
		  dim rtst As clDataRow
		  
		  Dim table as clDataTable
		  
		  table =  New clDataTable("T1")
		  for i as integer = 1 to 4
		    rtst = New clDataRow
		    rtst.set_cell("aaa",I*1000)
		    rtst.set_cell("bbb","abcd")
		    rtst.set_cell("ccc",123.456)
		    
		    table.append_row(rtst)
		    
		  next
		  
		  my_data_pool.set_table( table, "table_1")
		  
		  
		  table =  New clDataTable("T2")
		  for i as integer = 5 to 9
		    rtst = New clDataRow
		    rtst.set_cell("aaa",I*1000)
		    rtst.set_cell("bbb","xyz")
		    rtst.set_cell("ddd",567.89)
		    
		    table.append_row(rtst)
		    
		  next
		  
		  my_data_pool.set_table(table)
		  
		  
		  my_data_pool.set_table(my_data_pool.get_table("table_1").clone(), "res")
		  
		  my_data_pool.get_table("res").append_rows_from_table(my_data_pool.get_table("T2"))
		  
		  
		  System.DebugLog("Expecting aaa/bbb/ccc/ddd")
		  my_data_pool.get_table("res").debug_dump
		  
		  
		  Dim k As Integer = 1
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_002()
		  //  
		  //  Test simplified interface to tables in data pool
		  //  
		  //  
		  dim my_data_pool as new clDataPool
		  
		  dim rtst As clDataRow
		  
		  Dim table as clDataTable
		  
		  table =  New clDataTable("T1")
		  for i as integer = 1 to 4
		    rtst = New clDataRow
		    rtst.set_cell("aaa",I*1000)
		    rtst.set_cell("bbb","abcd")
		    rtst.set_cell("ccc",123.456)
		    
		    table.append_row(rtst)
		    
		  next
		  
		  my_data_pool.table("table_1") = table
		  
		  
		  table =  New clDataTable("T2")
		  for i as integer = 5 to 9
		    rtst = New clDataRow
		    rtst.set_cell("aaa",I*1000)
		    rtst.set_cell("bbb","xyz")
		    rtst.set_cell("ddd",567.89)
		    
		    table.append_row(rtst)
		    
		  next
		  
		  my_data_pool.table = table
		  
		  
		  my_data_pool.table("res") = my_data_pool.table("table_1").clone()
		  
		  my_data_pool.table("res").append_rows_from_table(my_data_pool.table("T2"))
		  
		  
		  System.DebugLog("Expecting aaa/bbb/ccc/ddd")
		  my_data_pool.table("res").debug_dump
		  
		  
		  Dim k As Integer = 1
		  
		End Sub
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
End Module
#tag EndModule
