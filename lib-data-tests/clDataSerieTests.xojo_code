#tag Class
Protected Class clDataSerieTests
	#tag Method, Flags = &h0
		Sub test_calc_001(log as LogMessageInterface)
		  
		  log.StartTask(CurrentMethodName)
		  
		  var test  As clDataSerie
		  
		  
		  test = New clDataSerie("test")
		  
		  test.AddElement("hello")
		  test.AddElement("world")
		  
		  call check_value(log,"row count", test.RowCount, 2)
		  
		  
		  log.end_exec(CurrentMethodName)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_calc_003(log as LogMessageInterface)
		  
		  log.StartTask(CurrentMethodName)
		  
		  var test  As clDataSerie
		  
		  test = New clDataSerie("test", VariantArray("aaa",123,True))
		  
		  var expected() as variant
		  expected.add("aaa")
		  expected.add(123)
		  expected.Add(True)
		  
		  if test.RowCount <> 3 then
		    System.DebugLog("Invalid row count")
		    return
		    
		  end if
		  
		  for row as integer =0 to test.RowCount-1
		    call check_value(log,"row " + str(row), expected(row), test.GetElement(row))
		    
		  next
		  
		  
		  log.end_exec(CurrentMethodName)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_calc_006(log as LogMessageInterface)
		  
		  
		  log.StartTask(CurrentMethodName)
		  
		  var src As New clDataSerie("premier") 
		  
		  src.AddElement("aaa1")
		  src.AddElement("bb1")
		  src.AddElement("cccc1")
		  src.AddElement("aaa2")
		  src.AddElement("bb2")
		  src.AddElement("cccc2")
		  src.AddElement("aaa3")
		  src.AddElement("bb3")
		  src.AddElement("cccc3")
		  src.AddElement("aaa4")
		  src.AddElement("bb4")
		  src.AddElement("cccc4")
		  
		  var f1() As variant
		  var f2() As variant
		  var f3() As Variant
		  
		  // all boolean arrays have the same size
		  //
		  
		  f1 = src.ApplyFilterFunction(AddressOf filter01)
		  
		  f2 = src.ApplyFilterFunction(AddressOf RetainSerieHead, 7)
		  
		  f3 = src.ApplyFilterFunction(AddressOf RetainSerieTail)
		  
		  var c1 As New clDataSerie("test001", f1)
		  var c2 As New clDataSerie("test002", f2)
		  var c3 as New clDataSerie("test003", f3)
		  
		  
		  var cnt1, cnt2, cnt3, cnt4, cnt5, cnt6 as Integer
		  
		  for i as integer =  0 to f1.LastIndex
		    if f1(i) then  cnt1 = cnt1 + 1
		    if f2(i) then cnt2 = cnt2 + 1 
		    if f3(i) then cnt3 = cnt3 + 1
		    
		    if c1.GetElement(i) then cnt4 = cnt4 + 1
		    if c2.GetElement(i) then cnt5 = cnt5 + 1
		    if c3.GetElement(i) then cnt6 = cnt6 + 1
		    
		  next
		  
		  call check_value(log,"cnt1", 12, cnt1)
		  call check_value(log, "cnt2", 7, cnt2)
		  call check_value(log,"cnt3", 10, cnt3)
		  
		  call check_value(log,"cnt4", 12, cnt4)
		  call check_value(log, "cnt5", 7, cnt5)
		  call check_value(log, "cnt6", 10, cnt6)
		  
		  log.end_exec(CurrentMethodName)
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_calc_007(log as LogMessageInterface)
		  
		  log.StartTask(CurrentMethodName)
		  
		  var c1 As New clDataSerie("premier") 
		  var c2 As New clDataSerie("second") 
		  
		  c1.AddElement("123.4")
		  c1.AddElement(140.5)
		  
		  c2.AddElement("123.4")
		  c2.AddElement(140.5)
		  c2.AddElement("yoyo")
		  
		  var d1 As Double
		  var d2 As Double
		  
		  d1 = c1.sum
		  d2 = c2.sum
		  
		  call check_value(log,"d1", 263.9, d1)
		  call check_value(log,"d2", 263.9, d2)
		  
		  log.end_exec(CurrentMethodName)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_calc_008(log as LogMessageInterface)
		  
		  log.StartTask(CurrentMethodName)
		  
		  var c1 As New clDataSerie("premier") 
		  var c2 As New clDataSerie("second") 
		  var c3 As New clDataSerie("parent")
		  var c4 As New clDataSerie("grand-parent")
		  
		  c1.AddElement("123.4")
		  c1.AddElement(140.5)
		  
		  c2.AddElement("123.4")
		  c2.AddElement(140.5)
		  c2.AddElement("yoyo")
		  
		  
		  c3.AddElement(c1)
		  c3.AddElement(c2)
		  
		  c4.AddElement(c3)
		  
		  var d3 As Double = c3.sum
		  var d4 As Double = c4.sum
		  
		  call check_value(log,"upper bound for c3", 1, c3.LastIndex)
		  call check_value(log, "upper bound for c4", 0, c4.LastIndex)
		  
		  
		  log.end_exec(CurrentMethodName)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_calc_009(log as LogMessageInterface)
		  
		  log.StartTask(CurrentMethodName)
		  
		  var c1 As New clDataSerieMultiValued(Array("aaaa","bbbb")) 
		  
		  call check_value(log,"name", "aaaa" + Chr(9) + "bbbb", c1.name)
		  
		  
		  
		  log.end_exec(CurrentMethodName)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_calc_010(log as LogMessageInterface)
		  
		  log.StartTask(CurrentMethodName)
		  
		  var c1 As New clCompressedDataSerie("CompSerie") 
		  var c2 As New clDataSerie("BaseSerie") 
		  
		  c1.AddElement("aaa")
		  c1.AddElement("bb")
		  c1.AddElement("cccc")
		  c1.AddElement("aaa")
		  c1.AddElement("bb")
		  c1.AddElement("cccc")
		  c1.AddElement("aaa")
		  c1.AddElement("bb")
		  c1.AddElement("cccc")
		  c1.AddElement("aaa")
		  c1.AddElement("bb")
		  c1.AddElement("cccc")
		  c1.AddElement("bb")
		  c1.AddElement("cccc")
		  c1.AddElement("cccc")
		  
		  c1.CopyElementsTo(c2)
		  
		  
		  var f1() As variant
		  var f2() As variant 
		  
		  f1 = c1.ApplyFilterFunction(AddressOf filter_value_is_not_aaa)
		  
		  f2 = c2.ApplyFilterFunction(AddressOf filter_value_is_not_aaa)
		  
		  var r1 As New clDataSerie("test001", f1)
		  var r2 As New clDataSerie("test002", f2)
		  
		  var nbf1, nbf2, nbr1, nbr2 as integer
		  
		  for i as integer = 0 to f1.LastIndex
		    if f1(i) then nbf1 = nbf1 + 1
		    if f2(i) then nbf2 = nbf2 + 1
		    
		    if r1.GetElement(i) then nbr1 = nbr1 + 1
		    if r2.GetElement(i) then nbr2 = nbr2 + 1
		    
		  next
		  
		  call check_value(log,"nbf1", 11, nbf1)
		  call check_value(log, "nbf2", 11, nbf2)
		  call check_value(log,"nbr1", 11, nbr1)
		  call check_value(log, "nbr2", 11, nbr2) 
		  
		  
		  log.end_exec(CurrentMethodName)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_calc_011(log as LogMessageInterface)
		  
		  log.StartTask(CurrentMethodName)
		  
		  var test  As clNumberDataSerie
		  
		  
		  test = New clNumberDataSerie("test")
		  
		  test.AddElement(125)
		  test.AddElement(142)
		  
		  call check_value(log,"row count", test.RowCount, 2) 
		  
		  log.end_exec(CurrentMethodName)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_calc_012(log as LogMessageInterface)
		  
		  log.StartTask(CurrentMethodName)
		  
		  var test  As clNumberDataSerie
		  
		  
		  test = New clNumberDataSerie("test")
		  
		  test.AddElement("125")
		  test.AddElement(142)
		  
		  call check_value(log,"row count", test.RowCount, 2) 
		  
		  log.end_exec(CurrentMethodName)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_calc_014(log as LogMessageInterface)
		  
		  log.StartTask(CurrentMethodName)
		  
		  var test  As clNumberDataSerie
		  
		  
		  test = New clNumberDataSerie("test")
		  
		  test.AddElement("abc")
		  test.AddElement(142)
		  
		  call check_value(log,"row count", test.RowCount, 2)
		  
		  
		  log.end_exec(CurrentMethodName)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_calc_015(log as LogMessageInterface)
		  
		  log.StartTask(CurrentMethodName)
		  
		  var test0, test1, test2, test3  As clNumberDataSerie
		  var expected, delta as clNumberDataSerie
		  
		  test1 = New clNumberDataSerie("test1")
		  
		  test1.AddElement(124)
		  test1.AddElement(456)
		  
		  test2 = new clNumberDataSerie("test2")
		  test2.AddElement(12)
		  test2.AddElement(24)
		  test2.AddElement(10)
		  
		  test3 = new clNumberDataSerie("test3")
		  test3.AddElement(100)
		  test3.AddElement(300)
		  test3.AddElement(6)
		  
		  test0 = (test1 + test2 - test3 + 1000) * 0.5
		  
		  expected = new clNumberDataSerie("expected")
		  expected.AddElement(518)
		  expected.AddElement(590)
		  expected.AddElement(502)
		  
		  delta = test0 - expected
		  
		  call check_value(log,"sum of diff", 0, delta.sum)
		  
		  log.end_exec(CurrentMethodName)
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_calc_016(log as LogMessageInterface)
		  
		  log.StartTask(CurrentMethodName)
		  
		  
		  var c1 As New clDataSerie("premier") 
		  var c2 As New clIntegerDataSerie("second") 
		  
		  var c3 as new clCompressedDataSerie("troisieme")
		  
		  for i as integer = 0 to 10
		    c1.AddElement("aaa")
		    c1.AddElement("bb")
		    c1.AddElement("cccc")
		    c1.AddElement("ddddd")
		    c1.AddElement("ee")
		    
		    c2.AddElement(345)
		    c2.AddElement(5678)
		    c2.AddElement(12756)
		    c2.AddElement(3345)
		    c2.AddElement(564378)
		    
		    c3.AddElement("aaa")
		    c3.AddElement("bb")
		    c3.AddElement("cccc")
		    c3.AddElement("ddddd")
		    c3.AddElement("ee")
		    
		  next
		  
		  var uniq1() as variant = c1.unique
		  var uniq2() as Variant = c2.unique
		  var uniq3() as variant = c3.unique
		  
		  call check_value(log, "uniq1", 5, uniq1.Count)
		  call check_value(log, "uniq2", 5, uniq2.Count)
		  call check_value(log, "uniq3", 5, uniq3.Count)
		  
		  log.end_exec(CurrentMethodName)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_calc_017(log as LogMessageInterface)
		  
		  log.StartTask(CurrentMethodName)
		  
		  var c1 As New clCompressedDataSerie("CompSerie") 
		  var c2 As New clDataSerie("BaseSerie") 
		  
		  c1.AddElement("aaa")
		  c1.AddElement("bb")
		  c1.AddElement("cccc")
		  c1.AddElement("aaa")
		  c1.AddElement("bb")
		  c1.AddElement("cccc")
		  c1.AddElement("aaa")
		  c1.AddElement("bb")
		  c1.AddElement("cccc")
		  c1.AddElement("aaa")
		  c1.AddElement("bb")
		  c1.AddElement("cccc")
		  c1.AddElement("bb")
		  c1.AddElement("cccc")
		  c1.AddElement("cccc")
		  
		  c1.CopyElementsTo(c2)
		  
		  
		  var f1() As variant
		  var f2() As variant 
		  
		  f1 = c1.ApplyFilterFunction(AddressOf filter_value_is_parameter,"aaa")
		  
		  f2 = c2.ApplyFilterFunction(AddressOf filter_value_is_parameter,"aaa")
		  
		  
		  var r1 As New clDataSerie("test001", f1)
		  var r2 As New clDataSerie("test002", f2)
		  
		  var nbf1, nbf2, nbr1, nbr2 as integer
		  
		  for i as integer = 0 to f1.LastIndex
		    if f1(i) then nbf1 = nbf1 + 1
		    if f2(i) then nbf2 = nbf2 + 1
		    
		    if r1.GetElement(i) then nbr1 = nbr1 + 1
		    if r2.GetElement(i) then nbr2 = nbr2 + 1
		    
		  next
		  
		  call check_value(log,"nbf1", 4, nbf1)
		  call check_value(log, "nbf2", 4, nbf2)
		  call check_value(log,"nbr1", 4, nbr1)
		  call check_value(log, "nbr2", 4, nbr2) 
		  
		  log.end_exec(CurrentMethodName)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_calc_018(log as LogMessageInterface)
		  
		  log.StartTask(CurrentMethodName)
		  
		  var c1 As New clDateDataSerie("premier") 
		  var c2 As New clDateDataSerie("second") 
		  
		  c1.AddElement("2023-06-01")
		  c1.AddElement("2022-08-12")
		  
		  c2.AddElement("2021-06-01")
		  c2.AddElement("2020-08-01")
		  
		  var c3 as clIntegerDataSerie = c1 - c2
		  
		  var c4 as clIntegerDataSerie = c1 - DateTime.FromString("2020-01-01")
		  
		  var c5 as clStringDataSerie = c1.ToString()
		  
		  var c6 as clStringDataSerie = c1.ToString(DateTime.FormatStyles.Medium)
		  
		  var c7 as clStringDataSerie = c1.ToString("yyyy-MM")
		  
		  
		  log.end_exec(CurrentMethodName)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_calc_019(log as LogMessageInterface)
		  
		  log.StartTask(CurrentMethodName)
		  
		  var c1 As New clDateDataSerie("premier") 
		  var c2 As New clDateDataSerie("second") 
		  
		  // The time part must be reset/ignored since we use a DateDataSerie
		  c1.AddElement("2023-06-01 18:12:11")
		  c1.AddElement("2022-08-12")
		  
		  c2.AddElement("2021-06-01")
		  c2.AddElement("2020-08-01")
		  
		  var c3 as clIntegerDataSerie = c1 - c2
		  
		  var c4 as clIntegerDataSerie = c1.ToYearInteger()
		  
		  var c5 as clStringDataSerie = c1.ToYearMonthString()
		  
		  var c6 as clIntegerDataSerie = c1.ToDayInteger()
		  
		  var c7 as clStringDataSerie = c1.ToString("yyyy-MM")
		  
		  var c8  as clStringDataSerie = c1.ToYearString()
		  
		  var d4 as clIntegerDataSerie = c1.ToDayOfWeekInteger()
		  
		  var d5 as clIntegerDataSerie = c1.ToDayOfWeekInteger(True)
		  
		  var expected_c3 as new clIntegerDataSerie("premier-second", 730, 741)
		  
		  var expected_c4 as new clIntegerDataSerie("Year of premier", 2023, 2022)
		  
		  var expected_c5 as new clStringDataSerie("Year Month of premier", "2023-06","2022-08")
		  
		  var expected_c6 as new clIntegerDataSerie("Day of premier", 1, 12)
		  
		  var expected_c7 as new clStringDataSerie("premier as yyyy-MM", "2023-06","2022-08")
		  
		  var expected_c8 as new clStringDataSerie("Year of premier", "2023", "2022")
		  
		  var expected_d4 as new clIntegerDataSerie("Day of week of premier", 5, 6)
		  
		  var expected_d5 as new clIntegerDataSerie("Day of week of premier", 4,5)
		  
		  call check_serie(log, "c3", expected_c3, c3)
		  call check_serie(log, "c4", expected_c4, c4)
		  call check_serie(log, "c5", expected_c5, c5)
		  call check_serie(log, "c6", expected_c6, c6)
		  call check_serie(log, "c7", expected_c7, c7)
		  call check_serie(log, "c8", expected_c8,c8)
		  
		  
		  call check_serie(log, "d4",expected_d4, d4)
		  call check_serie(log, "d5",expected_d5, d5)
		  
		  
		  
		  
		  log.end_exec(CurrentMethodName)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_calc_020(log as LogMessageInterface)
		  
		  log.StartTask(CurrentMethodName)
		  
		  var c1 As New clDateTimeDataSerie("premier") 
		  var c2 As New clDateTimeDataSerie("second") 
		  
		  // The time part must be used since we use a DateTimeDataSerie
		  c1.AddElement("2023-06-01")
		  c1.AddElement("2022-08-12")
		  c1.AddElement("2024-06-12 22:51:33")
		  
		  c2.AddElement("2021-06-01")
		  c2.AddElement("2020-08-01")
		  c2.AddElement("2024-06-12 22:52:31")
		  
		  var c3 as clIntegerDataSerie = c1 - c2
		  
		  var c4 as clIntegerDataSerie = c1.ToYearInteger()
		  
		  var c5 as clStringDataSerie = c1.ToYearMonthString()
		  
		  var c6 as clIntegerDataSerie = c1.ToDayInteger()
		  
		  var c7 as clStringDataSerie = c1.ToString("yyyy-MM")
		  
		  var c8  as clStringDataSerie = c1.ToYearString()
		  
		  var c9 as clStringDataSerie = c1.ToHourMinuteString()
		  
		  var d1 as clIntegerDataSerie = c1.ToHourInteger()
		  
		  var d2 as clIntegerDataSerie = c1.ToMinuteInteger()
		  
		  var d3 as clIntegerDataSerie = c1.ToSecondInteger()
		  
		  var d4 as clIntegerDataSerie = c1.ToDayOfWeekInteger()
		  
		  var d5 as clIntegerDataSerie = c1.ToDayOfWeekInteger(True)
		  
		  // Differences in seconds
		  var expected_c3 as new clIntegerDataSerie("premier-second", 63072000, 64022400, -58)
		  
		  var expected_c4 as new clIntegerDataSerie("Year of premier", 2023, 2022, 2024)
		  
		  var expected_c5 as new clStringDataSerie("Year Month of premier", "2023-06","2022-08", "2024-06")
		  
		  var expected_c6 as new clIntegerDataSerie("Day of premier", 1, 12, 12)
		  
		  var expected_c7 as new clStringDataSerie("premier as yyyy-MM", "2023-06","2022-08", "2024-06")
		  
		  var expected_c8 as new clStringDataSerie("Year of premier", "2023", "2022", "2024")
		  
		  var expected_c9  as new clStringDataSerie("Hour minute of premier", "00:00","00:00","22:51")
		  
		  var expected_d1 as new clIntegerDataSerie("Hour of premier", 0,0, 22)
		  
		  var expected_d2 as new clIntegerDataSerie("Minute of premier", 0,0, 51)
		  
		  var expected_d3 as new clIntegerDataSerie("Second of premier", 0,0,33)
		  
		  var expected_d4 as new clIntegerDataSerie("Day of week of premier", 5, 6, 4)
		  
		  var expected_d5 as new clIntegerDataSerie("Day of week of premier", 4,5,3)
		  
		  
		  call check_serie(log, "c3", expected_c3, c3)
		  call check_serie(log, "c4", expected_c4, c4)
		  call check_serie(log, "c5", expected_c5, c5)
		  call check_serie(log, "c6", expected_c6, c6)
		  call check_serie(log, "c7", expected_c7, c7)
		  call check_serie(log, "c8", expected_c8,c8)
		  call check_serie(log, "c9", expected_c9, c9)
		  call check_serie(log, "d1",expected_d1, d1)
		  call check_serie(log, "d2",expected_d2, d2)
		  call check_serie(log, "d3",expected_d3, d3)
		  
		  call check_serie(log, "d4",expected_d4, d4)
		  call check_serie(log, "d5",expected_d5, d5)
		  
		  
		  
		  log.end_exec(CurrentMethodName)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_calc_021(log as LogMessageInterface)
		  
		  // parsing tests
		  log.StartTask(CurrentMethodName)
		  
		  var c1 as new clStringDataSerie("Alpha")
		  
		  var baselist() as string = array("123", "1,234","1.234", "1,234,567")
		  
		  for each base as string in baselist
		    c1.AddElement(base)
		    c1.AddElement(base+"-")
		    c1.AddElement(base+"+")
		    c1.AddElement("-"+base)
		    c1.AddElement("+"+base)
		    
		  next
		  
		  c1.SetIntegerParser(new clIntegerParser)
		  var c2 as clIntegerDataSerie = c1.ToInteger()
		  var expected_c2 as  new clIntegerDataSerie("Alpha as integer", array(123, -123, 123, -123, 123, 1234, -1234,1234,-1234,1234, 0,0,0,0,0,1234567,-1234567,1234567,-1234567,1234567))
		  
		  c1.SetIntegerParser(new clIntegerLocalParser)
		  var c3 as clIntegerDataSerie = c1.ToInteger()
		  var expected_c3 as new clIntegerDataSerie("Alpha as integer", array(123, -123, 123, -123, 123, 0,0,0,0,0, 1234, -1234,1234,-1234,1234, 0,0,0,0,0))
		  
		  
		  call check_serie(log, "c2", expected_c2, c2)
		  call check_serie(log, "c3", expected_c3, c3)
		  
		  log.end_exec(CurrentMethodName)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_calc_022(log as LogMessageInterface)
		  
		  // parsing tests
		  log.StartTask(CurrentMethodName)
		  
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
		  var expected_c2 as  new clNumberDataSerie("Alpha as number", array(0.123, -0.123, 0.123, -0.123, 0.123, 123.0, -123.0, 123.0, -123.0, 123.0, 12.3, -12.3, 12.3, -12.3, 12.3, 123.4, -123.4,123.4,-123.4,123.4, 0,0,0,0,0,123456.7,-123456.7,123456.7,-123456.7,123456.7))
		  
		  c1.SetNumberParser(new clNumberLocalParser)
		  var c3 as clNumberDataSerie = c1.ToNumber()
		  
		  var rr() as string
		  for each item as Double in c3.GetElements
		    rr.add(str(item, "#####.0####"))
		  next
		  System.DebugLog(join(rr, ", "))
		  
		  var expected_c3 as new clNumberDataSerie("Alpha as number", array(123.0, -123.0, 123.0, -123.0, 123.0, 123.0, -123.0, 123.0, -123.0, 123.0, 123.0, -123.0, 123.0, -123.0, 123.0, 0.0, 0.0, 0.0, 0.0, 0.0, 123.4, -123.4, 123.4, -123.4, 123.4, 0.0, 0.0, 0.0, 0.0, 0.0))
		  
		  call check_serie(log, "c2", expected_c2, c2)
		  call check_serie(log, "c3", expected_c3, c3)
		  
		  log.end_exec(CurrentMethodName)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_calc_023(log as LogMessageInterface)
		  
		  log.StartTask(CurrentMethodName)
		  
		  var test0, test1, test2, test3  As clCurrencyDataSerie
		  var expected, delta as clCurrencyDataSerie
		  
		  test1 = New clCurrencyDataSerie("test1")
		  
		  test1.AddElement(124)
		  test1.AddElement(456)
		  
		  test2 = new clCurrencyDataSerie("test2")
		  test2.AddElement(12)
		  test2.AddElement(24)
		  test2.AddElement(10)
		  
		  test3 = new clCurrencyDataSerie("test3")
		  test3.AddElement(100)
		  test3.AddElement(300)
		  test3.AddElement(6)
		  
		  test0 = (test1 + test2 - test3 + 1000) * 0.5
		  
		  expected = new clCurrencyDataSerie("expected")
		  expected.AddElement(518)
		  expected.AddElement(590)
		  expected.AddElement(502)
		  
		  delta = test0 - expected
		  
		  call check_value(log,"sum of diff", 0, delta.sum)
		  
		  log.end_exec(CurrentMethodName)
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_calc_024(log as LogMessageInterface)
		  
		  log.StartTask(CurrentMethodName)
		  
		  var test0, test1, test2, test3  As clCurrencyDataSerie
		  var expected, delta as clCurrencyDataSerie
		  
		  test1 = New clCurrencyDataSerie("test1")
		  
		  test1.AddElement(124)
		  test1.AddElement(456)
		  
		  test2 = new clCurrencyDataSerie("test2")
		  test2.AddElement(12)
		  test2.AddElement(24)
		  test2.AddElement(10)
		  
		  test3 = new clCurrencyDataSerie("test3")
		  test3.AddElement(100)
		  test3.AddElement(300)
		  test3.AddElement(6)
		  
		  test0 = (test1 + test2 - test3 + 1000) * 0.5
		  
		  expected = new clCurrencyDataSerie("expected")
		  expected.AddElement(518)
		  expected.AddElement(590)
		  expected.AddElement(502)
		  
		  delta = test0 - expected
		  
		  call check_value(log,"sum of diff", 0, delta.sum)
		  
		  log.end_exec(CurrentMethodName)
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_calc_025(log as LogMessageInterface)
		  
		  // parsing tests
		  log.StartTask(CurrentMethodName)
		  
		  var c1 as new clStringDataSerie("Alpha")
		  
		  var baselist() as string = array(".123","123", "12.3", "1,23.4","1.23,4", "1,234,56.7")
		  
		  for each base as string in baselist
		    c1.AddElement(base)
		    c1.AddElement(base+"-")
		    c1.AddElement(base+"+")
		    c1.AddElement("-"+base)
		    c1.AddElement("+"+base)
		    
		  next
		  
		  c1.SetParser(new clCurrencyParser)
		  var c2 as clCurrencyDataSerie = c1.ToCurrency()
		  var expected_c2 as  new clCurrencyDataSerie("Alpha as currency", array(0.123, -0.123, 0.123, -0.123, 0.123, 123.0, -123.0, 123.0, -123.0, 123.0, 12.3, -12.3, 12.3, -12.3, 12.3, 123.4, -123.4,123.4,-123.4,123.4, 0,0,0,0,0,123456.7,-123456.7,123456.7,-123456.7,123456.7))
		  
		  call check_serie(log, "c2", expected_c2, c2)
		  
		  log.end_exec(CurrentMethodName)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_calc_026(log as LogMessageInterface)
		  
		  // parsing tests
		  log.StartTask(CurrentMethodName)
		  
		  var cNumber as new clNumberDataSerie("MyNumber", array(123.0,456.0,781.0))
		  var cCurrency as new clCurrencyDataSerie("MyCurrency",array(123.0,456.0,781.0))
		  
		  var cNumberDiv as clNumberDataSerie = cNumber / 3
		  var cCurrencyDiv as clCurrencyDataSerie = cCurrency / 3
		  
		  var cNumberDivExpected as new clNumberDataSerie("MyNumber/3", array(41,152,260.3333333))
		  var cCurrencyDivExpected as new clCurrencyDataSerie ("MyCurrency/3",array(41,152,260.3333))
		  
		  call check_serie(log, "Number", cNumberDivExpected, cNumberDiv)
		  call check_serie(log, "Currency", cCurrencyDivExpected, cCurrencyDiv)
		  
		  log.end_exec(CurrentMethodName)
		  
		  return
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_calc_027(log as LogMessageInterface)
		  
		  // parsing tests
		  log.StartTask(CurrentMethodName)
		  
		  var cNumber as new clNumberDataSerie("MyNumber", array(123.0,456.0,0.1111 ))
		  var cCurrency as new clCurrencyDataSerie("MyCurrency",array(123.0,456.0,0.1111 ))
		  
		  var cNumberDiv as clNumberDataSerie = cNumber / 2
		  var cCurrencyDiv as clCurrencyDataSerie = cCurrency / 2
		  
		  var cNumberDivExpected as new clNumberDataSerie("MyNumber/2", array(61.5,228.0,0.05555555))
		  var cCurrencyDivExpected as new clCurrencyDataSerie ("MyCurrency/2",array(61.5,228.0, 0.0556))
		  
		  call check_serie(log, "Number", cNumberDivExpected, cNumberDiv)
		  call check_serie(log, "Currency", cCurrencyDivExpected, cCurrencyDiv)
		  
		  log.end_exec(CurrentMethodName)
		  return
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_calc_028(log as LogMessageInterface)
		  
		  // parsing tests using locale
		  log.StartTask(CurrentMethodName)
		  
		  var c1 as new clStringDataSerie("Alpha")
		  
		  var baselist() as string = array(".123","123", "12.3", "1,23.4","1.23,4", "1,234,56.7")
		  
		  for each base as string in baselist
		    c1.AddElement(base)
		    c1.AddElement(base+"-")
		    c1.AddElement(base+"+")
		    c1.AddElement("-"+base)
		    c1.AddElement("+"+base)
		    
		  next
		  
		  c1.SetParser(new clCurrencyLocalParser)
		  var c3 as clCurrencyDataSerie = c1.ToCurrency()
		  
		  var rr() as string
		  for each item as Double in c3.GetElements
		    rr.add(str(item, "#####.0####"))
		  next
		  System.DebugLog(join(rr, ", "))
		  
		  var expected_c3 as new clCurrencyDataSerie("Alpha as currency", array(123.0, -123.0, 123.0, -123.0, 123.0, 123.0, -123.0, 123.0, -123.0, 123.0, 123.0, -123.0, 123.0, -123.0, 123.0, 0.0, 0.0, 0.0, 0.0, 0.0, 123.4, -123.4, 123.4, -123.4, 123.4, 0.0, 0.0, 0.0, 0.0, 0.0))
		  
		  call check_serie(log, "c3", expected_c3, c3)
		  
		  log.end_exec(CurrentMethodName)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_io_001(log as LogMessageInterface)
		  
		  log.StartTask(CurrentMethodName)
		  
		  var k As Variant
		  
		  var main_folder As  FolderItem = GetTestBaseFolder()
		  var fld_file As FolderItem
		  
		  fld_file = main_folder.Child("myfile3_10K_tab.txt")
		  
		  var ss1 As  clDataSerie = clDataSerie(AppendTextfileToDataSerie(fld_file, new clDataSerie(""), true))
		  
		  var k2 As Integer = 1
		  
		  
		  log.end_exec(CurrentMethodName)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_io_005(log as LogMessageInterface)
		  
		  log.StartTask(CurrentMethodName)
		  
		  
		  var k As Variant
		  
		  var main_folder As  FolderItem = GetTestBaseFolder()
		  
		  var fld_file_in As FolderItem
		  var fld_file_out As FolderItem
		  
		  fld_file_in = main_folder.Child("myfile3_10K_tab.txt")
		  
		  fld_file_out =  main_folder.Child("mytest.txt")
		  
		  
		  var ss1 As  clDataSerie = clDataSerie(AppendTextfileToDataSerie(fld_file_in, new clDataSerie(""), true))
		  
		  SaveDataSerieToTextfile(fld_file_out, ss1, True)
		  
		  
		  
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
