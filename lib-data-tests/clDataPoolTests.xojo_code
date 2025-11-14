#tag Class
Protected Class clDataPoolTests
	#tag Method, Flags = &h0
		Sub test_calc_001(log as LogMessageInterface)
		  
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
		    
		    table.AddRow(rtst, clDataTable.AddRowMode.CreateNewColumnAsVariant)
		    
		  next
		  
		  my_data_pool.SetTable( table, "table_1")
		  
		  
		  table =  New clDataTable("T2")
		  for i as integer = 5 to 9
		    rtst = New clDataRow
		    rtst.SetCell("aaa",I*1000)
		    rtst.SetCell("bbb","xyz")
		    rtst.SetCell("ddd",567.89)
		    
		    table.AddRow(rtst, clDataTable.AddRowMode.CreateNewColumnAsVariant)
		    
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
		Sub test_calc_002(log as LogMessageInterface)
		  //  
		  //  Test simplified interface to tables in data pool
		  //  
		  //  
		  
		  
		  log.start_exec(CurrentMethodName)
		  
		  var my_data_pool as new clDataPool
		  
		  var rtst As clDataRow
		  var v as integer
		  
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
		  col4 = new clDataSerie("ddd",0.0, 0.0, 0.0, 0.0, 567.89,567.89,567.89,567.89)
		  var expected_res as new clDataTable("res", SerieArray(col1, col2, col3, col4))
		  
		  call check_table(log,"T1", expected_t1, my_data_pool.table("table_1"))
		  call check_table(log,"T2", expected_t2, my_data_pool.table("T2"))
		  call check_table(log,"res", expected_res, my_data_pool.table("res"))
		  
		  
		  log.end_exec(CurrentMethodName)
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_calc_003(log as LogMessageInterface)
		  //  
		  //  Test simplified interface to tables in data pool
		  //  
		  //  
		  
		  
		  log.start_exec(CurrentMethodName)
		  
		  var my_data_pool as new clDataPool
		  
		  var tblCustomers as new clDataTable("Customers")
		  tblCustomers.AddRow(new clDataRow("ID":"A1","Name":"John","City":"Bruxelles"))
		  tblCustomers.AddRow(new clDataRow("ID":"A2","Name":"Paul","City":"Liege"))
		  tblCustomers.AddRow(new clDataRow("ID":"A3","Name":"Pierre","City":"Bruxelles"))
		  
		  
		  var tblInvoiceHeader as new clDataTable("InvoiceHeaders")
		  tblInvoiceHeader.AddRow(new clDataRow("InvoiceID":100, "CustomerID":"A2")) 
		  tblInvoiceHeader.AddRow(new clDataRow("InvoiceID":101, "CustomerID":"A3"))
		  tblInvoiceHeader.AddRow(new clDataRow("InvoiceID":103, "CustomerID":"A2"))
		  
		  
		  var tblInvoiceDetails as new clDataTable("InvoiceItems")
		  tblInvoiceDetails.AddRow(new clDataRow("InvoiceID":100, "line":10001, "Item":"Somethign","TotalPrice":100.0))
		  tblInvoiceDetails.AddRow(new clDataRow("InvoiceID":100, "line":10002, "Item":"Somethign","TotalPrice":101.0))
		  tblInvoiceDetails.AddRow(new clDataRow("InvoiceID":100, "line":10003, "Item":"Somethign","TotalPrice":102.0))
		  tblInvoiceDetails.AddRow(new clDataRow("InvoiceID":103, "line":10301, "Item":"Somethign","TotalPrice":202.0))
		  tblInvoiceDetails.AddRow(new clDataRow("InvoiceID":103, "line":10302, "Item":"Somethign","TotalPrice":203.0))
		  tblInvoiceDetails.AddRow(new clDataRow("InvoiceID":101, "line":10101, "Item":"Somethign","TotalPrice":302))
		  tblInvoiceDetails.AddRow(new clDataRow("InvoiceID":101, "line":10102, "Item":"Somethign","TotalPrice":302))
		  tblInvoiceDetails.AddRow(new clDataRow("InvoiceID":101, "line":10103, "Item":"Somethign","TotalPrice":303))
		  
		  
		  // Group invoice lines by invoice ID and calculate totals
		  var trsfGroupByInvoice as new clGroupByTransformer(tblInvoiceDetails, array("InvoiceID"), array("TotalPrice"),"NbrLines")
		  call trsfGroupByInvoice.Transform()
		  var tblGroupedInvoice as clDataTable = trsfGroupByInvoice.GetOutputTable()
		  tblGroupedInvoice.RenameColumn("Sum of TotalPrice","InvoiceTotal")
		  
		  // convert column datatype because groupby only works on clNumericDataSerie (to be fixed !!)
		  call tblGroupedInvoice.AddColumn(tblGroupedInvoice.GetIntegerColumn("NbrLines").ToNumber().Rename("NbrLinesAsNumber"))
		  
		  // Join with invoice headers to get customer ID
		  var trsfJoinCustomerID as new clLookupTransformer(tblGroupedInvoice, tblInvoiceHeader, array("InvoiceID"), array("CustomerID"))
		  call trsfJoinCustomerID.Transform()
		  var tblInvoicedCustomers as clDataTable = tblGroupedInvoice
		  
		  // Calculate the total per customer
		  var trsfGroupByCustomer as new clGroupByTransformer(tblInvoicedCustomers, array("CustomerID"), array("InvoiceTotal","NbrLinesAsNumber"), "NbrInvoices")
		  call trsfGroupByCustomer.Transform()
		  var tblCustomerTotals as clDataTable = trsfGroupByCustomer.GetOutputTable()
		  
		  // lookup transformer will add columns to the source, we clone to allow for checks 
		  var tblCustTotalsCloned as clDataTable = tblCustomerTotals.Clone("CustomerTotals")
		  var trsfJoinCustomerInfo as new clLookupTransformer(tblCustTotalsCloned, tblCustomers, array("CustomerID":"ID"), array("Name":"Name", "City":"City"))
		  call trsfJoinCustomerInfo.Transform()
		  
		  var tblExpectedTotals as new clDataTable("ExpectedtTotal")
		  tblExpectedTotals.AddRow(new clDataRow("CustomerID":"A2", "Sum of InvoiceTotal":708.0,"Sum of NbrLinesAsNumber":5.0, "NbrInvoices":2))
		  tblExpectedTotals.AddRow(new clDataRow("CustomerID":"A3", "Sum of InvoiceTotal":907.0,"Sum of NbrLinesAsNumber":3.0, "NbrInvoices":1))
		  
		  
		  var tblExpectedJoinedTotals as new clDataTable("ExpectedJoinedTotal")
		  tblExpectedJoinedTotals.AddRow(new clDataRow("CustomerID":"A2", "Sum of InvoiceTotal":708.0,"Sum of NbrLinesAsNumber":5.0, "NbrInvoices":2,"Name":"Paul","City":"Liege"))
		  tblExpectedJoinedTotals.AddRow(new clDataRow("CustomerID":"A3", "Sum of InvoiceTotal":907.0,"Sum of NbrLinesAsNumber":3.0, "NbrInvoices":1,"Name":"Pierre", "City":"Bruxelles"))
		  
		  
		  call check_table(log,"T1", tblExpectedTotals, tblCustomerTotals)
		  call check_table(log,"T2", tblExpectedJoinedTotals,tblCustTotalsCloned)
		  
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
		  
		  var main_folder As  FolderItem = GetTestBaseFolder()
		  var sub_folder as FolderItem  = ClearFolder(main_folder.Child(CurrentMethodName))
		  
		  my_data_pool.SaveEachTable(new clTextWriter(sub_folder, True))
		  
		  
		  var loaded_table1 As New clDataTable(new clTextReader(sub_folder.child("PoolTable1.csv"), True, new clTextFileConfig(chr(9))))
		  var loaded_table2 As New clDataTable(new clTextReader(sub_folder.child("PoolTable2.csv"), True, new clTextFileConfig(chr(9))))
		  
		  call check_table(log,"table 1", pool_table1, loaded_table1)
		  call check_table(log,"table 2", pool_table2, loaded_table2)
		  
		  
		  var test_data_pool as new clDataPool
		  test_data_pool.LoadOneTable(new clTextReader(sub_folder.child("PoolTable1.csv"),True, new clTextFileConfig(chr(9))))
		  test_data_pool.LoadOneTable(new clTextReader(sub_folder.child("PoolTable2.csv"),True, new clTextFileConfig(chr(9))))
		  
		  
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
		  
		  call check_table(log,"table 1", pool_table1, loaded_table1)
		  call check_table(log,"table 2", pool_table2, loaded_table2)
		  
		  
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
		  
		  
		  var main_folder As  FolderItem = GetTestBaseFolder()
		  var sub_folder as FolderItem  = ClearFolder(main_folder.Child(CurrentMethodName))
		  
		  my_data_pool.SaveEachTable(new clTextWriter(sub_folder, True))
		  
		  
		  var loaded_table1 As New clDataTable(new clTextReader(sub_folder.child("PoolTable1.csv"), True, new clTextFileConfig(chr(9))))
		  var loaded_table2 As New clDataTable(new clTextReader(sub_folder.child("PoolTable2.csv"), True, new clTextFileConfig(chr(9))))
		  
		  call check_table(log,"table 1", pool_table1, loaded_table1)
		  call check_table(log,"table 2", pool_table2, loaded_table2)
		  
		  
		  var test_data_pool as new clDataPool
		  test_data_pool.LoadEachTable(new clTextReader(sub_folder, True, new clTextFileConfig(chr(9))))
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
		  
		  
		  var main_folder As  FolderItem = GetTestBaseFolder()
		  var sub_folder as FolderItem  = ClearFolder(main_folder.Child(CurrentMethodName))
		  
		  var fld_file as FolderItem  = sub_folder.child("myfile.json")
		  
		  my_data_pool.SaveEachTable(new clJSONWriter(fld_file, nil))
		  
		  
		  var test_data_pool as new clDataPool
		  test_data_pool.LoadEachTable(new clJSONReader(fld_file, nil))
		  
		  
		  call check_table(log,"pool table 1",my_data_pool.GetTable("PoolTable1"), test_data_pool.GetTable("from PoolTable1"))
		  call check_table(log,"pool table 2",my_data_pool.GetTable("PoolTable2"), test_data_pool.GetTable("from PoolTable2"))
		  
		  log.end_exec(CurrentMethodName)
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_io_005(log as LogMessageInterface)
		  
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
		    rtst.SetCell("bbb","ab"+str(i)+"cd")
		    rtst.SetCell("ccc",123.456 * i) 
		    
		    pool_table1.AddRow(rtst)
		    
		  next
		  
		  my_data_pool.SetTable( pool_table1)
		  
		  
		  var pool_table2 as New clDataTable("PoolTable2")
		  for i as integer = 5 to 9
		    rtst = New clDataRow
		    rtst.SetCell("aaa",I*1000)
		    rtst.SetCell("bbb","xyz" + str(i))
		    rtst.SetCell("ddd",567.89 * i)
		    
		    pool_table2.AddRow(rtst)
		    
		  next
		  
		  my_data_pool.SetTable(pool_table2)
		  
		  my_data_pool.SaveEachTable(new clDBWriter(new clSqliteDBAccess(db)))
		  
		  
		  var loaded_table1 as new clDataTable(new clDBReader(new clSqliteDBAccess(db),"PoolTable1"))
		  var loaded_table2 As New clDataTable(new clDBReader(db.SelectSql("select * from PoolTable2")))
		  
		  call check_table(log,"table 1", pool_table1, loaded_table1)
		  call check_table(log,"table 2", pool_table2, loaded_table2)
		  
		  
		  var test_data_pool as new clDataPool
		  
		  test_data_pool.LoadEachTable(new clDBReader(new clSqliteDBAccess(db),""))
		  
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
End Class
#tag EndClass
