#tag Module
Protected Module clDataPool_tests
	#tag Method, Flags = &h0
		Sub tests(log as LogMessageInterface)
		  
		  dim logwriter as  LogMessageInterface = log 
		  
		  if log = nil then
		    logwriter = new clWriteToSystemLog
		  end if
		  
		  
		  logwriter.start_exec(CurrentMethodName)
		  
		  test_001(logwriter)
		  test_002(logwriter) 
		  
		  logwriter.end_exec(CurrentMethodName)
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub tests_io(log as LogMessageInterface)
		  
		  dim logwriter as  LogMessageInterface = log 
		  
		  if log = nil then
		    logwriter = new clWriteToSystemLog
		  end if
		  
		  
		  logwriter.start_exec(CurrentMethodName)
		  
		  test_io_001(logwriter) 
		  
		  logwriter.end_exec(CurrentMethodName)
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_001(log as LogMessageInterface)
		  
		  log.start_exec(CurrentMethodName)
		  
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
		  
		  my_data_pool.get_table("res").append_from_column_source(my_data_pool.get_table("T2"))
		  
		  dim col1 as clDataSerie
		  dim col2 as clDataSerie
		  dim col3 as clDataSerie
		  dim col4 as clDataSerie
		  dim v as variant
		  
		  col1 = new clDataSerie("aaa", 1000,2000,3000,4000)
		  col2 = new clDataSerie("bbb","abcd","abcd","abcd","abcd")
		  col3 = new clDataSerie("ccc",123.456, 123.456,123.456,123.456)
		  dim expected_t1 as new clDataTable("T1", serie_array(col1, col2, col3))
		  
		  col1 = new clDataSerie("aaa", 5000,6000,7000,8000, 9000)
		  col2 = new clDataSerie("bbb","xyz","xyz","xyz","xyz","xyz")
		  col3 = new clDataSerie("ddd",567.89,567.89,567.89,567.89,567.89)
		  dim expected_t2 as new clDataTable("T1", serie_array(col1, col2, col3))
		  
		  col1 = new clDataSerie("aaa",1000,2000,3000,4000,5000,6000,7000,8000,9000)
		  col2 = new clDataSerie("bbb","abcd","abcd","abcd","abcd","xyz","xyz","xyz","xyz","xyz")
		  col3 = new clDataSerie("ccc",123.456, 123.456,123.456,123.456,v,v,v,v,v)
		  col4 = new clDataSerie("ddd",v,v,v,v,567.89,567.89,567.89,567.89,567.89)
		  dim expected_res as new clDataTable("res", serie_array(col1, col2, col3, col4))
		  
		  call check_table(log,"T1", expected_t1, my_data_pool.get_table("table_1"))
		  call check_table(log,"T2", expected_t2, my_data_pool.get_table("T2"))
		  call check_table(log,"res", expected_res, my_data_pool.get_table("res"))
		  
		  
		  log.end_exec(CurrentMethodName)
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_002(log as LogMessageInterface)
		  //  
		  //  Test simplified interface to tables in data pool
		  //  
		  //  
		  
		  
		  log.start_exec(CurrentMethodName)
		  
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
		  for i as integer = 5 to 8
		    rtst = New clDataRow
		    rtst.set_cell("aaa",I*1000)
		    rtst.set_cell("bbb","xyz")
		    rtst.set_cell("ddd",567.89)
		    
		    table.append_row(rtst)
		    
		  next
		  
		  my_data_pool.table = table
		  
		  
		  my_data_pool.table("res") = my_data_pool.table("table_1").clone()
		  
		  my_data_pool.table("res").append_from_column_source(my_data_pool.table("T2"))
		  
		  dim col1 as clDataSerie
		  dim col2 as clDataSerie
		  dim col3 as clDataSerie
		  dim col4 as clDataSerie
		  dim v as variant
		  
		  col1 = new clDataSerie("aaa", 1000,2000,3000,4000)
		  col2 = new clDataSerie("bbb","abcd","abcd","abcd","abcd")
		  col3 = new clDataSerie("ccc",123.456, 123.456,123.456,123.456)
		  dim expected_t1 as new clDataTable("T1", serie_array(col1, col2, col3))
		  
		  col1 = new clDataSerie("aaa", 5000,6000,7000,8000)
		  col2 = new clDataSerie("bbb","xyz","xyz","xyz","xyz")
		  col3 = new clDataSerie("ddd",567.89,567.89,567.89,567.89)
		  dim expected_t2 as new clDataTable("T1", serie_array(col1, col2, col3))
		  
		  col1 = new clDataSerie("aaa",1000,2000,3000,4000,5000,6000,7000,8000)
		  col2 = new clDataSerie("bbb","abcd","abcd","abcd","abcd","xyz","xyz","xyz","xyz")
		  col3 = new clDataSerie("ccc",123.456, 123.456,123.456,123.456,v,v,v,v)
		  col4 = new clDataSerie("ddd",v,v,v,v,567.89,567.89,567.89,567.89)
		  dim expected_res as new clDataTable("res", serie_array(col1, col2, col3, col4))
		  
		  call check_table(log,"T1", expected_t1, my_data_pool.table("table_1"))
		  call check_table(log,"T2", expected_t2, my_data_pool.table("T2"))
		  call check_table(log,"res", expected_res, my_data_pool.table("res"))
		  
		  
		  log.end_exec(CurrentMethodName)
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_io_001(log as LogMessageInterface)
		  
		  log.start_exec(CurrentMethodName)
		  
		  dim my_data_pool as new clDataPool
		  
		  dim rtst As clDataRow
		  
		  
		  dim pool_table1 as  New clDataTable("PoolTable1")
		  
		  for i as integer = 1 to 4
		    rtst = New clDataRow
		    rtst.set_cell("aaa",I*1000)
		    rtst.set_cell("bbb","abcd")
		    rtst.set_cell("ccc",123.456 * i) 
		    
		    pool_table1.append_row(rtst)
		    
		  next
		  
		  my_data_pool.set_table( pool_table1)
		  
		  
		  dim pool_table2 as New clDataTable("PoolTable2")
		  for i as integer = 5 to 9
		    rtst = New clDataRow
		    rtst.set_cell("aaa",I*1000)
		    rtst.set_cell("bbb","xyz")
		    rtst.set_cell("ddd",567.89 * i)
		    
		    pool_table2.append_row(rtst)
		    
		  next
		  
		  my_data_pool.set_table(pool_table2)
		  
		  
		  Dim fld_folder As New FolderItem
		  
		  fld_folder = fld_folder.Child("test-data")
		  
		  my_data_pool.save(new clTextWriter(fld_folder, True))
		  
		  
		  Dim loaded_table1 As New clDataTable(new clTextReader(fld_folder.child("PoolTable1.csv"), True, new clTextFileConfig(chr(9))))
		  Dim loaded_table2 As New clDataTable(new clTextReader(fld_folder.child("PoolTable2.csv"), True, new clTextFileConfig(chr(9))))
		  
		  call check_table(log,"table 1", loaded_table1, pool_table1)
		  call check_table(log,"table 2", loaded_table2, pool_table2)
		  
		  
		  dim test_data_pool as new clDataPool
		  test_data_pool.load_table(new clTextReader(fld_folder.child("PoolTable1.csv"),True, new clTextFileConfig(chr(9))))
		  test_data_pool.load_table(new clTextReader(fld_folder.child("PoolTable2.csv"),True, new clTextFileConfig(chr(9))))
		  
		  
		  call check_table(log,"pool table 1",my_data_pool.get_table("PoolTable1"), test_data_pool.get_table("from PoolTable1.csv"))
		  call check_table(log,"pool table 2",my_data_pool.get_table("PoolTable2"), test_data_pool.get_table("from PoolTable2.csv"))
		  
		  log.end_exec(CurrentMethodName)
		  
		  
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
