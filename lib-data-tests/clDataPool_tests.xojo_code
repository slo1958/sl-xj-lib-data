#tag Module
Protected Module clDataPool_tests
	#tag Method, Flags = &h0
		Sub tests(log as LogMessageInterface)
		  
		  var logwriter as  LogMessageInterface = log 
		  
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
		  
		  var logwriter as  LogMessageInterface = log 
		  
		  if log = nil then
		    logwriter = new clWriteToSystemLog
		  end if
		  
		  
		  logwriter.start_exec(CurrentMethodName)
		  
		  test_io_001(logwriter) 
		  test_io_002(logwriter) 
		  test_io_003(logwriter)
		  test_io_004(logwriter)
		  
		  logwriter.end_exec(CurrentMethodName)
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_001(log as LogMessageInterface)
		  
		  log.start_exec(CurrentMethodName)
		  
		  var my_data_pool as new clDataPool
		  
		  var rtst As clDataRow
		  
		  var table as clDataTable
		  
		  table =  New clDataTable("T1")
		  for i as integer = 1 to 4
		    rtst = New clDataRow
		    rtst.SetCell("aaa",I*1000)
		    rtst.SetCell("bbb","abcd")
		    rtst.SetCell("ccc",123.456)
		    
		    table.AddRow(rtst)
		    
		  next
		  
		  my_data_pool.SetTable( table, "table_1")
		  
		  
		  table =  New clDataTable("T2")
		  for i as integer = 5 to 9
		    rtst = New clDataRow
		    rtst.SetCell("aaa",I*1000)
		    rtst.SetCell("bbb","xyz")
		    rtst.SetCell("ddd",567.89)
		    
		    table.AddRow(rtst)
		    
		  next
		  
		  my_data_pool.SetTable(table)
		  
		  
		  my_data_pool.SetTable(my_data_pool.GetTable("table_1").Clone(), "res")
		  
		  my_data_pool.GetTable("res"). AddColumnsData(my_data_pool.GetTable("T2"))
		  
		  var col1 as clDataSerie
		  var col2 as clDataSerie
		  var col3 as clDataSerie
		  var col4 as clDataSerie
		  var v as variant
		  
		  col1 = new clDataSerie("aaa", 1000,2000,3000,4000)
		  col2 = new clDataSerie("bbb","abcd","abcd","abcd","abcd")
		  col3 = new clDataSerie("ccc",123.456, 123.456,123.456,123.456)
		  var expected_t1 as new clDataTable("T1", SerieArray(col1, col2, col3))
		  
		  col1 = new clDataSerie("aaa", 5000,6000,7000,8000, 9000)
		  col2 = new clDataSerie("bbb","xyz","xyz","xyz","xyz","xyz")
		  col3 = new clDataSerie("ddd",567.89,567.89,567.89,567.89,567.89)
		  var expected_t2 as new clDataTable("T1", SerieArray(col1, col2, col3))
		  
		  col1 = new clDataSerie("aaa",1000,2000,3000,4000,5000,6000,7000,8000,9000)
		  col2 = new clDataSerie("bbb","abcd","abcd","abcd","abcd","xyz","xyz","xyz","xyz","xyz")
		  col3 = new clDataSerie("ccc",123.456, 123.456,123.456,123.456,v,v,v,v,v)
		  col4 = new clDataSerie("ddd",v,v,v,v,567.89,567.89,567.89,567.89,567.89)
		  var expected_res as new clDataTable("res", SerieArray(col1, col2, col3, col4))
		  
		  call check_table(log,"T1", expected_t1, my_data_pool.GetTable("table_1"))
		  call check_table(log,"T2", expected_t2, my_data_pool.GetTable("T2"))
		  call check_table(log,"res", expected_res, my_data_pool.GetTable("res"))
		  
		  
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
		  
		  var my_data_pool as new clDataPool
		  
		  var rtst As clDataRow
		  
		  var table as clDataTable
		  
		  table =  New clDataTable("T1")
		  for i as integer = 1 to 4
		    rtst = New clDataRow
		    rtst.SetCell("aaa",I*1000)
		    rtst.SetCell("bbb","abcd")
		    rtst.SetCell("ccc",123.456)
		    
		    table.AddRow(rtst)
		    
		  next
		  
		  my_data_pool.table("table_1") = table
		  
		  
		  table =  New clDataTable("T2")
		  for i as integer = 5 to 8
		    rtst = New clDataRow
		    rtst.SetCell("aaa",I*1000)
		    rtst.SetCell("bbb","xyz")
		    rtst.SetCell("ddd",567.89)
		    
		    table.AddRow(rtst)
		    
		  next
		  
		  my_data_pool.table = table
		  
		  
		  my_data_pool.table("res") = my_data_pool.table("table_1").Clone()
		  
		  my_data_pool.table("res"). AddColumnsData(my_data_pool.table("T2"))
		  
		  var col1 as clDataSerie
		  var col2 as clDataSerie
		  var col3 as clDataSerie
		  var col4 as clDataSerie
		  var v as variant
		  
		  col1 = new clDataSerie("aaa", 1000,2000,3000,4000)
		  col2 = new clDataSerie("bbb","abcd","abcd","abcd","abcd")
		  col3 = new clDataSerie("ccc",123.456, 123.456,123.456,123.456)
		  var expected_t1 as new clDataTable("T1", SerieArray(col1, col2, col3))
		  
		  col1 = new clDataSerie("aaa", 5000,6000,7000,8000)
		  col2 = new clDataSerie("bbb","xyz","xyz","xyz","xyz")
		  col3 = new clDataSerie("ddd",567.89,567.89,567.89,567.89)
		  var expected_t2 as new clDataTable("T1", SerieArray(col1, col2, col3))
		  
		  col1 = new clDataSerie("aaa",1000,2000,3000,4000,5000,6000,7000,8000)
		  col2 = new clDataSerie("bbb","abcd","abcd","abcd","abcd","xyz","xyz","xyz","xyz")
		  col3 = new clDataSerie("ccc",123.456, 123.456,123.456,123.456,v,v,v,v)
		  col4 = new clDataSerie("ddd",v,v,v,v,567.89,567.89,567.89,567.89)
		  var expected_res as new clDataTable("res", SerieArray(col1, col2, col3, col4))
		  
		  call check_table(log,"T1", expected_t1, my_data_pool.table("table_1"))
		  call check_table(log,"T2", expected_t2, my_data_pool.table("T2"))
		  call check_table(log,"res", expected_res, my_data_pool.table("res"))
		  
		  
		  log.end_exec(CurrentMethodName)
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_io_001(log as LogMessageInterface)
		  
		  log.start_exec(CurrentMethodName)
		  
		  var my_data_pool as new clDataPool
		  
		  var rtst As clDataRow
		  
		  
		  var pool_table1 as  New clDataTable("PoolTable1")
		  
		  for i as integer = 1 to 4
		    rtst = New clDataRow
		    rtst.SetCell("aaa",I*1000)
		    rtst.SetCell("bbb","abcd")
		    rtst.SetCell("ccc",123.456 * i) 
		    
		    pool_table1.AddRow(rtst)
		    
		  next
		  
		  my_data_pool.SetTable( pool_table1)
		  
		  
		  var pool_table2 as New clDataTable("PoolTable2")
		  for i as integer = 5 to 9
		    rtst = New clDataRow
		    rtst.SetCell("aaa",I*1000)
		    rtst.SetCell("bbb","xyz")
		    rtst.SetCell("ddd",567.89 * i)
		    
		    pool_table2.AddRow(rtst)
		    
		  next
		  
		  my_data_pool.SetTable(pool_table2)
		  
		  var fld_folder As New FolderItem
		  fld_folder = ClearFolder( fld_folder.Child("test-data").Child(CurrentMethodName))
		  
		  my_data_pool.SaveEachTable(new clTextWriter(fld_folder, True))
		  
		  
		  var loaded_table1 As New clDataTable(new clTextReader(fld_folder.child("PoolTable1.csv"), True, new clTextFileConfig(chr(9))))
		  var loaded_table2 As New clDataTable(new clTextReader(fld_folder.child("PoolTable2.csv"), True, new clTextFileConfig(chr(9))))
		  
		  call check_table(log,"table 1", loaded_table1, pool_table1)
		  call check_table(log,"table 2", loaded_table2, pool_table2)
		  
		  
		  var test_data_pool as new clDataPool
		  test_data_pool.LoadOneTable(new clTextReader(fld_folder.child("PoolTable1.csv"),True, new clTextFileConfig(chr(9))))
		  test_data_pool.LoadOneTable(new clTextReader(fld_folder.child("PoolTable2.csv"),True, new clTextFileConfig(chr(9))))
		  
		  
		  call check_table(log,"pool table 1",my_data_pool.GetTable("PoolTable1"), test_data_pool.GetTable("from PoolTable1.csv"))
		  call check_table(log,"pool table 2",my_data_pool.GetTable("PoolTable2"), test_data_pool.GetTable("from PoolTable2.csv"))
		  
		  log.end_exec(CurrentMethodName)
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_io_002(log as LogMessageInterface)
		  
		  log.start_exec(CurrentMethodName)
		  
		  var my_data_pool as new clDataPool
		  
		  var rtst As clDataRow
		  
		  var db as new SQLiteDatabase
		  
		  Try
		    db.Connect
		    
		  Catch error As DatabaseException
		    System.DebugLog("DB Connection Error: " + error.Message)
		    
		  End Try
		  
		  
		  var pool_table1 as  New clDataTable("PoolTable1")
		  
		  for i as integer = 1 to 4
		    rtst = New clDataRow
		    rtst.SetCell("aaa",I*1000)
		    rtst.SetCell("bbb","abcd")
		    rtst.SetCell("ccc",123.456 * i) 
		    
		    pool_table1.AddRow(rtst)
		    
		  next
		  
		  my_data_pool.SetTable( pool_table1)
		  
		  
		  var pool_table2 as New clDataTable("PoolTable2")
		  for i as integer = 5 to 9
		    rtst = New clDataRow
		    rtst.SetCell("aaa",I*1000)
		    rtst.SetCell("bbb","xyz")
		    rtst.SetCell("ddd",567.89 * i)
		    
		    pool_table2.AddRow(rtst)
		    
		  next
		  
		  my_data_pool.SetTable(pool_table2)
		  
		  my_data_pool.SaveEachTable(new clDBWriter(new clSqliteDBAccess(db)))
		  
		  
		  var loaded_table1 as new clDataTable(new clDBReader(new clSqliteDBAccess(db),"PoolTable1"))
		  var loaded_table2 As New clDataTable(new clDBReader(db.SelectSql("select * from PoolTable2")))
		  
		  call check_table(log,"table 1", loaded_table1, pool_table1)
		  call check_table(log,"table 2", loaded_table2, pool_table2)
		  
		  
		  var test_data_pool as new clDataPool
		  
		  test_data_pool.LoadOneTable(new clDBReader(new clSqliteDBAccess(db),"PoolTable1"))
		  test_data_pool.LoadOneTable(new clDBReader(new clSqliteDBAccess(db),"PoolTable2"))
		  
		  call check_table(log,"pool table 1",my_data_pool.GetTable("PoolTable1"), test_data_pool.GetTable("from PoolTable1"))
		  call check_table(log,"pool table 2",my_data_pool.GetTable("PoolTable2"), test_data_pool.GetTable("from PoolTable2"))
		  
		  log.end_exec(CurrentMethodName)
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_io_003(log as LogMessageInterface)
		  
		  log.start_exec(CurrentMethodName)
		  
		  var my_data_pool as new clDataPool
		  
		  var rtst As clDataRow
		  
		  
		  var pool_table1 as  New clDataTable("PoolTable1")
		  
		  for i as integer = 1 to 4
		    rtst = New clDataRow
		    rtst.SetCell("aaa",I*1000)
		    rtst.SetCell("bbb","abcd")
		    rtst.SetCell("ccc",123.456 * i) 
		    
		    pool_table1.AddRow(rtst)
		    
		  next
		  
		  my_data_pool.SetTable( pool_table1)
		  
		  
		  var pool_table2 as New clDataTable("PoolTable2")
		  for i as integer = 5 to 9
		    rtst = New clDataRow
		    rtst.SetCell("aaa",I*1000)
		    rtst.SetCell("bbb","xyz")
		    rtst.SetCell("ddd",567.89 * i)
		    
		    pool_table2.AddRow(rtst)
		    
		  next
		  
		  my_data_pool.SetTable(pool_table2)
		  
		  
		  var fld_folder As New FolderItem
		  fld_folder = ClearFolder( fld_folder.Child("test-data").Child(CurrentMethodName))
		  
		  my_data_pool.SaveEachTable(new clTextWriter(fld_folder, True))
		  
		  
		  var loaded_table1 As New clDataTable(new clTextReader(fld_folder.child("PoolTable1.csv"), True, new clTextFileConfig(chr(9))))
		  var loaded_table2 As New clDataTable(new clTextReader(fld_folder.child("PoolTable2.csv"), True, new clTextFileConfig(chr(9))))
		  
		  call check_table(log,"table 1", loaded_table1, pool_table1)
		  call check_table(log,"table 2", loaded_table2, pool_table2)
		  
		  
		  var test_data_pool as new clDataPool
		  test_data_pool.LoadEachTable(new clTextReader(fld_folder, True, new clTextFileConfig(chr(9))))
		  //test_data_pool.LoadOneTable(new clTextReader(fld_folder.child("PoolTable1.csv"),True, new clTextFileConfig(chr(9))))
		  //test_data_pool.LoadOneTable(new clTextReader(fld_folder.child("PoolTable2.csv"),True, new clTextFileConfig(chr(9))))
		  
		  
		  call check_table(log,"pool table 1",my_data_pool.GetTable("PoolTable1"), test_data_pool.GetTable("from PoolTable1.csv"))
		  call check_table(log,"pool table 2",my_data_pool.GetTable("PoolTable2"), test_data_pool.GetTable("from PoolTable2.csv"))
		  
		  log.end_exec(CurrentMethodName)
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_io_004(log as LogMessageInterface)
		  
		  log.start_exec(CurrentMethodName)
		  
		  var my_data_pool as new clDataPool
		  
		  var rtst As clDataRow
		  
		  
		  var pool_table1 as  New clDataTable("PoolTable1")
		  
		  for i as integer = 1 to 4
		    rtst = New clDataRow
		    rtst.SetCell("aaa",I*1000)
		    rtst.SetCell("bbb","abcd")
		    rtst.SetCell("ccc",123.456 * i) 
		    
		    pool_table1.AddRow(rtst)
		    
		  next
		  
		  my_data_pool.SetTable( pool_table1)
		  
		  
		  var pool_table2 as New clDataTable("PoolTable2")
		  for i as integer = 5 to 9
		    rtst = New clDataRow
		    rtst.SetCell("aaa",I*1000)
		    rtst.SetCell("bbb","xyz")
		    rtst.SetCell("ddd",567.89 * i)
		    
		    pool_table2.AddRow(rtst)
		    
		  next
		  
		  my_data_pool.SetTable(pool_table2)
		  
		  
		  var fld_folder As New FolderItem
		  fld_folder = ClearFolder( fld_folder.Child("test-data").Child(CurrentMethodName))
		  fld_folder = fld_folder.child("myfile.json")
		  
		  my_data_pool.SaveEachTable(new clJSONWriter(fld_folder, nil))
		  
		  
		  var test_data_pool as new clDataPool
		  test_data_pool.LoadEachTable(new clJSONReader(fld_folder, nil))
		  
		   
		  call check_table(log,"pool table 1",my_data_pool.GetTable("PoolTable1"), test_data_pool.GetTable("from PoolTable1"))
		  call check_table(log,"pool table 2",my_data_pool.GetTable("PoolTable2"), test_data_pool.GetTable("from PoolTable2"))
		  
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
