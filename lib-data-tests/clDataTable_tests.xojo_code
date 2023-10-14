#tag Module
Protected Module clDataTable_tests
	#tag Method, Flags = &h0
		Function alloc_series(column_name as string) As clAbstractDataSerie
		  if column_name = "Alpha" then
		    Return new clCompressedDataSerie(column_name)
		    
		  else
		    return new clDataSerie(column_name)
		    
		  end if
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub check_table(label as string, expected as clDataTable, calculated as clDataTable)
		  dim tmp as Boolean = check_table(label, expected, calculated)
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function check_table(label as string, expected as clDataTable, calculated as clDataTable) As Boolean
		  dim cnt1 as integer  
		  dim cnt2 as integer 
		  
		  cnt1 = expected.column_count
		  cnt2 = calculated.column_count
		  
		  if not check_value("column count", cnt1, cnt2) then return False
		  
		  dim col_ok as boolean = True
		  for col as integer = 0 to expected.column_count-1
		    
		    col_ok = col_ok and check_serie(label + " " + expected.column_name(col), expected.get_column_by_index(col), calculated.get_column_by_index(col))
		    
		  next
		  
		  if not col_ok then return False
		  
		  // compare values
		  
		  return True
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function filter_008(the_row_index as integer, the_row_count as integer, the_column_names() as string, the_cell_values() as variant, paramarray function_param as variant) As Boolean
		  dim idx as integer = the_column_names.IndexOf("cc2")
		  
		  return the_cell_values(idx) = function_param(0)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub tests()
		  System.DebugLog("START "+CurrentMethodName)
		  
		  test_001
		  test_002
		  test_003
		  
		  test_005
		  test_006
		  test_007
		  test_008
		  test_009
		  test_010
		  test_011
		  test_012
		  test_013
		  test_014
		  test_015
		  test_017
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub tests_io()
		  
		  System.DebugLog("START "+CurrentMethodName)
		  
		  test_io_004
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_001()
		  System.DebugLog("START "+CurrentMethodName)
		  
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
		  
		  check_table("T1", texpected, my_table)
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_002()
		  System.DebugLog("START "+CurrentMethodName)
		  
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
		  
		  my_table1.append_rows_from_table(my_table2)
		  
		  Dim my_table3 As clDataTable = my_table1.select_columns(Array("aaa","zccc"))
		  
		  
		  dim col1 as new clDataSerie("aaa", 1234, 1235, 81234, 81235)
		  dim col2 as new clDataSerie("zccc", nil, nil, 8123.456, nil)
		  dim texpected as new clDataTable("select T1", serie_array(col1, col2))
		  
		  check_table("T1", my_table3, texpected)
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_003()
		  System.DebugLog("START "+CurrentMethodName)
		  
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
		  
		  Dim my_col As clDataSerie
		  Dim my_table3 As clDataTable = my_table1.select_columns(Array("aaa","zccc")) // zccc does not exist, not included in my_table3
		  
		  
		  my_col = my_table3.add_column("xyz") 
		  
		  dim col1 as new clDataSerie("aaa", 1234, 1235)
		  dim col2 as new clDataSerie("xyz", nil, nil) 
		  
		  dim texpected as new clDataTable("select T1", serie_array(col1, col2))
		  
		  check_table("T1", texpected, my_table3)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_005()
		  System.DebugLog("START "+CurrentMethodName)
		  
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
		  
		  check_table("T1", texpected, my_table)
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_006()
		  System.DebugLog("START "+CurrentMethodName)
		  
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
		  
		  check_table("mytable1", expected_t1, t1)
		  
		  check_table("mytable2", expected_t2, t2)
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_007()
		  System.DebugLog("START "+CurrentMethodName)
		  
		  Dim rtst As clDataRow
		  
		  Dim my_table As New clDataTable("T1")
		  
		  call my_table.add_columns(Array("cc1","cc2","cc3"))
		  
		  my_table.append_row(Array("aaa0","bbb0","ccc0"))
		  my_table.append_row(Array("aaa1","bbb1","ccc1"))
		  my_table.append_row(Array("aaa2","bbb2","ccc2"))
		  my_table.append_row(Array("aaa3","bbb3","ccc3"))
		  
		  Dim tmp1 As Integer = my_table.find_first_matching_row_index("cc2","bbb2")
		  Dim tmp2 As Integer = my_table.find_first_matching_row_index("cc2","zzz2")
		  Dim tmp3 As Integer = my_table.find_first_matching_row_index("zz2","bbb2")
		  
		  check_value("tmp1", 2, tmp1)
		  check_value("tmp2", -1, tmp2) // value not found
		  check_value("tmp3", -2, tmp3) // column not found
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_008()
		  System.DebugLog("START "+CurrentMethodName)
		  
		  
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
		  
		  check_table("t1", expected, my_table)
		  Dim k As Integer = 1
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_009()
		  System.DebugLog("START "+CurrentMethodName)
		  
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
		  
		  my_table3.append_rows_from_table(my_table2, true)
		  my_table4.append_rows_from_table(my_table2, false)
		  
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
		  
		  check_table("T1", expected_t1, my_table1)
		  check_table("T2", expected_t2, my_table2)
		  check_table("T3", expected_t3, my_table3)
		  check_table("T4", expected_t4, my_table4)
		  
		  
		  Dim k As Integer = 1
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_010()
		  System.DebugLog("START "+CurrentMethodName)
		  
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
		  
		  check_table("T1", expected_t1, mytable)
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_011()
		  
		  System.DebugLog("START "+CurrentMethodName)
		  
		  Dim table0 As New clDataTable("mytable")
		  
		  call table0.add_columns(Array("country","city","sales"))
		  
		  table0.append_row(Array("France","Paris",1100))
		  table0.append_row(Array("","Marseille",1200))
		  table0.append_row(Array("Belgique","",1300))
		  table0.append_row(Array("USA","NewYork",1400))
		  table0.append_row(Array("Belgique","Bruxelles",1500))
		  table0.append_row(Array("USA","Chicago",1600))
		  
		  dim tmp_row as clDataRow = table0.get_row(2, False)
		  
		  check_value("row 2, country", "Belgique", tmp_row.get_cell("country"))
		  check_value("row 2, city", "", tmp_row.get_cell("city"))
		  check_value("row 2, sales", 1300, tmp_row.get_cell("sales"))
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_012()
		  
		  System.DebugLog("START "+CurrentMethodName)
		  
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
		  
		  check_value("row 3, country", "USA", tmp_row.get_cell("country"))
		  check_value("row 3, city", "NewYork", tmp_row.get_cell("city"))
		  check_value("row 3, sales", 1400, tmp_row.get_cell("sales"))
		  check_value("row 3, mask", False, tmp_row.get_cell("mask"))
		  
		  dim k as integer = 0
		  
		  for each row as clDataRow in table0.filtered_on("mask")
		    k = k+1
		  next
		  
		  check_value("filtered row count", 2, k)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_013()
		  
		  System.DebugLog("START "+CurrentMethodName)
		  
		  Dim table0 As New clDataTable("mytable")
		  
		  call table0.add_columns(Array("country","city","sales"))
		  
		  table0.append_row(Array("France","Paris",1100))
		  table0.append_row(Array("USA","NewYork",1400))
		  
		  table0.index_visible_when_iterate(True)
		  
		  dim row_index as integer = 0 // required for validation
		  
		  for each row as clDataRow in table0
		    
		    if row_index = 0 then
		      check_value("row 0, index",  0, row.get_cell("row_index"))
		      check_value("row 0, country",  "France", row.get_cell("country"))
		      check_value("row 0, city",  "Paris", row.get_cell("city"))
		      check_value("row 0, sales",  1100, row.get_cell("sales"))
		      
		      
		    elseif row_index = 1 then
		      check_value("row 1, index",  1, row.get_cell("row_index"))
		      check_value("row 1, country",  "USA", row.get_cell("country"))
		      check_value("row 1, city",  "NewYork", row.get_cell("city"))
		      check_value("row 1, sales",  1400, row.get_cell("sales"))
		      
		      
		    else
		      
		    end if
		    
		    row_index = row_index + 1
		  next
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_014()
		  
		  System.DebugLog("START "+CurrentMethodName)
		  
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
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_015()
		  
		  System.DebugLog("START "+CurrentMethodName)
		  
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
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_017()
		  System.DebugLog("START "+CurrentMethodName)
		  
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
		  
		  check_table("unique", new clDataTable("mytable", serie_array(col1, col2)), table1)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_io_004()
		  System.DebugLog("START "+CurrentMethodName)
		  
		  Dim k As Variant
		  
		  Dim fld_folder As New FolderItem
		  Dim fld_file1 As FolderItem
		  Dim fld_file2 As FolderItem
		  Dim fld_file3 As FolderItem
		  
		  fld_folder = fld_folder.Child("test-data")
		  
		  fld_file1 = fld_folder.Child("myfile3_10K_tab.txt")
		  fld_file2  = fld_folder.Child("myfile3_10K_comma.txt")
		  fld_file3  = fld_folder.Child("myfile3_10K_output.txt")
		  
		  Dim my_table3 As New clDataTable(new clTextReader(fld_file1, New clRowParser_full(Chr(9)),True))
		  
		  Dim my_table4 As New clDataTable(new clTextReader(fld_file2, New clRowParser_full(","), True))
		  
		  my_table4.save_as_text(fld_file3, New clRowParser_full(";"), True)
		  
		  dim my_table5  as new clDataTable(new clTextReader(fld_file1, New clRowParser_full(Chr(9)), True), AddressOf alloc_series)
		  
		  
		  System.DebugLog(join(my_table3.column_names,";"))
		  
		  System.DebugLog("DONE WITH "+CurrentMethodName)
		  
		  
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
