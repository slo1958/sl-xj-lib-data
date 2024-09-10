#tag Module
Protected Module clDataTable_tests
	#tag Method, Flags = &h0
		Function alloc_obj(name as string) As object
		  select case name
		  case "test_class_01"
		    return new test_class_01
		    
		  case "test_class_02"
		    return new test_class_02
		    
		  case "test_class_03"
		    return new test_class_03
		    
		  case else
		    return nil
		    
		  end select
		  
		  
		End Function
	#tag EndMethod

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
		  var cnt1 as integer  
		  var cnt2 as integer 
		  
		  cnt1 = expected.column_count
		  cnt2 = calculated.column_count
		  
		  if not check_value(log,"column count", cnt1, cnt2) then return False
		  
		  var col_ok as boolean = True
		  for col as integer = 0 to expected.column_count-1
		    
		    col_ok = col_ok and check_serie(log, label + " field [" + expected.column_name(col)+"]", expected.get_column_by_index(col), calculated.get_column_by_index(col), accepted_error_on_double)
		    
		  next
		  
		  Return col_ok
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function filter_008(the_row_index as integer, the_row_count as integer, the_column_names() as string, the_cell_values() as variant, paramarray function_param as variant) As Boolean
		  var idx as integer = the_column_names.IndexOf("cc2")
		  
		  return the_cell_values(idx) = function_param(0)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub tests(log as LogMessageInterface)
		  
		  var logwriter as  LogMessageInterface = log 
		  
		  if log = nil then
		    logwriter = new clWriteToSystemLog
		  end if
		  
		  logwriter.start_exec(CurrentMethodName)
		  
		  test_001(logwriter)
		  test_002(logwriter)
		  test_003(logwriter)
		  test_004(logwriter)
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
		  test_016(logwriter)
		  test_017(logwriter)
		  test_018(logwriter)
		  test_019(logwriter)
		  test_020(logwriter)
		  test_021(logwriter)
		  test_022(logwriter)
		  test_023(logwriter)
		  test_024(logwriter)
		  test_025(logwriter)
		  test_026(logwriter)
		  
		  
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
		  
		  test_io_005(logwriter)
		  
		  logwriter.end_exec(CurrentMethodName)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_001(log as LogMessageInterface)
		  
		  log.start_exec(CurrentMethodName)
		  
		  var rtst As clDataRow
		  
		  var my_table As New clDataTable("T1")
		  
		  rtst = New clDataRow
		  rtst.set_cell("aaa",1234)
		  rtst.set_cell("bbb","abcd")
		  rtst.set_cell("ccc",123.456)
		  
		  my_table.AddRow(rtst)
		  
		  rtst = New clDataRow
		  rtst.set_cell("aaa",1235)
		  rtst.set_cell("bbb","abce")
		  rtst.set_cell("ddd",987.654)
		  
		  my_table.AddRow(rtst)
		  
		  var col1 as new clDataSerie("aaa", 1234, 1235)
		  var col2 as new clDataSerie("bbb", "abcd", "abce")
		  var col3 as new clDataSerie("ccc", 123.456, nil)
		  var col4 as new clDataSerie("ddd", nil, 987.654)
		  
		  
		  var texpected as new clDataTable("T1", serie_array(col1, col2, col3 ,col4))
		  
		  call check_table(log, "T1", texpected, my_table)
		  
		  log.end_exec(CurrentMethodName)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_002(log as LogMessageInterface)
		  
		  log.start_exec(CurrentMethodName)
		  
		  var rtst As clDataRow
		  
		  var my_table1 As New clDataTable("T1")
		  
		  rtst = New clDataRow
		  rtst.set_cell("aaa",1234)
		  rtst.set_cell("bbb","abcd")
		  rtst.set_cell("ccc",123.456)
		  
		  my_table1.AddRow(rtst)
		  
		  rtst = New clDataRow
		  rtst.set_cell("aaa",1235)
		  rtst.set_cell("bbb","abce")
		  rtst.set_cell("ddd",987.654)
		  
		  my_table1.AddRow(rtst)
		  
		  var my_table2 As New clDataTable("T2")
		  
		  rtst = New clDataRow
		  rtst.set_cell("aaa",81234)
		  rtst.set_cell("bbb","zabcd")
		  rtst.set_cell("zccc",8123.456)
		  
		  my_table2.AddRow(rtst)
		  
		  rtst = New clDataRow
		  rtst.set_cell("aaa",81235)
		  rtst.set_cell("bbb","zabce")
		  rtst.set_cell("zddd",8987.654)
		  
		  my_table2.AddRow(rtst)
		  
		  my_table1.append_from_column_source(my_table2)
		  
		  var my_table3 As clDataTable = my_table1.select_columns(Array("aaa","zccc"))
		  
		  
		  var col1 as new clDataSerie("aaa", 1234, 1235, 81234, 81235)
		  var col2 as new clDataSerie("zccc", nil, nil, 8123.456, nil)
		  var texpected as new clDataTable("select T1", serie_array(col1, col2))
		  
		  call check_table(log, "T1", my_table3, texpected)
		  
		  log.end_exec(CurrentMethodName)
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_003(log as LogMessageInterface)
		  
		  log.start_exec(CurrentMethodName)
		  
		  
		  var rtst As clDataRow
		  var my_table1 As New clDataTable("T1")
		  
		  
		  rtst = New clDataRow
		  rtst.set_cell("aaa",1234)
		  rtst.set_cell("bbb","abcd")
		  rtst.set_cell("ccc",123.456)
		  
		  my_table1.AddRow(rtst)
		  
		  rtst = New clDataRow
		  rtst.set_cell("aaa",1235)
		  rtst.set_cell("bbb","abce")
		  rtst.set_cell("ddd",987.654)
		  
		  my_table1.AddRow(rtst) 
		  
		  var my_col As clAbstractDataSerie
		  var my_table3 As clDataTable = my_table1.select_columns(Array("aaa","zccc")) // zccc does not exist, not included in my_table3
		  
		  
		  my_col = my_table3.AddColumn("xyz") 
		  
		  var col1 as new clDataSerie("aaa", 1234, 1235)
		  var col2 as new clDataSerie("xyz", nil, nil) 
		  
		  var texpected as new clDataTable("select T1", serie_array(col1, col2))
		  
		  call check_table(log,"T1", texpected, my_table3)
		  
		  log.end_exec(CurrentMethodName)
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_004(log as LogMessageInterface)
		  
		  log.start_exec(CurrentMethodName)
		  
		  var rtst As clDataRow
		  
		  var my_table As New clDataTable("T1")
		  
		  var d as new Dictionary
		  d.value("aaa") = 1234
		  d.value("bbb") =  "abcd"
		  d.value("ccc") =  123.456
		  rtst = New clDataRow(d)
		  
		  my_table.AddRow(rtst)
		  
		  var c as new test_class_01
		  c.aaa = 1235
		  c.bbb = "abce"
		  c.ddd = 987.654
		  
		  rtst = New clDataRow(c)
		  
		  my_table.AddRow(rtst)
		  
		  var col1 as new clDataSerie("aaa", 1234, 1235)
		  var col2 as new clDataSerie("bbb", "abcd", "abce")
		  var col3 as new clDataSerie("ccc", 123.456, nil)
		  var col4 as new clDataSerie("ddd", nil, 987.654)
		  
		  var texpected as new clDataTable("T1", serie_array(col1, col2, col3 ,col4))
		  
		  call check_table(log, "T1", texpected, my_table)
		  
		  log.end_exec(CurrentMethodName)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_005(log as LogMessageInterface)
		  
		  log.start_exec(CurrentMethodName)
		  
		  
		  var rtst As clDataRow
		  
		  var my_table As New clDataTable("T1")
		  
		  rtst = New clDataRow
		  rtst.set_cell("aaa",1234)
		  rtst.set_cell("bbb","abcd")
		  rtst.set_cell("ccc",123.456)
		  
		  my_table.AddRow(rtst)
		  
		  rtst = New clDataRow
		  rtst.set_cell("aaa",1235)
		  rtst.set_cell("bbb","abce")
		  rtst.set_cell("ddd",987.654)
		  
		  my_table.AddRow(rtst)
		  
		  var cols() As clAbstractDataSerie
		  
		  cols = my_table.get_columns("aaa","bbb","ddd")
		  
		  cols(1).rename("bB1")
		  
		  var col1 as new clDataSerie("aaa", 1234, 1235)
		  var col2 as new clDataSerie("bB1", "abcd", "abce")
		  var col3 as new clDataSerie("ccc", 123.456, nil)
		  var col4 as new clDataSerie("ddd", nil, 987.654)
		  
		  
		  var texpected as new clDataTable("T1", serie_array(col1, col2, col3 ,col4))
		  
		  call check_table(log,"T1", texpected, my_table)
		  
		  log.end_exec(CurrentMethodName)
		  
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_006(log as LogMessageInterface)
		  
		  log.start_exec(CurrentMethodName)
		  
		  
		  var c1 As New clDataSerie("premier")
		  var c2 As New clDataSerie("second")
		  
		  c1.append_element("aaa")
		  c1.append_element("bbb")
		  c1.append_element("ccc")
		  
		  
		  c2.append_element(12)
		  c2.append_element(34)
		  c2.append_element(56)
		  c2.append_element(78)
		  
		  var t1 As New clDataTable("mytable1", serie_array(c1, c2))
		  
		  var t2 As New clDataTable("mytable2", serie_array(c1, c2), True)
		  
		  var r1 As clDataRow
		  r1 = New clDataRow
		  r1.set_cell("premier","dddd")
		  r1.set_cell("second",90)
		  
		  t1.AddRow(r1)
		  
		  r1.set_cell("troisieme",True)
		  t2.AddRow(r1)
		  
		  
		  var col1 as new clDataSerie("premier","aaa","bbb","ccc",nil,"dddd")
		  var col2 as new clDataSerie("second",12,34,56,78,90)
		  
		  var expected_t1 as new clDataTable("mytable1", serie_array(col1, col2))
		  
		  var col3 as new clDataSerie("premier","aaa","bbb","ccc",nil,"dddd")
		  var col4 as new clDataSerie("second",12,34,56,78,90)
		  var col5 as new clDataSerie("troisieme",nil,nil,nil,nil,True)
		  
		  var expected_t2 as new clDataTable("mytable2", serie_array(col3, col4, col5))
		  
		  call check_table(log,"mytable1", expected_t1, t1)
		  
		  call check_table(log,"mytable2", expected_t2, t2)
		  
		  
		  log.end_exec(CurrentMethodName)
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_007(log as LogMessageInterface)
		  
		  log.start_exec(CurrentMethodName)
		  
		  
		  var my_table As New clDataTable("T1")
		  
		  call my_table.AddColumns(Array("cc1","cc2","cc3"))
		  
		  my_table.AddRow(Array("aaa0","bbb0","ccc0"))
		  my_table.AddRow(Array("aaa1","bbb1","ccc1"))
		  my_table.AddRow(Array("aaa2","bbb2","ccc2"))
		  my_table.AddRow(Array("aaa3","bbb3","ccc3"))
		  
		  var tmp1 As Integer = my_table.find_first_matching_row_index("cc2","bbb2")
		  var tmp2 As Integer = my_table.find_first_matching_row_index("cc2","zzz2")
		  var tmp3 As Integer = my_table.find_first_matching_row_index("zz2","bbb2")
		  
		  call check_value(log, "tmp1", 2, tmp1)
		  call check_value(log, "tmp2", -1, tmp2) // value not found
		  call check_value(log, "tmp3", -2, tmp3) // column not found
		  
		  log.end_exec(CurrentMethodName)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_008(log as LogMessageInterface)
		  
		  log.start_exec(CurrentMethodName)
		  
		  
		  var my_table As New clDataTable("T1")
		  
		  call my_table.AddColumns(Array("cc1","cc2","cc3"))
		  
		  my_table.AddRow(Array("aaa0","bbb0","ccc0"))
		  my_table.AddRow(Array("aaa1","bbb1","ccc1"))
		  my_table.AddRow(Array("aaa2","bbb0","ccc2"))
		  my_table.AddRow(Array("aaa3","bbb3","ccc3"))
		  
		  //  The function is filtering on column cc2. The parameter is the value to look for
		  
		  var tmp1() as variant = my_table.filter_with_function(AddressOf filter_008,"bbb0")
		  
		  call my_table.AddColumn(new clBooleanDataSerie("is_bbb0", tmp1))
		  
		  call my_table.AddColumn(new clBooleanDataSerie("is_bbb1", clDataSerie(my_table.get_column("cc2")).filter_value_in_list(array("bbb1"))))
		  
		  call my_table.AddColumn(new clBooleanDataSerie("is_bbb3",  my_table.filter_with_function(AddressOf filter_008, "bbb3")))
		  
		  
		  var col1 as new clDataSerie("cc1", "aaa0","aaa1","aaa2","aaa3")
		  var col2 as new clDataSerie("cc2", "bbb0","bbb1","bbb0","bbb3")
		  var col3 as new clDataSerie("cc3", "ccc0","ccc1","ccc2","ccc3")
		  
		  var col4 as new clDataSerie("is_bbb0", True, False, True, False)
		  
		  var col5 as new clDataSerie("is_bbb1", False, True, False, False)
		  var col6 as new clDataSerie("is_bbb3", False, False, False, True)
		  
		  var expected as new clDataTable("T1", serie_array(col1, col2, col3, col4, col5, col6))
		  
		  call check_table(log,"t1", expected, my_table)
		  
		  log.end_exec(CurrentMethodName)
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_009(log as LogMessageInterface)
		  
		  log.start_exec(CurrentMethodName)
		  
		  
		  var rtst As clDataRow
		  
		  var my_table1 As New clDataTable("T1")
		  var my_table2 as New clDataTable("T2")
		  
		  for i as integer = 1 to 4
		    rtst = New clDataRow
		    rtst.set_cell("aaa",I*1000)
		    rtst.set_cell("bbb","abcd")
		    rtst.set_cell("ccc",123.456)
		    
		    my_table1.AddRow(rtst)
		    
		  next
		  
		  
		  for i as integer = 5 to 9
		    rtst = New clDataRow
		    rtst.set_cell("aaa",I*1000)
		    rtst.set_cell("bbb","xyz")
		    rtst.set_cell("ddd",567.89)
		    
		    my_table2.AddRow(rtst)
		    
		  next
		  
		  var my_table3 as clDataTable = my_table1.clone()
		  var my_table4 as clDataTable = my_table1.clone()
		  
		  my_table3.append_from_column_source(my_table2, true)
		  my_table4.append_from_column_source(my_table2, false)
		  
		  var col1 as new clDataSerie("aaa", 1000, 2000, 3000, 4000)
		  var col2 as new clDataSerie("bbb","abcd","abcd","abcd","abcd")
		  var col3 as new clDataSerie("ccc", 123.456, 123.456, 123.456, 123.456)
		  
		  var expected_t1 as new clDataTable("T1", serie_array(col1, col2, col3))
		  
		  var col4 as new clDataSerie("aaa", 5000, 6000, 7000, 8000, 9000)
		  var col5 as new clDataSerie("bbb","xyz","xyz","xyz","xyz", "xyz")
		  var col6 as new clDataSerie("ddd", 567.89, 567.89, 567.89, 567.89, 567.89)
		  
		  var expected_t2 as new clDataTable("T2", serie_array(col4, col5, col6))
		  
		  
		  var col7 as new clDataSerie("aaa", 1000, 2000, 3000, 4000, 5000, 6000, 7000, 8000, 9000)
		  var col8 as new clDataSerie("bbb","abcd","abcd","abcd","abcd","xyz","xyz","xyz","xyz", "xyz")
		  var col9 as new clDataSerie("ccc", 123.456, 123.456, 123.456, 123.456, nil, nil, nil, nil, nil)
		  var col0 as new clDataSerie("ddd", nil, nil, nil, nil, 567.89, 567.89, 567.89, 567.89, 567.89)
		  var expected_t3 as new clDataTable("T3", serie_array(col7, col8, col9, col0))
		  
		  var expected_t4 as new clDataTable("T4", serie_array(col7, col8, col9), True)
		  
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
		  
		  
		  var temp_row As clDataRow
		  var mytable As New clDataTable("T1")
		  
		  call mytable.AddColumn(new clDataSerie("name"))
		  call mytable.AddColumn(new clNumberDataSerie("quantity"))
		  call mytable.AddColumn(new clNumberDataSerie("unit_price"))
		  
		  temp_row = New clDataRow
		  temp_row.set_cell("name","alpha")
		  temp_row.set_cell("quantity",50)
		  temp_row.set_cell("unit_price",6)
		  mytable.AddRow(temp_row)
		  
		  temp_row = New clDataRow
		  temp_row.set_cell("name","alpha")
		  temp_row.set_cell("quantity",20)
		  temp_row.set_cell("unit_price",8)
		  mytable.AddRow(temp_row)
		  
		  call mytable.AddColumn(clNumberDataSerie(mytable.get_column("unit_price")) * clNumberDataSerie(mytable.get_column("quantity")))
		  
		  var col1 as new clDataSerie("name", "alpha","alpha")
		  var col2 as new clNumberDataSerie("quantity", 50, 20)
		  var col3 as new clNumberDataSerie("unit_price", 6, 8)
		  var col4 as new clNumberDataSerie("unit_price*quantity", 300, 160)
		  
		  var expected_t1 as new clDataTable("T1", serie_array(col1, col2, col3, col4))
		  
		  call check_table(log,"T1", expected_t1, mytable)
		  
		  
		  log.end_exec(CurrentMethodName)
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_011(log as LogMessageInterface)
		  
		  log.start_exec(CurrentMethodName)
		  
		  
		  var table0 As New clDataTable("mytable")
		  
		  call table0.AddColumns(Array("country","city","sales"))
		  
		  table0.AddRow(Array("France","Paris",1100))
		  table0.AddRow(Array("","Marseille",1200))
		  table0.AddRow(Array("Belgique","",1300))
		  table0.AddRow(Array("USA","NewYork",1400))
		  table0.AddRow(Array("Belgique","Bruxelles",1500))
		  table0.AddRow(Array("USA","Chicago",1600))
		  
		  var tmp_row as clDataRow = table0.get_row(2, False)
		  
		  call check_value(log,"row 2, country", "Belgique", tmp_row.get_cell("country"))
		  call check_value(log, "row 2, city", "", tmp_row.get_cell("city"))
		  call check_value(log,"row 2, sales", 1300, tmp_row.get_cell("sales"))
		  
		  log.end_exec(CurrentMethodName)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_012(log as LogMessageInterface)
		  
		  log.start_exec(CurrentMethodName)
		  
		  var table0 As New clDataTable("mytable")
		  
		  call table0.AddColumns(Array("country","city","sales"))
		  
		  table0.AddRow(Array("France","Paris",1100))
		  table0.AddRow(Array("","Marseille",1200))
		  table0.AddRow(Array("Belgique","",1300))
		  table0.AddRow(Array("USA","NewYork",1400))
		  table0.AddRow(Array("Belgique","Bruxelles",1500))
		  table0.AddRow(Array("USA","Chicago",1600))
		  
		  var filterserie as new clBooleanDataSerie("mask",(False, False,True, False, True, False)) 
		  
		  call table0.AddColumn(filterserie)
		  
		  var tmp_row as clDataRow = table0.get_row(3, False)
		  
		  call check_value(log,"row 3, country", "USA", tmp_row.get_cell("country"))
		  call check_value(log, "row 3, city", "NewYork", tmp_row.get_cell("city"))
		  call check_value(log,"row 3, sales", 1400, tmp_row.get_cell("sales"))
		  call check_value(log, "row 3, mask", False, tmp_row.get_cell("mask"))
		  
		  var k as integer = 0
		  
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
		  
		  
		  var table0 As New clDataTable("mytable")
		  
		  call table0.AddColumns(Array("country","city","sales"))
		  
		  table0.AddRow(Array("France","Paris",1100))
		  table0.AddRow(Array("USA","NewYork",1400))
		  
		  table0.index_visible_when_iterate(True)
		  
		  var row_index as integer = 0 // required for validation
		  
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
		  
		  
		  var table0 As New clDataTable("mytable")
		  
		  call table0.AddColumns(Array("country","city","sales","product"))
		  
		  table0.AddRow(Array("France","Paris",1100,"AA"))
		  table0.AddRow(Array("","Marseille",1200,"AA"))
		  table0.AddRow(Array("Belgique","",1300,"AA"))
		  table0.AddRow(Array("USA","NewYork",1400,"AA"))
		  table0.AddRow(Array("Belgique","Bruxelles",1500,"BB"))
		  table0.AddRow(Array("USA","Chicago",1600,"AA"))
		  
		  var filter_country as new clBooleanDataSerie("mask_country")
		  for each cell as string in table0.get_column("Country")
		    filter_country.append_element(cell = "Belgique")
		    
		  next
		  call table0.AddColumn(filter_country)
		  
		  var filter_product as new clBooleanDataSerie("mask_product")
		  for each cell as string in table0.get_column("product")
		    filter_product.append_element(cell = "BB")
		    
		  next
		  call table0.AddColumn(not filter_product)
		  
		  
		  table0.index_visible_when_iterate(True)
		  
		  for each row as clDataRow in table0
		    for each cell as string in row
		      //system.DebugLog("field " + cell + "value " + row.get_cell(cell))
		      
		    next
		    
		  next
		  
		  var k as integer = 1
		  
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
		  
		  
		  var table0 As New clDataTable("mytable")
		  
		  call table0.AddColumns(Array("country","city","sales","product"))
		  
		  table0.AddRow(Array("France","Paris",1100,"AA"))
		  table0.AddRow(Array("","Marseille",1200,"AA"))
		  table0.AddRow(Array("Belgique","",1300,"AA"))
		  table0.AddRow(Array("USA","NewYork",1400,"AA"))
		  table0.AddRow(Array("Belgique","Bruxelles",1500,"BB"))
		  table0.AddRow(Array("USA","Chicago",1600,"AA"))
		  
		  var filter_country as new clBooleanDataSerie("mask_country")
		  for each cell as string in table0.get_column("Country")
		    filter_country.append_element(cell = "Belgique")
		    
		  next 
		  
		  var filter_product as new clBooleanDataSerie("mask_product")
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
		  
		  var k as integer = 1
		  
		  //  directly use the  boolean serie as parameter to 'filtered_on'; and, or and not operator are overloaded for clBooleanDataSerie
		  
		  for each row as clDataRow in table0.filtered_on(filter_country and filter_product)
		    k = k+1
		  next
		  
		  
		  log.end_exec(CurrentMethodName)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_016(log as LogMessageInterface)
		  
		  log.start_exec(CurrentMethodName)
		  
		  
		  var my_table As New clDataTable("T1")
		  
		  var d as new test_class_02
		  d.aaa = 1234
		  d.bbb =  "abcd"
		  d.ccc =  "123.456"
		  
		  my_table.AddRow( New clDataRow(d))
		  
		  var c as new test_class_01
		  c.aaa = 1235
		  c.bbb = "abce"
		  c.ddd = 987.654
		  
		  
		  my_table.AddRow(New clDataRow(c))
		  
		  var col1 as new clDataSerie("aaa", 1234, 1235)
		  var col2 as new clDataSerie("bbb", "abcd", "abce")
		  var col3 as new clDataSerie("ccc", 123.456, nil)
		  var col4 as new clDataSerie("ddd", nil, 987.654)
		  
		  var texpected as new clDataTable("T1", serie_array(col1, col2, col3 ,col4))
		  
		  call check_table(log, "T1", texpected, my_table)
		  
		  log.end_exec(CurrentMethodName)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_017(log as LogMessageInterface)
		  
		  log.start_exec(CurrentMethodName)
		  
		  var table0 As New clDataTable("mytable")
		  
		  call table0.AddColumns(Array("country","city","sales"))
		  
		  table0.AddRow(Array("France","Paris",1100))
		  table0.AddRow(Array("","Marseille",1200))
		  table0.AddRow(Array("Belgique","",1300))
		  table0.AddRow(Array("France","Paris",2100))
		  table0.AddRow(Array("","Marseille",2200))
		  table0.AddRow(Array("Belgique","",2300))
		  table0.AddRow(Array("USA","NewYork",2400))
		  table0.AddRow(Array("Belgique","Bruxelles",2500))
		  table0.AddRow(Array("USA","Chicago",2600))
		  table0.AddRow(Array("USA","NewYork",1400))
		  table0.AddRow(Array("Belgique","Bruxelles",1500))
		  table0.AddRow(Array("USA","Chicago",1600))
		  
		  
		  var table1 As clDataTable = table0.unique(array("country", "city"))
		  
		  var col1 as new clDataSerie("country", "France", "", "Belgique","Belgique","USA","USA")
		  
		  var col2 as new clDataSerie("city", "Paris", "Marseille", "","Bruxelles","NewYork","Chicago")
		  
		  call check_table(log,"unique", new clDataTable("mytable", serie_array(col1, col2)), table1)
		  
		  
		  log.end_exec(CurrentMethodName)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_018(log as LogMessageInterface)
		  
		  log.start_exec(CurrentMethodName)
		  
		  
		  var col_country as new clDataSerie("Country", "France", "", "Belgique", "France", "USA")
		  var col_city as new clDataSerie("City", "Paris", "Marseille", "Bruxelles", "Lille", "Chicago")
		  var col_sales as new clNumberDataSerie("sales", 900.0, 1200.0, 1400.0, 1600.0, 2900)
		  
		  var table0 As New clDataTable("mytable", serie_array(col_country, col_city, col_sales))
		  
		  call table0.AddColumn(col_sales *2 )
		  
		  var nb as integer = table0.clip_range("sales",1000, 2000)
		  
		  call table0.AddColumn(col_sales.clipped_by_range(1100, 1500) * 2)
		  
		  // create expected table
		  var col1 as clDataSerie = col_country.clone()
		  var col2 as clDataSerie = col_city.clone()
		  var col3 as new clNumberDataSerie("sales", 1000.0, 1200.0, 1400.0, 1600.0, 2000.0)
		  var col4 as new clNumberDataSerie("sales*2", 1800.0, 2400.0, 2800.0, 3200.0, 5800.0)
		  var col5 as new clNumberDataSerie("clip sales*2", 2200.0, 2400.0, 2800.0, 3000.0, 3000.0)
		  
		  call check_table(log,"clipping fct", new clDataTable("mytable", serie_array(col1, col2, col3, col4, col5)), table0)
		  
		  call check_value(log, "nb clipped", 3, nb)
		  
		  log.end_exec(CurrentMethodName)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_019(log as LogMessageInterface)
		  
		  log.start_exec(CurrentMethodName)
		  
		  var dct as Dictionary
		  
		  dct = new Dictionary
		  dct.value("Country") = array("France", "", "Belgique", "France", "USA")
		  dct.Value("City") = array("Paris", "Marseille", "Bruxelles", "Lille", "Chicago")
		  dct.Value("Sales") = array(900.0, 1200.0, 1400.0, 1600.0, 2900)
		  
		  var table0 As New clDataTable("mytable", dct)  
		  
		  var col_country as new clDataSerie("Country", "France", "", "Belgique", "France", "USA")
		  var col_city as new clDataSerie("City", "Paris", "Marseille", "Bruxelles", "Lille", "Chicago")
		  var col_sales as new clNumberDataSerie("Sales", 900.0, 1200.0, 1400.0, 1600.0, 2900)
		  
		  var table_expected As New clDataTable("mytable", serie_array(col_country, col_city, col_sales))
		  
		  call check_table(log,"use dict for creation", table_expected, table0)
		  
		  table0.get_column("City").display_title = "Ville"
		  table0.get_column("Country").display_title = "Pays"
		  table0.get_column("Sales").display_title="Ventes" 
		  
		  var struc0 as clDataTable = table0.get_structure_as_table
		  
		  dct = new Dictionary
		  dct.value("name") = array("Country", "City", "Sales")
		  dct.Value("type") = array("Generic","Generic","Generic")
		  dct.Value("title") = array("Pays","Ville","Ventes")
		  
		  var struc_expected as new clDataTable("exp_struct", dct)
		  
		  call check_table(log,"structure", struc_expected, struc0)
		  
		  
		  log.end_exec(CurrentMethodName)
		  
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_020(log as LogMessageInterface)
		  
		  log.start_exec(CurrentMethodName)
		  
		  var dct as Dictionary
		  
		  dct = new Dictionary
		  dct.value("Country") = array("France", "", "Belgique", "France", "USA")
		  dct.Value("City") = array("Paris", "Marseille", "Bruxelles", "Lille", "Chicago")
		  dct.Value("Sales") = array(900.0, 1200.0, 1400.0, 1600.0, 2900)
		  
		  var table0 As New clDataTable("mytable", dct ,AddressOf alloc_series_019)
		  
		  var col_country as new clDataSerie("Country", "France", "", "Belgique", "France", "USA")
		  var col_city as new clDataSerie("City", "Paris", "Marseille", "Bruxelles", "Lille", "Chicago")
		  var col_sales as new clNumberDataSerie("Sales", 900.0, 1200.0, 1400.0, 1600.0, 2900)
		  
		  var table_expected As New clDataTable("mytable", serie_array(col_country, col_city, col_sales))
		  
		  call check_table(log,"use dict for creation", table_expected, table0)
		  
		  table0.get_column("City").display_title = "Ville"
		  table0.get_column("Country").display_title = "Pays"
		  table0.get_column("Sales").display_title="Ventes" 
		  
		  var struc0 as clDataTable = table0.get_structure_as_table
		  
		  dct = new Dictionary
		  dct.value("name") = array("Country", "City", "Sales")
		  dct.Value("type") = array("Generic","Generic","Number")
		  dct.Value("title") = array("Pays","Ville","Ventes")
		  
		  var struc_expected as new clDataTable("exp_struct", dct)
		  call check_table(log,"structure", struc_expected, struc0)
		  
		  var table1 as clDataTable = struc0.CreateTableFromStructure("mytable")
		  
		  var struc1 as clDataTable = table0.get_structure_as_table
		  call check_table(log,"structure", struc_expected, struc1)
		  
		  
		  log.end_exec(CurrentMethodName)
		  
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_021(log as LogMessageInterface)
		  
		  log.start_exec(CurrentMethodName)
		  
		  var c1 as new clDataSerie("DataSerie")
		  var c2 as new clNumberDataSerie("NumberDataSerie")
		  var c3 as new clStringDataSerie("StringDataSerie")
		  var c4 as new clIntegerDataSerie("IntegerDataSerie")
		  
		  var series() as clAbstractDataSerie = serie_array(c1, c2, c3, c4)
		  
		  for each cc as clAbstractDataSerie in series
		    cc.append_element("aaa")
		    cc.append_element(100)
		    cc.append_element(119)
		    cc.append_element(120)
		    cc.append_element(nil)
		    cc.append_element(0)
		    
		  next
		  
		  
		  
		  var data_table as new clDataTable("data", series)
		  var stat_table as clDataTable = data_table.get_statistics_as_table
		  
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
		  
		  var table_expected as clDataTable = new clDataTable("expected", series)
		  
		  call check_table(log,"statistics", table_expected, stat_table)
		  
		  
		  log.end_exec(CurrentMethodName)
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_022(log as LogMessageInterface)
		  
		  log.start_exec(CurrentMethodName)
		  
		  
		  // Build the source list of dictionaries
		  
		  var t_expected as new clDataTable("expected",string_array("field_a", "field_b","field_c"))
		  
		  var s() as Dictionary
		  
		  for i as integer = 0 to 2//0
		    var d as new Dictionary
		    
		    var fielda as string = str(1000+i)
		    var fieldb as string =  "country"+str(i)
		    var fieldc as string = "city"+str(i)
		    
		    d.value("field_a") = fielda
		    d.value("field_b" ) = fieldb
		    
		    if i mod 2 = 0 then
		      d.value("field_c") = fieldc
		      
		    else
		      fieldc = ""
		      
		    end if
		    t_expected.AddRow(string_array(fielda, fieldb, fieldc))
		    
		    s.Add(d)
		    
		  next
		  
		  var rs as new clListOfDictionariesReader(s, "actual")
		  
		  var t_actual  as new clDataTable("actual")
		  t_actual.AddRows(rs, true)
		  
		  
		  call check_table(log,"list of dicts", t_expected, t_actual)
		  
		  
		  log.end_exec(CurrentMethodName)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_023(log as LogMessageInterface)
		  
		  log.start_exec(CurrentMethodName)
		  
		  
		  // Build the source list of dictionaries
		  
		  var t_expected as new clDataTable("expected",string_array("field_a", "field_c", "field_d"))
		  
		  var s() as Dictionary
		  
		  for i as integer = 0 to 2
		    var d as new Dictionary
		    
		    var fielda as string = str(1000+i)
		    var fieldb as string =  "country"+str(i)
		    var fieldc as string = "city"+str(i)
		    
		    d.value("field_a") = fielda
		    d.value("field_b" ) = fieldb
		    
		    if i mod 2 = 0 then
		      d.value("field_c") = fieldc
		      
		    else
		      fieldc = ""
		      
		    end if
		    
		    t_expected.AddRow(string_array(fielda, fieldc,""))
		    
		    s.Add(d)
		    
		  next
		  
		  var rs as new clListOfDictionariesReader(s, "actual", string_array("field_a","field_c","field_d"))
		  
		  var t_actual  as new clDataTable("actual")
		  t_actual.AddRows(rs, true)
		  
		  
		  call check_table(log,"list of dicts", t_expected, t_actual)
		  
		  
		  log.end_exec(CurrentMethodName)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_024(log as LogMessageInterface)
		  
		  log.start_exec(CurrentMethodName)
		  
		  var my_table As New clDataTable("T1", serie_array(new clIntegerDataSerie("aaa"), new clStringDataSerie("bbb"), new clNumberDataSerie("ccc")))
		  
		  var d as new test_class_02
		  d.aaa = 1234
		  d.bbb =  "abcd"
		  d.ccc =  "123.456"
		  
		  my_table.AddRow( New clDataRow(d), false)
		  
		  var c as new test_class_01
		  c.aaa = 1235
		  c.bbb = "abce"
		  c.ddd = 987.654
		  
		  
		  my_table.AddRow(New clDataRow(c), True)
		  
		  var col1 as new clDataSerie("aaa", 1234, 1235)
		  var col2 as new clDataSerie("bbb", "abcd", "abce")
		  var col3 as new clDataSerie("ccc", 123.456, 0)
		  var col4 as new clDataSerie("ddd", nil, 987.654)
		  
		  var texpected as new clDataTable("T1", serie_array(col1, col2, col3 ,col4))
		  
		  call check_table(log, "T1", texpected, my_table)
		  
		  log.end_exec(CurrentMethodName)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_025(log as LogMessageInterface)
		  
		  log.start_exec(CurrentMethodName)
		  
		  var my_table_1 As New clDataTable("T1", serie_array(new clIntegerDataSerie("aaa"), new clStringDataSerie("bbb"), new clNumberDataSerie("ccc")))
		  
		  var r1 as new test_class_02
		  r1.aaa = 1234
		  r1.bbb =  "abcd"
		  r1.ccc =  "123.456"
		  
		  my_table_1.AddRow( New clDataRow(r1), False)
		  
		  var r2 as new test_class_02
		  r2.aaa = 1235
		  r2.bbb = "abce"
		  r2.ccc = "987.654"
		  
		  my_table_1.AddRow(New clDataRow(r2), False)
		  
		  var res() as test_class_03
		  
		  for each r as clDataRow in my_table_1
		    res.Add(new test_class_03)
		    r.update_object(res(res.LastIndex))
		    
		  next 
		  
		  for each c as test_class_03 in res
		    c.aaa = c.aaa*2
		    c.bbb = "$" + c.bbb
		    
		  next
		  
		  var my_table_2 As New clDataTable("T1", serie_array(new clIntegerDataSerie("aaa"), new clStringDataSerie("bbb")))
		  
		  for each c as test_class_03 in res
		    my_table_2.AddRow(new clDataRow(c), False)
		    
		  next
		  
		  
		  var col1 as new clDataSerie("aaa", 2468, 2470)
		  var col2 as new clDataSerie("bbb", "$abcd", "$abce")
		  
		  var texpected as new clDataTable("T1", serie_array(col1, col2))
		  
		  call check_table(log, "T1", texpected, my_table_2)
		  
		  log.end_exec(CurrentMethodName)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_026(log as LogMessageInterface)
		  
		  log.start_exec(CurrentMethodName)
		  
		  var my_table_0 As New clDataTable("T1", serie_array(new clIntegerDataSerie("aaa"), new clStringDataSerie("bbb"), new clNumberDataSerie("ccc")))
		  my_table_0.row_name_as_column = True
		  
		  var r1 as new test_class_02
		  r1.aaa = 1234
		  r1.bbb =  "abcd"
		  r1.ccc =  "123.456"
		  
		  my_table_0.AddRow( New clDataRow(r1), True)
		  
		  var r2 as new test_class_02
		  r2.aaa = 1235
		  r2.bbb = "abce"
		  r2.ccc = "987.654"
		  
		  my_table_0.AddRow(New clDataRow(r2), False)
		  
		  
		  var res_1() as test_class_02
		  var res_2() as test_class_02
		  
		  
		  for each r as clDataRow in my_table_0
		    res_1.Add(test_class_02(r.AsObject("row_type", AddressOf alloc_obj)))
		    
		    res_2.Add(test_class_02(r.AsObject(AddressOf alloc_obj)))
		    
		  next
		  
		  var my_table_1 as new clDataTable("T2",serie_array(new clIntegerDataSerie("aaa"), new clStringDataSerie("bbb"), new clNumberDataSerie("ccc")))
		  my_table_1.AddRows(res_1)
		  
		  
		  var my_table_2 as new clDataTable("T2",serie_array(new clIntegerDataSerie("aaa"), new clStringDataSerie("bbb"), new clNumberDataSerie("ccc")))
		  my_table_2.AddRows(res_2)
		  
		  
		  
		  var col1 as new clDataSerie("aaa", 1234, 1235)
		  var col2 as new clDataSerie("bbb", "abcd", "abce")
		  var col3 as new clNumberDataSerie("ccc", 123.456, 987.654)
		  
		  var texpected as new clDataTable("T2", serie_array(col1, col2,col3))
		  
		  call check_table(log, "T2a", texpected, my_table_1)
		  call check_table(log, "T2b", texpected, my_table_2)
		  
		  log.end_exec(CurrentMethodName)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_examples(log as LogMessageInterface)
		  
		  var logwriter as  LogMessageInterface = log 
		  
		  if log = nil then
		    logwriter = new clWriteToSystemLog
		  end if
		  
		  
		  var ex() as clLibDataExample = clLibDataExample.get_all_examples
		  
		  for each example as clLibDataExample in ex
		    call example.run(logwriter)
		    
		  next
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_io_001(log as LogMessageInterface)
		  
		  log.start_exec(CurrentMethodName)
		  
		  var fld_folder As New FolderItem
		  var fld_file1 As FolderItem
		  var fld_file2 As FolderItem
		  var fld_file3 As FolderItem
		  
		  fld_folder = fld_folder.Child("test-data")
		  
		  fld_file1 = fld_folder.Child("myfile3_10K_tab.txt")
		  fld_file2  = fld_folder.Child("myfile3_10K_comma.txt")
		  fld_file3  = fld_folder.Child("myfile3_10K_output.txt")
		  
		  var my_table3 As New clDataTable(new clTextReader(fld_file1, True, new clTextFileConfig(chr(9))))
		  
		  var my_table4 As New clDataTable(new clTextReader(fld_file2, True, New clTextFileConfig(",")))
		  
		  my_table4.save(new clTextWriter(fld_file3, True, new clTextFileConfig(";")))
		  
		  var my_table5 as new clDataTable(new clTextReader(fld_file3, True, new clTextFileConfig(";")))
		  
		  call check_table(log,"T4/T5", my_table4, my_table5) 
		  
		  var my_table6  as new clDataTable(new clTextReader(fld_file1, True, New clTextFileConfig(Chr(9))), AddressOf alloc_series_io1)
		  
		  
		  log.end_exec(CurrentMethodName)
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_io_002(log as LogMessageInterface)
		  
		  log.start_exec(CurrentMethodName)
		  
		  var db as new SQLiteDatabase
		  
		  Try
		    db.Connect
		    
		  Catch error As DatabaseException
		    System.DebugLog("DB Connection Error: " + error.Message)
		    
		  End Try
		  
		  var dbrow as  DatabaseRow
		  
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
		  
		  
		  var my_table1 as new clDataTable(new clDBReader(db.SelectSql("select * from test1")))
		  my_table1.rename("test2")
		  my_table1.save(new clDBWriter(new clSqliteDBAccess(db)))
		  
		  var my_table2 as new clDataTable(new clDBReader(db.SelectSql("select * from test2")))
		  
		  call check_table(log,"Test1/Test2", my_table1, my_table2)
		  
		  
		  
		  var my_table3 as new clDataTable(new clDBReader(db.SelectSql("select * from test3")))
		  my_table3.rename("test4")
		  my_table3.save(new clDBAppendWriter(new clSqliteDBAccess(db)))
		  
		  var my_table4 as new clDataTable(new clDBReader(db.SelectSql("select * from test4")))
		  
		  call check_table(log,"Test3/Test4", my_table3, my_table4)
		  
		  
		  var my_table5 as new clDataTable(new clDBReader(db.SelectSQL("select * from test1")))
		  
		  var my_table6 as new clDataTable(new clDBReader(db.SelectSQL("select * from test3")))
		  
		  // create expected ds
		  var my_table7 as clDataTable = my_table5.clone
		  my_table7.append_from_column_source(my_table6)
		  
		  
		  // add rows from test3 to test2
		  my_table6.rename("test2")
		  my_table6.save(new clDBAppendWriter(new clSqliteDBAccess(db)))
		  
		  
		  var my_table8 as new clDataTable(new clDBReader(db.SelectSQL("select * from test2")))
		  
		  
		  call check_table(log,"Test7/Test8", my_table7, my_table8)
		  
		  
		  log.end_exec(CurrentMethodName)
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_io_003(log as LogMessageInterface)
		  
		  log.start_exec(CurrentMethodName)
		  
		  var db as new SQLiteDatabase
		  
		  Try
		    db.Connect
		    
		  Catch error As DatabaseException
		    System.DebugLog("DB Connection Error: " + error.Message)
		    
		  End Try
		  
		  var dbrow as  DatabaseRow
		  
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
		  
		  
		  var my_table1 as new clDataTable("test2", new clDBReader(new clSqliteDBAccess(db),"test1"))
		  
		  my_table1.save(new clDBWriter(new clSqliteDBAccess(db)))
		  
		  var my_table2 as new clDataTable(new clDBReader(db.SelectSql("select * from test2")))
		  
		  call check_table(log,"Test1/Test2", my_table1, my_table2)
		  
		  
		  var my_table3 as new clDataTable("test4", new clDBReader(new clSqliteDBAccess(db),"test3"))
		  
		  my_table3.save(new clDBAppendWriter(new clSqliteDBAccess(db)))
		  
		  var my_table4 as new clDataTable(new clDBReader(db.SelectSql("select * from test4")))
		  
		  call check_table(log,"Test3/Test4", my_table3, my_table4)
		  
		  
		  var my_table5 as new clDataTable(new clDBReader(db.SelectSQL("select * from test1")))
		  
		  var my_table6 as new clDataTable(new clDBReader(db.SelectSQL("select * from test3")))
		  
		  // create expected ds
		  var my_table7 as clDataTable = my_table5.clone
		  my_table7.append_from_column_source(my_table6)
		  
		  
		  // add rows from test3 to test2
		  my_table6.rename("test2")
		  my_table6.save(new clDBAppendWriter(new clSqliteDBAccess(db)))
		  
		  
		  var my_table8 as new clDataTable(new clDBReader(db.SelectSQL("select * from test2")))
		  
		  call check_table(log,"Test7/Test8", my_table7, my_table8)
		  
		  log.end_exec(CurrentMethodName)
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_io_004(log as LogMessageInterface)
		  
		  
		  log.start_exec(CurrentMethodName)
		  
		  var fld_folder As New FolderItem
		  var fld_file1 As FolderItem
		  var fld_file2 As FolderItem
		  var fld_file3 As FolderItem
		  var fld_fileX as FolderItem
		  
		  fld_folder = fld_folder.Child("test-data")
		  
		  fld_file1 = fld_folder.Child("myfile4_A_tab.txt")
		  fld_file2  = fld_folder.Child("myfile4_B_tab.txt") 
		  fld_file3  = fld_folder.Child("myfile4_C_tab.txt") 
		  fld_fileX  = fld_folder.Child("myfile4_X_tab.txt") 
		  
		  
		  var my_table as new clDataTable("calc")
		  call my_table.AddColumn(new clStringDataSerie("Alpha"))
		  call my_table.AddColumn(new clIntegerDataSerie("Beta"))
		  call my_table.AddColumn(new clNumberDataSerie("Delta"))
		  call my_table.AddColumn(new clNumberDataSerie("Gamma"))
		  call my_table.AddColumn(new clIntegerDataSerie("Group"))
		  
		  
		  var dct_mapping_file3 as new Dictionary
		  dct_mapping_file3.value("Un") = "Alpha"
		  dct_mapping_file3.value("Deux") = "Beta"
		  dct_mapping_file3.value("Trois") = "Gamma"
		  dct_mapping_file3.value("Quatre") = "Delta"
		  dct_mapping_file3.value("Extra") = "New_col"
		  
		  my_table.AddRows(new clTextReader(fld_file1, True, new clTextFileConfig(chr(9))))
		  
		  my_table.AddRows(new clTextReader(fld_file2, True, new clTextFileConfig(chr(9))))
		  
		  my_table.AddRows(new clTextReader(fld_file3, True, new clTextFileConfig(chr(9))),dct_mapping_file3)
		  
		  var expected_table as new clDataTable("calc")
		  call expected_table.AddColumn(new clStringDataSerie("Alpha"))
		  call expected_table.AddColumn(new clIntegerDataSerie("Beta"))
		  call expected_table.AddColumn(new clNumberDataSerie("Delta"))
		  call expected_table.AddColumn(new clNumberDataSerie("Gamma"))
		  call expected_table.AddColumn(new clIntegerDataSerie("Group"))
		  call expected_table.AddColumn(new clStringDataSerie("New_col"))
		  
		  expected_table.AddRows(new clTextReader(fld_fileX, True, new clTextFileConfig(chr(9))))
		  
		  call check_table(log,"T4/T5", expected_table, my_table, 0.0001) 
		  
		  log.end_exec(CurrentMethodName)
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_io_005(log as LogMessageInterface)
		  
		  log.start_exec(CurrentMethodName)
		  
		  var v1 as new clDBReader(nil, "my_table")
		  var v1_name as string = v1.name
		  
		  
		  var v2 as new clDBReader(nil, "select alpha, beta from my_table")
		  var v2_name as string = v2.name
		  
		  var v3 as new clDBReader(nil, "select alpha, beta from my_table left join something on ")
		  var v3_name as string = v3.name
		  
		  var v4 as new clDBReader(nil, "select alpha, beta  from   my_table")
		  var v4_name as string = v4.name
		  
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
