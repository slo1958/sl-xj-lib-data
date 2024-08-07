#tag Module
Protected Module clDataTable_tests
	#tag Method, Flags = &h0
		Function alloc_series_019(column_name as string, column_type_info as string) As clAbstractDataSerie
		  if column_name = "Sales" then
		    Return new clNumberDataSerie(column_name)
		    
		  else
		    return new clDataSerie(column_name)
		    
		  end if
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function alloc_series_io1(column_name as string, column_type_info as string) As clAbstractDataSerie
		  if column_name = "Alpha" then
		    Return new clCompressedDataSerie(column_name)
		    
		  else
		    return new clDataSerie(column_name)
		    
		  end if
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function check_table(log as LogMessageInterface, label as string, expected as clDataTable, calculated as clDataTable, accepted_error_on_double as double = 0.00001) As Boolean
		  dim cnt1 as integer  
		  dim cnt2 as integer 
		  
		  cnt1 = expected.column_count
		  cnt2 = calculated.column_count
		  
		  if not check_value(log,"column count", cnt1, cnt2) then return False
		  
		  dim col_ok as boolean = True
		  for col as integer = 0 to expected.column_count-1
		    
		    col_ok = col_ok and check_serie(log, label + " field [" + expected.column_name(col)+"]", expected.get_column_by_index(col), calculated.get_column_by_index(col), accepted_error_on_double)
		    
		  next
		  
		  Return col_ok
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function filter_008(the_row_index as integer, the_row_count as integer, the_column_names() as string, the_cell_values() as variant, paramarray function_param as variant) As Boolean
		  dim idx as integer = the_column_names.IndexOf("cc2")
		  
		  return the_cell_values(idx) = function_param(0)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub tests(log as LogMessageInterface)
		  
		  dim logwriter as  LogMessageInterface = log 
		  
		  if log = nil then
		    logwriter = new clWriteToSystemLog
		  end if
		  
		  logwriter.start_exec(CurrentMethodName)
		  
		  test_001(logwriter)
		  test_002(logwriter)
		  test_003(logwriter)
		  
		  test_005(logwriter)
		  test_006(logwriter)
		  test_007(logwriter)
		  test_008(logwriter)
		  test_009(logwriter)
		  test_010(logwriter)
		  test_011(logwriter)
		  test_012(logwriter)
		  test_013(logwriter)
		  test_014(logwriter)
		  test_015(logwriter)
		  test_017(logwriter)
		  test_018(logwriter)
		  test_019(logwriter)
		  test_020(logwriter)
		  test_021(logwriter)
		  
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
		  
		  test_io_002(logwriter)
		  
		  test_io_003(logwriter)
		  
		  test_io_004(logwriter)
		  
		  test_io_005(logwriter)
		  
		  logwriter.end_exec(CurrentMethodName)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_001(log as LogMessageInterface)
		  
		  log.start_exec(CurrentMethodName)
		  
		  Dim rtst As clDataRow
		  
		  Dim my_table As New clDataTable("T1")
		  
		  rtst = New clDataRow
		  rtst.set_cell("aaa",1234)
		  rtst.set_cell("bbb","abcd")
		  rtst.set_cell("ccc",123.456)
		  
		  my_table.append_row(rtst)
		  
		  rtst = New clDataRow
		  rtst.set_cell("aaa",1235)
		  rtst.set_cell("bbb","abce")
		  rtst.set_cell("ddd",987.654)
		  
		  my_table.append_row(rtst)
		  
		  dim col1 as new clDataSerie("aaa", 1234, 1235)
		  dim col2 as new clDataSerie("bbb", "abcd", "abce")
		  dim col3 as new clDataSerie("ccc", 123.456, nil)
		  dim col4 as new clDataSerie("ddd", nil, 987.654)
		  
		  
		  dim texpected as new clDataTable("T1", serie_array(col1, col2, col3 ,col4))
		  
		  call check_table(log, "T1", texpected, my_table)
		  
		  log.end_exec(CurrentMethodName)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_002(log as LogMessageInterface)
		  
		  log.start_exec(CurrentMethodName)
		  
		  Dim rtst As clDataRow
		  
		  Dim my_table1 As New clDataTable("T1")
		  
		  rtst = New clDataRow
		  rtst.set_cell("aaa",1234)
		  rtst.set_cell("bbb","abcd")
		  rtst.set_cell("ccc",123.456)
		  
		  my_table1.append_row(rtst)
		  
		  rtst = New clDataRow
		  rtst.set_cell("aaa",1235)
		  rtst.set_cell("bbb","abce")
		  rtst.set_cell("ddd",987.654)
		  
		  my_table1.append_row(rtst)
		  
		  Dim my_table2 As New clDataTable("T2")
		  
		  rtst = New clDataRow
		  rtst.set_cell("aaa",81234)
		  rtst.set_cell("bbb","zabcd")
		  rtst.set_cell("zccc",8123.456)
		  
		  my_table2.append_row(rtst)
		  
		  rtst = New clDataRow
		  rtst.set_cell("aaa",81235)
		  rtst.set_cell("bbb","zabce")
		  rtst.set_cell("zddd",8987.654)
		  
		  my_table2.append_row(rtst)
		  
		  my_table1.append_from_column_source(my_table2)
		  
		  Dim my_table3 As clDataTable = my_table1.select_columns(Array("aaa","zccc"))
		  
		  
		  dim col1 as new clDataSerie("aaa", 1234, 1235, 81234, 81235)
		  dim col2 as new clDataSerie("zccc", nil, nil, 8123.456, nil)
		  dim texpected as new clDataTable("select T1", serie_array(col1, col2))
		  
		  call check_table(log, "T1", my_table3, texpected)
		  
		  log.end_exec(CurrentMethodName)
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_003(log as LogMessageInterface)
		  
		  log.start_exec(CurrentMethodName)
		  
		  
		  Dim rtst As clDataRow
		  Dim my_table1 As New clDataTable("T1")
		  
		  
		  rtst = New clDataRow
		  rtst.set_cell("aaa",1234)
		  rtst.set_cell("bbb","abcd")
		  rtst.set_cell("ccc",123.456)
		  
		  my_table1.append_row(rtst)
		  
		  rtst = New clDataRow
		  rtst.set_cell("aaa",1235)
		  rtst.set_cell("bbb","abce")
		  rtst.set_cell("ddd",987.654)
		  
		  my_table1.append_row(rtst) 
		  
		  Dim my_col As clAbstractDataSerie
		  Dim my_table3 As clDataTable = my_table1.select_columns(Array("aaa","zccc")) // zccc does not exist, not included in my_table3
		  
		  
		  my_col = my_table3.add_column("xyz") 
		  
		  dim col1 as new clDataSerie("aaa", 1234, 1235)
		  dim col2 as new clDataSerie("xyz", nil, nil) 
		  
		  dim texpected as new clDataTable("select T1", serie_array(col1, col2))
		  
		  call check_table(log,"T1", texpected, my_table3)
		  
		  log.end_exec(CurrentMethodName)
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_005(log as LogMessageInterface)
		  
		  log.start_exec(CurrentMethodName)
		  
		  
		  Dim rtst As clDataRow
		  
		  Dim my_table As New clDataTable("T1")
		  
		  rtst = New clDataRow
		  rtst.set_cell("aaa",1234)
		  rtst.set_cell("bbb","abcd")
		  rtst.set_cell("ccc",123.456)
		  
		  my_table.append_row(rtst)
		  
		  rtst = New clDataRow
		  rtst.set_cell("aaa",1235)
		  rtst.set_cell("bbb","abce")
		  rtst.set_cell("ddd",987.654)
		  
		  my_table.append_row(rtst)
		  
		  Dim cols() As clAbstractDataSerie
		  
		  cols = my_table.get_columns("aaa","bbb","ddd")
		  
		  cols(1).rename("bB1")
		  
		  dim col1 as new clDataSerie("aaa", 1234, 1235)
		  dim col2 as new clDataSerie("bB1", "abcd", "abce")
		  dim col3 as new clDataSerie("ccc", 123.456, nil)
		  dim col4 as new clDataSerie("ddd", nil, 987.654)
		  
		  
		  dim texpected as new clDataTable("T1", serie_array(col1, col2, col3 ,col4))
		  
		  call check_table(log,"T1", texpected, my_table)
		  
		  log.end_exec(CurrentMethodName)
		  
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_006(log as LogMessageInterface)
		  
		  log.start_exec(CurrentMethodName)
		  
		  
		  Dim c1 As New clDataSerie("premier")
		  Dim c2 As New clDataSerie("second")
		  
		  c1.append_element("aaa")
		  c1.append_element("bbb")
		  c1.append_element("ccc")
		  
		  
		  c2.append_element(12)
		  c2.append_element(34)
		  c2.append_element(56)
		  c2.append_element(78)
		  
		  Dim t1 As New clDataTable("mytable1", serie_array(c1, c2))
		  
		  Dim t2 As New clDataTable("mytable2", serie_array(c1, c2), True)
		  
		  Dim r1 As clDataRow
		  r1 = New clDataRow
		  r1.set_cell("premier","dddd")
		  r1.set_cell("second",90)
		  
		  t1.append_row(r1)
		  
		  r1.set_cell("troisieme",True)
		  t2.append_row(r1)
		  
		  
		  dim col1 as new clDataSerie("premier","aaa","bbb","ccc",nil,"dddd")
		  dim col2 as new clDataSerie("second",12,34,56,78,90)
		  
		  dim expected_t1 as new clDataTable("mytable1", serie_array(col1, col2))
		  
		  dim col3 as new clDataSerie("premier","aaa","bbb","ccc",nil,"dddd")
		  dim col4 as new clDataSerie("second",12,34,56,78,90)
		  dim col5 as new clDataSerie("troisieme",nil,nil,nil,nil,True)
		  
		  dim expected_t2 as new clDataTable("mytable2", serie_array(col3, col4, col5))
		  
		  call check_table(log,"mytable1", expected_t1, t1)
		  
		  call check_table(log,"mytable2", expected_t2, t2)
		  
		  
		  log.end_exec(CurrentMethodName)
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_007(log as LogMessageInterface)
		  
		  log.start_exec(CurrentMethodName)
		  
		  
		  Dim my_table As New clDataTable("T1")
		  
		  call my_table.add_columns(Array("cc1","cc2","cc3"))
		  
		  my_table.append_row(Array("aaa0","bbb0","ccc0"))
		  my_table.append_row(Array("aaa1","bbb1","ccc1"))
		  my_table.append_row(Array("aaa2","bbb2","ccc2"))
		  my_table.append_row(Array("aaa3","bbb3","ccc3"))
		  
		  Dim tmp1 As Integer = my_table.find_first_matching_row_index("cc2","bbb2")
		  Dim tmp2 As Integer = my_table.find_first_matching_row_index("cc2","zzz2")
		  Dim tmp3 As Integer = my_table.find_first_matching_row_index("zz2","bbb2")
		  
		  call check_value(log, "tmp1", 2, tmp1)
		  call check_value(log, "tmp2", -1, tmp2) // value not found
		  call check_value(log, "tmp3", -2, tmp3) // column not found
		  
		  log.end_exec(CurrentMethodName)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_008(log as LogMessageInterface)
		  
		  log.start_exec(CurrentMethodName)
		  
		  
		  Dim my_table As New clDataTable("T1")
		  
		  call my_table.add_columns(Array("cc1","cc2","cc3"))
		  
		  my_table.append_row(Array("aaa0","bbb0","ccc0"))
		  my_table.append_row(Array("aaa1","bbb1","ccc1"))
		  my_table.append_row(Array("aaa2","bbb0","ccc2"))
		  my_table.append_row(Array("aaa3","bbb3","ccc3"))
		  
		  //  The function is filtering on column cc2. The parameter is the value to look for
		  
		  dim tmp1() as variant = my_table.filter_apply_function(AddressOf filter_008,"bbb0")
		  
		  call my_table.add_column(new clBooleanDataSerie("is_bbb0", tmp1))
		  
		  call my_table.add_column(new clBooleanDataSerie("is_bbb1", clDataSerie(my_table.get_column("cc2")).filter_value_in_list(array("bbb1"))))
		  
		  call my_table.add_column(new clBooleanDataSerie("is_bbb3",  my_table.filter_apply_function(AddressOf filter_008, "bbb3")))
		  
		  
		  dim col1 as new clDataSerie("cc1", "aaa0","aaa1","aaa2","aaa3")
		  dim col2 as new clDataSerie("cc2", "bbb0","bbb1","bbb0","bbb3")
		  dim col3 as new clDataSerie("cc3", "ccc0","ccc1","ccc2","ccc3")
		  
		  dim col4 as new clDataSerie("is_bbb0", True, False, True, False)
		  
		  dim col5 as new clDataSerie("is_bbb1", False, True, False, False)
		  dim col6 as new clDataSerie("is_bbb3", False, False, False, True)
		  
		  dim expected as new clDataTable("T1", serie_array(col1, col2, col3, col4, col5, col6))
		  
		  call check_table(log,"t1", expected, my_table)
		  
		  log.end_exec(CurrentMethodName)
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_009(log as LogMessageInterface)
		  
		  log.start_exec(CurrentMethodName)
		  
		  
		  Dim rtst As clDataRow
		  
		  Dim my_table1 As New clDataTable("T1")
		  Dim my_table2 as New clDataTable("T2")
		  
		  for i as integer = 1 to 4
		    rtst = New clDataRow
		    rtst.set_cell("aaa",I*1000)
		    rtst.set_cell("bbb","abcd")
		    rtst.set_cell("ccc",123.456)
		    
		    my_table1.append_row(rtst)
		    
		  next
		  
		  
		  for i as integer = 5 to 9
		    rtst = New clDataRow
		    rtst.set_cell("aaa",I*1000)
		    rtst.set_cell("bbb","xyz")
		    rtst.set_cell("ddd",567.89)
		    
		    my_table2.append_row(rtst)
		    
		  next
		  
		  dim my_table3 as clDataTable = my_table1.clone()
		  dim my_table4 as clDataTable = my_table1.clone()
		  
		  my_table3.append_from_column_source(my_table2, true)
		  my_table4.append_from_column_source(my_table2, false)
		  
		  dim col1 as new clDataSerie("aaa", 1000, 2000, 3000, 4000)
		  dim col2 as new clDataSerie("bbb","abcd","abcd","abcd","abcd")
		  dim col3 as new clDataSerie("ccc", 123.456, 123.456, 123.456, 123.456)
		  
		  dim expected_t1 as new clDataTable("T1", serie_array(col1, col2, col3))
		  
		  dim col4 as new clDataSerie("aaa", 5000, 6000, 7000, 8000, 9000)
		  dim col5 as new clDataSerie("bbb","xyz","xyz","xyz","xyz", "xyz")
		  dim col6 as new clDataSerie("ddd", 567.89, 567.89, 567.89, 567.89, 567.89)
		  
		  dim expected_t2 as new clDataTable("T2", serie_array(col4, col5, col6))
		  
		  
		  dim col7 as new clDataSerie("aaa", 1000, 2000, 3000, 4000, 5000, 6000, 7000, 8000, 9000)
		  dim col8 as new clDataSerie("bbb","abcd","abcd","abcd","abcd","xyz","xyz","xyz","xyz", "xyz")
		  dim col9 as new clDataSerie("ccc", 123.456, 123.456, 123.456, 123.456, nil, nil, nil, nil, nil)
		  dim col0 as new clDataSerie("ddd", nil, nil, nil, nil, 567.89, 567.89, 567.89, 567.89, 567.89)
		  dim expected_t3 as new clDataTable("T3", serie_array(col7, col8, col9, col0))
		  
		  dim expected_t4 as new clDataTable("T4", serie_array(col7, col8, col9), True)
		  
		  call check_table(log,"T1", expected_t1, my_table1)
		  call check_table(log,"T2", expected_t2, my_table2)
		  call check_table(log,"T3", expected_t3, my_table3)
		  call check_table(log,"T4", expected_t4, my_table4)
		  
		  
		  log.end_exec(CurrentMethodName)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_010(log as LogMessageInterface)
		  
		  log.start_exec(CurrentMethodName)
		  
		  
		  Dim temp_row As clDataRow
		  Dim mytable As New clDataTable("T1")
		  
		  call mytable.add_column(new clDataSerie("name"))
		  call mytable.add_column(new clNumberDataSerie("quantity"))
		  call mytable.add_column(new clNumberDataSerie("unit_price"))
		  
		  temp_row = New clDataRow
		  temp_row.set_cell("name","alpha")
		  temp_row.set_cell("quantity",50)
		  temp_row.set_cell("unit_price",6)
		  mytable.append_row(temp_row)
		  
		  temp_row = New clDataRow
		  temp_row.set_cell("name","alpha")
		  temp_row.set_cell("quantity",20)
		  temp_row.set_cell("unit_price",8)
		  mytable.append_row(temp_row)
		  
		  call mytable.add_column(clNumberDataSerie(mytable.get_column("unit_price")) * clNumberDataSerie(mytable.get_column("quantity")))
		  
		  dim col1 as new clDataSerie("name", "alpha","alpha")
		  dim col2 as new clNumberDataSerie("quantity", 50, 20)
		  dim col3 as new clNumberDataSerie("unit_price", 6, 8)
		  dim col4 as new clNumberDataSerie("unit_price*quantity", 300, 160)
		  
		  dim expected_t1 as new clDataTable("T1", serie_array(col1, col2, col3, col4))
		  
		  call check_table(log,"T1", expected_t1, mytable)
		  
		  
		  log.end_exec(CurrentMethodName)
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_011(log as LogMessageInterface)
		  
		  log.start_exec(CurrentMethodName)
		  
		  
		  Dim table0 As New clDataTable("mytable")
		  
		  call table0.add_columns(Array("country","city","sales"))
		  
		  table0.append_row(Array("France","Paris",1100))
		  table0.append_row(Array("","Marseille",1200))
		  table0.append_row(Array("Belgique","",1300))
		  table0.append_row(Array("USA","NewYork",1400))
		  table0.append_row(Array("Belgique","Bruxelles",1500))
		  table0.append_row(Array("USA","Chicago",1600))
		  
		  dim tmp_row as clDataRow = table0.get_row(2, False)
		  
		  call check_value(log,"row 2, country", "Belgique", tmp_row.get_cell("country"))
		  call check_value(log, "row 2, city", "", tmp_row.get_cell("city"))
		  call check_value(log,"row 2, sales", 1300, tmp_row.get_cell("sales"))
		  
		  log.end_exec(CurrentMethodName)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_012(log as LogMessageInterface)
		  
		  log.start_exec(CurrentMethodName)
		  
		  Dim table0 As New clDataTable("mytable")
		  
		  call table0.add_columns(Array("country","city","sales"))
		  
		  table0.append_row(Array("France","Paris",1100))
		  table0.append_row(Array("","Marseille",1200))
		  table0.append_row(Array("Belgique","",1300))
		  table0.append_row(Array("USA","NewYork",1400))
		  table0.append_row(Array("Belgique","Bruxelles",1500))
		  table0.append_row(Array("USA","Chicago",1600))
		  
		  dim filterserie as new clBooleanDataSerie("mask",(False, False,True, False, True, False)) 
		  
		  call table0.add_column(filterserie)
		  
		  dim tmp_row as clDataRow = table0.get_row(3, False)
		  
		  call check_value(log,"row 3, country", "USA", tmp_row.get_cell("country"))
		  call check_value(log, "row 3, city", "NewYork", tmp_row.get_cell("city"))
		  call check_value(log,"row 3, sales", 1400, tmp_row.get_cell("sales"))
		  call check_value(log, "row 3, mask", False, tmp_row.get_cell("mask"))
		  
		  dim k as integer = 0
		  
		  for each row as clDataRow in table0.filtered_on("mask")
		    k = k+1
		  next
		  
		  call check_value(log, "filtered row count", 2, k)
		  
		  log.end_exec(CurrentMethodName)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_013(log as LogMessageInterface)
		  
		  log.start_exec(CurrentMethodName)
		  
		  
		  Dim table0 As New clDataTable("mytable")
		  
		  call table0.add_columns(Array("country","city","sales"))
		  
		  table0.append_row(Array("France","Paris",1100))
		  table0.append_row(Array("USA","NewYork",1400))
		  
		  table0.index_visible_when_iterate(True)
		  
		  dim row_index as integer = 0 // required for validation
		  
		  for each row as clDataRow in table0
		    
		    if row_index = 0 then
		      call check_value(log,"row 0, index",  0, row.get_cell("row_index"))
		      call check_value(log, "row 0, country",  "France", row.get_cell("country"))
		      call check_value(log,"row 0, city",  "Paris", row.get_cell("city"))
		      call check_value(log, "row 0, sales",  1100, row.get_cell("sales"))
		      
		    elseif row_index  = 1 then
		      call check_value(log, "row 1, index",  1, row.get_cell("row_index"))
		      call check_value(log, "row 1, country",  "USA", row.get_cell("country"))
		      call check_value(log, "row 1, city",  "NewYork", row.get_cell("city"))
		      call check_value(log, "row 1, sales",  1400, row.get_cell("sales"))
		      
		      
		      
		    end if
		    
		    row_index = row_index + 1
		  next
		  
		  
		  log.end_exec(CurrentMethodName)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_014(log as LogMessageInterface)
		  
		  log.start_exec(CurrentMethodName)
		  
		  
		  Dim table0 As New clDataTable("mytable")
		  
		  call table0.add_columns(Array("country","city","sales","product"))
		  
		  table0.append_row(Array("France","Paris",1100,"AA"))
		  table0.append_row(Array("","Marseille",1200,"AA"))
		  table0.append_row(Array("Belgique","",1300,"AA"))
		  table0.append_row(Array("USA","NewYork",1400,"AA"))
		  table0.append_row(Array("Belgique","Bruxelles",1500,"BB"))
		  table0.append_row(Array("USA","Chicago",1600,"AA"))
		  
		  dim filter_country as new clBooleanDataSerie("mask_country")
		  for each cell as string in table0.get_column("Country")
		    filter_country.append_element(cell = "Belgique")
		    
		  next
		  call table0.add_column(filter_country)
		  
		  dim filter_product as new clBooleanDataSerie("mask_product")
		  for each cell as string in table0.get_column("product")
		    filter_product.append_element(cell = "BB")
		    
		  next
		  call table0.add_column(not filter_product)
		  
		  
		  table0.index_visible_when_iterate(True)
		  
		  for each row as clDataRow in table0
		    for each cell as string in row
		      //system.DebugLog("field " + cell + "value " + row.get_cell(cell))
		      
		    next
		    
		  next
		  
		  dim k as integer = 1
		  
		  //  use the name of the boolean serie as parameter to 'filtered_on'
		  for each row as clDataRow in table0.filtered_on("mask_country")
		    k = k+1
		  next
		  
		  
		  log.end_exec(CurrentMethodName)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_015(log as LogMessageInterface)
		  
		  log.start_exec(CurrentMethodName)
		  
		  
		  Dim table0 As New clDataTable("mytable")
		  
		  call table0.add_columns(Array("country","city","sales","product"))
		  
		  table0.append_row(Array("France","Paris",1100,"AA"))
		  table0.append_row(Array("","Marseille",1200,"AA"))
		  table0.append_row(Array("Belgique","",1300,"AA"))
		  table0.append_row(Array("USA","NewYork",1400,"AA"))
		  table0.append_row(Array("Belgique","Bruxelles",1500,"BB"))
		  table0.append_row(Array("USA","Chicago",1600,"AA"))
		  
		  dim filter_country as new clBooleanDataSerie("mask_country")
		  for each cell as string in table0.get_column("Country")
		    filter_country.append_element(cell = "Belgique")
		    
		  next 
		  
		  dim filter_product as new clBooleanDataSerie("mask_product")
		  for each cell as string in table0.get_column("product")
		    filter_product.append_element(cell = "BB")
		    
		  next 
		  
		  //  
		  //  The filter series are not added to the table, but we can used them to filter the datatable
		  
		  table0.index_visible_when_iterate(True)
		  
		  for each row as clDataRow in table0
		    for each cell as string in row
		      //system.DebugLog("field " + cell + "value " + row.get_cell(cell))
		      
		    next
		    
		  next
		  
		  dim k as integer = 1
		  
		  //  directly use the  boolean serie as parameter to 'filtered_on'; and, or and not operator are overloaded for clBooleanDataSerie
		  
		  for each row as clDataRow in table0.filtered_on(filter_country and filter_product)
		    k = k+1
		  next
		  
		  
		  log.end_exec(CurrentMethodName)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_017(log as LogMessageInterface)
		  
		  log.start_exec(CurrentMethodName)
		  
		  Dim table0 As New clDataTable("mytable")
		  
		  call table0.add_columns(Array("country","city","sales"))
		  
		  table0.append_row(Array("France","Paris",1100))
		  table0.append_row(Array("","Marseille",1200))
		  table0.append_row(Array("Belgique","",1300))
		  table0.append_row(Array("France","Paris",2100))
		  table0.append_row(Array("","Marseille",2200))
		  table0.append_row(Array("Belgique","",2300))
		  table0.append_row(Array("USA","NewYork",2400))
		  table0.append_row(Array("Belgique","Bruxelles",2500))
		  table0.append_row(Array("USA","Chicago",2600))
		  table0.append_row(Array("USA","NewYork",1400))
		  table0.append_row(Array("Belgique","Bruxelles",1500))
		  table0.append_row(Array("USA","Chicago",1600))
		  
		  
		  Dim table1 As clDataTable = table0.unique(array("country", "city"))
		  
		  dim col1 as new clDataSerie("country", "France", "", "Belgique","Belgique","USA","USA")
		  
		  dim col2 as new clDataSerie("city", "Paris", "Marseille", "","Bruxelles","NewYork","Chicago")
		  
		  call check_table(log,"unique", new clDataTable("mytable", serie_array(col1, col2)), table1)
		  
		  
		  log.end_exec(CurrentMethodName)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_018(log as LogMessageInterface)
		  
		  log.start_exec(CurrentMethodName)
		  
		  
		  dim col_country as new clDataSerie("Country", "France", "", "Belgique", "France", "USA")
		  dim col_city as new clDataSerie("City", "Paris", "Marseille", "Bruxelles", "Lille", "Chicago")
		  dim col_sales as new clNumberDataSerie("sales", 900.0, 1200.0, 1400.0, 1600.0, 2900)
		  
		  Dim table0 As New clDataTable("mytable", serie_array(col_country, col_city, col_sales))
		  
		  call table0.add_column(col_sales *2 )
		  
		  dim nb as integer = table0.clip_range("sales",1000, 2000)
		  
		  call table0.add_column(col_sales.clipped_by_range(1100, 1500) * 2)
		  
		  // create expected table
		  dim col1 as clDataSerie = col_country.clone()
		  dim col2 as clDataSerie = col_city.clone()
		  dim col3 as new clNumberDataSerie("sales", 1000.0, 1200.0, 1400.0, 1600.0, 2000.0)
		  dim col4 as new clNumberDataSerie("sales*2", 1800.0, 2400.0, 2800.0, 3200.0, 5800.0)
		  dim col5 as new clNumberDataSerie("clip sales*2", 2200.0, 2400.0, 2800.0, 3000.0, 3000.0)
		  
		  call check_table(log,"clipping fct", new clDataTable("mytable", serie_array(col1, col2, col3, col4, col5)), table0)
		  
		  call check_value(log, "nb clipped", 3, nb)
		  
		  log.end_exec(CurrentMethodName)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_019(log as LogMessageInterface)
		  
		  log.start_exec(CurrentMethodName)
		  
		  dim dct as Dictionary
		  
		  dct = new Dictionary
		  dct.value("Country") = array("France", "", "Belgique", "France", "USA")
		  dct.Value("City") = array("Paris", "Marseille", "Bruxelles", "Lille", "Chicago")
		  dct.Value("Sales") = array(900.0, 1200.0, 1400.0, 1600.0, 2900)
		  
		  Dim table0 As New clDataTable("mytable", dct)  
		  
		  dim col_country as new clDataSerie("Country", "France", "", "Belgique", "France", "USA")
		  dim col_city as new clDataSerie("City", "Paris", "Marseille", "Bruxelles", "Lille", "Chicago")
		  dim col_sales as new clNumberDataSerie("Sales", 900.0, 1200.0, 1400.0, 1600.0, 2900)
		  
		  Dim table_expected As New clDataTable("mytable", serie_array(col_country, col_city, col_sales))
		  
		  call check_table(log,"use dict for creation", table_expected, table0)
		  
		  table0.get_column("City").display_title = "Ville"
		  table0.get_column("Country").display_title = "Pays"
		  table0.get_column("Sales").display_title="Ventes" 
		  
		  dim struc0 as clDataTable = table0.get_structure_as_table
		  
		  dct = new Dictionary
		  dct.value("name") = array("Country", "City", "Sales")
		  dct.Value("type") = array("Generic","Generic","Generic")
		  dct.Value("title") = array("Pays","Ville","Ventes")
		  
		  dim struc_expected as new clDataTable("exp_struct", dct)
		  
		  call check_table(log,"structure", struc_expected, struc0)
		  
		  
		  log.end_exec(CurrentMethodName)
		  
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_020(log as LogMessageInterface)
		  
		  log.start_exec(CurrentMethodName)
		  
		  dim dct as Dictionary
		  
		  dct = new Dictionary
		  dct.value("Country") = array("France", "", "Belgique", "France", "USA")
		  dct.Value("City") = array("Paris", "Marseille", "Bruxelles", "Lille", "Chicago")
		  dct.Value("Sales") = array(900.0, 1200.0, 1400.0, 1600.0, 2900)
		  
		  Dim table0 As New clDataTable("mytable", dct ,AddressOf alloc_series_019)
		  
		  dim col_country as new clDataSerie("Country", "France", "", "Belgique", "France", "USA")
		  dim col_city as new clDataSerie("City", "Paris", "Marseille", "Bruxelles", "Lille", "Chicago")
		  dim col_sales as new clNumberDataSerie("Sales", 900.0, 1200.0, 1400.0, 1600.0, 2900)
		  
		  Dim table_expected As New clDataTable("mytable", serie_array(col_country, col_city, col_sales))
		  
		  call check_table(log,"use dict for creation", table_expected, table0)
		  
		  table0.get_column("City").display_title = "Ville"
		  table0.get_column("Country").display_title = "Pays"
		  table0.get_column("Sales").display_title="Ventes" 
		  
		  dim struc0 as clDataTable = table0.get_structure_as_table
		  
		  dct = new Dictionary
		  dct.value("name") = array("Country", "City", "Sales")
		  dct.Value("type") = array("Generic","Generic","Number")
		  dct.Value("title") = array("Pays","Ville","Ventes")
		  
		  dim struc_expected as new clDataTable("exp_struct", dct)
		  call check_table(log,"structure", struc_expected, struc0)
		  
		  dim table1 as clDataTable = struc0.CreateTableFromStructure("mytable")
		  
		  dim struc1 as clDataTable = table0.get_structure_as_table
		  call check_table(log,"structure", struc_expected, struc1)
		  
		  
		  log.end_exec(CurrentMethodName)
		  
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_021(log as LogMessageInterface)
		  
		  log.start_exec(CurrentMethodName)
		  
		  dim c1 as new clDataSerie("DataSerie")
		  dim c2 as new clNumberDataSerie("NumberDataSerie")
		  dim c3 as new clStringDataSerie("StringDataSerie")
		  dim c4 as new clIntegerDataSerie("IntegerDataSerie")
		  
		  dim series() as clAbstractDataSerie = serie_array(c1, c2, c3, c4)
		  
		  for each cc as clAbstractDataSerie in series
		    cc.append_element("aaa")
		    cc.append_element(100)
		    cc.append_element(119)
		    cc.append_element(120)
		    cc.append_element(nil)
		    cc.append_element(0)
		    
		  next
		  
		  
		  
		  dim data_table as new clDataTable("data", series)
		  dim stat_table as clDataTable = data_table.get_statistics_as_table
		  
		  call stat_table.get_column(clDataTable.statistics_average_column).round_values(2)
		  
		  
		  //
		  // Expected table
		  
		  series.RemoveAll
		  
		  series.Add(new clDataSerie(clDataTable.statistics_name_column, array("DataSerie", "NumberDataSerie", "StringDataSerie", "IntegerDataSerie")))
		  
		  series.add(new clIntegerDataSerie(clDataTable.statistics_ubound_column, array(5,5,5,5)))
		  series.Add(new clIntegerDataSerie(clDataTable.statistics_count_column, array(5,6,6,6)))
		  series.Add(new clIntegerDataSerie(clDataTable.statistics_count_nz_column, array(3,3,3,3)))
		  
		  series.Add(new clNumberDataSerie(clDataTable.statistics_sum_column, array(339.0,339.0,339.0,339.0)))
		  series.Add(new clNumberDataSerie(clDataTable.statistics_average_column, array(67.8, 56.5, 56.5, 56.5)))
		  series.Add(new clNumberDataSerie(clDataTable.statistics_average_nz_column, array(113, 113, 113, 113)))
		  
		  series.Add(new clNumberDataSerie(clDataTable.statistics_std_dev_column, array(62.4035, 62.3, 62.3, 62.3)))
		  series.Add(new clNumberDataSerie(clDataTable.statistics_std_dev_nz_column, array(11.27, 11.27, 11.27)))
		  
		  dim table_expected as clDataTable = new clDataTable("expected", series)
		  
		  call check_table(log,"statistics", table_expected, stat_table)
		  
		  
		  log.end_exec(CurrentMethodName)
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_examples(log as LogMessageInterface)
		  
		  dim logwriter as  LogMessageInterface = log 
		  
		  if log = nil then
		    logwriter = new clWriteToSystemLog
		  end if
		  
		  
		  dim ex() as clLibDataExample = clLibDataExample.get_all_examples
		  
		  for each example as clLibDataExample in ex
		    call example.run(logwriter)
		    
		  next
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_io_001(log as LogMessageInterface)
		  
		  log.start_exec(CurrentMethodName)
		  
		  Dim fld_folder As New FolderItem
		  Dim fld_file1 As FolderItem
		  Dim fld_file2 As FolderItem
		  Dim fld_file3 As FolderItem
		  
		  fld_folder = fld_folder.Child("test-data")
		  
		  fld_file1 = fld_folder.Child("myfile3_10K_tab.txt")
		  fld_file2  = fld_folder.Child("myfile3_10K_comma.txt")
		  fld_file3  = fld_folder.Child("myfile3_10K_output.txt")
		  
		  Dim my_table3 As New clDataTable(new clTextReader(fld_file1, True, new clTextFileConfig(chr(9))))
		  
		  Dim my_table4 As New clDataTable(new clTextReader(fld_file2, True, New clTextFileConfig(",")))
		  
		  my_table4.save(new clTextWriter(fld_file3, True, new clTextFileConfig(";")))
		  
		  dim my_table5 as new clDataTable(new clTextReader(fld_file3, True, new clTextFileConfig(";")))
		  
		  call check_table(log,"T4/T5", my_table4, my_table5) 
		  
		  dim my_table6  as new clDataTable(new clTextReader(fld_file1, True, New clTextFileConfig(Chr(9))), AddressOf alloc_series_io1)
		  
		  
		  log.end_exec(CurrentMethodName)
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_io_002(log as LogMessageInterface)
		  
		  log.start_exec(CurrentMethodName)
		  
		  dim db as new SQLiteDatabase
		  
		  Try
		    db.Connect
		    
		  Catch error As DatabaseException
		    System.DebugLog("DB Connection Error: " + error.Message)
		    
		  End Try
		  
		  dim dbrow as  DatabaseRow
		  
		  //test1
		  db.ExecuteSQL("create table test1(ID INTEGER NOT NULL, aaa varchar(20), bbb integer, ccc float, PRIMARY KEY(ID))")
		  
		  dbrow = new DatabaseRow
		  dbrow.Column("aaa")="Belgium1"
		  dbrow.Column("bbb")= 32
		  dbrow.Column("ccc") = 10.3
		  db.AddRow("test1", dbrow)
		  
		  dbrow = new DatabaseRow
		  dbrow.Column("aaa")="France1"
		  dbrow.Column("bbb")= 3
		  dbrow.Column("ccc") = 14.6
		  db.AddRow("test1", dbrow)
		  
		  dbrow = new DatabaseRow
		  dbrow.Column("aaa")="Italy1"
		  dbrow.Column("bbb")= 39
		  dbrow.Column("ccc") = 12.7
		  db.AddRow("test1", dbrow)
		  
		  //db.CommitTransaction
		  
		  
		  
		  //test3
		  db.ExecuteSQL("create table test3(ID INTEGER NOT NULL, aaa varchar(20), bbb integer, ddd float, PRIMARY KEY(ID))")
		  
		  
		  dbrow = new DatabaseRow
		  dbrow.Column("aaa")="Belgium1"
		  dbrow.Column("bbb")= 32
		  dbrow.Column("ddd") = 10.3
		  db.AddRow("test3", dbrow)
		  
		  dbrow = new DatabaseRow
		  dbrow.Column("aaa")="France1"
		  dbrow.Column("bbb")= 3
		  dbrow.Column("ddd") = 14.6
		  db.AddRow("test3", dbrow)
		  
		  dbrow = new DatabaseRow
		  dbrow.Column("aaa")="Italy1"
		  dbrow.Column("bbb")= 39
		  dbrow.Column("ddd") = 12.7
		  db.AddRow("test3", dbrow)
		  
		  
		  dim my_table1 as new clDataTable(new clDBReader(db.SelectSql("select * from test1")))
		  my_table1.rename("test2")
		  my_table1.save(new clDBWriter(new clSqliteDBAccess(db)))
		  
		  dim my_table2 as new clDataTable(new clDBReader(db.SelectSql("select * from test2")))
		  
		  call check_table(log,"Test1/Test2", my_table1, my_table2)
		  
		  
		  
		  dim my_table3 as new clDataTable(new clDBReader(db.SelectSql("select * from test3")))
		  my_table3.rename("test4")
		  my_table3.save(new clDBAppendWriter(new clSqliteDBAccess(db)))
		  
		  dim my_table4 as new clDataTable(new clDBReader(db.SelectSql("select * from test4")))
		  
		  call check_table(log,"Test3/Test4", my_table3, my_table4)
		  
		  
		  dim my_table5 as new clDataTable(new clDBReader(db.SelectSQL("select * from test1")))
		  
		  dim my_table6 as new clDataTable(new clDBReader(db.SelectSQL("select * from test3")))
		  
		  // create expected ds
		  dim my_table7 as clDataTable = my_table5.clone
		  my_table7.append_from_column_source(my_table6)
		  
		  
		  // add rows from test3 to test2
		  my_table6.rename("test2")
		  my_table6.save(new clDBAppendWriter(new clSqliteDBAccess(db)))
		  
		  
		  dim my_table8 as new clDataTable(new clDBReader(db.SelectSQL("select * from test2")))
		  
		  
		  call check_table(log,"Test7/Test8", my_table7, my_table8)
		  
		  
		  log.end_exec(CurrentMethodName)
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_io_003(log as LogMessageInterface)
		  
		  log.start_exec(CurrentMethodName)
		  
		  dim db as new SQLiteDatabase
		  
		  Try
		    db.Connect
		    
		  Catch error As DatabaseException
		    System.DebugLog("DB Connection Error: " + error.Message)
		    
		  End Try
		  
		  dim dbrow as  DatabaseRow
		  
		  //test1
		  db.ExecuteSQL("create table test1(ID INTEGER NOT NULL, aaa varchar(20), bbb integer, ccc float, PRIMARY KEY(ID))")
		  
		  dbrow = new DatabaseRow
		  dbrow.Column("aaa")="Belgium1"
		  dbrow.Column("bbb")= 32
		  dbrow.Column("ccc") = 10.3
		  db.AddRow("test1", dbrow)
		  
		  dbrow = new DatabaseRow
		  dbrow.Column("aaa")="France1"
		  dbrow.Column("bbb")= 3
		  dbrow.Column("ccc") = 14.6
		  db.AddRow("test1", dbrow)
		  
		  dbrow = new DatabaseRow
		  dbrow.Column("aaa")="Italy1"
		  dbrow.Column("bbb")= 39
		  dbrow.Column("ccc") = 12.7
		  db.AddRow("test1", dbrow)
		  
		  //db.CommitTransaction
		  
		  
		  
		  //test3
		  db.ExecuteSQL("create table test3(ID INTEGER NOT NULL, aaa varchar(20), bbb integer, ddd float, PRIMARY KEY(ID))")
		  
		  
		  dbrow = new DatabaseRow
		  dbrow.Column("aaa")="Belgium1"
		  dbrow.Column("bbb")= 32
		  dbrow.Column("ddd") = 10.3
		  db.AddRow("test3", dbrow)
		  
		  dbrow = new DatabaseRow
		  dbrow.Column("aaa")="France1"
		  dbrow.Column("bbb")= 3
		  dbrow.Column("ddd") = 14.6
		  db.AddRow("test3", dbrow)
		  
		  dbrow = new DatabaseRow
		  dbrow.Column("aaa")="Italy1"
		  dbrow.Column("bbb")= 39
		  dbrow.Column("ddd") = 12.7
		  db.AddRow("test3", dbrow)
		  
		  
		  dim my_table1 as new clDataTable("test2", new clDBReader(new clSqliteDBAccess(db),"test1"))
		  
		  my_table1.save(new clDBWriter(new clSqliteDBAccess(db)))
		  
		  dim my_table2 as new clDataTable(new clDBReader(db.SelectSql("select * from test2")))
		  
		  call check_table(log,"Test1/Test2", my_table1, my_table2)
		  
		  
		  dim my_table3 as new clDataTable("test4", new clDBReader(new clSqliteDBAccess(db),"test3"))
		  
		  my_table3.save(new clDBAppendWriter(new clSqliteDBAccess(db)))
		  
		  dim my_table4 as new clDataTable(new clDBReader(db.SelectSql("select * from test4")))
		  
		  call check_table(log,"Test3/Test4", my_table3, my_table4)
		  
		  
		  dim my_table5 as new clDataTable(new clDBReader(db.SelectSQL("select * from test1")))
		  
		  dim my_table6 as new clDataTable(new clDBReader(db.SelectSQL("select * from test3")))
		  
		  // create expected ds
		  dim my_table7 as clDataTable = my_table5.clone
		  my_table7.append_from_column_source(my_table6)
		  
		  
		  // add rows from test3 to test2
		  my_table6.rename("test2")
		  my_table6.save(new clDBAppendWriter(new clSqliteDBAccess(db)))
		  
		  
		  dim my_table8 as new clDataTable(new clDBReader(db.SelectSQL("select * from test2")))
		  
		  call check_table(log,"Test7/Test8", my_table7, my_table8)
		  
		  log.end_exec(CurrentMethodName)
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_io_004(log as LogMessageInterface)
		  
		  
		  log.start_exec(CurrentMethodName)
		  
		  Dim fld_folder As New FolderItem
		  Dim fld_file1 As FolderItem
		  Dim fld_file2 As FolderItem
		  Dim fld_file3 As FolderItem
		  dim fld_fileX as FolderItem
		  
		  fld_folder = fld_folder.Child("test-data")
		  
		  fld_file1 = fld_folder.Child("myfile4_A_tab.txt")
		  fld_file2  = fld_folder.Child("myfile4_B_tab.txt") 
		  fld_file3  = fld_folder.Child("myfile4_C_tab.txt") 
		  fld_fileX  = fld_folder.Child("myfile4_X_tab.txt") 
		  
		  
		  dim my_table as new clDataTable("calc")
		  call my_table.add_column(new clStringDataSerie("Alpha"))
		  call my_table.add_column(new clIntegerDataSerie("Beta"))
		  call my_table.add_column(new clNumberDataSerie("Delta"))
		  call my_table.add_column(new clNumberDataSerie("Gamma"))
		  call my_table.add_column(new clIntegerDataSerie("Group"))
		  
		  
		  dim dct_mapping_file3 as new Dictionary
		  dct_mapping_file3.value("Un") = "Alpha"
		  dct_mapping_file3.value("Deux") = "Beta"
		  dct_mapping_file3.value("Trois") = "Gamma"
		  dct_mapping_file3.value("Quatre") = "Delta"
		  dct_mapping_file3.value("Extra") = "New_col"
		  
		  my_table.append_from_row_source(new clTextReader(fld_file1, True, new clTextFileConfig(chr(9))))
		  
		  my_table.append_from_row_source(new clTextReader(fld_file2, True, new clTextFileConfig(chr(9))))
		  
		  my_table.append_from_row_source(new clTextReader(fld_file3, True, new clTextFileConfig(chr(9))),dct_mapping_file3)
		  
		  dim expected_table as new clDataTable("calc")
		  call expected_table.add_column(new clStringDataSerie("Alpha"))
		  call expected_table.add_column(new clIntegerDataSerie("Beta"))
		  call expected_table.add_column(new clNumberDataSerie("Delta"))
		  call expected_table.add_column(new clNumberDataSerie("Gamma"))
		  call expected_table.add_column(new clIntegerDataSerie("Group"))
		  call expected_table.add_column(new clStringDataSerie("New_col"))
		  
		  expected_table.append_from_row_source(new clTextReader(fld_fileX, True, new clTextFileConfig(chr(9))))
		  
		  call check_table(log,"T4/T5", expected_table, my_table, 0.0001) 
		  
		  log.end_exec(CurrentMethodName)
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_io_005(log as LogMessageInterface)
		  
		  log.start_exec(CurrentMethodName)
		  
		  dim v1 as new clDBReader(nil, "my_table")
		  dim v1_name as string = v1.name
		  
		  
		  dim v2 as new clDBReader(nil, "select alpha, beta from my_table")
		  dim v2_name as string = v2.name
		  
		  dim v3 as new clDBReader(nil, "select alpha, beta from my_table left join something on ")
		  dim v3_name as string = v3.name
		  
		  dim v4 as new clDBReader(nil, "select alpha, beta  from   my_table")
		  dim v4_name as string = v4.name
		  
		  call check_value(log, "name v1", "my_table", v1_name)
		  call check_value(log, "name v2", "my_table", v2_name)
		  call check_value(log, "name v3", "my_table", v3_name)
		  call check_value(log, "name v3", "my_table", v4_name)
		  
		  log.end_exec(CurrentMethodName)
		  
		  
		  
		End Sub
	#tag EndMethod


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
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
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
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
