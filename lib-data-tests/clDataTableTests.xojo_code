#tag Class
Protected Class clDataTableTests
	#tag Method, Flags = &h0
		Sub test_calc_001(log as LogMessageInterface)
		  
		  log.start_exec(CurrentMethodName)
		  
		  var table As New clDataTable("T1")
		  
		  var rtst As clDataRow
		  
		  rtst = New clDataRow
		  rtst.SetCell("aaa",1234)
		  rtst.SetCell("bbb","abcd")
		  rtst.SetCell("ccc",123.456)
		  
		  table.AddRow(rtst)
		  
		  rtst = New clDataRow
		  rtst.SetCell("aaa",1235)
		  rtst.SetCell("bbb","abce")
		  rtst.SetCell("ddd",987.654)
		  
		  table.AddRow(rtst)
		  
		  var col1 as new clIntegerDataSerie("aaa", 1234, 1235)
		  var col2 as new clStringDataSerie("bbb", "abcd", "abce")
		  var col3 as new clNumberDataSerie("ccc", 123.456, nil)
		  var col4 as new clNumberDataSerie("ddd", nil, 987.654)
		  
		  
		  var expected_table as new clDataTable("T1", SerieArray(col1, col2, col3 ,col4))
		  
		  call check_table(log, "T1", expected_table, table)
		  
		  log.end_exec(CurrentMethodName)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_calc_002(log as LogMessageInterface)
		  
		  log.start_exec(CurrentMethodName)
		  
		  var rtst As clDataRow
		  
		  var table1 As New clDataTable("T1")
		  
		  rtst = New clDataRow
		  rtst.SetCell("aaa",1234)
		  rtst.SetCell("bbb","abcd")
		  rtst.SetCell("ccc",123.456)
		  
		  table1.AddRow(rtst)
		  
		  rtst = New clDataRow
		  rtst.SetCell("aaa",1235)
		  rtst.SetCell("bbb","abce")
		  rtst.SetCell("ddd",987.654)
		  
		  table1.AddRow(rtst)
		  
		  var table2 As New clDataTable("T2")
		  
		  rtst = New clDataRow
		  rtst.SetCell("aaa",81234)
		  rtst.SetCell("bbb","zabcd")
		  rtst.SetCell("zccc",8123.456)
		  
		  table2.AddRow(rtst)
		  
		  rtst = New clDataRow
		  rtst.SetCell("aaa",81235)
		  rtst.SetCell("bbb","zabce")
		  rtst.SetCell("zddd",8987.654)
		  
		  table2.AddRow(rtst)
		  
		  table1.AddColumnsData(table2)
		  
		  
		  var table3 As clDataTable = table1.SelectColumns(Array("aaa","zccc"))
		  
		  call check_table(log, "table 1 integrity", nil, table1)
		  call check_table(log, "table 2 integrity", nil, table2)
		  
		  
		  var col1 as new clDataSerie("aaa", 1234, 1235, 81234, 81235)
		  var col2 as new clNumberDataSerie("zccc", nil, nil, 8123.456, nil)
		  var expected_table3 as new clDataTable("select T1", SerieArray(col1, col2))
		  
		  call check_table(log, "T1", expected_table3, table3)
		  
		  log.end_exec(CurrentMethodName)
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_calc_003(log as LogMessageInterface)
		  
		  log.start_exec(CurrentMethodName)
		  
		  
		  var rtst As clDataRow
		  var table1 As New clDataTable("T1")
		  
		  
		  rtst = New clDataRow
		  rtst.SetCell("aaa",1234)
		  rtst.SetCell("bbb","abcd")
		  rtst.SetCell("ccc",123.456)
		  
		  table1.AddRow(rtst)
		  
		  rtst = New clDataRow
		  rtst.SetCell("aaa",1235)
		  rtst.SetCell("bbb","abce")
		  rtst.SetCell("ddd",987.654)
		  
		  table1.AddRow(rtst) 
		  
		  var my_col As clAbstractDataSerie
		  var table3 As clDataTable = table1.SelectColumns(Array("aaa","zccc")) // zccc does not exist, not included in table3
		  
		  
		  my_col = table3.AddColumn("xyz") 
		  
		  var col1 as new clDataSerie("aaa", 1234, 1235)
		  var col2 as new clDataSerie("xyz", nil, nil) 
		  
		  var expected_table3 as new clDataTable("select T1", SerieArray(col1, col2))
		  
		  call check_table(log, "table 1 integrity", nil, table1)
		  
		  call check_table(log,"T1", expected_table3, table3)
		  
		  log.end_exec(CurrentMethodName)
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_calc_004(log as LogMessageInterface)
		  
		  log.start_exec(CurrentMethodName)
		  
		  var rtst As clDataRow
		  
		  var table As New clDataTable("T1")
		  
		  var d as new Dictionary
		  d.value("aaa") = 1234
		  d.value("bbb") =  "abcd"
		  d.value("ccc") =  123.456
		  rtst = New clDataRow(d)
		  
		  table.AddRow(rtst)
		  
		  var c as new test_class_01
		  c.aaa = 1235
		  c.bbb = "abce"
		  c.ddd = 987.654
		  
		  rtst = New clDataRow(c)
		  
		  table.AddRow(rtst)
		  
		  var col1 as new clIntegerDataSerie("aaa", 1234, 1235)
		  var col2 as new clStringDataSerie("bbb", "abcd", "abce")
		  var col3 as new clNumberDataSerie("ccc", 123.456, nil)
		  var col4 as new clNumberDataSerie("ddd", nil, 987.654)
		  
		  var expected_table as new clDataTable("T1", SerieArray(col1, col2, col3 ,col4))
		  
		  call check_table(log, "T1", expected_table, table)
		  
		  log.end_exec(CurrentMethodName)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_calc_005(log as LogMessageInterface)
		  
		  log.start_exec(CurrentMethodName)
		  
		  
		  var rtst As clDataRow
		  
		  var table As New clDataTable("T1")
		  
		  rtst = New clDataRow
		  rtst.SetCell("aaa",1234)
		  rtst.SetCell("bbb","abcd")
		  rtst.SetCell("ccc",123.456)
		  
		  table.AddRow(rtst)
		  
		  rtst = New clDataRow
		  rtst.SetCell("aaa",1235)
		  rtst.SetCell("bbb","abce")
		  rtst.SetCell("ddd",987.654)
		  
		  table.AddRow(rtst)
		  
		  var cols() As clAbstractDataSerie
		  
		  cols = table.GetColumns("aaa","bbb","ddd")
		  
		  cols(1).rename("bB1")
		  
		  var col1 as new clIntegerDataSerie("aaa", 1234, 1235)
		  var col2 as new clStringDataSerie("bB1", "abcd", "abce")
		  var col3 as new clNumberDataSerie("ccc", 123.456, nil)
		  var col4 as new clNumberDataSerie("ddd", nil, 987.654)
		  
		  
		  var expected_table as new clDataTable("T1", SerieArray(col1, col2, col3 ,col4))
		  
		  call check_table(log,"T1", expected_table, table)
		  
		  log.end_exec(CurrentMethodName)
		  
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_calc_006(log as LogMessageInterface)
		  
		  log.start_exec(CurrentMethodName)
		  
		  
		  var c1 As New clDataSerie("premier")
		  var c2 As New clDataSerie("second")
		  
		  c1.AddElement("aaa")
		  c1.AddElement("bbb")
		  c1.AddElement("ccc")
		  
		  
		  c2.AddElement(12)
		  c2.AddElement(34)
		  c2.AddElement(56)
		  c2.AddElement(78)
		  
		  var t1 As New clDataTable("mytable1", SerieArray(c1, c2))
		  
		  var t2 As New clDataTable("mytable2", SerieArray(c1, c2), True)
		  
		  var r1 As clDataRow
		  r1 = New clDataRow
		  r1.SetCell("premier","dddd")
		  r1.SetCell("second",90)
		  
		  t1.AddRow(r1)
		  
		  r1.SetCell("troisieme",True)
		  
		  // allow creation of new columns, impose variant type
		  t2.AddRow(r1, clDataTable.AddRowMode.CreateNewColumnAsVariant)
		  
		  
		  var col1 as new clDataSerie("premier","aaa","bbb","ccc",nil,"dddd")
		  var col2 as new clDataSerie("second",12,34,56,78,90)
		  
		  var expected_t1 as new clDataTable("mytable1", SerieArray(col1, col2))
		  
		  var col3 as new clDataSerie("premier","aaa","bbb","ccc",nil,"dddd")
		  var col4 as new clDataSerie("second",12,34,56,78,90)
		  var col5 as new clDataSerie("troisieme",nil,nil,nil,nil,True)
		  
		  var expected_t2 as new clDataTable("mytable2", SerieArray(col3, col4, col5))
		  
		  call check_table(log,"mytable1", expected_t1, t1)
		  
		  call check_table(log,"mytable2", expected_t2, t2)
		  
		  
		  log.end_exec(CurrentMethodName)
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_calc_007(log as LogMessageInterface)
		  
		  log.start_exec(CurrentMethodName)
		  
		  
		  var table As New clDataTable("T1")
		  
		  call table.AddColumns(Array("cc1","cc2","cc3"))
		  
		  table.AddRow(Array("aaa0","bbb0","ccc0"))
		  table.AddRow(Array("aaa1","bbb1","ccc1"))
		  table.AddRow(Array("aaa2","bbb2","ccc2"))
		  table.AddRow(Array("aaa3","bbb3","ccc3"))
		  
		  var tmp1 As Integer = table.FindFirstMatchingRowIndex("cc2","bbb2")
		  var tmp2 As Integer = table.FindFirstMatchingRowIndex("cc2","zzz2")
		  var tmp3 As Integer = table.FindFirstMatchingRowIndex("zz2","bbb2")
		  
		  call check_value(log, "tmp1", 2, tmp1)
		  call check_value(log, "tmp2", -1, tmp2) // value not found
		  call check_value(log, "tmp3", -2, tmp3) // column not found
		  
		  call check_table(log, "mytable integrity", nil, table) 
		  
		  
		  log.end_exec(CurrentMethodName)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_calc_008(log as LogMessageInterface)
		  
		  log.start_exec(CurrentMethodName)
		  
		  
		  var table As New clDataTable("T1")
		  
		  call table.AddColumns(Array("cc1","cc2","cc3"))
		  
		  table.AddRow(Array("aaa0","bbb0","ccc0"))
		  table.AddRow(Array("aaa1","bbb1","ccc1"))
		  table.AddRow(Array("aaa2","bbb0","ccc2"))
		  table.AddRow(Array("aaa3","bbb3","ccc3"))
		  
		  //  The function is filtering on column cc2. The parameter is the value to look for
		  
		  var tmp1() as variant = table.ApplyFilterFunction(AddressOf filter_008,"bbb0")
		  
		  call table.AddColumn(new clBooleanDataSerie("is_bbb0", tmp1))
		  
		  call table.AddColumn(new clBooleanDataSerie("is_bbb1", clDataSerie(table.GetColumn("cc2")).FilterValueInList(array("bbb1"))))
		  
		  call table.AddColumn(new clBooleanDataSerie("is_bbb3",  table.ApplyFilterFunction(AddressOf filter_008, "bbb3")))
		  
		  
		  var col1 as new clDataSerie("cc1", "aaa0","aaa1","aaa2","aaa3")
		  var col2 as new clDataSerie("cc2", "bbb0","bbb1","bbb0","bbb3")
		  var col3 as new clDataSerie("cc3", "ccc0","ccc1","ccc2","ccc3")
		  
		  var col4 as new clDataSerie("is_bbb0", True, False, True, False)
		  
		  var col5 as new clDataSerie("is_bbb1", False, True, False, False)
		  var col6 as new clDataSerie("is_bbb3", False, False, False, True)
		  
		  var expected_table as new clDataTable("T1", SerieArray(col1, col2, col3, col4, col5, col6))
		  
		  call check_table(log,"t1", expected_table, table)
		  
		  log.end_exec(CurrentMethodName)
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_calc_009(log as LogMessageInterface)
		  
		  log.start_exec(CurrentMethodName)
		  
		  
		  var rtst As clDataRow
		  
		  var table1 As New clDataTable("T1")
		  var table2 as New clDataTable("T2")
		  
		  for i as integer = 1 to 4
		    rtst = New clDataRow
		    rtst.SetCell("aaa",I*1000)
		    rtst.SetCell("bbb","abcd")
		    rtst.SetCell("ccc",123.456)
		    
		    table1.AddRow(rtst, clDataTable.AddRowMode.CreateNewColumnAsVariant)
		    
		  next
		  
		  
		  for i as integer = 5 to 9
		    rtst = New clDataRow
		    rtst.SetCell("aaa",I*1000)
		    rtst.SetCell("bbb","xyz")
		    rtst.SetCell("ddd",567.89)
		    
		    table2.AddRow(rtst, clDataTable.AddRowMode.CreateNewColumnAsVariant)
		    
		  next
		  
		  var table3 as clDataTable = table1.Clone()
		  var table4 as clDataTable = table1.Clone()
		  
		  table3. AddColumnsData(table2, true)
		  table4. AddColumnsData(table2, false)
		  
		  var dr as new clDataRow
		  dr.SetCell("aaa",9010)
		  dr.SetCell("zzz", 8888)
		  
		  table4.UpdateRowAt(8,dr)
		  
		  var col1 as new clDataSerie("aaa", 1000, 2000, 3000, 4000)
		  var col2 as new clDataSerie("bbb","abcd","abcd","abcd","abcd")
		  var col3 as new clDataSerie("ccc", 123.456, 123.456, 123.456, 123.456)
		  
		  var expected_table1 as new clDataTable("T1", SerieArray(col1, col2, col3))
		  
		  var col4 as new clDataSerie("aaa", 5000, 6000, 7000, 8000, 9000)
		  var col5 as new clDataSerie("bbb","xyz","xyz","xyz","xyz", "xyz")
		  var col6 as new clDataSerie("ddd", 567.89, 567.89, 567.89, 567.89, 567.89)
		  
		  var expected_table2 as new clDataTable("T2", SerieArray(col4, col5, col6))
		  
		  
		  var col7a as new clDataSerie("aaa", 1000, 2000, 3000, 4000, 5000, 6000, 7000, 8000, 9000)
		  var col7b as new clDataSerie("aaa", 1000, 2000, 3000, 4000, 5000, 6000, 7000, 8000, 9010)
		  var col8 as new clDataSerie("bbb","abcd","abcd","abcd","abcd","xyz","xyz","xyz","xyz", "xyz")
		  var col9 as new clDataSerie("ccc", 123.456, 123.456, 123.456, 123.456, nil, nil, nil, nil, nil)
		  var col0 as new clDataSerie("ddd", nil, nil, nil, nil, 567.89, 567.89, 567.89, 567.89, 567.89)
		  var expected_table3 as new clDataTable("T3", SerieArray(col7a, col8, col9, col0))
		  
		  var expected_table4 as new clDataTable("T4", SerieArray(col7b, col8, col9), True)
		  
		  call check_table(log,"T1", expected_table1, table1)
		  call check_table(log,"T2", expected_table2, table2)
		  call check_table(log,"T3", expected_table3, table3)
		  call check_table(log,"T4", expected_table4, table4)
		  
		  
		  log.end_exec(CurrentMethodName)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_calc_010(log as LogMessageInterface)
		  
		  log.start_exec(CurrentMethodName)
		  
		  
		  var temp_row As clDataRow
		  var table1 As New clDataTable("T1")
		  
		  call table1.AddColumn(new clDataSerie("name"))
		  call table1.AddColumn(new clNumberDataSerie("quantity"))
		  call table1.AddColumn(new clNumberDataSerie("unit_price"))
		  
		  temp_row = New clDataRow
		  temp_row.SetCell("name","alpha")
		  temp_row.SetCell("quantity",50)
		  temp_row.SetCell("unit_price",6)
		  table1.AddRow(temp_row)
		  
		  temp_row = New clDataRow
		  temp_row.SetCell("name","alpha")
		  temp_row.SetCell("quantity",20)
		  temp_row.SetCell("unit_price",8)
		  table1.AddRow(temp_row)
		  
		  call table1.AddColumn(table1.GetNumberColumn("unit_price") * table1.GetNumberColumn("quantity"))
		  
		  var col1 as new clDataSerie("name", "alpha","alpha")
		  var col2 as new clNumberDataSerie("quantity", 50, 20)
		  var col3 as new clNumberDataSerie("unit_price", 6, 8)
		  var col4 as new clNumberDataSerie("unit_price*quantity", 300, 160)
		  
		  var expected_table1 as new clDataTable("T1", SerieArray(col1, col2, col3, col4))
		  
		  call check_table(log,"T1", expected_table1, table1)
		  
		  
		  log.end_exec(CurrentMethodName)
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_calc_011(log as LogMessageInterface)
		  
		  log.start_exec(CurrentMethodName)
		  
		  
		  var table1 As New clDataTable("mytable")
		  
		  call table1.AddColumns(Array("country","city","sales"))
		  
		  table1.AddRow(Array("France","Paris",1100))
		  table1.AddRow(Array("","Marseille",1200))
		  table1.AddRow(Array("Belgique","",1300))
		  table1.AddRow(Array("USA","NewYork",1400))
		  table1.AddRow(Array("Belgique","Bruxelles",1500))
		  table1.AddRow(Array("USA","Chicago",1600))
		  
		  var tmp_row as clDataRow = table1.GetRowAt(2, False)
		  
		  call check_table(log, "table1 integrity", nil, table1) 
		  
		  
		  call check_value(log,"row 2, country", "Belgique", tmp_row.GetCell("country"))
		  call check_value(log, "row 2, city", "", tmp_row.GetCell("city"))
		  call check_value(log,"row 2, sales", 1300, tmp_row.GetCell("sales"))
		  
		  
		  log.end_exec(CurrentMethodName)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_calc_012(log as LogMessageInterface)
		  
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
		  
		  call check_table(log, "table0 integrity", nil, table0) 
		  
		  var tmp_row as clDataRow = table0.GetRowAt(3, False)
		  
		  call check_value(log,"row 3, country", "USA", tmp_row.GetCell("country"))
		  call check_value(log, "row 3, city", "NewYork", tmp_row.GetCell("city"))
		  call check_value(log,"row 3, sales", 1400, tmp_row.GetCell("sales"))
		  call check_value(log, "row 3, mask", False, tmp_row.GetCell("mask"))
		  
		  var k as integer = 0
		  
		  for each row as clDataRow in table0.FilteredOn("mask")
		    k = k+1
		  next
		  
		  call check_value(log, "filtered row count", 2, k)
		  
		  log.end_exec(CurrentMethodName)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_calc_013(log as LogMessageInterface)
		  
		  log.start_exec(CurrentMethodName)
		  
		  
		  var table0 As New clDataTable("mytable")
		  
		  call table0.AddColumns(Array("country","city","sales"))
		  
		  table0.AddRow(Array("France","Paris",1100))
		  table0.AddRow(Array("USA","NewYork",1400))
		  
		  table0.IndexVisibleWhenIterating(True)
		  
		  call check_table(log, "table0 integrity", nil, table0) 
		  
		  
		  var row_index as integer = 0 // required for validation
		  
		  for each row as clDataRow in table0
		    
		    if row_index = 0 then
		      call check_value(log,"row 0, index",  0, row.GetCell(table0.DefaultRowIndexColumnName))
		      call check_value(log, "row 0, country",  "France", row.GetCell("country"))
		      call check_value(log,"row 0, city",  "Paris", row.GetCell("city"))
		      call check_value(log, "row 0, sales",  1100, row.GetCell("sales"))
		      
		    elseif row_index  = 1 then
		      call check_value(log, "row 1, index",  1, row.GetCell(table0.DefaultRowIndexColumnName))
		      call check_value(log, "row 1, country",  "USA", row.GetCell("country"))
		      call check_value(log, "row 1, city",  "NewYork", row.GetCell("city"))
		      call check_value(log, "row 1, sales",  1400, row.GetCell("sales"))
		      
		      
		      
		    end if
		    
		    row_index = row_index + 1
		  next
		  
		  
		  log.end_exec(CurrentMethodName)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_calc_014(log as LogMessageInterface)
		  
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
		  for each cell as string in table0.GetColumn("Country")
		    filter_country.AddElement(cell = "Belgique")
		    
		  next
		  call table0.AddColumn(filter_country)
		  
		  var filter_product as new clBooleanDataSerie("mask_product")
		  for each cell as string in table0.GetColumn("product")
		    filter_product.AddElement(cell = "BB")
		    
		  next
		  call table0.AddColumn(not filter_product)
		  
		  
		  table0.IndexVisibleWhenIterating(True)
		  
		  for each row as clDataRow in table0
		    for each cell as string in row
		      //system.DebugLog("field " + cell + "value " + row.GetCell(cell))
		      
		    next
		    
		  next
		  
		  var k as integer = 1
		  
		  //  use the name of the boolean serie as parameter to 'FilteredOn'
		  for each row as clDataRow in table0.FilteredOn("mask_country")
		    k = k+1
		  next
		  
		  
		  log.end_exec(CurrentMethodName)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_calc_015(log as LogMessageInterface)
		  
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
		  for each cell as string in table0.GetColumn("Country")
		    filter_country.AddElement(cell = "Belgique")
		    
		  next 
		  
		  var filter_product as new clBooleanDataSerie("mask_product")
		  for each cell as string in table0.GetColumn("product")
		    filter_product.AddElement(cell = "BB")
		    
		  next 
		  
		  //  
		  //  The filter series are not added to the table, but we can used them to filter the datatable
		  
		  table0.IndexVisibleWhenIterating(True)
		  
		  for each row as clDataRow in table0
		    for each cell as string in row
		      //system.DebugLog("field " + cell + "value " + row.GetCell(cell))
		      
		    next
		    
		  next
		  
		  var k as integer = 1
		  
		  //  directly use the  boolean serie as parameter to 'FilteredOn'; and, or and not operator are overloaded for clBooleanDataSerie
		  
		  for each row as clDataRow in table0.FilteredOn(filter_country and filter_product)
		    k = k+1
		  next
		  
		  call check_table(log, "table0  integrity", nil, table0) 
		  
		  log.end_exec(CurrentMethodName)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_calc_016(log as LogMessageInterface)
		  
		  log.start_exec(CurrentMethodName)
		  
		  
		  var table As New clDataTable("T1")
		  
		  var d as new test_class_02
		  d.aaa = 1234
		  d.bbb =  "abcd"
		  d.ccc =  "123.456"
		  
		  table.AddRow( New clDataRow(d), clDataTable.AddRowMode.CreateNewColumnAsVariant)
		  
		  
		  var c as new test_class_01
		  c.aaa = 1235
		  c.bbb = "abce"
		  c.ddd = 987.654
		  
		  table.AddRow(New clDataRow(c), clDataTable.AddRowMode.CreateNewColumnAsVariant)
		  
		  
		  var col1 as new clDataSerie("aaa", 1234, 1235)
		  var col2 as new clDataSerie("bbb", "abcd", "abce")
		  var col3 as new clDataSerie("ccc", 123.456, nil)
		  var col4 as new clDataSerie("ddd", nil, 987.654)
		  
		  var expected_table as new clDataTable("T1", SerieArray(col1, col2, col3 ,col4))
		  
		  call check_table(log, "T1", expected_table, table)
		  
		  log.end_exec(CurrentMethodName)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_calc_017(log as LogMessageInterface)
		  
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
		  
		  
		  call check_table(log, "table0 integrity", nil, table0) 
		  
		  var table1 As clDataTable = table0.Groupby(array("country", "city"))
		  
		  var col1 as new clDataSerie("country", "France", "", "Belgique","Belgique","USA","USA")
		  
		  var col2 as new clDataSerie("city", "Paris", "Marseille", "","Bruxelles","NewYork","Chicago")
		  
		  var expected_table1 as new clDataTable("mytable", SerieArray(col1, col2))
		  call check_table(log,"unique", expected_table1, table1)
		  
		  
		  log.end_exec(CurrentMethodName)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_calc_018(log as LogMessageInterface)
		  
		  log.start_exec(CurrentMethodName)
		  
		  
		  var col_country as new clDataSerie("Country", "France", "", "Belgique", "France", "USA")
		  var col_city as new clDataSerie("City", "Paris", "Marseille", "Bruxelles", "Lille", "Chicago")
		  var col_something as new clIntegerDataSerie("Something", 1000, 2000, 3000, 4000, 5000)
		  
		  var col_sales as new clNumberDataSerie("sales", 900.0, 1200.0, 1400.0, 1600.0, 2900)
		  
		  var table0 As New clDataTable("mytable", SerieArray(col_country, col_city, col_sales, col_something))
		  
		  call table0.AddColumn(col_sales *2 )
		  
		  var nb as integer = table0.ClipByRange("sales",1000, 2000)
		  
		  call table0.AddColumn(col_sales.ClippedByRange(1100, 1500) * 2)
		  call table0.AddColumn(col_something.ClippedByRange(2500, 4500))
		  
		  // create expected table
		  var columns() as clAbstractDataSerie
		  columns.Add  col_country.Clone()
		  columns.Add  col_city.Clone()
		  columns.Add  new clNumberDataSerie("sales", 1000.0, 1200.0, 1400.0, 1600.0, 2000.0)
		  columns.Add  col_something.Clone()
		  columns.Add new clNumberDataSerie("sales*2", 1800.0, 2400.0, 2800.0, 3200.0, 5800.0)
		  columns.Add  new clNumberDataSerie("clip sales*2", 2200.0, 2400.0, 2800.0, 3000.0, 3000.0)
		  columns.Add new clIntegerDataSerie("clip something", 2500,2500, 3000, 4000, 4500)
		  
		  var expected_table0 as new clDataTable("mytable", Columns)
		  
		  call check_table(log,"clipping fct", expected_table0, table0)
		  
		  call check_value(log, "nb clipped", 3, nb)
		  
		  log.end_exec(CurrentMethodName)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_calc_019(log as LogMessageInterface)
		  
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
		  
		  var table_expected As New clDataTable("mytable", SerieArray(col_country, col_city, col_sales))
		  
		  call check_table(log,"use dict for creation", table_expected, table0)
		  
		  table0.GetColumn("City").DisplayTitle = "Ville"
		  table0.GetColumn("Country").DisplayTitle = "Pays"
		  table0.GetColumn("Sales").DisplayTitle="Ventes" 
		  
		  var struc0 as clDataTable = table0.GetStructureAsTable
		  
		  dct = new Dictionary
		  dct.value("name") = array("Country", "City", "Sales")
		  dct.Value("type") = array("Generic","Generic","Generic")
		  dct.Value("title") = array("Pays","Ville","Ventes")
		  
		  var struc_expected as new clDataTable("expected_struct", dct)
		  
		  call check_table(log,"structure", struc_expected, struc0)
		  
		  
		  log.end_exec(CurrentMethodName)
		  
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_calc_020(log as LogMessageInterface)
		  
		  log.start_exec(CurrentMethodName)
		  
		  var dct as Dictionary
		  
		  dct = new Dictionary
		  dct.value("Country") = array("France", "", "Belgique", "France", "USA")
		  dct.Value("City") = array("Paris", "Marseille", "Bruxelles", "Lille", "Chicago")
		  dct.Value("Sales") = array(900.0, 1200.0, 1400.0, 1600.0, 2900)
		  
		  var table0 As New clDataTable("mytable", dct ,AddressOf alloc_series_019)
		  
		  //
		  // Check structure and content of table created from dictionaries
		  //
		  var col_country as new clDataSerie("Country", "France", "", "Belgique", "France", "USA")
		  var col_city as new clDataSerie("City", "Paris", "Marseille", "Bruxelles", "Lille", "Chicago")
		  var col_sales as new clNumberDataSerie("Sales", 900.0, 1200.0, 1400.0, 1600.0, 2900)
		  
		  var table_expected0 As New clDataTable("mytable", SerieArray(col_country, col_city, col_sales))
		  
		  call check_table(log,"use dict for creation", table_expected0, table0)
		  
		  
		  //
		  // Extract structure as table and validate
		  //
		  
		  table0.GetColumn("City").DisplayTitle = "Ville"
		  table0.GetColumn("Country").DisplayTitle = "Pays"
		  table0.GetColumn("Sales").DisplayTitle="Ventes" 
		  
		  call check_table(log, "table0  integrity", nil, table0) 
		  
		  
		  var struc0 as clDataTable = table0.GetStructureAsTable
		  
		  
		  dct = new Dictionary
		  dct.value("name") = array("Country", "City", "Sales")
		  dct.Value("type") = array("Generic","Generic","Number")
		  dct.Value("title") = array("Pays","Ville","Ventes")
		  
		  var struc_expected as new clDataTable("expected_struct", dct)
		  call check_table(log,"structure", struc_expected, struc0)
		  
		  //
		  // Create table from structure description and check structure
		  //
		  
		  var table1 as clDataTable = struc0.CreateTableFromStructure("mytable")
		  
		  var col_country1 as new clDataSerie("Country")
		  var col_city1 as new clDataSerie("City")
		  var col_sales1 as new clNumberDataSerie("Sales")
		  var table_expected1 As New clDataTable("mytable", SerieArray(col_country1, col_city1, col_sales1))
		  call check_table(log,"create from structure table", table_expected1, table1)
		  
		  
		  var struc1 as clDataTable = table0.GetStructureAsTable
		  
		  call check_table(log,"structure", struc_expected, struc1)
		  
		  
		  log.end_exec(CurrentMethodName)
		  
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_calc_021(log as LogMessageInterface)
		  
		  log.start_exec(CurrentMethodName)
		  
		  var c1 as new clDataSerie("DataSerie")
		  var c2 as new clNumberDataSerie("NumberDataSerie")
		  var c3 as new clStringDataSerie("StringDataSerie")
		  var c4 as new clIntegerDataSerie("IntegerDataSerie")
		  
		  var series() as clAbstractDataSerie = SerieArray(c1, c2, c3, c4)
		  
		  for each cc as clAbstractDataSerie in series
		    cc.AddElement("aaa")
		    cc.AddElement(100)
		    cc.AddElement(119)
		    cc.AddElement(120)
		    cc.AddElement(nil)
		    cc.AddElement(0)
		    
		  next
		  
		  
		  
		  var data_table as new clDataTable("data", series)
		  var stat_table as clDataTable = data_table.GetStatisticsAsTable
		  
		  call stat_table.GetColumn(clDataTable.StatisticsAverageColumn).RoundValues(2)
		  call stat_table.GetColumn(clDataTable.StatisticsStdDevColumn).RoundValues(5)
		  call stat_table.GetColumn(clDataTable.StatisticsStdDevNZColumn).RoundValues(2)
		  call check_table(log, "data_table  integrity", nil, data_table) 
		  
		  //
		  // Expected table
		  
		  series.RemoveAll
		  
		  series.add(new clStringDataSerie(clDataTable.StatisticsTableNameColumn, array("data","data","data","data")))
		  series.Add(new clDataSerie(clDataTable.StatisticsSerieNameColumn, array("DataSerie", "NumberDataSerie", "StringDataSerie", "IntegerDataSerie")))
		  
		  series.add(new clIntegerDataSerie(clDataTable.StatisticsUboundColumn, array(5,5,5,5)))
		  series.Add(new clIntegerDataSerie(clDataTable.StatisticsCountColumn, array(5,6,6,6)))
		  series.Add(new clIntegerDataSerie(clDataTable.StatisticsCountNZColumn, array(3,3,3,3)))
		  
		  series.Add(new clNumberDataSerie(clDataTable.StatisticsSumColumn, array(339.0,339.0,339.0,339.0)))
		  series.Add(new clNumberDataSerie(clDataTable.StatisticsAverageColumn, array(67.8, 56.5, 56.5, 56.5)))
		  series.Add(new clNumberDataSerie(clDataTable.StatisticsAverageNZColumn, array(113, 113, 113, 113)))
		  
		  series.Add(new clNumberDataSerie(clDataTable.StatisticsStdDevColumn, array(62.40353, 62.30169,62.30169, 62.30169)))
		  series.Add(new clNumberDataSerie(clDataTable.StatisticsStdDevNZColumn, array(11.27, 11.27, 11.27, 11.27)))
		  
		  var table_expected as clDataTable = new clDataTable("expected", series)
		  
		  call check_table(log,"statistics", table_expected, stat_table)
		  
		  
		  log.end_exec(CurrentMethodName)
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_calc_022(log as LogMessageInterface)
		  
		  log.start_exec(CurrentMethodName)
		  
		  
		  // Build the source list of dictionaries
		  
		  var t_expected as new clDataTable("expected",StringArray("field_a", "field_b","field_c"))
		  
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
		    t_expected.AddRow(StringArray(fielda, fieldb, fieldc))
		    
		    s.Add(d)
		    
		  next
		  
		  var rs as new clListOfDictionariesReader(s, "actual")
		  
		  var t_actual  as new clDataTable("actual")
		  call t_actual.AddRows(rs, clDataTable.AddRowMode.CreateNewColumn)
		  
		  
		  call check_table(log,"list of dicts", t_expected, t_actual)
		  
		  
		  log.end_exec(CurrentMethodName)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_calc_023(log as LogMessageInterface)
		  
		  log.start_exec(CurrentMethodName)
		  
		  
		  // Build the source list of dictionaries
		  
		  var t_expected as new clDataTable("expected",StringArray("field_a", "field_c", "field_d"))
		  
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
		    
		    t_expected.AddRow(StringArray(fielda, fieldc,""))
		    
		    s.Add(d)
		    
		  next
		  
		  var rs as new clListOfDictionariesReader(s, "actual", StringArray("field_a","field_c","field_d"))
		  
		  var t_actual  as new clDataTable("actual")
		  call t_actual.AddRows(rs, clDataTable.AddRowMode.CreateNewColumn)
		  
		  
		  call check_table(log,"list of dicts", t_expected, t_actual)
		  
		  
		  log.end_exec(CurrentMethodName)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_calc_024(log as LogMessageInterface)
		  
		  log.start_exec(CurrentMethodName)
		  
		  var table As New clDataTable("T1", SerieArray(new clIntegerDataSerie("aaa"), new clStringDataSerie("bbb"), new clNumberDataSerie("ccc")))
		  
		  var d as new test_class_02
		  d.aaa = 1234
		  d.bbb =  "abcd"
		  d.ccc =  "123.456"
		  
		  table.AddRow( New clDataRow(d), clDataTable.AddRowMode.IgnoreNewColumn)
		  
		  var c as new test_class_01
		  c.aaa = 1235
		  c.bbb = "abce"
		  c.ddd = 987.654
		  
		  
		  table.AddRow(New clDataRow(c),  clDataTable.AddRowMode.CreateNewColumn)
		  
		  var col1 as new clDataSerie("aaa", 1234, 1235)
		  var col2 as new clDataSerie("bbb", "abcd", "abce")
		  var col3 as new clDataSerie("ccc", 123.456, 0)
		  // col 'ddd' will be created as a clNumberDataSerie 
		  var col4 as new clDataSerie("ddd", 0, 987.654)
		  
		  var expected_table as new clDataTable("T1", SerieArray(col1, col2, col3 ,col4))
		  
		  call check_table(log, "T1", expected_table, table)
		  
		  log.end_exec(CurrentMethodName)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_calc_025(log as LogMessageInterface)
		  
		  log.start_exec(CurrentMethodName)
		  
		  var table_1 As New clDataTable("T1", SerieArray(new clIntegerDataSerie("aaa"), new clStringDataSerie("bbb"), new clNumberDataSerie("ccc")))
		  
		  var r1 as new test_class_02
		  r1.aaa = 1234
		  r1.bbb =  "abcd"
		  r1.ccc =  "123.456"
		  
		  table_1.AddRow( New clDataRow(r1), clDataTable.AddRowMode.IgnoreNewColumn)
		  
		  var r2 as new test_class_02
		  r2.aaa = 1235
		  r2.bbb = "abce"
		  r2.ccc = "987.654"
		  
		  table_1.AddRow(New clDataRow(r2),  clDataTable.AddRowMode.IgnoreNewColumn)
		  
		  call check_table(log, "table_1 integrity", nil, table_1) 
		  
		  var res() as test_class_03
		  
		  for each r as clDataRow in table_1
		    res.Add(new test_class_03)
		    r.UpdateObject(res(res.LastIndex))
		    
		  next 
		  
		  for each c as test_class_03 in res
		    c.aaa = c.aaa*2
		    c.bbb = "$" + c.bbb
		    
		  next
		  
		  
		  var table_2 As New clDataTable("T1", SerieArray(new clIntegerDataSerie("aaa"), new clStringDataSerie("bbb")))
		  
		  for each c as test_class_03 in res
		    table_2.AddRow(new clDataRow(c),  clDataTable.AddRowMode.IgnoreNewColumn)
		    
		  next
		  
		  
		  var col1 as new clDataSerie("aaa", 2468, 2470)
		  var col2 as new clDataSerie("bbb", "$abcd", "$abce")
		  
		  var expected_table as new clDataTable("T1", SerieArray(col1, col2))
		  
		  call check_table(log, "T1", expected_table, table_2)
		  
		  log.end_exec(CurrentMethodName)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_calc_026(log as LogMessageInterface)
		  
		  log.start_exec(CurrentMethodName)
		  
		  var table_0 As New clDataTable("T1", SerieArray(new clIntegerDataSerie("aaa"), new clStringDataSerie("bbb"), new clNumberDataSerie("ccc")))
		  table_0.IncludeRowNameAsColumn( True)
		  
		  var r1 as new test_class_02
		  r1.aaa = 1234
		  r1.bbb =  "abcd"
		  r1.ccc =  "123.456"
		  
		  table_0.AddRow( New clDataRow(r1),  clDataTable.AddRowMode.CreateNewColumn)
		  
		  var r2 as new test_class_02
		  r2.aaa = 1235
		  r2.bbb = "abce"
		  r2.ccc = "987.654"
		  
		  table_0.AddRow(New clDataRow(r2),  clDataTable.AddRowMode.IgnoreNewColumn)
		  
		  call check_table(log, "table_0 integrity", nil, table_0) 
		  
		  var res_1() as test_class_02
		  var res_2() as test_class_02
		  
		  
		  for each r as clDataRow in table_0
		    res_1.Add(test_class_02(r.AsObject("row_type", AddressOf alloc_obj)))
		    
		    res_2.Add(test_class_02(r.AsObject(AddressOf alloc_obj)))
		    
		  next
		  
		  var table_1 as new clDataTable("T2",SerieArray(new clIntegerDataSerie("aaa"), new clStringDataSerie("bbb"), new clNumberDataSerie("ccc")))
		  call table_1.AddRows(res_1)
		  
		  
		  var table_2 as new clDataTable("T2",SerieArray(new clIntegerDataSerie("aaa"), new clStringDataSerie("bbb"), new clNumberDataSerie("ccc")))
		  call table_2.AddRows(res_2)
		  
		  
		  
		  var col1 as new clDataSerie("aaa", 1234, 1235)
		  var col2 as new clDataSerie("bbb", "abcd", "abce")
		  var col3 as new clNumberDataSerie("ccc", 123.456, 987.654)
		  
		  var expected_table as new clDataTable("T2", SerieArray(col1, col2,col3))
		  
		  call check_table(log, "T2a", expected_table, table_1)
		  call check_table(log, "T2b", expected_table, table_2)
		  
		  log.end_exec(CurrentMethodName)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_calc_027(log as LogMessageInterface)
		  
		  log.start_exec(CurrentMethodName)
		  
		  var table As New clDataTable("T1", array("aaa", "bbb", "ccc","ddd"))
		  
		  // This will use the existing columns, all created as clDataSerie
		  table.AddRow(new Dictionary("aaa":1234, "bbb": "abcd", "ccc":123.456))
		  
		  table.AddRow(new Dictionary("aaa":1235, "bbb": "abce", "ddd":987.654, "eee":"to_ignore"), clDataTable.AddRowMode.IgnoreNewColumn)
		  
		  var col1 as new clDataSerie("aaa", 1234, 1235)
		  var col2 as new clDataSerie("bbb", "abcd", "abce")
		  var col3 as new clDataSerie("ccc", 123.456, nil)
		  var col4 as new clDataSerie("ddd", nil, 987.654)
		  
		  
		  var expected_table as new clDataTable("T1", SerieArray(col1, col2, col3 ,col4))
		  
		  call check_table(log, "T1", expected_table, table)
		  
		  log.end_exec(CurrentMethodName)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_calc_028(log as LogMessageInterface)
		  
		  log.start_exec(CurrentMethodName)
		  
		  
		  var mytable As New clDataTable("T1")
		  
		  call mytable.AddColumn(new clDataSerie("name"))
		  call mytable.AddColumn(new clNumberDataSerie("quantity"))
		  call mytable.AddColumn(new clNumberDataSerie("unit_price"))
		  
		  mytable.AddRow(new Dictionary("name": "alpha", "quantity":50, "unit_price": 6))
		  mytable.AddRow(new Dictionary("name": "alpha", "quantity":20, "unit_price": 8))
		  
		  call mytable.AddColumn(mytable.GetNumberColumn("unit_price") * mytable.GetNumberColumn("quantity"))
		  
		  var col1 as new clDataSerie("name", "alpha","alpha")
		  var col2 as new clNumberDataSerie("quantity", 50, 20)
		  var col3 as new clNumberDataSerie("unit_price", 6, 8)
		  var col4 as new clNumberDataSerie("unit_price*quantity", 300, 160)
		  
		  var expected_t1 as new clDataTable("T1", SerieArray(col1, col2, col3, col4))
		  
		  call check_table(log,"T1", expected_t1, mytable)
		  
		  
		  log.end_exec(CurrentMethodName)
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_calc_029(log as LogMessageInterface)
		  
		  log.start_exec(CurrentMethodName)
		  
		  
		  var mytable As New clDataTable("T1")
		  
		  call mytable.AddColumn(new clDataSerie("name"))
		  call mytable.AddColumn(new clNumberDataSerie("quantity"))
		  call mytable.AddColumn(new clNumberDataSerie("unit_price"))
		  
		  mytable.AddRow("name": "alpha", "quantity":50, "unit_price": 6)
		  mytable.AddRow("name": "alpha", "quantity":20, "unit_price": 8)
		  
		  call mytable.AddColumn(mytable.GetNumberColumn("unit_price") * mytable.GetNumberColumn("quantity"))
		  
		  var col1 as new clDataSerie("name", "alpha","alpha")
		  var col2 as new clNumberDataSerie("quantity", 50, 20)
		  var col3 as new clNumberDataSerie("unit_price", 6, 8)
		  var col4 as new clNumberDataSerie("unit_price*quantity", 300, 160)
		  
		  var expected_t1 as new clDataTable("T1", SerieArray(col1, col2, col3, col4))
		  
		  call check_table(log,"T1", expected_t1, mytable)
		  
		  
		  log.end_exec(CurrentMethodName)
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_calc_030(log as LogMessageInterface)
		  
		  log.start_exec(CurrentMethodName)
		  
		  var table0 As New clDataTable("mytable")
		  
		  call table0.AddColumns(Array("country","city","sales"))
		  
		  table0.AddRow(Array("France","Paris",1100))
		  table0.AddRow(Array("France","Marseille",1200))
		  table0.AddRow(Array("Belgique","Bruxelles",1300))
		  table0.AddRow(Array("USA","New York",1400))
		  table0.AddRow(Array("Belgique","Bruxelles",1500))
		  table0.AddRow(Array("USA","Chicago",1600))
		  
		  var is_france() as variant = table0.ApplyFilterFunction(AddressOf BasicFieldFilter,"country","France")
		  var is_belgium() as variant =  table0.ApplyFilterFunction(AddressOf BasicFieldFilter, "country","Belgique")
		  
		  call table0.AddColumn(new clIntegerDataSerie("is_france"))
		  call table0.AddColumn(new clIntegerDataSerie("is_belgium"))
		  call table0.AddColumn(new clIntegerDataSerie("is_europe"))
		  
		  call table0.SetColumnValues("is_france", is_france, false)
		  call table0.SetColumnValues("is_belgium", is_belgium, false)
		  
		  // Set the flag to 0 or 2 for test purposes only
		  table0.ColumnValues("is_europe") = ( table0.GetIntegerColumn("is_france") + table0.GetIntegerColumn("is_belgium")) * 2
		  
		  
		  var col1 as new clDataSerie("country", Array("France","France", "Belgique", "USA","Belgique","USA"))
		  var col2 as new clDataSerie("City","Paris","Marseille","Bruxelles","New York", "Bruxelles","Chicago")
		  var col3 as new clDataSerie("Sales",1100,1200,1300,1400,1500,1600)
		  var col4 as new clIntegerDataSerie("is_france",1,1,0,0,0,0)
		  var col5 as new clIntegerDataSerie("is_belgium",0,0,1,0,1,0)
		  var col6 as new clIntegerDataSerie("is_europe",2,2,2,0,2,0)
		  
		  var expected_table0 as new clDataTable("T1", SerieArray(col1, col2, col3, col4, col5, col6))
		  
		  call check_table(log,"T1", expected_table0, table0)
		  
		  
		  log.end_exec(CurrentMethodName)
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_calc_031(log as LogMessageInterface)
		  
		  log.start_exec(CurrentMethodName)
		  
		  
		  var mytable As New clDataTable("T1")
		  
		  call mytable.AddColumn(new clDataSerie("name"))
		  call mytable.AddColumn(new clNumberDataSerie("quantity"))
		  call mytable.AddColumn(new clNumberDataSerie("unit_price"))
		  
		  mytable.AddRow("name": "alpha", "quantity":50, "unit_price": 6)
		  mytable.AddRow("name": "alpha", "quantity":20, "unit_price": 8)
		  
		  call mytable.AddColumn(mytable.GetNumberColumn("unit_price") * mytable.GetNumberColumn("quantity"))
		  
		  var col1 as new clDataSerie("name", "alpha","alpha")
		  var col2 as new clNumberDataSerie("quantity", 50, 20)
		  var col3 as new clNumberDataSerie("unit_price", 6, 8)
		  var col4 as new clNumberDataSerie("unit_price*quantity", 300, 160)
		  
		  var expected_t1 as new clDataTable("T1", SerieArray(col1, col2, col3, col4))
		  
		  call check_table(log,"T1", expected_t1, mytable)
		  
		  
		  log.end_exec(CurrentMethodName)
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_calc_032(log as LogMessageInterface)
		  
		  log.start_exec(CurrentMethodName)
		  
		  var table0 As New clDataTable("mytable")
		  
		  call table0.AddColumns(Array("country","city","sales"))
		  
		  table0.AddRow(Array("France","Paris",1100))
		  table0.AddRow(Array("France","Marseille",1200))
		  table0.AddRow(Array("Belgique","Bruxelles",1300))
		  table0.AddRow(Array("USA","New York",1400))
		  table0.AddRow(Array("Belgique","Bruxelles",1500))
		  table0.AddRow(Array("USA","Chicago",1600))
		  
		  var is_france() as variant = table0.ApplyFilterFunction(AddressOf BasicFieldFilter,"country","France")
		  var is_belgium() as variant =  table0.ApplyFilterFunction(AddressOf BasicFieldFilter, "country","Belgique")
		  
		  call table0.AddColumn(new clIntegerDataSerie("is_france"))
		  call table0.AddColumn(new clIntegerDataSerie("is_belgium"))
		  call table0.AddColumn(new clIntegerDataSerie("is_europe"))
		  
		  call table0.SetColumnValues("is_france", is_france, false)
		  call table0.SetColumnValues("is_belgium", is_belgium, false)
		  
		  // Set the flag to 0 or 2 for test purposes only
		  table0.ColumnValues("is_europe") = (table0.GetIntegerColumn("is_france") +  table0.GetIntegerColumn("is_belgium")) * 2
		  
		  
		  var col1 as new clDataSerie("country", Array("France","France", "Belgique", "USA","Belgique","USA"))
		  var col2 as new clDataSerie("City","Paris","Marseille","Bruxelles","New York", "Bruxelles","Chicago")
		  var col3 as new clDataSerie("Sales",1100,1200,1300,1400,1500,1600)
		  var col4 as new clIntegerDataSerie("is_france",1,1,0,0,0,0)
		  var col5 as new clIntegerDataSerie("is_belgium",0,0,1,0,1,0)
		  var col6 as new clIntegerDataSerie("is_europe",2,2,2,0,2,0)
		  
		  var expected_t1 as new clDataTable("T1", SerieArray(col1, col2, col3, col4, col5, col6))
		  
		  call check_table(log,"T1", expected_t1, table0)
		  
		  log.end_exec(CurrentMethodName)
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_calc_033(log as LogMessageInterface)
		  
		  log.start_exec(CurrentMethodName)
		  
		  var col_country1 as new clStringDataSerie("Country", "France", "France", "Belgique")
		  var col_city1 as new clStringDataSerie("City", "Paris", "Marseille", "Bruxelles")
		  
		  var table0 As New clDataTable("mytable", SerieArray(col_country1, col_city1))
		  
		  
		  call table0.AddColumn(new clStringDataSerie("Combined"))
		  
		  table0.StringColumn("Combined") = table0.StringColumn("Country") + "-" + table0.StringColumn("City")
		  
		  var col_country2 as new  clStringDataSerie("Country", "France", "France", "Belgique")
		  var col_city2 as new  clStringDataSerie("City", "Paris", "Marseille", "Bruxelles")
		  var col_combined2 as new clStringDataSerie("Combined","France-Paris","France-Marseille","Belgique-Bruxelles")
		  
		  var table_expected As New clDataTable("mytable", SerieArray(col_country2, col_city2, col_combined2))
		  
		  call check_table(log,"use dict for creation", table_expected, table0)
		  
		  log.end_exec(CurrentMethodName)
		  
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_calc_034(log as LogMessageInterface)
		  
		  log.start_exec(CurrentMethodName)
		  
		  var t as new clDataTable("t")
		  
		  var ccnt As clAbstractDataSerie =  t.AddColumn(new clStringDataSerie("Country"))
		  var ccity As clAbstractDataSerie =  t.AddColumn(new clStringDataSerie("City"))
		  var cqtt as clAbstractDataSerie =  t.AddColumn(new clNumberDataSerie("Quantity"))
		  var cup as clAbstractDataSerie = t.AddColumn(new clNumberDataSerie("UnitPrice"))
		  
		  t.AddRow(new Dictionary("Country":"Belgium","City":"Brussels", "Quantity":12, "Unitprice": 21))
		  t.AddRow(new Dictionary("Country":"Belgium","City":"Liege", "Quantity":12, "Unitprice": 22))
		  t.AddRow(new Dictionary("Country":"Belgium","City":"Brussels", "Quantity":12, "Unitprice": 23))
		  t.AddRow(new Dictionary("Country":"Belgium","City":"Brussels", "Quantity":12, "Unitprice": 24))
		  t.AddRow(new Dictionary("Country":"Belgium","City":"Liege", "Quantity":12, "Unitprice": 25))
		  t.AddRow(new Dictionary("Country":"France","City":"Paris", "Quantity":12, "Unitprice": 26))
		  t.AddRow(new Dictionary("Country":"Belgium","City":"Liege", "Quantity":12, "Unitprice": 27))
		  t.AddRow(new Dictionary("Country":"France","City":"Paris", "Quantity":12, "Unitprice": 28))
		  t.AddRow(new Dictionary("Country":"Italy", "City":"Rome","Quantity":10, "UnitPrice":9))
		  
		  var ctp as clAbstractDataSerie = t.AddColumn(clNumberDataSerie(cqtt) * clNumberDataSerie(cup))
		  
		  var g as new clSeriesGroupAndAggregate(SerieArray(ccnt, ccity), array( _
		  cqtt:AggMode.Sum, _
		  cup:AggMode.Min, _
		  cup:AggMode.Max, _
		  ctp:AggMode.Sum, _
		  cup:AggMode.Count) _
		  )
		  
		  call check_table(log, "table integrity", nil, t) 
		  
		  var table0 as clDataTable = new clDataTable("group", g.Flattened(""))
		  
		  var table_expected As New clDataTable("mytable", SerieArray( _
		  new clStringDataSerie("Country", array("Belgium","Belgium", "France", "Italy")), _
		  new clStringDataSerie("City", array("Brussels","Liege", "Paris","Rome")),_
		  new clNumberDataSerie("Sum of Quantity", array(36.00, 36.00, 24.00, 10.00)),_
		  new clNumberDataSerie("Min of UnitPrice", array(21.0, 22.0, 26.0, 9.0)),_
		  new clNumberDataSerie("Max of UnitPrice", array(24.0, 27.0, 28.0, 9.0)),_
		  new clNumberDataSerie("Sum of Quantity*UnitPrice", array(816.0, 888.0, 648.0, 90.0)), _
		  new clIntegerDataSerie("Count of UnitPrice", array( 3, 3, 2, 1)) _ 
		  ))
		  
		  call check_table(log,"groupby and aggregate", table_expected, table0)
		  
		  log.end_exec(CurrentMethodName)
		  
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_calc_035(log as LogMessageInterface)
		  
		  log.start_exec(CurrentMethodName)
		  
		  var t as new clDataTable("t")
		  
		  var ccnt As clAbstractDataSerie =  t.AddColumn(new clStringDataSerie("Country"))
		  var ccity As clAbstractDataSerie =  t.AddColumn(new clStringDataSerie("City"))
		  var cqtt as clAbstractDataSerie =  t.AddColumn(new clNumberDataSerie("Quantity"))
		  var cup as clAbstractDataSerie = t.AddColumn(new clNumberDataSerie("UnitPrice"))
		  
		  t.AddRow(new Dictionary("Country":"Belgium","City":"Brussels", "Quantity":12, "Unitprice": 21))
		  t.AddRow(new Dictionary("Country":"Belgium","City":"Liege", "Quantity":12, "Unitprice": 22))
		  t.AddRow(new Dictionary("Country":"Belgium","City":"Brussels", "Quantity":12, "Unitprice": 23))
		  t.AddRow(new Dictionary("Country":"Belgium","City":"Brussels", "Quantity":12, "Unitprice": 24))
		  t.AddRow(new Dictionary("Country":"Belgium","City":"Liege", "Quantity":12, "Unitprice": 25))
		  t.AddRow(new Dictionary("Country":"France","City":"Paris", "Quantity":12, "Unitprice": 26))
		  t.AddRow(new Dictionary("Country":"Belgium","City":"Liege", "Quantity":12, "Unitprice": 27))
		  t.AddRow(new Dictionary("Country":"France","City":"Paris", "Quantity":12, "Unitprice": 28))
		  
		  var ctp as clAbstractDataSerie = t.AddColumn(clNumberDataSerie(cqtt) * clNumberDataSerie(cup))
		  
		  call check_table(log, "table integrity", nil, t) 
		  
		  var g as new clSeriesGroupBy(SerieArray(ccnt, ccity))
		  
		  var gf() as clAbstractDataSerie = g.Flattened("")
		  var table0 as clDataTable = new clDataTable("group", gf)
		  
		  var table_expected As New clDataTable("mytable", SerieArray( _
		  new clStringDataSerie("Country", array("Belgium","Belgium", "France")), _
		  new clStringDataSerie("City", array("Brussels","Liege", "Paris")) _
		  ))
		  
		  call check_table(log,"get distinct values", table_expected, table0)
		  
		  log.end_exec(CurrentMethodName)
		  
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_calc_036(log as LogMessageInterface)
		  
		  log.start_exec(CurrentMethodName)
		  
		  
		  var tcountries as new clDataTable("Countries")
		  call  tcountries.AddColumn(new clStringDataSerie("Country"))
		  call  tcountries.AddColumn(new clStringDataSerie("City"))
		  tcountries.AddRow(new Dictionary("Country":"Belgium","City":"Brussels"))
		  tcountries.AddRow(new Dictionary("Country":"Belgium","City":"Liege"))
		  tcountries.AddRow(new Dictionary("Country":"France","City":"Paris"))
		  tcountries.AddRow(new Dictionary("Country":"USA","City":"NewYork"))
		  
		  call check_table(log, "tcountries table integrity", nil, tcountries) 
		  
		  
		  var tsales as new clDataTable("Sales")
		  
		  var ccity As clAbstractDataSerie =  tsales.AddColumn(new clStringDataSerie("City"))
		  var cqtt as clAbstractDataSerie =  tsales.AddColumn(new clNumberDataSerie("Quantity"))
		  var cup as clAbstractDataSerie = tsales.AddColumn(new clNumberDataSerie("UnitPrice"))
		  call tsales.AddColumn(new clBooleanDataSerie("CountryFound"))
		  
		  
		  tsales.AddRow(new Dictionary("City":"Brussels", "Quantity":12, "Unitprice": 21))
		  tsales.AddRow(new Dictionary("City":"Liege", "Quantity":12, "Unitprice": 22))
		  tsales.AddRow(new Dictionary("City":"Brussels", "Quantity":12, "Unitprice": 23))
		  tsales.AddRow(new Dictionary("City":"Brussels", "Quantity":12, "Unitprice": 24))
		  tsales.AddRow(new Dictionary("City":"Liege", "Quantity":12, "Unitprice": 25))
		  tsales.AddRow(new Dictionary("City":"Paris", "Quantity":12, "Unitprice": 26))
		  tsales.AddRow(new Dictionary("City":"Liege", "Quantity":12, "Unitprice": 27))
		  tsales.AddRow(new Dictionary("City":"Paris", "Quantity":12, "Unitprice": 28))
		  
		  var ctp as clAbstractDataSerie = tsales.AddColumn(clNumberDataSerie(cqtt) * clNumberDataSerie(cup))
		  ctp.Rename("Sales")
		  
		  call check_table(log, "tsales table integrity", nil, tsales) 
		  
		  var join_results as Boolean = tsales.Lookup(tcountries, array("City"), array("Country"), "CountryFound")
		  
		  var ccnty as clAbstractDataSerie = tsales.GetColumn("Country")
		  
		  var gDistinct as new clSeriesGroupBy(Array(ccnty, ccity))
		  
		  var tDistinct  as clDataTable = new clDataTable("group", gDistinct.Flattened(""))
		  
		  var tDistinct_expected As New clDataTable("mytable", SerieArray( _
		  new clStringDataSerie("Country", array("Belgium","Belgium", "France")), _
		  new clStringDataSerie("City", array("Brussels","Liege", "Paris")) _
		  ))
		  
		  call check_table(log,"get distinct values", tDistinct_expected, tDistinct )
		  
		  
		  var tSumSales as clDataTable = tsales.GroupBy(StringArray("Country"), StringArray("Sales","Quantity"))
		  
		  var tSumSales_expected As New clDataTable("mytable", SerieArray( _
		  new clStringDataSerie("Country", array("Belgium","France")), _
		  new clNumberDataSerie("Sum of Sales", array(1704, 648)), _
		  new clNumberDataSerie("Sum of Quantity", array (72,24)) _
		  ))
		  
		  call check_table(log,"Check total sales", tSumSales_expected, tSumSales )
		  
		  
		  log.end_exec(CurrentMethodName)
		  
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_calc_037(log as LogMessageInterface)
		  
		  log.start_exec(CurrentMethodName)
		  
		  
		  var tcountries as new clDataTable("Countries")
		  call  tcountries.AddColumn(new clStringDataSerie("Country"))
		  call  tcountries.AddColumn(new clStringDataSerie("City"))
		  tcountries.AddRow(new Dictionary("Country":"Belgium","City":"Brussels"))
		  tcountries.AddRow(new Dictionary("Country":"Belgium","City":"Liege"))
		  tcountries.AddRow(new Dictionary("Country":"France","City":"Paris"))
		  tcountries.AddRow(new Dictionary("Country":"USA","City":"NewYork"))
		  
		  call check_table(log, "tcountries table integrity", nil, tcountries) 
		  
		  
		  var tsales as new clDataTable("Sales")
		  
		  var ccity As clAbstractDataSerie =  tsales.AddColumn(new clStringDataSerie("City"))
		  var cqtt as clAbstractDataSerie =  tsales.AddColumn(new clNumberDataSerie("Quantity"))
		  var cup as clAbstractDataSerie = tsales.AddColumn(new clNumberDataSerie("UnitPrice"))
		  
		  tsales.AddRow(new Dictionary("City":"Brussels", "Quantity":12, "Unitprice": 21))
		  tsales.AddRow(new Dictionary("City":"Liege", "Quantity":12, "Unitprice": 22))
		  tsales.AddRow(new Dictionary("City":"Brussels", "Quantity":12, "Unitprice": 23))
		  tsales.AddRow(new Dictionary("City":"Brussels", "Quantity":12, "Unitprice": 24))
		  tsales.AddRow(new Dictionary("City":"Liege", "Quantity":12, "Unitprice": 25))
		  tsales.AddRow(new Dictionary("City":"Paris", "Quantity":12, "Unitprice": 26))
		  tsales.AddRow(new Dictionary("City":"Liege", "Quantity":12, "Unitprice": 27))
		  tsales.AddRow(new Dictionary("City":"Paris", "Quantity":12, "Unitprice": 28))
		  tsales.AddRow(new Dictionary("City":"Rome", "Quantity":10, "Unitprice": 25))
		  
		  var ctp as clAbstractDataSerie = tsales.AddColumn(clNumberDataSerie(cqtt) * clNumberDataSerie(cup))
		  ctp.Rename("Sales")
		  
		  call check_table(log, "tsales table integrity", nil, tsales) 
		  
		  var join_results as Boolean = tsales.Lookup(tcountries, array("City"), array("Country"))
		  
		  var tDistinct  as clDataTable = tsales.GroupBy(StringArray("Country", "City"))
		  
		  var tDistinct_expected As New clDataTable("mytable", SerieArray( _
		  new clStringDataSerie("Country", array("Belgium","Belgium", "France","")), _
		  new clStringDataSerie("City", array("Brussels","Liege", "Paris","Rome")) _
		  ))
		  
		  call check_table(log,"get distinct values", tDistinct_expected, tDistinct )
		  
		  var tSumSales as clDataTable = tsales.GroupBy(StringArray("Country"), StringArray("Sales","Quantity"))
		  
		  var tSumSales_expected As New clDataTable("mytable", SerieArray( _
		  new clStringDataSerie("Country", array("Belgium","France","")), _
		  new clNumberDataSerie("Sum of Sales", array(1704, 648,250)), _
		  new clNumberDataSerie("Sum of Quantity", array (72,24, 10)) _
		  ))
		  
		  call check_table(log,"Check total sales", tSumSales_expected, tSumSales )
		  
		  
		  log.end_exec(CurrentMethodName)
		  
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_calc_038(log as LogMessageInterface)
		  
		  log.start_exec(CurrentMethodName)
		  
		  var t as new clDataTable("t")
		  
		  var ccnt As clAbstractDataSerie =  t.AddColumn(new clStringDataSerie("Country"))
		  var ccity As clAbstractDataSerie =  t.AddColumn(new clStringDataSerie("City"))
		  var cqtt as clAbstractDataSerie =  t.AddColumn(new clNumberDataSerie("Quantity"))
		  var cup as clAbstractDataSerie = t.AddColumn(new clNumberDataSerie("UnitPrice"))
		  
		  t.AddRow(new Dictionary("Country":"Belgium","City":"Brussels", "Quantity":12, "Unitprice": 21))
		  t.AddRow(new Dictionary("Country":"Belgium","City":"Liege", "Quantity":12, "Unitprice": 22))
		  t.AddRow(new Dictionary("Country":"Belgium","City":"Brussels", "Quantity":12, "Unitprice": 23))
		  t.AddRow(new Dictionary("Country":"Belgium","City":"Brussels", "Quantity":12, "Unitprice": 24))
		  t.AddRow(new Dictionary("Country":"Belgium","City":"Liege", "Quantity":12, "Unitprice": 25))
		  t.AddRow(new Dictionary("Country":"France","City":"Paris", "Quantity":12, "Unitprice": 26))
		  t.AddRow(new Dictionary("Country":"Belgium","City":"Liege", "Quantity":12, "Unitprice": 27))
		  t.AddRow(new Dictionary("Country":"France","City":"Paris", "Quantity":12, "Unitprice": 28))
		  
		  var ctp as clAbstractDataSerie = t.AddColumn(clNumberDataSerie(cqtt) * clNumberDataSerie(cup))
		  
		  call check_table(log, "table integrity", nil, t) 
		  
		  var table0 as clDataTable = t.GroupBy(array("Country","City"))
		  
		  var table_expected As New clDataTable("mytable", SerieArray( _
		  new clStringDataSerie("Country", array("Belgium","Belgium", "France")), _
		  new clStringDataSerie("City", array("Brussels","Liege", "Paris")) _
		  ))
		  
		  call check_table(log,"get distinct values", table_expected, table0)
		  
		  log.end_exec(CurrentMethodName)
		  
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_calc_039(log as LogMessageInterface)
		  
		  log.start_exec(CurrentMethodName)
		  
		  var t1 as new clDataTable("Main")
		  
		  var ccnt As clAbstractDataSerie =  t1.AddColumn(new clStringDataSerie("Country"))
		  var ccity As clAbstractDataSerie =  t1.AddColumn(new clStringDataSerie("City"))
		  var cqtt as clAbstractDataSerie =  t1.AddColumn(new clNumberDataSerie("Quantity"))
		  var cup as clAbstractDataSerie = t1.AddColumn(new clNumberDataSerie("UnitPrice"))
		  
		  t1.AddRow(new Dictionary("Country":"Italy","City":"Rome", "Quantity":12, "Unitprice": 23))
		  t1.AddRow(new Dictionary("Country":"Belgium","City":"Brussels", "Quantity":12, "Unitprice": 21))
		  t1.AddRow(new Dictionary("Country":"Belgium","City":"Liege", "Quantity":12, "Unitprice": 5))
		  t1.AddRow(new Dictionary("Country":"Belgium","City":"Liege", "Quantity":12, "Unitprice": 26))
		  t1.AddRow(new Dictionary("Country":"France","City":"Paris", "Quantity":12, "Unitprice": 4))
		  t1.AddRow(new Dictionary("Country":"Belgium","City":"Liege", "Quantity":12, "Unitprice": 28))
		  t1.AddRow(new Dictionary("Country":"Italy","City":"MIlano", "Quantity":12, "Unitprice": 29))
		  t1.AddRow(new Dictionary("Country":"France","City":"Paris", "Quantity":12, "Unitprice": 30))
		  t1.AddRow(new Dictionary("Country":"Belgium","City":"Brussels", "Quantity":12, "Unitprice": 24))
		  t1.AddRow(new Dictionary("Country":"Belgium","City":"Antwerpen", "Quantity":12, "Unitprice": 25))
		  
		  t1.AddColumn(clNumberDataSerie(cqtt) * clNumberDataSerie(cup)).Rename("Sales")
		  
		  var sort11 as clDataTable = t1.Sort(array("Country","City"))
		  //sort1.Rename("Sorted on country and city")
		  
		  var sort12 as clDataTable = t1.Sort(array("Country","UnitPrice"))
		  //sort2.Rename("Sorted on country and unit price")
		  
		  var sort13 as clDataTable = t1.Sort(array("Sales"),SortOrder.Descending)
		  //sort3.Rename("Sorted on Sales descending")
		  
		  var t2 as clDataTable = t1.Groupby(array("Country"), array("Sales"))
		  
		  var sort21 as clDataTable = t2.Sort(array("Sum of Sales"), SortOrder.Descending)
		  
		  var sort22 as clDataTable = t2.Sort(array("Country"))
		  
		  call check_table(log, "table integrity", nil, t1)
		  call check_table(log, "table integrity", nil, t2)
		  call check_table(log, "table integrity", nil, sort11)
		  call check_table(log, "table integrity", nil, sort12)
		  call check_table(log, "table integrity", nil, sort13)
		  call check_table(log, "table integrity", nil, sort21)
		  call check_table(log, "table integrity", nil, sort22)
		  
		  var expected_sort21 as new clDataTable("Country", SerieArray( _
		  new clStringDataSerie("Country", "Belgium", "Italy", "France") _
		  , new clNumberDataSerie("sum of Sales", 1548.0, 624.0,408.0) _
		  ))
		  
		  var expected_sort22 as new clDataTable("Country", SerieArray( _
		  new clStringDataSerie("Country","Belgium", "France", "Italy") _
		  , new clNumberDataSerie("sum of Sales", 1548.0, 408.0, 624.0) _
		  ))
		  
		  call check_table(log,"Sort 21", expected_sort21, sort21)
		  call check_table(log,"Sort 22", expected_sort22, sort22)
		  
		  // call check_table(log,"get distinct values", table_expected, table0)
		  
		  log.end_exec(CurrentMethodName)
		  
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_calc_040(log as LogMessageInterface)
		  //
		  // Test full joins
		  
		  log.start_exec(CurrentMethodName)
		  
		  
		  var tcountries1 as new clDataTable("Countries1")
		  call  tcountries1.AddColumn(new clStringDataSerie("Country"))
		  call  tcountries1.AddColumn(new clStringDataSerie("City"))
		  tcountries1.AddRow(new Dictionary("Country":"Belgium","City":"Brussels"))
		  tcountries1.AddRow(new Dictionary("Country":"Belgium","City":"Liege"))
		  tcountries1.AddRow(new Dictionary("Country":"France","City":"Paris"))
		  tcountries1.AddRow(new Dictionary("Country":"USA","City":"NewYork"))
		  tcountries1.AddRow(new Dictionary("City":"London"))
		  
		  call check_table(log, "tcountries table integrity", nil, tcountries1) 
		  
		  var tcountries2 as new clDataTable("Countries2")
		  call  tcountries2.AddColumn(new clStringDataSerie("Country"))
		  call  tcountries2.AddColumn(new clStringDataSerie("City"))
		  tcountries2.AddRow(new Dictionary("Country":"USA","City":"NewYork"))
		  tcountries2.AddRow(new Dictionary("Country":"France","City":"Lyon"))
		  tcountries2.AddRow(new Dictionary("Country":"Spain","City":"Madrid"))
		  
		  call check_table(log, "tcountries table integrity", nil, tcountries2) 
		  
		  
		  
		  var tcountries3 as new clDataTable("Countries3")
		  call  tcountries3.AddColumn(new clStringDataSerie("Country"))
		  call  tcountries3.AddColumn(new clStringDataSerie("City"))
		  call tcountries3.AddColumn(new clStringDataSerie("Something"))
		  
		  tcountries3.AddRow(new Dictionary("Country":"Belgium","City":"Brussels","Something":"Alpha"))
		  tcountries3.AddRow(new Dictionary("Country":"Belgium","City":"Liege","Something":"Beta"))
		  tcountries3.AddRow(new Dictionary("Country":"Belgium","City":"Liege","Something":"Gamma"))
		  tcountries3.AddRow(new Dictionary("Country":"France","City":"Paris","Something":"Delta"))
		  tcountries3.AddRow(new Dictionary("Country":"France","City":"Lille","Something":"Omega"))
		  tcountries3.AddRow(new Dictionary("Country":"USA","City":"NewYork","Something":"Zeta"))
		  tcountries3.AddRow(new Dictionary("City":"London"))
		  
		  call check_table(log, "tcountries table integrity", nil, tcountries3) 
		  
		  
		  
		  var tsales as new clDataTable("Sales")
		  
		  var ccity As clAbstractDataSerie =  tsales.AddColumn(new clStringDataSerie("City"))
		  var cqtt as clAbstractDataSerie =  tsales.AddColumn(new clNumberDataSerie("Quantity"))
		  var cup as clAbstractDataSerie = tsales.AddColumn(new clNumberDataSerie("UnitPrice"))
		  
		  tsales.AddRow(new Dictionary("City":"Brussels", "Quantity":12, "Unitprice": 21))
		  tsales.AddRow(new Dictionary("City":"Liege", "Quantity":12, "Unitprice": 22))
		  tsales.AddRow(new Dictionary("City":"Brussels", "Quantity":12, "Unitprice": 23))
		  tsales.AddRow(new Dictionary("City":"Brussels", "Quantity":12, "Unitprice": 24))
		  tsales.AddRow(new Dictionary("City":"Liege", "Quantity":12, "Unitprice": 25))
		  tsales.AddRow(new Dictionary("City":"Paris", "Quantity":12, "Unitprice": 26))
		  tsales.AddRow(new Dictionary("City":"Liege", "Quantity":12, "Unitprice": 27))
		  tsales.AddRow(new Dictionary("City":"Paris", "Quantity":12, "Unitprice": 28))
		  tsales.AddRow(new Dictionary("City":"Rome", "Quantity":10, "Unitprice": 25))
		  
		  call check_table(log, "tsales table integrity", nil, tsales) 
		  
		  var tjoin1 as clDataTable = tsales.FullJoin(tcountries1, JoinMode.InnerJoin, array("City"))
		  
		  var tjoin2 as clDataTable = tsales.FullJoin(tcountries1, JoinMode.OuterJoin, array("City"))
		  
		  var tjoin3 as clDataTable = tsales.FullJoin(tcountries2, JoinMode.InnerJoin, array("City"))
		  
		  var tjoin4 as clDataTable = tsales.FullJoin(tcountries2, JoinMode.OuterJoin, array("City"))
		  
		  var tjoin5 as clDataTable = tsales.FullJoin(tcountries3, JoinMode.InnerJoin, array("City"))
		  
		  var tjoin6 as clDataTable = tsales.FullJoin(tcountries3, JoinMode.OuterJoin, array("City"))
		  
		  
		  var tjoin1_expected as new clDataTable("X1")
		  call tjoin1_expected.AddColumn(new clStringDataSerie("City"))
		  call tjoin1_expected.AddColumn(new clNumberDataSerie("Quantity"))
		  call tjoin1_expected.AddColumn(new clNumberDataSerie("UnitPrice"))
		  call tjoin1_expected.AddColumn(new clStringDataSerie("Country"))
		  
		  tjoin1_expected.AddRow(new Dictionary("City":"Brussels", "Quantity":12, "Unitprice": 21,"Country":"Belgium"))
		  tjoin1_expected.AddRow(new Dictionary("City":"Liege", "Quantity":12, "Unitprice": 22,"Country":"Belgium"))
		  tjoin1_expected.AddRow(new Dictionary("City":"Brussels", "Quantity":12, "Unitprice": 23,"Country":"Belgium"))
		  tjoin1_expected.AddRow(new Dictionary("City":"Brussels", "Quantity":12, "Unitprice": 24,"Country":"Belgium"))
		  tjoin1_expected.AddRow(new Dictionary("City":"Liege", "Quantity":12, "Unitprice": 25,"Country":"Belgium"))
		  tjoin1_expected.AddRow(new Dictionary("City":"Paris", "Quantity":12, "Unitprice": 26,"Country":"France"))
		  tjoin1_expected.AddRow(new Dictionary("City":"Liege", "Quantity":12, "Unitprice": 27,"Country":"Belgium"))
		  tjoin1_expected.AddRow(new Dictionary("City":"Paris", "Quantity":12, "Unitprice": 28,"Country":"France"))
		  
		  
		  //
		  var tjoin2_expected as new clDataTable("X2")
		  call tjoin2_expected.AddColumn(new clStringDataSerie("City"))
		  call tjoin2_expected.AddColumn(new clNumberDataSerie("Quantity"))
		  call tjoin2_expected.AddColumn(new clNumberDataSerie("UnitPrice"))
		  call tjoin2_expected.AddColumn(new clStringDataSerie("Country"))
		  
		  tjoin2_expected.AddRow(new Dictionary("City":"Brussels", "Quantity":12, "Unitprice": 21,"Country":"Belgium"))
		  tjoin2_expected.AddRow(new Dictionary("City":"Liege", "Quantity":12, "Unitprice": 22,"Country":"Belgium"))
		  tjoin2_expected.AddRow(new Dictionary("City":"Brussels", "Quantity":12, "Unitprice": 23,"Country":"Belgium"))
		  tjoin2_expected.AddRow(new Dictionary("City":"Brussels", "Quantity":12, "Unitprice": 24,"Country":"Belgium"))
		  tjoin2_expected.AddRow(new Dictionary("City":"Liege", "Quantity":12, "Unitprice": 25,"Country":"Belgium"))
		  tjoin2_expected.AddRow(new Dictionary("City":"Paris", "Quantity":12, "Unitprice": 26,"Country":"France"))
		  tjoin2_expected.AddRow(new Dictionary("City":"Liege", "Quantity":12, "Unitprice": 27,"Country":"Belgium"))
		  tjoin2_expected.AddRow(new Dictionary("City":"Paris", "Quantity":12, "Unitprice": 28,"Country":"France"))
		  tjoin2_expected.AddRow(new Dictionary("City":"Rome", "Quantity":10, "Unitprice": 25))
		  tjoin2_expected.AddRow(new Dictionary("Country":"USA","City":"NewYork"))
		  tjoin2_expected.AddRow(new Dictionary("City":"London"))
		  
		  
		  
		  var tjoin3_expected as new clDataTable("X3")
		  call tjoin3_expected.AddColumn(new clStringDataSerie("City"))
		  call tjoin3_expected.AddColumn(new clNumberDataSerie("Quantity"))
		  call tjoin3_expected.AddColumn(new clNumberDataSerie("UnitPrice"))
		  call tjoin3_expected.AddColumn(new clStringDataSerie("Country"))
		  
		  var tjoin4_expected as new clDataTable("X4")
		  call tjoin4_expected.AddColumn(new clStringDataSerie("City"))
		  call tjoin4_expected.AddColumn(new clNumberDataSerie("Quantity"))
		  call tjoin4_expected.AddColumn(new clNumberDataSerie("UnitPrice"))
		  call tjoin4_expected.AddColumn(new clStringDataSerie("Country"))
		  
		  tjoin4_expected.AddRow(new Dictionary("City":"Brussels", "Quantity":12, "Unitprice": 21))
		  tjoin4_expected.AddRow(new Dictionary("City":"Liege", "Quantity":12, "Unitprice": 22))
		  tjoin4_expected.AddRow(new Dictionary("City":"Brussels", "Quantity":12, "Unitprice": 23))
		  tjoin4_expected.AddRow(new Dictionary("City":"Brussels", "Quantity":12, "Unitprice": 24))
		  tjoin4_expected.AddRow(new Dictionary("City":"Liege", "Quantity":12, "Unitprice": 25))
		  tjoin4_expected.AddRow(new Dictionary("City":"Paris", "Quantity":12, "Unitprice": 26))
		  tjoin4_expected.AddRow(new Dictionary("City":"Liege", "Quantity":12, "Unitprice": 27))
		  tjoin4_expected.AddRow(new Dictionary("City":"Paris", "Quantity":12, "Unitprice": 28))
		  tjoin4_expected.AddRow(new Dictionary("City":"Rome", "Quantity":10, "Unitprice": 25))
		  tjoin4_expected.AddRow(new Dictionary("Country":"USA","City":"NewYork"))
		  tjoin4_expected.AddRow(new Dictionary("Country":"France","City":"Lyon"))
		  tjoin4_expected.AddRow(new Dictionary("Country":"Spain","City":"Madrid"))
		  
		  
		  
		  
		  var tjoin5_expected as new clDataTable("X5")
		  call tjoin5_expected.AddColumn(new clStringDataSerie("City"))
		  call tjoin5_expected.AddColumn(new clNumberDataSerie("Quantity"))
		  call tjoin5_expected.AddColumn(new clNumberDataSerie("UnitPrice"))
		  call tjoin5_expected.AddColumn(new clNumberDataSerie("Country"))
		  call tjoin5_expected.AddColumn(new clStringDataSerie("Something"))
		  
		  tjoin5_expected.AddRow(new Dictionary("City":"Brussels", "Quantity":12, "Unitprice": 21,"Country":"Belgium","Something":"Alpha"))
		  tjoin5_expected.AddRow(new Dictionary("City":"Liege", "Quantity":12, "Unitprice": 22,"Country":"Belgium","Something":"Beta"))
		  tjoin5_expected.AddRow(new Dictionary("City":"Liege", "Quantity":12, "Unitprice": 22,"Country":"Belgium","Something":"Gamma"))
		  tjoin5_expected.AddRow(new Dictionary("City":"Brussels", "Quantity":12, "Unitprice": 23,"Country":"Belgium","Something":"Alpha"))
		  tjoin5_expected.AddRow(new Dictionary("City":"Brussels", "Quantity":12, "Unitprice": 24,"Country":"Belgium","Something":"Alpha"))
		  tjoin5_expected.AddRow(new Dictionary("City":"Liege", "Quantity":12, "Unitprice": 25,"Country":"Belgium","Something":"Beta"))
		  tjoin5_expected.AddRow(new Dictionary("City":"Liege", "Quantity":12, "Unitprice": 25,"Country":"Belgium","Something":"Gamma"))
		  tjoin5_expected.AddRow(new Dictionary("City":"Paris", "Quantity":12, "Unitprice": 26,"Country":"France","Something":"Delta"))
		  tjoin5_expected.AddRow(new Dictionary("City":"Liege", "Quantity":12, "Unitprice": 27,"Country":"Belgium","Something":"Beta"))
		  tjoin5_expected.AddRow(new Dictionary("City":"Liege", "Quantity":12, "Unitprice": 27,"Country":"Belgium","Something":"Gamma"))
		  tjoin5_expected.AddRow(new Dictionary("City":"Paris", "Quantity":12, "Unitprice": 28,"Country":"France","Something":"Delta"))
		  
		  
		  
		  var tjoin6_expected as new clDataTable("X6")
		  call tjoin6_expected.AddColumn(new clStringDataSerie("City"))
		  call tjoin6_expected.AddColumn(new clNumberDataSerie("Quantity"))
		  call tjoin6_expected.AddColumn(new clNumberDataSerie("UnitPrice"))
		  call tjoin6_expected.AddColumn(new clNumberDataSerie("Country"))
		  call tjoin6_expected.AddColumn(new clStringDataSerie("Something"))
		  
		  tjoin6_expected.AddRow(new Dictionary("City":"Brussels", "Quantity":12, "Unitprice": 21,"Country":"Belgium","Something":"Alpha"))
		  tjoin6_expected.AddRow(new Dictionary("City":"Liege", "Quantity":12, "Unitprice": 22,"Country":"Belgium","Something":"Beta"))
		  tjoin6_expected.AddRow(new Dictionary("City":"Liege", "Quantity":12, "Unitprice": 22,"Country":"Belgium","Something":"Gamma"))
		  tjoin6_expected.AddRow(new Dictionary("City":"Brussels", "Quantity":12, "Unitprice": 23,"Country":"Belgium","Something":"Alpha"))
		  tjoin6_expected.AddRow(new Dictionary("City":"Brussels", "Quantity":12, "Unitprice": 24,"Country":"Belgium","Something":"Alpha"))
		  tjoin6_expected.AddRow(new Dictionary("City":"Liege", "Quantity":12, "Unitprice": 25,"Country":"Belgium","Something":"Beta"))
		  tjoin6_expected.AddRow(new Dictionary("City":"Liege", "Quantity":12, "Unitprice": 25,"Country":"Belgium","Something":"Gamma"))
		  tjoin6_expected.AddRow(new Dictionary("City":"Paris", "Quantity":12, "Unitprice": 26,"Country":"France","Something":"Delta"))
		  tjoin6_expected.AddRow(new Dictionary("City":"Liege", "Quantity":12, "Unitprice": 27,"Country":"Belgium","Something":"Beta"))
		  tjoin6_expected.AddRow(new Dictionary("City":"Liege", "Quantity":12, "Unitprice": 27,"Country":"Belgium","Something":"Gamma"))
		  tjoin6_expected.AddRow(new Dictionary("City":"Paris", "Quantity":12, "Unitprice": 28,"Country":"France","Something":"Delta"))
		  tjoin6_expected.AddRow(new Dictionary("City":"Rome", "Quantity":10, "Unitprice": 25))
		  tjoin6_expected.AddRow(new Dictionary("City":"Lille", "Quantity":0, "Unitprice": 0,"Country":"Belgium","Something":"Omega"))
		  tjoin6_expected.AddRow(new Dictionary("City":"NewYork", "Quantity":0, "Unitprice": 0,"Country":"USA","Something":"Zeta"))
		  tjoin6_expected.AddRow(new Dictionary("City":"London", "Quantity":0, "UnitPrice":0))
		  
		  
		  
		  call check_table(log, "Join1", tjoin1_expected, tjoin1)
		  
		  call check_table(log, "Join2", tjoin2_expected, tjoin2)
		  
		  call check_table(log, "Join3", tjoin3_expected, tjoin3)
		  
		  call check_table(log, "Join4", tjoin4_expected, tjoin4)
		  
		  call check_table(log, "Join5", tjoin5_expected, tjoin5)
		  
		  call check_table(log, "Join6", tjoin6_expected, tjoin6)
		  
		  
		  log.end_exec(CurrentMethodName)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_calc_041(log as LogMessageInterface)
		  
		  log.start_exec(CurrentMethodName)
		  
		  
		  var tcountries as new clDataTable("Countries")
		  call  tcountries.AddColumn(new clStringDataSerie("Country"))
		  call  tcountries.AddColumn(new clStringDataSerie("City"))
		  tcountries.AddRow(new Dictionary("Country":"Belgium","City":"Brussels"))
		  tcountries.AddRow(new Dictionary("Country":"Belgium","City":"Liege"))
		  tcountries.AddRow(new Dictionary("Country":"France","City":"Paris"))
		  tcountries.AddRow(new Dictionary("Country":"USA","City":"NewYork"))
		  
		  call check_table(log, "tcountries table integrity", nil, tcountries) 
		  
		  
		  var tsales as new clDataTable("Sales")
		  
		  var ccity As clAbstractDataSerie =  tsales.AddColumn(new clStringDataSerie("City"))
		  var cqtt as clAbstractDataSerie =  tsales.AddColumn(new clNumberDataSerie("Quantity"))
		  var cup as clAbstractDataSerie = tsales.AddColumn(new clNumberDataSerie("UnitPrice"))
		  
		  tsales.AddRow(new Dictionary("City":"Brussels", "Quantity":12, "Unitprice": 21))
		  tsales.AddRow(new Dictionary("City":"Liege", "Quantity":12, "Unitprice": 22))
		  tsales.AddRow(new Dictionary("City":"Brussels", "Quantity":12, "Unitprice": 23))
		  tsales.AddRow(new Dictionary("City":"Brussels", "Quantity":12, "Unitprice": 24))
		  tsales.AddRow(new Dictionary("City":"Liege", "Quantity":12, "Unitprice": 25))
		  tsales.AddRow(new Dictionary("City":"Paris", "Quantity":12, "Unitprice": 26))
		  tsales.AddRow(new Dictionary("City":"Liege", "Quantity":12, "Unitprice": 27))
		  tsales.AddRow(new Dictionary("City":"Paris", "Quantity":12, "Unitprice": 28))
		  tsales.AddRow(new Dictionary("City":"Rome", "Quantity":10, "Unitprice": 25))
		  
		  var ctp as clAbstractDataSerie = tsales.AddColumn(clNumberDataSerie(cqtt) * clNumberDataSerie(cup))
		  ctp.Rename("Sales")
		  
		  call check_table(log, "tsales table integrity 1", nil, tsales) 
		  
		  var join_results as Boolean = tsales.Lookup(tcountries, array("City"), array("Country"), "CountryFound")
		  
		  call check_table(log, "tsales table integrity 2", nil, tsales) 
		  
		  
		  var gTransformer1 as new clGroupByTransformer(tsales, StringArray("Country", "City"), "")
		  call gTransformer1.Transform
		  var tDistinct  as clDataTable = gTransformer1.GetOutputTable()
		  
		  var tDistinct_expected As New clDataTable("mytable", SerieArray( _
		  new clStringDataSerie("Country", array("Belgium","Belgium", "France","")), _
		  new clStringDataSerie("City", array("Brussels","Liege", "Paris","Rome")) _
		  ))
		  
		  call check_table(log,"get distinct values", tDistinct_expected, tDistinct )
		  
		  
		  
		  var gTransformer2 as new clGroupByTransformer(tsales, StringArray("Country") _
		  , PairArray("Sales":aggMode.Sum,"Quantity":aggMode.Sum, "UnitPrice":aggMode.Min, "UnitPrice":aggMode.Max) _
		  ,"" _
		  )
		  
		  call gTransformer2.Transform
		  var tSumSales as clDataTable = gTransformer2.GetOutputTable()
		  
		  var tSumSales_expected As New clDataTable("mytable", SerieArray( _
		  new clStringDataSerie("Country", array("Belgium","France","")) _
		  , new clNumberDataSerie("Sum of Sales", array(1704, 648,250)) _
		  , new clNumberDataSerie("Sum of Quantity", array (72,24, 10)) _
		  , new clNumberDataSerie("Min of UnitPrice", array( 21, 26 , 25)) _
		  , new clNumberDataSerie("Max of UnitPrice", array( 27, 28 , 25)) _
		  ))
		  
		  call check_table(log,"Check total sales", tSumSales_expected, tSumSales )
		  
		  
		  log.end_exec(CurrentMethodName)
		  
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_calc_042(log as LogMessageInterface)
		  
		  log.start_exec(CurrentMethodName)
		  
		  
		  var temp_row As clDataRow
		  var mytable As New clDataTable("T1")
		  
		  call mytable.AddColumn(new clStringDataSerie("name", array("2020Q1","2020Q2","2020Q3")))
		  call mytable.AddColumn(new clNumberDataSerie("Sales_France", array(101.1, 101.2, 101.3)))
		  call mytable.AddColumn(new clNumberDataSerie("Sales_Belgium", array(102.1, 102.2, 102.3)))
		  call mytable.AddColumn(new clNumberDataSerie("Sales_Italy", array(103.1, 103.2, 103.3)))
		  
		  call check_table(log,"Consistency T1", nil, mytable)
		  
		  var uTransformer as new clUnpivotTransformer(mytable, array("name"), "Area","Sales")
		  
		  call uTransformer.Transform()
		  
		  var results as clDataTable  = uTransformer.GetOutputTable()
		  
		  call check_table(log,"Consistency results", nil, results)
		  
		  var expected_results as new clDataTable("Expected Results")
		  call expected_results.AddColumn(new clStringDataSerie("name",array("2020Q1","2020Q1","2020Q1","2020Q2","2020Q2","2020Q2","2020Q3","2020Q3","2020Q3")))
		  call expected_results.AddColumn(new clStringDataSerie("Area",array("Sales_France","Sales_Belgium","Sales_Italy","Sales_France","Sales_Belgium","Sales_Italy","Sales_France","Sales_Belgium","Sales_Italy")))
		  call expected_results.AddColumn(new clNumberDataSerie("Sales",array(101.1, 102.1, 103.1, 101.2, 102.2, 103.2,101.3, 102.3, 103.3)))
		  
		  
		  call check_table(log,"Results", expected_results, results)
		  
		  
		  log.end_exec(CurrentMethodName)
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_calc_043(log as LogMessageInterface)
		  
		  log.start_exec(CurrentMethodName)
		  
		  
		  var temp_row As clDataRow
		  var mytable As New clDataTable("T1")
		  
		  call mytable.AddColumn(new clStringDataSerie("name", array("2020Q1","2020Q2","2020Q3")))
		  call mytable.AddColumn(new clNumberDataSerie("Sales_France", array(101.1, 101.2, 101.3)))
		  call myTable.AddColumn(new clNumberDataSerie("col1", array(1.1, 2.1, 3.1)))
		  call mytable.AddColumn(new clNumberDataSerie("Sales_Belgium", array(102.1, 102.2, 102.3)))
		  call mytable.AddColumn(new clNumberDataSerie("Sales_Italy", array(103.1, 103.2, 103.3)))
		  
		  
		  call check_table(log,"Consistency T1", nil, mytable)
		  
		  var uTransformer as new clUnpivotTransformer(mytable, array("name"), "Area","Sales", array("col1"))
		  
		  call uTransformer.Transform()
		  
		  var results as clDataTable  = uTransformer.GetOutputTable()
		  
		  call check_table(log,"Consistency results", nil, results)
		  
		  var expected_results as new clDataTable("Expected Results")
		  call expected_results.AddColumn(new clStringDataSerie("name",array("2020Q1","2020Q1","2020Q1","2020Q2","2020Q2","2020Q2","2020Q3","2020Q3","2020Q3")))
		  call expected_results.AddColumn(new clStringDataSerie("Area",array("Sales_France","Sales_Belgium","Sales_Italy","Sales_France","Sales_Belgium","Sales_Italy","Sales_France","Sales_Belgium","Sales_Italy")))
		  call expected_results.AddColumn(new clNumberDataSerie("Sales",array(101.1, 102.1, 103.1, 101.2, 102.2, 103.2,101.3, 102.3, 103.3)))
		  
		  
		  call check_table(log,"Results", expected_results, results)
		  
		  
		  log.end_exec(CurrentMethodName)
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_calc_044(log as LogMessageInterface)
		  //
		  // Test clGroupAndPivot, direct calls
		  //
		  
		  log.start_exec(CurrentMethodName)
		  
		  var table0 As New clDataTable("mytable")
		  
		  call table0.AddColumns(Array("country","product"))
		  
		  call table0.AddColumn(new clNumberDataSerie("sales"))
		  call table0.AddColumn(new clNumberDataSerie("quantity"))
		  
		  
		  table0.AddRow(Array("France","P1",1100, 50))
		  table0.AddRow(Array("France","P2",1200, 60))
		  table0.AddRow(Array("Belgique","P1",1300, 70))
		  table0.AddRow(Array("USA","P3",1400, 80))
		  table0.AddRow(Array("Belgique","P3",1500, 90))
		  table0.AddRow(Array("USA","P2",1600, 100))
		  table0.AddRow(Array("France","P2",1700, 95))
		  
		  
		  
		  var g1() as clAbstractDataSerie = array(table0.GetColumn("country"))
		  var pv as clAbstractDataSerie = table0.GetColumn("product")
		  
		  var pr() as pair = array(table0.GetColumn("sales"): mdEnumerations.AggMode.Sum, table0.GetColumn("quantity"): mdEnumerations.AggMode.Sum)
		  
		  var mp() as Dictionary
		  mp.add(new Dictionary("P1":"P1_Sales", "P2":"P2_Sales", "":"Other_sales"))
		  mp.add(new Dictionary("P1":"P1_Qtty", "P2":"P2_Qtty", "":"Other_Qtty"))
		  
		  var cg1 as new clSeriesGroupAndPivot(g1, pr, pv, mp)
		  
		  
		  var table1 as new clDataTable("outptu", cg1.Flattened)
		  
		  var expected_t1 as new clDataTable("results", SerieArray( _
		  new clDataSerie("Country") _
		  ,new clNumberDataSerie("P1_Sales") _
		  ,new clNumberDataSerie("P2_Sales") _
		  ,new clNumberDataSerie("Other_Sales") _
		  ,new clNumberDataSerie("P1_Qtty") _
		  ,new clNumberDataSerie("P2_Qtty") _
		  ,new clNumberDataSerie("Other_Qtty") _
		  ))
		  
		  expected_t1.AddRow(array("France", 1100,2900,0,50,155,0))
		  expected_t1.AddRow(array("Belgique", 1300,0,1500,70,0,90))
		  expected_t1.AddRow(array("USA", 0,1600,1400,0,100,80))
		  
		  call check_table(log,"T1", expected_t1, table1)
		  
		  log.end_exec(CurrentMethodName)
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_calc_045(log as LogMessageInterface)
		  //
		  // Test the pivot transformer
		  //
		  
		  log.start_exec(CurrentMethodName)
		  
		  var table0 As New clDataTable("mytable")
		  
		  call table0.AddColumns(Array("country","product"))
		  
		  call table0.AddColumn(new clNumberDataSerie("sales"))
		  call table0.AddColumn(new clNumberDataSerie("quantity"))
		  
		  
		  table0.AddRow(Array("France","P1",1100, 50))
		  table0.AddRow(Array("France","P2",1200, 60))
		  table0.AddRow(Array("Belgique","P1",1300, 70))
		  table0.AddRow(Array("USA","P3",1400, 80))
		  table0.AddRow(Array("Belgique","P3",1500, 90))
		  table0.AddRow(Array("USA","P2",1600, 100))
		  table0.AddRow(Array("France","P2",1700, 95))
		  
		  
		  var pTransformer as new clPivotTransformer(table0, array("country"), "product", array("P1","P2",""), array("sales","quantity"))
		  
		  call pTransformer.Transform()
		  
		  var table1 as clDataTable  = pTransformer.GetOutputTable()
		  
		  var expected_t1 as new clDataTable("results", SerieArray( _
		  new clDataSerie("Country") _
		  ,new clNumberDataSerie("P1_Sales") _
		  ,new clNumberDataSerie("P2_Sales") _
		  ,new clNumberDataSerie("Other_Sales") _
		  ,new clNumberDataSerie("P1_quantity") _
		  ,new clNumberDataSerie("P2_quantity") _
		  ,new clNumberDataSerie("Other_quantity") _
		  ))
		  
		  expected_t1.AddRow(array("France", 1100,2900,0,50,155,0))
		  expected_t1.AddRow(array("Belgique", 1300,0,1500,70,0,90))
		  expected_t1.AddRow(array("USA", 0,1600,1400,0,100,80))
		  
		  call check_table(log,"T1", expected_t1, table1)
		  
		  log.end_exec(CurrentMethodName)
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_calc_046(log as LogMessageInterface)
		  //
		  // Test select columns (creating a view)  and extract columns (cloning the columns)
		  // Updating the data in the orignal table once selectColumns() and ExtractColumns are called will also update the values
		  // in the table created by selectColumns (since this is a view on original columns) but not in the table created by extractColumns.
		  //
		  //
		  
		  log.start_exec(CurrentMethodName)
		  
		  var rtst As clDataRow
		  
		  var table1 As New clDataTable("T1")
		  
		  rtst = New clDataRow
		  rtst.SetCell("aaa",1234)
		  rtst.SetCell("bbb","abcd")
		  rtst.SetCell("ccc",123.456)
		  
		  table1.AddRow(rtst)
		  
		  rtst = New clDataRow
		  rtst.SetCell("aaa",1235)
		  rtst.SetCell("bbb","abce")
		  rtst.SetCell("ddd",987.654)
		  
		  table1.AddRow(rtst)
		  
		  var table2 As clDataTable  = table1.SelectColumns("aaa","bbb","ddd")
		  
		  var table3 As clDataTable  = table1.ExtractColumns("aaa","bbb","ddd")
		  
		  var v() as variant =  VariantArray(123, 456)
		  call table1.SetColumnValues("ddd",v)
		  
		  call check_table(log, "table 1 integrity", nil, table1)
		  call check_table(log, "table 2 integrity", nil, table2)
		  call check_table(log, "table 2 integrity", nil, table3)
		  
		  var expected_table1  as new clDataTable("EXP1")
		  expected_table1.AddRow(New Dictionary("aaa":1234, "bbb":"abcd","ccc":123.456,"ddd":123))
		  expected_table1.AddRow(New Dictionary("aaa":1235, "bbb":"abce","ccc":nil,"ddd":456))
		  
		  //
		  // Table2 was. produced by SelectColumns() which retains the original column, so updating Table1 also updates 
		  // the values seen in Table2.
		  //
		  var expected_table2 as new clDataTable("EXP2")
		  expected_table2.AddRow(New Dictionary("aaa":1234, "bbb":"abcd","ddd":123))
		  expected_table2.AddRow(New Dictionary("aaa":1235, "bbb":"abce","ddd":456))
		  
		  //
		  // Table3 was. produced by ExtractColumns() which clones the column values
		  //
		  var expected_table3 as new clDataTable("EXP3")
		  expected_table3.AddRow(New Dictionary("aaa":1234, "bbb":"abcd","ddd":nil))
		  expected_table3.AddRow(New Dictionary("aaa":1235, "bbb":"abce","ddd":987.654))
		  
		  
		  call check_table(log, "T1", table1, expected_table1)
		  call check_table(log, "T1", table2, expected_table2)
		  call check_table(log, "T1", table3, expected_table3)
		  
		  
		  log.end_exec(CurrentMethodName)
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_calc_047(log as LogMessageInterface)
		  //
		  // Test full joins with join success column
		  
		  log.start_exec(CurrentMethodName)
		  
		  // First join table: with a match with some cities, only row per city
		  var tcountries1 as new clDataTable("Countries1")
		  call  tcountries1.AddColumn(new clStringDataSerie("Country"))
		  call  tcountries1.AddColumn(new clStringDataSerie("City"))
		  tcountries1.AddRow(new Dictionary("Country":"Belgium","City":"Brussels"))
		  tcountries1.AddRow(new Dictionary("Country":"Belgium","City":"Liege"))
		  tcountries1.AddRow(new Dictionary("Country":"France","City":"Paris"))
		  tcountries1.AddRow(new Dictionary("Country":"USA","City":"NewYork"))
		  tcountries1.AddRow(new Dictionary("City":"London"))
		  
		  call check_table(log, "tcountries table integrity", nil, tcountries1) 
		  
		  // Second join table; no matching cities
		  var tcountries2 as new clDataTable("Countries2")
		  call  tcountries2.AddColumn(new clStringDataSerie("Country"))
		  call  tcountries2.AddColumn(new clStringDataSerie("City"))
		  tcountries2.AddRow(new Dictionary("Country":"USA","City":"NewYork"))
		  tcountries2.AddRow(new Dictionary("Country":"France","City":"Lyon"))
		  tcountries2.AddRow(new Dictionary("Country":"Spain","City":"Madrid"))
		  
		  call check_table(log, "tcountries table integrity", nil, tcountries2) 
		  
		  
		  // Third join table, with mutlitple matching rows for some cities
		  var tcountries3 as new clDataTable("Countries3")
		  call  tcountries3.AddColumn(new clStringDataSerie("Country"))
		  call  tcountries3.AddColumn(new clStringDataSerie("City"))
		  call tcountries3.AddColumn(new clStringDataSerie("Something"))
		  
		  tcountries3.AddRow(new Dictionary("Country":"Belgium","City":"Brussels","Something":"Alpha"))
		  tcountries3.AddRow(new Dictionary("Country":"Belgium","City":"Liege","Something":"Beta"))
		  tcountries3.AddRow(new Dictionary("Country":"Belgium","City":"Liege","Something":"Gamma"))
		  tcountries3.AddRow(new Dictionary("Country":"France","City":"Paris","Something":"Delta"))
		  tcountries3.AddRow(new Dictionary("Country":"France","City":"Lille","Something":"Omega"))
		  tcountries3.AddRow(new Dictionary("Country":"USA","City":"NewYork","Something":"Zeta"))
		  tcountries3.AddRow(new Dictionary("City":"London"))
		  
		  call check_table(log, "tcountries table integrity", nil, tcountries3) 
		  
		  
		  
		  var tsales as new clDataTable("Sales")
		  
		  var ccity As clAbstractDataSerie =  tsales.AddColumn(new clStringDataSerie("City"))
		  var cqtt as clAbstractDataSerie =  tsales.AddColumn(new clNumberDataSerie("Quantity"))
		  var cup as clAbstractDataSerie = tsales.AddColumn(new clNumberDataSerie("UnitPrice"))
		  
		  tsales.AddRow(new Dictionary("City":"Brussels", "Quantity":12, "Unitprice": 21))
		  tsales.AddRow(new Dictionary("City":"Liege", "Quantity":12, "Unitprice": 22))
		  tsales.AddRow(new Dictionary("City":"Brussels", "Quantity":12, "Unitprice": 23))
		  tsales.AddRow(new Dictionary("City":"Brussels", "Quantity":12, "Unitprice": 24))
		  tsales.AddRow(new Dictionary("City":"Liege", "Quantity":12, "Unitprice": 25))
		  tsales.AddRow(new Dictionary("City":"Paris", "Quantity":12, "Unitprice": 26))
		  tsales.AddRow(new Dictionary("City":"Liege", "Quantity":12, "Unitprice": 27))
		  tsales.AddRow(new Dictionary("City":"Paris", "Quantity":12, "Unitprice": 28))
		  tsales.AddRow(new Dictionary("City":"Rome", "Quantity":10, "Unitprice": 25))
		  
		  call check_table(log, "tsales table integrity", nil, tsales) 
		  
		  var tjoin1 as clDataTable = tsales.FullJoin(tcountries1, JoinMode.InnerJoin, array("City"), "JoinStatus")
		  
		  var tjoin2 as clDataTable = tsales.FullJoin(tcountries1, JoinMode.OuterJoin, array("City"), "JoinStatus")
		  
		  var tjoin3 as clDataTable = tsales.FullJoin(tcountries2, JoinMode.InnerJoin, array("City"), "JoinStatus")
		  
		  var tjoin4 as clDataTable = tsales.FullJoin(tcountries2, JoinMode.OuterJoin, array("City"), "JoinStatus")
		  
		  var tjoin5 as clDataTable = tsales.FullJoin(tcountries3, JoinMode.InnerJoin, array("City"), "JoinStatus")
		  
		  var tjoin6 as clDataTable = tsales.FullJoin(tcountries3, JoinMode.OuterJoin, array("City"), "JoinStatus")
		  
		  var tjoin7 as clDataTable = tsales.LeftJoin(tcountries3, array("City"), "JoinStatus")
		  
		  
		  var tjoin1_expected as new clDataTable("X1")
		  call tjoin1_expected.AddColumn(new clStringDataSerie("City"))
		  call tjoin1_expected.AddColumn(new clNumberDataSerie("Quantity"))
		  call tjoin1_expected.AddColumn(new clNumberDataSerie("UnitPrice"))
		  call tjoin1_expected.AddColumn(new clStringDataSerie("JoinStatus"))
		  call tjoin1_expected.AddColumn(new clStringDataSerie("Country"))
		  
		  
		  tjoin1_expected.AddRow(new Dictionary("City":"Brussels", "Quantity":12, "Unitprice": 21,"Country":"Belgium","JoinStatus":clDataTable.JoinSuccessBoth))
		  tjoin1_expected.AddRow(new Dictionary("City":"Liege", "Quantity":12, "Unitprice": 22,"Country":"Belgium","JoinStatus":clDataTable.JoinSuccessBoth))
		  tjoin1_expected.AddRow(new Dictionary("City":"Brussels", "Quantity":12, "Unitprice": 23,"Country":"Belgium","JoinStatus":clDataTable.JoinSuccessBoth))
		  tjoin1_expected.AddRow(new Dictionary("City":"Brussels", "Quantity":12, "Unitprice": 24,"Country":"Belgium","JoinStatus":clDataTable.JoinSuccessBoth))
		  tjoin1_expected.AddRow(new Dictionary("City":"Liege", "Quantity":12, "Unitprice": 25,"Country":"Belgium","JoinStatus":clDataTable.JoinSuccessBoth))
		  tjoin1_expected.AddRow(new Dictionary("City":"Paris", "Quantity":12, "Unitprice": 26,"Country":"France","JoinStatus":clDataTable.JoinSuccessBoth))
		  tjoin1_expected.AddRow(new Dictionary("City":"Liege", "Quantity":12, "Unitprice": 27,"Country":"Belgium","JoinStatus":clDataTable.JoinSuccessBoth))
		  tjoin1_expected.AddRow(new Dictionary("City":"Paris", "Quantity":12, "Unitprice": 28,"Country":"France","JoinStatus":clDataTable.JoinSuccessBoth))
		  
		  
		  //
		  var tjoin2_expected as new clDataTable("X2")
		  call tjoin2_expected.AddColumn(new clStringDataSerie("City"))
		  call tjoin2_expected.AddColumn(new clNumberDataSerie("Quantity"))
		  call tjoin2_expected.AddColumn(new clNumberDataSerie("UnitPrice"))
		  call tjoin2_expected.AddColumn(new clStringDataSerie("JoinStatus"))
		  call tjoin2_expected.AddColumn(new clStringDataSerie("Country"))
		  
		  tjoin2_expected.AddRow(new Dictionary("City":"Brussels", "Quantity":12, "Unitprice": 21,"Country":"Belgium","JoinStatus":clDataTable.JoinSuccessBoth))
		  tjoin2_expected.AddRow(new Dictionary("City":"Liege", "Quantity":12, "Unitprice": 22,"Country":"Belgium","JoinStatus":clDataTable.JoinSuccessBoth))
		  tjoin2_expected.AddRow(new Dictionary("City":"Brussels", "Quantity":12, "Unitprice": 23,"Country":"Belgium","JoinStatus":clDataTable.JoinSuccessBoth))
		  tjoin2_expected.AddRow(new Dictionary("City":"Brussels", "Quantity":12, "Unitprice": 24,"Country":"Belgium","JoinStatus":clDataTable.JoinSuccessBoth))
		  tjoin2_expected.AddRow(new Dictionary("City":"Liege", "Quantity":12, "Unitprice": 25,"Country":"Belgium","JoinStatus":clDataTable.JoinSuccessBoth))
		  tjoin2_expected.AddRow(new Dictionary("City":"Paris", "Quantity":12, "Unitprice": 26,"Country":"France","JoinStatus":clDataTable.JoinSuccessBoth))
		  tjoin2_expected.AddRow(new Dictionary("City":"Liege", "Quantity":12, "Unitprice": 27,"Country":"Belgium","JoinStatus":clDataTable.JoinSuccessBoth))
		  tjoin2_expected.AddRow(new Dictionary("City":"Paris", "Quantity":12, "Unitprice": 28,"Country":"France","JoinStatus":clDataTable.JoinSuccessBoth))
		  tjoin2_expected.AddRow(new Dictionary("City":"Rome", "Quantity":10, "Unitprice": 25,"JoinStatus":clDataTable.JoinSuccessMainOnly))
		  tjoin2_expected.AddRow(new Dictionary("Country":"USA","City":"NewYork","JoinStatus":clDataTable.JoinSuccessJoinedOnly))
		  tjoin2_expected.AddRow(new Dictionary("City":"London","JoinStatus":clDataTable.JoinSuccessJoinedOnly))
		  
		  
		  
		  var tjoin3_expected as new clDataTable("X3")
		  call tjoin3_expected.AddColumn(new clStringDataSerie("City"))
		  call tjoin3_expected.AddColumn(new clNumberDataSerie("Quantity"))
		  call tjoin3_expected.AddColumn(new clNumberDataSerie("UnitPrice"))
		  call tjoin3_expected.AddColumn(new clStringDataSerie("JoinStatus"))
		  call tjoin3_expected.AddColumn(new clStringDataSerie("Country"))
		  
		  var tjoin4_expected as new clDataTable("X4")
		  call tjoin4_expected.AddColumn(new clStringDataSerie("City"))
		  call tjoin4_expected.AddColumn(new clNumberDataSerie("Quantity"))
		  call tjoin4_expected.AddColumn(new clNumberDataSerie("UnitPrice"))
		  call tjoin4_expected.AddColumn(new clStringDataSerie("JoinStatus"))
		  call tjoin4_expected.AddColumn(new clStringDataSerie("Country"))
		  
		  tjoin4_expected.AddRow(new Dictionary("City":"Brussels", "Quantity":12, "Unitprice": 21,"JoinStatus":clDataTable.JoinSuccessMainOnly))
		  tjoin4_expected.AddRow(new Dictionary("City":"Liege", "Quantity":12, "Unitprice": 22,"JoinStatus":clDataTable.JoinSuccessMainOnly))
		  tjoin4_expected.AddRow(new Dictionary("City":"Brussels", "Quantity":12, "Unitprice": 23,"JoinStatus":clDataTable.JoinSuccessMainOnly))
		  tjoin4_expected.AddRow(new Dictionary("City":"Brussels", "Quantity":12, "Unitprice": 24,"JoinStatus":clDataTable.JoinSuccessMainOnly))
		  tjoin4_expected.AddRow(new Dictionary("City":"Liege", "Quantity":12, "Unitprice": 25,"JoinStatus":clDataTable.JoinSuccessMainOnly))
		  tjoin4_expected.AddRow(new Dictionary("City":"Paris", "Quantity":12, "Unitprice": 26,"JoinStatus":clDataTable.JoinSuccessMainOnly))
		  tjoin4_expected.AddRow(new Dictionary("City":"Liege", "Quantity":12, "Unitprice": 27,"JoinStatus":clDataTable.JoinSuccessMainOnly))
		  tjoin4_expected.AddRow(new Dictionary("City":"Paris", "Quantity":12, "Unitprice": 28,"JoinStatus":clDataTable.JoinSuccessMainOnly))
		  tjoin4_expected.AddRow(new Dictionary("City":"Rome", "Quantity":10, "Unitprice": 25,"JoinStatus":clDataTable.JoinSuccessMainOnly))
		  tjoin4_expected.AddRow(new Dictionary("Country":"USA","City":"NewYork","JoinStatus":clDataTable.JoinSuccessJoinedOnly))
		  tjoin4_expected.AddRow(new Dictionary("Country":"France","City":"Lyon","JoinStatus":clDataTable.JoinSuccessJoinedOnly))
		  tjoin4_expected.AddRow(new Dictionary("Country":"Spain","City":"Madrid","JoinStatus":clDataTable.JoinSuccessJoinedOnly))
		  
		  
		  
		  
		  var tjoin5_expected as new clDataTable("X5")
		  call tjoin5_expected.AddColumn(new clStringDataSerie("City"))
		  call tjoin5_expected.AddColumn(new clNumberDataSerie("Quantity"))
		  call tjoin5_expected.AddColumn(new clNumberDataSerie("UnitPrice"))
		  call tjoin5_expected.AddColumn(new clStringDataSerie("JoinStatus"))
		  call tjoin5_expected.AddColumn(new clNumberDataSerie("Country"))
		  call tjoin5_expected.AddColumn(new clStringDataSerie("Something"))
		  
		  tjoin5_expected.AddRow(new Dictionary("City":"Brussels", "Quantity":12, "Unitprice": 21,"Country":"Belgium","Something":"Alpha","JoinStatus":clDataTable.JoinSuccessBoth))
		  tjoin5_expected.AddRow(new Dictionary("City":"Liege", "Quantity":12, "Unitprice": 22,"Country":"Belgium","Something":"Beta","JoinStatus":clDataTable.JoinSuccessBoth))
		  tjoin5_expected.AddRow(new Dictionary("City":"Liege", "Quantity":12, "Unitprice": 22,"Country":"Belgium","Something":"Gamma","JoinStatus":clDataTable.JoinSuccessBoth))
		  tjoin5_expected.AddRow(new Dictionary("City":"Brussels", "Quantity":12, "Unitprice": 23,"Country":"Belgium","Something":"Alpha","JoinStatus":clDataTable.JoinSuccessBoth))
		  tjoin5_expected.AddRow(new Dictionary("City":"Brussels", "Quantity":12, "Unitprice": 24,"Country":"Belgium","Something":"Alpha","JoinStatus":clDataTable.JoinSuccessBoth))
		  tjoin5_expected.AddRow(new Dictionary("City":"Liege", "Quantity":12, "Unitprice": 25,"Country":"Belgium","Something":"Beta","JoinStatus":clDataTable.JoinSuccessBoth))
		  tjoin5_expected.AddRow(new Dictionary("City":"Liege", "Quantity":12, "Unitprice": 25,"Country":"Belgium","Something":"Gamma","JoinStatus":clDataTable.JoinSuccessBoth))
		  tjoin5_expected.AddRow(new Dictionary("City":"Paris", "Quantity":12, "Unitprice": 26,"Country":"France","Something":"Delta","JoinStatus":clDataTable.JoinSuccessBoth))
		  tjoin5_expected.AddRow(new Dictionary("City":"Liege", "Quantity":12, "Unitprice": 27,"Country":"Belgium","Something":"Beta","JoinStatus":clDataTable.JoinSuccessBoth))
		  tjoin5_expected.AddRow(new Dictionary("City":"Liege", "Quantity":12, "Unitprice": 27,"Country":"Belgium","Something":"Gamma","JoinStatus":clDataTable.JoinSuccessBoth))
		  tjoin5_expected.AddRow(new Dictionary("City":"Paris", "Quantity":12, "Unitprice": 28,"Country":"France","Something":"Delta","JoinStatus":clDataTable.JoinSuccessBoth))
		  
		  
		  
		  var tjoin6_expected as new clDataTable("X6")
		  call tjoin6_expected.AddColumn(new clStringDataSerie("City"))
		  call tjoin6_expected.AddColumn(new clNumberDataSerie("Quantity"))
		  call tjoin6_expected.AddColumn(new clNumberDataSerie("UnitPrice"))
		  call tjoin6_expected.AddColumn(new clStringDataSerie("JoinStatus"))
		  call tjoin6_expected.AddColumn(new clNumberDataSerie("Country"))
		  call tjoin6_expected.AddColumn(new clStringDataSerie("Something"))
		  
		  tjoin6_expected.AddRow(new Dictionary("City":"Brussels", "Quantity":12, "Unitprice": 21,"Country":"Belgium","Something":"Alpha","JoinStatus":clDataTable.JoinSuccessBoth))
		  tjoin6_expected.AddRow(new Dictionary("City":"Liege", "Quantity":12, "Unitprice": 22,"Country":"Belgium","Something":"Beta","JoinStatus":clDataTable.JoinSuccessBoth))
		  tjoin6_expected.AddRow(new Dictionary("City":"Liege", "Quantity":12, "Unitprice": 22,"Country":"Belgium","Something":"Gamma","JoinStatus":clDataTable.JoinSuccessBoth))
		  tjoin6_expected.AddRow(new Dictionary("City":"Brussels", "Quantity":12, "Unitprice": 23,"Country":"Belgium","Something":"Alpha","JoinStatus":clDataTable.JoinSuccessBoth))
		  tjoin6_expected.AddRow(new Dictionary("City":"Brussels", "Quantity":12, "Unitprice": 24,"Country":"Belgium","Something":"Alpha","JoinStatus":clDataTable.JoinSuccessBoth))
		  tjoin6_expected.AddRow(new Dictionary("City":"Liege", "Quantity":12, "Unitprice": 25,"Country":"Belgium","Something":"Beta","JoinStatus":clDataTable.JoinSuccessBoth))
		  tjoin6_expected.AddRow(new Dictionary("City":"Liege", "Quantity":12, "Unitprice": 25,"Country":"Belgium","Something":"Gamma","JoinStatus":clDataTable.JoinSuccessBoth))
		  tjoin6_expected.AddRow(new Dictionary("City":"Paris", "Quantity":12, "Unitprice": 26,"Country":"France","Something":"Delta","JoinStatus":clDataTable.JoinSuccessBoth))
		  tjoin6_expected.AddRow(new Dictionary("City":"Liege", "Quantity":12, "Unitprice": 27,"Country":"Belgium","Something":"Beta","JoinStatus":clDataTable.JoinSuccessBoth))
		  tjoin6_expected.AddRow(new Dictionary("City":"Liege", "Quantity":12, "Unitprice": 27,"Country":"Belgium","Something":"Gamma","JoinStatus":clDataTable.JoinSuccessBoth))
		  tjoin6_expected.AddRow(new Dictionary("City":"Paris", "Quantity":12, "Unitprice": 28,"Country":"France","Something":"Delta","JoinStatus":clDataTable.JoinSuccessBoth))
		  tjoin6_expected.AddRow(new Dictionary("City":"Rome", "Quantity":10, "Unitprice": 25,"JoinStatus":clDataTable.JoinSuccessMainOnly))
		  tjoin6_expected.AddRow(new Dictionary("City":"Lille", "Quantity":0, "Unitprice": 0,"Country":"Belgium","Something":"Omega","JoinStatus":clDataTable.JoinSuccessJoinedOnly))
		  tjoin6_expected.AddRow(new Dictionary("City":"NewYork", "Quantity":0, "Unitprice": 0,"Country":"USA","Something":"Zeta","JoinStatus":clDataTable.JoinSuccessJoinedOnly))
		  tjoin6_expected.AddRow(new Dictionary("City":"London", "Quantity":0, "UnitPrice":0,"JoinStatus":clDataTable.JoinSuccessJoinedOnly))
		  
		  
		  var tjoin7_expected as new clDataTable("X7")
		  call tjoin7_expected.AddColumn(new clStringDataSerie("City"))
		  call tjoin7_expected.AddColumn(new clNumberDataSerie("Quantity"))
		  call tjoin7_expected.AddColumn(new clNumberDataSerie("UnitPrice"))
		  call tjoin7_expected.AddColumn(new clStringDataSerie("JoinStatus"))
		  call tjoin7_expected.AddColumn(new clNumberDataSerie("Country"))
		  call tjoin7_expected.AddColumn(new clStringDataSerie("Something"))
		  
		  tjoin7_expected.AddRow(new Dictionary("City":"Brussels", "Quantity":12, "Unitprice": 21,"Country":"Belgium","Something":"Alpha","JoinStatus":clDataTable.JoinSuccessBoth))
		  tjoin7_expected.AddRow(new Dictionary("City":"Liege", "Quantity":12, "Unitprice": 22,"Country":"Belgium","Something":"Beta","JoinStatus":clDataTable.JoinSuccessBoth))
		  tjoin7_expected.AddRow(new Dictionary("City":"Liege", "Quantity":12, "Unitprice": 22,"Country":"Belgium","Something":"Gamma","JoinStatus":clDataTable.JoinSuccessBoth))
		  tjoin7_expected.AddRow(new Dictionary("City":"Brussels", "Quantity":12, "Unitprice": 23,"Country":"Belgium","Something":"Alpha","JoinStatus":clDataTable.JoinSuccessBoth))
		  tjoin7_expected.AddRow(new Dictionary("City":"Brussels", "Quantity":12, "Unitprice": 24,"Country":"Belgium","Something":"Alpha","JoinStatus":clDataTable.JoinSuccessBoth))
		  tjoin7_expected.AddRow(new Dictionary("City":"Liege", "Quantity":12, "Unitprice": 25,"Country":"Belgium","Something":"Beta","JoinStatus":clDataTable.JoinSuccessBoth))
		  tjoin7_expected.AddRow(new Dictionary("City":"Liege", "Quantity":12, "Unitprice": 25,"Country":"Belgium","Something":"Gamma","JoinStatus":clDataTable.JoinSuccessBoth))
		  tjoin7_expected.AddRow(new Dictionary("City":"Paris", "Quantity":12, "Unitprice": 26,"Country":"France","Something":"Delta","JoinStatus":clDataTable.JoinSuccessBoth))
		  tjoin7_expected.AddRow(new Dictionary("City":"Liege", "Quantity":12, "Unitprice": 27,"Country":"Belgium","Something":"Beta","JoinStatus":clDataTable.JoinSuccessBoth))
		  tjoin7_expected.AddRow(new Dictionary("City":"Liege", "Quantity":12, "Unitprice": 27,"Country":"Belgium","Something":"Gamma","JoinStatus":clDataTable.JoinSuccessBoth))
		  tjoin7_expected.AddRow(new Dictionary("City":"Paris", "Quantity":12, "Unitprice": 28,"Country":"France","Something":"Delta","JoinStatus":clDataTable.JoinSuccessBoth))
		  tjoin7_expected.AddRow(new Dictionary("City":"Rome", "Quantity":10, "Unitprice": 25,"JoinStatus":clDataTable.JoinSuccessMainOnly))
		  
		  
		  call check_table(log, "Join1", tjoin1_expected, tjoin1)
		  
		  call check_table(log, "Join2", tjoin2_expected, tjoin2)
		  
		  call check_table(log, "Join3", tjoin3_expected, tjoin3)
		  
		  call check_table(log, "Join4", tjoin4_expected, tjoin4)
		  
		  call check_table(log, "Join5", tjoin5_expected, tjoin5)
		  
		  call check_table(log, "Join6", tjoin6_expected, tjoin6)
		  
		  call check_table(log, "Join7", tjoin7_expected, tjoin7)
		  
		  log.end_exec(CurrentMethodName)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_calc_048(log as LogMessageInterface)
		  //
		  // Test generation of unique names
		  
		  log.start_exec(CurrentMethodName)
		  
		  // First join table: with a match with some cities, only row per city
		  var myTable as new clDataTable("Countries")
		  call  myTable.AddColumn(new clStringDataSerie("Country"))
		  call  myTable.AddColumn(new clStringDataSerie("City"))
		  myTable.AddRow(new Dictionary("Country":"Belgium","City":"Brussels"))
		  
		  call check_table(log, "myTable table integrity", nil, myTable) 
		  
		  var col1 as string = myTable.GetUniqueColumnName("Country")
		  var col2 as string = myTable.GetUniqueColumnName("City", "-","")
		  
		  call myTable.AddColumn(col1)
		  call myTable.AddColumn(col2)
		  
		  var col3 as string = myTable.GetUniqueColumnName("Country")
		  var col4 as string = myTable.GetUniqueColumnName("City", " (",")")
		  
		  call myTable.AddColumn(col3)
		  call myTable.AddColumn(col4)
		  
		  var myExpectedTable as new clDataTable("Expected")
		  call  myExpectedTable.AddColumn(new clStringDataSerie("Country"))
		  call  myExpectedTable.AddColumn(new clStringDataSerie("City"))
		  myExpectedTable.AddRow(new Dictionary("Country":"Belgium","City":"Brussels"))
		  
		  call  myExpectedTable.AddColumn("Country 0")
		  call  myExpectedTable.AddColumn("City-0")
		  call  myExpectedTable.AddColumn("Country 1")
		  call  myExpectedTable.AddColumn("City (0)")
		  
		  
		  call check_table(log, "Unique column names", myExpectedTable, myTable)
		  
		  log.end_exec(CurrentMethodName)
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_calc_049(log as LogMessageInterface)
		  //
		  // Test full joins
		  
		  log.start_exec(CurrentMethodName)
		  
		  
		  // Main data table
		  var tsales as new clDataTable("Sales")
		  
		  var ccity As clAbstractDataSerie =  tsales.AddColumn(new clStringDataSerie("City"))
		  var cqtt as clAbstractDataSerie =  tsales.AddColumn(new clNumberDataSerie("Quantity"))
		  var cup as clAbstractDataSerie = tsales.AddColumn(new clNumberDataSerie("UnitPrice"))
		  
		  tsales.AddRow(new Dictionary("City":"Brussels", "Quantity":12, "Unitprice": 21))
		  tsales.AddRow(new Dictionary("City":"Liege", "Quantity":12, "Unitprice": 22))
		  tsales.AddRow(new Dictionary("City":"Brussels", "Quantity":12, "Unitprice": 23))
		  tsales.AddRow(new Dictionary("City":"Brussels", "Quantity":12, "Unitprice": 24))
		  tsales.AddRow(new Dictionary("City":"Liege", "Quantity":12, "Unitprice": 25))
		  tsales.AddRow(new Dictionary("City":"Paris", "Quantity":12, "Unitprice": 26))
		  tsales.AddRow(new Dictionary("City":"Liege", "Quantity":12, "Unitprice": 27))
		  tsales.AddRow(new Dictionary("City":"Paris", "Quantity":12, "Unitprice": 28))
		  tsales.AddRow(new Dictionary("City":"Rome", "Quantity":10, "Unitprice": 25))
		  
		  call check_table(log, "tsales table integrity", nil, tsales) 
		  
		  
		  var tcountries1 as new clDataTable("Countries1")
		  call  tcountries1.AddColumn(new clStringDataSerie("Country"))
		  call  tcountries1.AddColumn(new clStringDataSerie("City"))
		  tcountries1.AddRow(new Dictionary("Country":"Belgium","City":"Brussels"))
		  tcountries1.AddRow(new Dictionary("Country":"Belgium","City":"Liege"))
		  tcountries1.AddRow(new Dictionary("Country":"France","City":"Paris"))
		  tcountries1.AddRow(new Dictionary("Country":"USA","City":"NewYork"))
		  tcountries1.AddRow(new Dictionary("City":"London"))
		  
		  call check_table(log, "tcountries table integrity", nil, tcountries1) 
		  
		  var tcountries2 as new clDataTable("Countries2")
		  call  tcountries2.AddColumn(new clStringDataSerie("Country"))
		  call  tcountries2.AddColumn(new clStringDataSerie("City"))
		  tcountries2.AddRow(new Dictionary("Country":"USA","City":"NewYork"))
		  tcountries2.AddRow(new Dictionary("Country":"France","City":"Lyon"))
		  tcountries2.AddRow(new Dictionary("Country":"Spain","City":"Madrid"))
		  
		  call check_table(log, "tcountries table integrity", nil, tcountries2) 
		  
		  
		  var tcountries3 as new clDataTable("Countries3")
		  call  tcountries3.AddColumn(new clStringDataSerie("Country"))
		  call  tcountries3.AddColumn(new clStringDataSerie("City"))
		  call tcountries3.AddColumn(new clStringDataSerie("Something"))
		  
		  tcountries3.AddRow(new Dictionary("Country":"Belgium","City":"Brussels","Something":"Alpha"))
		  tcountries3.AddRow(new Dictionary("Country":"Belgium","City":"Liege","Something":"Beta"))
		  tcountries3.AddRow(new Dictionary("Country":"Belgium","City":"Liege","Something":"Gamma"))
		  tcountries3.AddRow(new Dictionary("Country":"France","City":"Paris","Something":"Delta"))
		  tcountries3.AddRow(new Dictionary("Country":"France","City":"Lille","Something":"Omega"))
		  tcountries3.AddRow(new Dictionary("Country":"USA","City":"NewYork","Something":"Zeta"))
		  tcountries3.AddRow(new Dictionary("City":"London"))
		  
		  call check_table(log, "tcountries table integrity", nil, tcountries3) 
		  
		  
		  var tjoin1 as clDataTable = tsales.InnerJoin(tcountries1, array("City"))
		  
		  var tjoin2 as clDataTable = tsales.OuterJoin(tcountries1,  array("City"))
		  
		  var tjoin3 as clDataTable = tsales.InnerJoin(tcountries2, array("City"))
		  
		  var tjoin4 as clDataTable = tsales.OuterJoin(tcountries2, array("City"))
		  
		  var tjoin5 as clDataTable = tsales.InnerJoin(tcountries3, array("City"))
		  
		  var tjoin6 as clDataTable = tsales.OuterJoin(tcountries3, array("City"))
		  
		  
		  var tjoin1_expected as new clDataTable("X1")
		  call tjoin1_expected.AddColumn(new clStringDataSerie("City"))
		  call tjoin1_expected.AddColumn(new clNumberDataSerie("Quantity"))
		  call tjoin1_expected.AddColumn(new clNumberDataSerie("UnitPrice"))
		  call tjoin1_expected.AddColumn(new clStringDataSerie("Country"))
		  
		  tjoin1_expected.AddRow(new Dictionary("City":"Brussels", "Quantity":12, "Unitprice": 21,"Country":"Belgium"))
		  tjoin1_expected.AddRow(new Dictionary("City":"Liege", "Quantity":12, "Unitprice": 22,"Country":"Belgium"))
		  tjoin1_expected.AddRow(new Dictionary("City":"Brussels", "Quantity":12, "Unitprice": 23,"Country":"Belgium"))
		  tjoin1_expected.AddRow(new Dictionary("City":"Brussels", "Quantity":12, "Unitprice": 24,"Country":"Belgium"))
		  tjoin1_expected.AddRow(new Dictionary("City":"Liege", "Quantity":12, "Unitprice": 25,"Country":"Belgium"))
		  tjoin1_expected.AddRow(new Dictionary("City":"Paris", "Quantity":12, "Unitprice": 26,"Country":"France"))
		  tjoin1_expected.AddRow(new Dictionary("City":"Liege", "Quantity":12, "Unitprice": 27,"Country":"Belgium"))
		  tjoin1_expected.AddRow(new Dictionary("City":"Paris", "Quantity":12, "Unitprice": 28,"Country":"France"))
		  
		  var tjoin2_expected as new clDataTable("X2")
		  call tjoin2_expected.AddColumn(new clStringDataSerie("City"))
		  call tjoin2_expected.AddColumn(new clNumberDataSerie("Quantity"))
		  call tjoin2_expected.AddColumn(new clNumberDataSerie("UnitPrice"))
		  call tjoin2_expected.AddColumn(new clStringDataSerie("Country"))
		  
		  tjoin2_expected.AddRow(new Dictionary("City":"Brussels", "Quantity":12, "Unitprice": 21,"Country":"Belgium"))
		  tjoin2_expected.AddRow(new Dictionary("City":"Liege", "Quantity":12, "Unitprice": 22,"Country":"Belgium"))
		  tjoin2_expected.AddRow(new Dictionary("City":"Brussels", "Quantity":12, "Unitprice": 23,"Country":"Belgium"))
		  tjoin2_expected.AddRow(new Dictionary("City":"Brussels", "Quantity":12, "Unitprice": 24,"Country":"Belgium"))
		  tjoin2_expected.AddRow(new Dictionary("City":"Liege", "Quantity":12, "Unitprice": 25,"Country":"Belgium"))
		  tjoin2_expected.AddRow(new Dictionary("City":"Paris", "Quantity":12, "Unitprice": 26,"Country":"France"))
		  tjoin2_expected.AddRow(new Dictionary("City":"Liege", "Quantity":12, "Unitprice": 27,"Country":"Belgium"))
		  tjoin2_expected.AddRow(new Dictionary("City":"Paris", "Quantity":12, "Unitprice": 28,"Country":"France"))
		  tjoin2_expected.AddRow(new Dictionary("City":"Rome", "Quantity":10, "Unitprice": 25))
		  tjoin2_expected.AddRow(new Dictionary("Country":"USA","City":"NewYork"))
		  tjoin2_expected.AddRow(new Dictionary("City":"London"))
		  
		  
		  
		  var tjoin3_expected as new clDataTable("X3")
		  call tjoin3_expected.AddColumn(new clStringDataSerie("City"))
		  call tjoin3_expected.AddColumn(new clNumberDataSerie("Quantity"))
		  call tjoin3_expected.AddColumn(new clNumberDataSerie("UnitPrice"))
		  call tjoin3_expected.AddColumn(new clStringDataSerie("Country"))
		  
		  var tjoin4_expected as new clDataTable("X4")
		  call tjoin4_expected.AddColumn(new clStringDataSerie("City"))
		  call tjoin4_expected.AddColumn(new clNumberDataSerie("Quantity"))
		  call tjoin4_expected.AddColumn(new clNumberDataSerie("UnitPrice"))
		  call tjoin4_expected.AddColumn(new clStringDataSerie("Country"))
		  
		  tjoin4_expected.AddRow(new Dictionary("City":"Brussels", "Quantity":12, "Unitprice": 21))
		  tjoin4_expected.AddRow(new Dictionary("City":"Liege", "Quantity":12, "Unitprice": 22))
		  tjoin4_expected.AddRow(new Dictionary("City":"Brussels", "Quantity":12, "Unitprice": 23))
		  tjoin4_expected.AddRow(new Dictionary("City":"Brussels", "Quantity":12, "Unitprice": 24))
		  tjoin4_expected.AddRow(new Dictionary("City":"Liege", "Quantity":12, "Unitprice": 25))
		  tjoin4_expected.AddRow(new Dictionary("City":"Paris", "Quantity":12, "Unitprice": 26))
		  tjoin4_expected.AddRow(new Dictionary("City":"Liege", "Quantity":12, "Unitprice": 27))
		  tjoin4_expected.AddRow(new Dictionary("City":"Paris", "Quantity":12, "Unitprice": 28))
		  tjoin4_expected.AddRow(new Dictionary("City":"Rome", "Quantity":10, "Unitprice": 25))
		  tjoin4_expected.AddRow(new Dictionary("Country":"USA","City":"NewYork"))
		  tjoin4_expected.AddRow(new Dictionary("Country":"France","City":"Lyon"))
		  tjoin4_expected.AddRow(new Dictionary("Country":"Spain","City":"Madrid"))
		  
		  
		  
		  
		  var tjoin5_expected as new clDataTable("X5")
		  call tjoin5_expected.AddColumn(new clStringDataSerie("City"))
		  call tjoin5_expected.AddColumn(new clNumberDataSerie("Quantity"))
		  call tjoin5_expected.AddColumn(new clNumberDataSerie("UnitPrice"))
		  call tjoin5_expected.AddColumn(new clNumberDataSerie("Country"))
		  call tjoin5_expected.AddColumn(new clStringDataSerie("Something"))
		  
		  tjoin5_expected.AddRow(new Dictionary("City":"Brussels", "Quantity":12, "Unitprice": 21,"Country":"Belgium","Something":"Alpha"))
		  tjoin5_expected.AddRow(new Dictionary("City":"Liege", "Quantity":12, "Unitprice": 22,"Country":"Belgium","Something":"Beta"))
		  tjoin5_expected.AddRow(new Dictionary("City":"Liege", "Quantity":12, "Unitprice": 22,"Country":"Belgium","Something":"Gamma"))
		  tjoin5_expected.AddRow(new Dictionary("City":"Brussels", "Quantity":12, "Unitprice": 23,"Country":"Belgium","Something":"Alpha"))
		  tjoin5_expected.AddRow(new Dictionary("City":"Brussels", "Quantity":12, "Unitprice": 24,"Country":"Belgium","Something":"Alpha"))
		  tjoin5_expected.AddRow(new Dictionary("City":"Liege", "Quantity":12, "Unitprice": 25,"Country":"Belgium","Something":"Beta"))
		  tjoin5_expected.AddRow(new Dictionary("City":"Liege", "Quantity":12, "Unitprice": 25,"Country":"Belgium","Something":"Gamma"))
		  tjoin5_expected.AddRow(new Dictionary("City":"Paris", "Quantity":12, "Unitprice": 26,"Country":"France","Something":"Delta"))
		  tjoin5_expected.AddRow(new Dictionary("City":"Liege", "Quantity":12, "Unitprice": 27,"Country":"Belgium","Something":"Beta"))
		  tjoin5_expected.AddRow(new Dictionary("City":"Liege", "Quantity":12, "Unitprice": 27,"Country":"Belgium","Something":"Gamma"))
		  tjoin5_expected.AddRow(new Dictionary("City":"Paris", "Quantity":12, "Unitprice": 28,"Country":"France","Something":"Delta"))
		  
		  
		  
		  var tjoin6_expected as new clDataTable("X6")
		  call tjoin6_expected.AddColumn(new clStringDataSerie("City"))
		  call tjoin6_expected.AddColumn(new clNumberDataSerie("Quantity"))
		  call tjoin6_expected.AddColumn(new clNumberDataSerie("UnitPrice"))
		  call tjoin6_expected.AddColumn(new clNumberDataSerie("Country"))
		  call tjoin6_expected.AddColumn(new clStringDataSerie("Something"))
		  
		  tjoin6_expected.AddRow(new Dictionary("City":"Brussels", "Quantity":12, "Unitprice": 21,"Country":"Belgium","Something":"Alpha"))
		  tjoin6_expected.AddRow(new Dictionary("City":"Liege", "Quantity":12, "Unitprice": 22,"Country":"Belgium","Something":"Beta"))
		  tjoin6_expected.AddRow(new Dictionary("City":"Liege", "Quantity":12, "Unitprice": 22,"Country":"Belgium","Something":"Gamma"))
		  tjoin6_expected.AddRow(new Dictionary("City":"Brussels", "Quantity":12, "Unitprice": 23,"Country":"Belgium","Something":"Alpha"))
		  tjoin6_expected.AddRow(new Dictionary("City":"Brussels", "Quantity":12, "Unitprice": 24,"Country":"Belgium","Something":"Alpha"))
		  tjoin6_expected.AddRow(new Dictionary("City":"Liege", "Quantity":12, "Unitprice": 25,"Country":"Belgium","Something":"Beta"))
		  tjoin6_expected.AddRow(new Dictionary("City":"Liege", "Quantity":12, "Unitprice": 25,"Country":"Belgium","Something":"Gamma"))
		  tjoin6_expected.AddRow(new Dictionary("City":"Paris", "Quantity":12, "Unitprice": 26,"Country":"France","Something":"Delta"))
		  tjoin6_expected.AddRow(new Dictionary("City":"Liege", "Quantity":12, "Unitprice": 27,"Country":"Belgium","Something":"Beta"))
		  tjoin6_expected.AddRow(new Dictionary("City":"Liege", "Quantity":12, "Unitprice": 27,"Country":"Belgium","Something":"Gamma"))
		  tjoin6_expected.AddRow(new Dictionary("City":"Paris", "Quantity":12, "Unitprice": 28,"Country":"France","Something":"Delta"))
		  tjoin6_expected.AddRow(new Dictionary("City":"Rome", "Quantity":10, "Unitprice": 25))
		  tjoin6_expected.AddRow(new Dictionary("City":"Lille", "Quantity":0, "Unitprice": 0,"Country":"Belgium","Something":"Omega"))
		  tjoin6_expected.AddRow(new Dictionary("City":"NewYork", "Quantity":0, "Unitprice": 0,"Country":"USA","Something":"Zeta"))
		  tjoin6_expected.AddRow(new Dictionary("City":"London", "Quantity":0, "UnitPrice":0))
		  
		  
		  
		  call check_table(log, "Join1", tjoin1_expected, tjoin1)
		  
		  call check_table(log, "Join2", tjoin2_expected, tjoin2)
		  
		  call check_table(log, "Join3", tjoin3_expected, tjoin3)
		  
		  call check_table(log, "Join4", tjoin4_expected, tjoin4)
		  
		  call check_table(log, "Join5", tjoin5_expected, tjoin5)
		  
		  call check_table(log, "Join6", tjoin6_expected, tjoin6)
		  
		  
		  log.end_exec(CurrentMethodName)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_calc_050(log as LogMessageInterface)
		  //
		  // Test full joins with join success column
		  
		  log.start_exec(CurrentMethodName)
		  
		  
		  // Create main table, to be joined
		  var tsales as new clDataTable("Sales")
		  
		  var ccity As clAbstractDataSerie =  tsales.AddColumn(new clStringDataSerie("City"))
		  var cqtt as clAbstractDataSerie =  tsales.AddColumn(new clNumberDataSerie("Quantity"))
		  var cup as clAbstractDataSerie = tsales.AddColumn(new clNumberDataSerie("UnitPrice"))
		  
		  tsales.AddRow(new Dictionary("City":"Brussels", "Quantity":12, "Unitprice": 21))
		  tsales.AddRow(new Dictionary("City":"Liege", "Quantity":12, "Unitprice": 22))
		  tsales.AddRow(new Dictionary("City":"Brussels", "Quantity":12, "Unitprice": 23))
		  tsales.AddRow(new Dictionary("City":"Brussels", "Quantity":12, "Unitprice": 24))
		  tsales.AddRow(new Dictionary("City":"Liege", "Quantity":12, "Unitprice": 25))
		  tsales.AddRow(new Dictionary("City":"Paris", "Quantity":12, "Unitprice": 26))
		  tsales.AddRow(new Dictionary("City":"Liege", "Quantity":12, "Unitprice": 27))
		  tsales.AddRow(new Dictionary("City":"Paris", "Quantity":12, "Unitprice": 28))
		  tsales.AddRow(new Dictionary("City":"Rome", "Quantity":10, "Unitprice": 25))
		  
		  call check_table(log, "tsales table integrity", nil, tsales) 
		  
		  
		  // First join table: with a match with some cities, only row per city
		  var tcountriesWithOneMatchingCityRow as new clDataTable("Countries1")
		  call  tcountriesWithOneMatchingCityRow.AddColumn(new clStringDataSerie("Country"))
		  call  tcountriesWithOneMatchingCityRow.AddColumn(new clStringDataSerie("City"))
		  tcountriesWithOneMatchingCityRow.AddRow(new Dictionary("Country":"Belgium","City":"Brussels"))
		  tcountriesWithOneMatchingCityRow.AddRow(new Dictionary("Country":"Belgium","City":"Liege"))
		  tcountriesWithOneMatchingCityRow.AddRow(new Dictionary("Country":"France","City":"Paris"))
		  tcountriesWithOneMatchingCityRow.AddRow(new Dictionary("Country":"USA","City":"NewYork"))
		  tcountriesWithOneMatchingCityRow.AddRow(new Dictionary("City":"London"))
		  
		  call check_table(log, "tcountries table integrity", nil, tcountriesWithOneMatchingCityRow) 
		  
		  // Second join table; no matching cities
		  var tcountriesWithoutMatchingCityRow as new clDataTable("Countries2")
		  call  tcountriesWithoutMatchingCityRow.AddColumn(new clStringDataSerie("Country"))
		  call  tcountriesWithoutMatchingCityRow.AddColumn(new clStringDataSerie("City"))
		  tcountriesWithoutMatchingCityRow.AddRow(new Dictionary("Country":"USA","City":"NewYork"))
		  tcountriesWithoutMatchingCityRow.AddRow(new Dictionary("Country":"France","City":"Lyon"))
		  tcountriesWithoutMatchingCityRow.AddRow(new Dictionary("Country":"Spain","City":"Madrid"))
		  
		  call check_table(log, "tcountries table integrity", nil, tcountriesWithoutMatchingCityRow) 
		  
		  
		  // Third join table, with mutlitple matching rows for some cities
		  var tcountriesWithMulitpleMatchingCityRow as new clDataTable("Countries3")
		  call  tcountriesWithMulitpleMatchingCityRow.AddColumn(new clStringDataSerie("Country"))
		  call  tcountriesWithMulitpleMatchingCityRow.AddColumn(new clStringDataSerie("City"))
		  call tcountriesWithMulitpleMatchingCityRow.AddColumn(new clStringDataSerie("Something"))
		  
		  tcountriesWithMulitpleMatchingCityRow.AddRow(new Dictionary("Country":"Belgium","City":"Brussels","Something":"Alpha"))
		  tcountriesWithMulitpleMatchingCityRow.AddRow(new Dictionary("Country":"Belgium","City":"Liege","Something":"Beta"))
		  tcountriesWithMulitpleMatchingCityRow.AddRow(new Dictionary("Country":"Belgium","City":"Liege","Something":"Gamma"))
		  tcountriesWithMulitpleMatchingCityRow.AddRow(new Dictionary("Country":"France","City":"Paris","Something":"Delta"))
		  tcountriesWithMulitpleMatchingCityRow.AddRow(new Dictionary("Country":"France","City":"Lille","Something":"Omega"))
		  tcountriesWithMulitpleMatchingCityRow.AddRow(new Dictionary("Country":"USA","City":"NewYork","Something":"Zeta"))
		  tcountriesWithMulitpleMatchingCityRow.AddRow(new Dictionary("City":"London"))
		  
		  call check_table(log, "tcountries table integrity", nil, tcountriesWithMulitpleMatchingCityRow) 
		  
		  
		  
		  var tinnerJoin_OneCity as clDataTable = tsales.InnerJoin(tcountriesWithOneMatchingCityRow, array("City"))
		  
		  var touterJoin_OneCity as clDataTable = tsales.OuterJoin(tcountriesWithOneMatchingCityRow, array("City"), "JoinStatus")
		  
		  var tinnerJoin_NoCity as clDataTable = tsales.InnerJoin(tcountriesWithoutMatchingCityRow, array("City"))
		  
		  var touterJoin_NoCity as clDataTable = tsales.OuterJoin(tcountriesWithoutMatchingCityRow, array("City"), "JoinStatus")
		  
		  var tinnerJoin_MulitpleCities as clDataTable = tsales.InnerJoin(tcountriesWithMulitpleMatchingCityRow, array("City"))
		  
		  var touterJoin_MulitpleCities as clDataTable = tsales.OuterJoin(tcountriesWithMulitpleMatchingCityRow, array("City"), "JoinStatus")
		  
		  
		  var tinnerJoin_OneCity_expected as new clDataTable("Inner-One city row")
		  call tinnerJoin_OneCity_expected.AddColumn(new clStringDataSerie("City"))
		  call tinnerJoin_OneCity_expected.AddColumn(new clNumberDataSerie("Quantity"))
		  call tinnerJoin_OneCity_expected.AddColumn(new clNumberDataSerie("UnitPrice"))
		  call tinnerJoin_OneCity_expected.AddColumn(new clStringDataSerie("Country"))
		  
		  
		  tinnerJoin_oneCity_expected.AddRow(new Dictionary("City":"Brussels", "Quantity":12, "Unitprice": 21,"Country":"Belgium"))
		  tinnerJoin_oneCity_expected.AddRow(new Dictionary("City":"Liege", "Quantity":12, "Unitprice": 22,"Country":"Belgium"))
		  tinnerJoin_oneCity_expected.AddRow(new Dictionary("City":"Brussels", "Quantity":12, "Unitprice": 23,"Country":"Belgium"))
		  tinnerJoin_oneCity_expected.AddRow(new Dictionary("City":"Brussels", "Quantity":12, "Unitprice": 24,"Country":"Belgium"))
		  tinnerJoin_oneCity_expected.AddRow(new Dictionary("City":"Liege", "Quantity":12, "Unitprice": 25,"Country":"Belgium"))
		  tinnerJoin_oneCity_expected.AddRow(new Dictionary("City":"Paris", "Quantity":12, "Unitprice": 26,"Country":"France"))
		  tinnerJoin_oneCity_expected.AddRow(new Dictionary("City":"Liege", "Quantity":12, "Unitprice": 27,"Country":"Belgium"))
		  tinnerJoin_oneCity_expected.AddRow(new Dictionary("City":"Paris", "Quantity":12, "Unitprice": 28,"Country":"France"))
		  
		  
		  //
		  var touterJoin_OneCity_expected as new clDataTable("Outer-One city row")
		  call touterJoin_OneCity_expected.AddColumn(new clStringDataSerie("City"))
		  call touterJoin_OneCity_expected.AddColumn(new clNumberDataSerie("Quantity"))
		  call touterJoin_OneCity_expected.AddColumn(new clNumberDataSerie("UnitPrice"))
		  call touterJoin_OneCity_expected.AddColumn(new clStringDataSerie("JoinStatus"))
		  call touterJoin_OneCity_expected.AddColumn(new clStringDataSerie("Country"))
		  
		  touterJoin_OneCity_expected.AddRow(new Dictionary("City":"Brussels", "Quantity":12, "Unitprice": 21,"Country":"Belgium","JoinStatus":clDataTable.JoinSuccessBoth))
		  touterJoin_OneCity_expected.AddRow(new Dictionary("City":"Liege", "Quantity":12, "Unitprice": 22,"Country":"Belgium","JoinStatus":clDataTable.JoinSuccessBoth))
		  touterJoin_OneCity_expected.AddRow(new Dictionary("City":"Brussels", "Quantity":12, "Unitprice": 23,"Country":"Belgium","JoinStatus":clDataTable.JoinSuccessBoth))
		  touterJoin_OneCity_expected.AddRow(new Dictionary("City":"Brussels", "Quantity":12, "Unitprice": 24,"Country":"Belgium","JoinStatus":clDataTable.JoinSuccessBoth))
		  touterJoin_OneCity_expected.AddRow(new Dictionary("City":"Liege", "Quantity":12, "Unitprice": 25,"Country":"Belgium","JoinStatus":clDataTable.JoinSuccessBoth))
		  touterJoin_OneCity_expected.AddRow(new Dictionary("City":"Paris", "Quantity":12, "Unitprice": 26,"Country":"France","JoinStatus":clDataTable.JoinSuccessBoth))
		  touterJoin_OneCity_expected.AddRow(new Dictionary("City":"Liege", "Quantity":12, "Unitprice": 27,"Country":"Belgium","JoinStatus":clDataTable.JoinSuccessBoth))
		  touterJoin_OneCity_expected.AddRow(new Dictionary("City":"Paris", "Quantity":12, "Unitprice": 28,"Country":"France","JoinStatus":clDataTable.JoinSuccessBoth))
		  touterJoin_OneCity_expected.AddRow(new Dictionary("City":"Rome", "Quantity":10, "Unitprice": 25,"JoinStatus":clDataTable.JoinSuccessMainOnly))
		  touterJoin_OneCity_expected.AddRow(new Dictionary("Country":"USA","City":"NewYork","JoinStatus":clDataTable.JoinSuccessJoinedOnly))
		  touterJoin_OneCity_expected.AddRow(new Dictionary("City":"London","JoinStatus":clDataTable.JoinSuccessJoinedOnly))
		  
		  
		  
		  var tinnerJoin_NoCity_expected as new clDataTable("Inner-No city row")
		  call tinnerJoin_NoCity_expected.AddColumn(new clStringDataSerie("City"))
		  call tinnerJoin_NoCity_expected.AddColumn(new clNumberDataSerie("Quantity"))
		  call tinnerJoin_NoCity_expected.AddColumn(new clNumberDataSerie("UnitPrice"))
		  call tinnerJoin_NoCity_expected.AddColumn(new clStringDataSerie("Country"))
		  
		  var touterJoin_NoCity_expected as new clDataTable("Outer-No city row")
		  call touterJoin_NoCity_expected.AddColumn(new clStringDataSerie("City"))
		  call touterJoin_NoCity_expected.AddColumn(new clNumberDataSerie("Quantity"))
		  call touterJoin_NoCity_expected.AddColumn(new clNumberDataSerie("UnitPrice"))
		  call touterJoin_NoCity_expected.AddColumn(new clStringDataSerie("JoinStatus"))
		  call touterJoin_NoCity_expected.AddColumn(new clStringDataSerie("Country"))
		  
		  touterJoin_NoCity_expected.AddRow(new Dictionary("City":"Brussels", "Quantity":12, "Unitprice": 21,"JoinStatus":clDataTable.JoinSuccessMainOnly))
		  touterJoin_NoCity_expected.AddRow(new Dictionary("City":"Liege", "Quantity":12, "Unitprice": 22,"JoinStatus":clDataTable.JoinSuccessMainOnly))
		  touterJoin_NoCity_expected.AddRow(new Dictionary("City":"Brussels", "Quantity":12, "Unitprice": 23,"JoinStatus":clDataTable.JoinSuccessMainOnly))
		  touterJoin_NoCity_expected.AddRow(new Dictionary("City":"Brussels", "Quantity":12, "Unitprice": 24,"JoinStatus":clDataTable.JoinSuccessMainOnly))
		  touterJoin_NoCity_expected.AddRow(new Dictionary("City":"Liege", "Quantity":12, "Unitprice": 25,"JoinStatus":clDataTable.JoinSuccessMainOnly))
		  touterJoin_NoCity_expected.AddRow(new Dictionary("City":"Paris", "Quantity":12, "Unitprice": 26,"JoinStatus":clDataTable.JoinSuccessMainOnly))
		  touterJoin_NoCity_expected.AddRow(new Dictionary("City":"Liege", "Quantity":12, "Unitprice": 27,"JoinStatus":clDataTable.JoinSuccessMainOnly))
		  touterJoin_NoCity_expected.AddRow(new Dictionary("City":"Paris", "Quantity":12, "Unitprice": 28,"JoinStatus":clDataTable.JoinSuccessMainOnly))
		  touterJoin_NoCity_expected.AddRow(new Dictionary("City":"Rome", "Quantity":10, "Unitprice": 25,"JoinStatus":clDataTable.JoinSuccessMainOnly))
		  touterJoin_NoCity_expected.AddRow(new Dictionary("Country":"USA","City":"NewYork","JoinStatus":clDataTable.JoinSuccessJoinedOnly))
		  touterJoin_NoCity_expected.AddRow(new Dictionary("Country":"France","City":"Lyon","JoinStatus":clDataTable.JoinSuccessJoinedOnly))
		  touterJoin_NoCity_expected.AddRow(new Dictionary("Country":"Spain","City":"Madrid","JoinStatus":clDataTable.JoinSuccessJoinedOnly))
		  
		  
		  
		  
		  var tinnerJoin_MulitpleCities_expected as new clDataTable("Inner-Multiple city rows")
		  call tinnerJoin_MulitpleCities_expected.AddColumn(new clStringDataSerie("City"))
		  call tinnerJoin_MulitpleCities_expected.AddColumn(new clNumberDataSerie("Quantity"))
		  call tinnerJoin_MulitpleCities_expected.AddColumn(new clNumberDataSerie("UnitPrice"))
		  call tinnerJoin_MulitpleCities_expected.AddColumn(new clNumberDataSerie("Country"))
		  call tinnerJoin_MulitpleCities_expected.AddColumn(new clStringDataSerie("Something"))
		  
		  tinnerJoin_MulitpleCities_expected.AddRow(new Dictionary("City":"Brussels", "Quantity":12, "Unitprice": 21,"Country":"Belgium","Something":"Alpha"))
		  tinnerJoin_MulitpleCities_expected.AddRow(new Dictionary("City":"Liege", "Quantity":12, "Unitprice": 22,"Country":"Belgium","Something":"Beta"))
		  tinnerJoin_MulitpleCities_expected.AddRow(new Dictionary("City":"Liege", "Quantity":12, "Unitprice": 22,"Country":"Belgium","Something":"Gamma"))
		  tinnerJoin_MulitpleCities_expected.AddRow(new Dictionary("City":"Brussels", "Quantity":12, "Unitprice": 23,"Country":"Belgium","Something":"Alpha"))
		  tinnerJoin_MulitpleCities_expected.AddRow(new Dictionary("City":"Brussels", "Quantity":12, "Unitprice": 24,"Country":"Belgium","Something":"Alpha"))
		  tinnerJoin_MulitpleCities_expected.AddRow(new Dictionary("City":"Liege", "Quantity":12, "Unitprice": 25,"Country":"Belgium","Something":"Beta"))
		  tinnerJoin_MulitpleCities_expected.AddRow(new Dictionary("City":"Liege", "Quantity":12, "Unitprice": 25,"Country":"Belgium","Something":"Gamma"))
		  tinnerJoin_MulitpleCities_expected.AddRow(new Dictionary("City":"Paris", "Quantity":12, "Unitprice": 26,"Country":"France","Something":"Delta"))
		  tinnerJoin_MulitpleCities_expected.AddRow(new Dictionary("City":"Liege", "Quantity":12, "Unitprice": 27,"Country":"Belgium","Something":"Beta"))
		  tinnerJoin_MulitpleCities_expected.AddRow(new Dictionary("City":"Liege", "Quantity":12, "Unitprice": 27,"Country":"Belgium","Something":"Gamma"))
		  tinnerJoin_MulitpleCities_expected.AddRow(new Dictionary("City":"Paris", "Quantity":12, "Unitprice": 28,"Country":"France","Something":"Delta"))
		  
		  
		  
		  var touterJoin_MulitpleCities_expected as new clDataTable("Outer-Mulitple city rows")
		  call touterJoin_MulitpleCities_expected.AddColumn(new clStringDataSerie("City"))
		  call touterJoin_MulitpleCities_expected.AddColumn(new clNumberDataSerie("Quantity"))
		  call touterJoin_MulitpleCities_expected.AddColumn(new clNumberDataSerie("UnitPrice"))
		  call touterJoin_MulitpleCities_expected.AddColumn(new clStringDataSerie("JoinStatus"))
		  call touterJoin_MulitpleCities_expected.AddColumn(new clNumberDataSerie("Country"))
		  call touterJoin_MulitpleCities_expected.AddColumn(new clStringDataSerie("Something"))
		  
		  touterJoin_MulitpleCities_expected.AddRow(new Dictionary("City":"Brussels", "Quantity":12, "Unitprice": 21,"Country":"Belgium","Something":"Alpha","JoinStatus":clDataTable.JoinSuccessBoth))
		  touterJoin_MulitpleCities_expected.AddRow(new Dictionary("City":"Liege", "Quantity":12, "Unitprice": 22,"Country":"Belgium","Something":"Beta","JoinStatus":clDataTable.JoinSuccessBoth))
		  touterJoin_MulitpleCities_expected.AddRow(new Dictionary("City":"Liege", "Quantity":12, "Unitprice": 22,"Country":"Belgium","Something":"Gamma","JoinStatus":clDataTable.JoinSuccessBoth))
		  touterJoin_MulitpleCities_expected.AddRow(new Dictionary("City":"Brussels", "Quantity":12, "Unitprice": 23,"Country":"Belgium","Something":"Alpha","JoinStatus":clDataTable.JoinSuccessBoth))
		  touterJoin_MulitpleCities_expected.AddRow(new Dictionary("City":"Brussels", "Quantity":12, "Unitprice": 24,"Country":"Belgium","Something":"Alpha","JoinStatus":clDataTable.JoinSuccessBoth))
		  touterJoin_MulitpleCities_expected.AddRow(new Dictionary("City":"Liege", "Quantity":12, "Unitprice": 25,"Country":"Belgium","Something":"Beta","JoinStatus":clDataTable.JoinSuccessBoth))
		  touterJoin_MulitpleCities_expected.AddRow(new Dictionary("City":"Liege", "Quantity":12, "Unitprice": 25,"Country":"Belgium","Something":"Gamma","JoinStatus":clDataTable.JoinSuccessBoth))
		  touterJoin_MulitpleCities_expected.AddRow(new Dictionary("City":"Paris", "Quantity":12, "Unitprice": 26,"Country":"France","Something":"Delta","JoinStatus":clDataTable.JoinSuccessBoth))
		  touterJoin_MulitpleCities_expected.AddRow(new Dictionary("City":"Liege", "Quantity":12, "Unitprice": 27,"Country":"Belgium","Something":"Beta","JoinStatus":clDataTable.JoinSuccessBoth))
		  touterJoin_MulitpleCities_expected.AddRow(new Dictionary("City":"Liege", "Quantity":12, "Unitprice": 27,"Country":"Belgium","Something":"Gamma","JoinStatus":clDataTable.JoinSuccessBoth))
		  touterJoin_MulitpleCities_expected.AddRow(new Dictionary("City":"Paris", "Quantity":12, "Unitprice": 28,"Country":"France","Something":"Delta","JoinStatus":clDataTable.JoinSuccessBoth))
		  touterJoin_MulitpleCities_expected.AddRow(new Dictionary("City":"Rome", "Quantity":10, "Unitprice": 25,"JoinStatus":clDataTable.JoinSuccessMainOnly))
		  touterJoin_MulitpleCities_expected.AddRow(new Dictionary("City":"Lille", "Quantity":0, "Unitprice": 0,"Country":"Belgium","Something":"Omega","JoinStatus":clDataTable.JoinSuccessJoinedOnly))
		  touterJoin_MulitpleCities_expected.AddRow(new Dictionary("City":"NewYork", "Quantity":0, "Unitprice": 0,"Country":"USA","Something":"Zeta","JoinStatus":clDataTable.JoinSuccessJoinedOnly))
		  touterJoin_MulitpleCities_expected.AddRow(new Dictionary("City":"London", "Quantity":0, "UnitPrice":0,"JoinStatus":clDataTable.JoinSuccessJoinedOnly))
		  
		  
		  
		  call check_table(log, "Join1", tinnerJoin_oneCity_expected, tinnerJoin_oneCity)
		  
		  call check_table(log, "Join2", touterJoin_OneCity_expected, touterJoin_OneCity)
		  
		  call check_table(log, "Join3", tinnerJoin_NoCity_expected, tinnerJoin_NoCity)
		  
		  call check_table(log, "Join4", touterJoin_NoCity_expected, touterJoin_NoCity)
		  
		  call check_table(log, "Join5", tinnerJoin_MulitpleCities_expected, tinnerJoin_MulitpleCities)
		  
		  call check_table(log, "Join6", touterJoin_MulitpleCities_expected, touterJoin_MulitpleCities)
		  
		  
		  log.end_exec(CurrentMethodName)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_calc_051(log as LogMessageInterface)
		  
		  log.start_exec(CurrentMethodName)
		  
		  // Test basic filter transformer
		  
		  var col_country as new clDataSerie("Country", "France", "", "Belgique", "France", "Belgique")
		  var col_city as new clDataSerie("City", "Paris", "Marseille", "Bruxelles", "Lille", "Namur")
		  var col_something as new clIntegerDataSerie("Something", 1000, 2000, 3000, 4000, 5000)
		  var col_sales as new clNumberDataSerie("sales", 900.0, 1200.0, 1400.0, 1600.0, 2900)
		  
		  var table0 As New clDataTable("mytable", SerieArray(col_country, col_city, col_sales, col_something))
		  
		  call table0.AddColumn(table0.ApplyFilterFunction("is_france",AddressOf BasicFieldFilter,"country","France"))
		  
		  var tableFrance as clDataTable
		  var tableNotFrance as clDataTable
		  
		  var t1 as new clFilterTransformer(table0, "is_france")
		  if t1.Transform() then tableFrance = t1.GetOutputTable
		  
		  var t2 as new clFilterTransformer(table0, "is_france", FilterMode.ExcludeSelected)
		  if t2.Transform() then tableNotFrance = t2.GetOutputTable
		  
		  var expectedTableNotFrance as new clDataTable("ExpectedNotFrance")
		  var expectedTableFrance as new clDataTable("ExpectedFrance")
		  
		  for each row as clDataRow in table0
		    var country as string = row.GetCell("country")
		     
		    if country = "France" then 
		      expectedTableFrance.AddRow(row)
		      
		    else
		      expectedTableNotFrance.AddRow(row)
		      
		    end if
		    
		    
		  next
		  
		  call check_table(log,"Selected France", expectedTableFrance, tableFrance)
		  call check_table(log,"Selected not france", expectedTableNotFrance, tableNotFrance)
		  
		  log.end_exec(CurrentMethodName)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_calc_052(log as LogMessageInterface)
		  
		  log.start_exec(CurrentMethodName)
		  
		  var tableInput As New clDataTable("mytable")
		  var tableOutput as clDataTable
		  
		  call tableInput.AddColumn(new clStringDataSerie("country"))
		  call tableInput.AddColumn(new clStringDataSerie("city"))
		  call tableInput.AddColumn(new clNumberDataSerie("sales"))
		  
		  tableInput.AddRow(Array("France","Paris",1100))
		  tableInput.AddRow(Array("","Marseille",1200))
		  tableInput.AddRow(Array("Belgique","",1300))
		  tableInput.AddRow(Array("USA","NewYork",1400))
		  tableInput.AddRow(Array("Belgique","Bruxelles",1500))
		  tableInput.AddRow(Array("USA","Chicago",1600))
		  
		  call check_table(log, "table0 integrity", nil, tableInput) 
		  
		  
		  
		  var t1 as new clFunctionTransformer(tableInput, AddressOf TransfomerFctApplyFixedRate, array("Taxes","Sales"), VariantArray(0.06))
		  
		  if t1.Transform() then tableOutput = t1.GetOutputTable
		  
		  var expectedOutput as clDataTable = tableInput.clone("expected output")
		  var tx as  clNumberDataSerie
		  tx = tableInput.GetNumberColumn("Sales")*0.06
		  
		  call expectedOutput.AddColumn(tx.Rename("Taxes"))
		  
		  call check_table(log, "results", expectedOutput, tableOutput) 
		  
		  
		  
		  var statusTable as new clDataTable("Status")
		  call statusTable.AddColumn(new clStringDataSerie("field"))
		  call statusTable.AddColumn(new clBooleanDataSerie("local"))
		  
		  for each v as string  in array("Country", "City","Sales","Taxes")
		    var r as new clDataRow
		    r.SetCell("field", v)
		    r.SetCell("local", tableOutput.GetColumn(v).IsLinkedToTable(tableOutput))
		    statusTable.AddRow(r)
		    
		  next
		  
		  var expectedstatusTable as   clDataTable = statusTable.CloneStructure("ExpStatus")
		  expectedstatusTable.AddRow(new cldatarow("field":"Country","local":false))
		  expectedstatusTable.AddRow(new cldatarow("field":"City","local":false))
		  expectedstatusTable.AddRow(new cldatarow("field":"Sales","local":false))
		  expectedstatusTable.AddRow(new cldatarow("field":"Taxes","local":true))
		  
		  call check_table(log, "status tables", expectedstatusTable, statusTable) 
		  
		  log.end_exec(CurrentMethodName)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_calc_053(log as LogMessageInterface)
		  
		  log.start_exec(CurrentMethodName)
		  
		  var tableInput As New clDataTable("mytable")
		  var tableOutput as clDataTable
		  
		  call tableInput.AddColumn(new clStringDataSerie("country"))
		  call tableInput.AddColumn(new clStringDataSerie("city"))
		  call tableInput.AddColumn(new clNumberDataSerie("sales1"))
		  call tableInput.AddColumn(new clNumberDataSerie("sales2"))
		  
		  
		  tableInput.AddRow(Array("France","Paris",1100, 800))
		  tableInput.AddRow(Array("","Marseille",1200, 900))
		  tableInput.AddRow(Array("Belgique","",1300, 2000))
		  tableInput.AddRow(Array("USA","NewYork",1400, 2100))
		  tableInput.AddRow(Array("Belgique","Bruxelles",1500, 1700))
		  tableInput.AddRow(Array("USA","Chicago",1600, 890))
		  
		  call check_table(log, "table0 integrity", nil, tableInput) 
		  
		  
		  var p() as pair = array(1:array("Taxes1","Sales1"), 2:array("Taxes2","Sales2"))
		  
		  var t1 as new clRepeatFunctionTransformer(tableInput, AddressOf TransfomerFctApplyFixedRate, p, VariantArray(0.06))
		  
		  if t1.Transform() then tableOutput = t1.GetOutputTable
		  
		  var expectedOutput as clDataTable = tableInput.clone("expected output")
		  
		  var tx as  clNumberDataSerie
		  
		  tx = tableInput.GetNumberColumn("Sales1")*0.06
		  call expectedOutput.AddColumn(tx.Rename("Taxes1"))
		  
		  tx = tableInput.GetNumberColumn("Sales2")*0.06
		  call expectedOutput.AddColumn(tx.Rename("Taxes2"))
		  
		  
		  call check_table(log, "results", expectedOutput, tableOutput) 
		  
		  
		  
		  var statusTable as new clDataTable("Status")
		  call statusTable.AddColumn(new clStringDataSerie("field"))
		  call statusTable.AddColumn(new clBooleanDataSerie("local"))
		  
		  for each v as string  in array("Country", "City","Sales1","Taxes1", "Sales2","Taxes2")
		    var r as new clDataRow
		    r.SetCell("field", v)
		    r.SetCell("local", tableOutput.GetColumn(v).IsLinkedToTable(tableOutput))
		    statusTable.AddRow(r)
		    
		  next
		  
		  var expectedstatusTable as   clDataTable = statusTable.CloneStructure("ExpStatus")
		  expectedstatusTable.AddRow(new cldatarow("field":"Country","local":false))
		  expectedstatusTable.AddRow(new cldatarow("field":"City","local":false))
		  expectedstatusTable.AddRow(new cldatarow("field":"Sales1","local":false))
		  expectedstatusTable.AddRow(new cldatarow("field":"Taxes1","local":true))
		  expectedstatusTable.AddRow(new cldatarow("field":"Sales2","local":false))
		  expectedstatusTable.AddRow(new cldatarow("field":"Taxes2","local":true))
		  
		  call check_table(log, "status tables", expectedstatusTable, statusTable) 
		  
		  log.end_exec(CurrentMethodName)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_io_001(log as LogMessageInterface)
		  
		  log.start_exec(CurrentMethodName)
		  
		  
		  var fld_file1 As FolderItem
		  var fld_file2 As FolderItem
		  var fld_file3Text As FolderItem
		  var fld_file3JSON As FolderItem
		  
		  var fld_folder As  FolderItem = GetTestBaseFolder()
		  var sub_folder as FolderItem  = ClearFolder( fld_folder.Child(CurrentMethodName))
		  
		  fld_file1 = fld_folder.Child("myfile3_10K_tab.txt")
		  fld_file2  = fld_folder.Child("myfile3_10K_comma.txt")
		  
		  
		  fld_file3Text  = sub_folder.Child("myfile3_10K_output.txt")
		  fld_file3JSON  = sub_folder.Child("myfile3_10K_output.json")
		  
		  var table3 As New clDataTable(new clTextReader(fld_file1, True, new clTextFileConfig(chr(9))))
		  
		  var table4 As New clDataTable(new clTextReader(fld_file2, True, New clTextFileConfig(",")))
		  
		  table4.save(new clTextWriter(fld_file3Text, True, new clTextFileConfig(";")))
		  
		  table4.save(new clJSONWriter(fld_file3JSON, new clJSONFileConfig()))
		  
		  var table5Text as new clDataTable(new clTextReader(fld_file3Text, True, new clTextFileConfig(";")))
		  var table5JSON as new clDataTable(new clJSONReader(fld_file3JSON, new clJSONFileConfig()))
		  
		  call check_table(log, "table3 integrity", nil, table3)
		  
		  call check_table(log,"table4/table5Text", table4, table5Text) 
		  call check_table(log,"table4/table5JSON", table4, table5JSON) 
		  
		  var table6Compressed  as new clDataTable(new clTextReader(fld_file1, True, New clTextFileConfig(Chr(9))), AddressOf alloc_series_io1)
		  
		  call check_table(log,"table3/table6Compressed", table3, table6Compressed) 
		  
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
		  
		  
		  var table1 as new clDataTable(new clDBReader(db.SelectSql("select * from test1")))
		  table1.rename("test2")
		  call check_table(log, "table1 integrity", nil, table1) 
		  
		  table1.save(new clDBWriter(new clSqliteDBAccess(db)))
		  
		  var table2 as new clDataTable(new clDBReader(db.SelectSql("select * from test2")))
		  call check_table(log, "mytable2 integrity", nil, table2) 
		  
		  
		  call check_table(log,"Test1/Test2", table1, table2)
		  
		  
		  
		  var table3 as new clDataTable(new clDBReader(db.SelectSql("select * from test3")))
		  table3.rename("test4")
		  table3.save(new clDBAppendWriter(new clSqliteDBAccess(db)))
		  call check_table(log, "mytable3 integrity", nil, table3) 
		  
		  
		  var table4 as new clDataTable(new clDBReader(db.SelectSql("select * from test4")))
		  call check_table(log, "mytable4 integrity", nil, table4) 
		  
		  call check_table(log,"Test3/Test4", table3, table4)
		  
		  
		  var table5 as new clDataTable(new clDBReader(db.SelectSQL("select * from test1")))
		  call check_table(log, "mytable5 integrity", nil, table5) 
		  
		  var table6 as new clDataTable(new clDBReader(db.SelectSQL("select * from test3")))
		  call check_table(log, "mytable6 integrity", nil, table6) 
		  
		  // create expected ds
		  var table7 as clDataTable = table5.clone
		  table7. AddColumnsData(table6)
		  
		  
		  // add rows from test3 to test2
		  table6.rename("test2")
		  table6.save(new clDBAppendWriter(new clSqliteDBAccess(db)))
		  
		  
		  var table8 as new clDataTable(new clDBReader(db.SelectSQL("select * from test2")))
		  
		  
		  call check_table(log,"Test7/Test8", table7, table8)
		  
		  
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
		  
		  
		  var table1 as new clDataTable("test2", new clDBReader(new clSqliteDBAccess(db),"test1"))
		  call check_table(log, "table1 integrity", nil, table1) 
		  
		  table1.save(new clDBWriter(new clSqliteDBAccess(db)))
		  
		  var table2 as new clDataTable(new clDBReader(db.SelectSql("select * from test2")))
		  
		  call check_table(log,"Test1/Test2", table1, table2)
		  
		  
		  var table3 as new clDataTable("test4", new clDBReader(new clSqliteDBAccess(db),"test3"))
		  
		  table3.save(new clDBAppendWriter(new clSqliteDBAccess(db)))
		  
		  var table4 as new clDataTable(new clDBReader(db.SelectSql("select * from test4")))
		  
		  call check_table(log,"Test3/Test4", table3, table4)
		  
		  
		  var table5 as new clDataTable(new clDBReader(db.SelectSQL("select * from test1")))
		  call check_table(log, "mytable5 integrity", nil, table5) 
		  
		  var table6 as new clDataTable(new clDBReader(db.SelectSQL("select * from test3")))
		  call check_table(log, "mytable6 integrity", nil, table6) 
		  
		  // create expected ds
		  var table7 as clDataTable = table5.clone
		  table7. AddColumnsData(table6)
		  
		  
		  // add rows from test3 to test2
		  table6.rename("test2")
		  table6.save(new clDBAppendWriter(new clSqliteDBAccess(db)))
		  
		  
		  var table8 as new clDataTable(new clDBReader(db.SelectSQL("select * from test2")))
		  
		  call check_table(log,"Test7/Test8", table7, table8)
		  
		  log.end_exec(CurrentMethodName)
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_io_004(log as LogMessageInterface)
		  
		  
		  log.start_exec(CurrentMethodName)
		  
		  
		  var fld_file1 As FolderItem
		  var fld_file2 As FolderItem
		  var fld_file3 As FolderItem
		  var fld_fileX as FolderItem
		  
		  var main_folder As  FolderItem = GetTestBaseFolder()
		  var sub_folder as FolderItem  = ClearFolder(main_folder.Child(CurrentMethodName))
		  
		  
		  fld_file1 = main_folder.Child("myfile4_A_tab.txt")
		  fld_file2  = main_folder.Child("myfile4_B_tab.txt") 
		  fld_file3  = main_folder.Child("myfile4_C_tab.txt") 
		  fld_fileX  = main_folder.Child("myfile4_X_tab.txt") 
		  
		  
		  var table as new clDataTable("calc")
		  call table.AddColumn(new clStringDataSerie("Alpha"))
		  call table.AddColumn(new clIntegerDataSerie("Beta"))
		  call table.AddColumn(new clNumberDataSerie("Delta"))
		  call table.AddColumn(new clNumberDataSerie("Gamma"))
		  call table.AddColumn(new clIntegerDataSerie("Group"))
		  
		  
		  var dct_mapping_file3 as new Dictionary
		  dct_mapping_file3.value("Un") = "Alpha"
		  dct_mapping_file3.value("Deux") = "Beta"
		  dct_mapping_file3.value("Trois") = "Gamma"
		  dct_mapping_file3.value("Quatre") = "Delta"
		  dct_mapping_file3.value("Extra") = "New_col"
		  
		  
		  call table.AddRows(new clTextReader(fld_file1, True, new clTextFileConfig(chr(9))))
		  
		  call table.AddRows(new clTextReader(fld_file2, True, new clTextFileConfig(chr(9))))
		  
		  call table.AddRows(new clTextReader(fld_file3, True, new clTextFileConfig(chr(9))),dct_mapping_file3)
		  
		  var expected_table as new clDataTable("calc")
		  call expected_table.AddColumn(new clStringDataSerie("Alpha"))
		  call expected_table.AddColumn(new clIntegerDataSerie("Beta"))
		  call expected_table.AddColumn(new clNumberDataSerie("Delta"))
		  call expected_table.AddColumn(new clNumberDataSerie("Gamma"))
		  call expected_table.AddColumn(new clIntegerDataSerie("Group"))
		  call expected_table.AddColumn(new clStringDataSerie("New_col"))
		  
		  call expected_table.AddRows(new clTextReader(fld_fileX, True, new clTextFileConfig(chr(9))))
		  
		  call check_table(log,"T4/T5", expected_table, table, 0.0001) 
		  
		  log.end_exec(CurrentMethodName)
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_io_005(log as LogMessageInterface)
		  
		  log.start_exec(CurrentMethodName)
		  
		  var v1 as new clDBReader(nil, "table")
		  var v1_name as string = v1.name
		  
		  
		  var v2 as new clDBReader(nil, "select alpha, beta from table")
		  var v2_name as string = v2.name
		  
		  var v3 as new clDBReader(nil, "select alpha, beta from table left join something on ")
		  var v3_name as string = v3.name
		  
		  var v4 as new clDBReader(nil, "select alpha, beta  from   table")
		  var v4_name as string = v4.name
		  
		  call check_value(log, "name v1", "table", v1_name)
		  call check_value(log, "name v2", "table", v2_name)
		  call check_value(log, "name v3", "table", v3_name)
		  call check_value(log, "name v3", "table", v4_name)
		  
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
