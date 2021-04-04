#tag Module
Protected Module clDataTable_tests
	#tag Method, Flags = &h1
		Protected Sub test_001()
		  
		  System.DebugLog("START test_001")
		  
		  Dim rtst As clDataRow
		  
		  Dim ttst As New clDataTable("T1")
		  
		  rtst = New clDataRow
		  rtst.set_cell("aaa",1234)
		  rtst.set_cell("bbb","abcd")
		  rtst.set_cell("ccc",123.456)
		  
		  ttst.append_row(rtst)
		  
		  rtst = New clDataRow
		  rtst.set_cell("aaa",1235)
		  rtst.set_cell("bbb","abce")
		  rtst.set_cell("ddd",987.654)
		  
		  ttst.append_row(rtst)
		  
		  ttst.debug_dump
		  
		  Dim k As Integer = 1
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub test_002()
		  
		  System.DebugLog("START test_002")
		  
		  Dim rtst As clDataRow
		  
		  Dim ttst1 As New clDataTable("T1")
		  
		  rtst = New clDataRow
		  rtst.set_cell("aaa",1234)
		  rtst.set_cell("bbb","abcd")
		  rtst.set_cell("ccc",123.456)
		  
		  ttst1.append_row(rtst)
		  
		  rtst = New clDataRow
		  rtst.set_cell("aaa",1235)
		  rtst.set_cell("bbb","abce")
		  rtst.set_cell("ddd",987.654)
		  
		  ttst1.append_row(rtst)
		  
		  ttst1.debug_dump
		  
		  
		  Dim ttst2 As New clDataTable("T2")
		  
		  rtst = New clDataRow
		  rtst.set_cell("aaa",81234)
		  rtst.set_cell("bbb","zabcd")
		  rtst.set_cell("zccc",8123.456)
		  
		  ttst2.append_row(rtst)
		  
		  rtst = New clDataRow
		  rtst.set_cell("aaa",81235)
		  rtst.set_cell("bbb","zabce")
		  rtst.set_cell("zddd",8987.654)
		  
		  ttst2.append_row(rtst)
		  
		  ttst2.debug_dump
		  
		  ttst1.append_table(ttst2)
		  ttst1.debug_dump
		  
		  Dim ttst3 As clDataTable = ttst1.select_columns(Array("aaa","zccc"))
		  ttst3.debug_dump
		  
		  Dim k As Integer = 1
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub test_003()
		  
		  Dim rtst As clDataRow
		  
		  Dim ttst1 As New clDataTable("T1")
		  
		  System.DebugLog("START test_003")
		  
		  rtst = New clDataRow
		  rtst.set_cell("aaa",1234)
		  rtst.set_cell("bbb","abcd")
		  rtst.set_cell("ccc",123.456)
		  
		  ttst1.append_row(rtst)
		  
		  rtst = New clDataRow
		  rtst.set_cell("aaa",1235)
		  rtst.set_cell("bbb","abce")
		  rtst.set_cell("ddd",987.654)
		  
		  ttst1.append_row(rtst)
		  
		  ttst1.debug_dump
		  
		  Dim k As Integer = 1
		  
		  Dim my_col As clDataSerie
		  Dim ttst3 As clDataTable = ttst1.select_columns(Array("aaa","zccc"))
		  ttst3.debug_dump
		  
		  my_col = ttst3.add_column("xyz")
		  
		  ttst3.debug_dump
		  
		  
		  ttst1.debug_dump
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_004()
		  Dim k As Variant
		  
		  Dim fld_folder As New FolderItem
		  Dim fld_file1 As FolderItem
		  Dim fld_file2 As FolderItem
		  Dim fld_file3 As FolderItem
		  
		  fld_folder = fld_folder.Child("test-data")
		  
		  fld_file1 = fld_folder.Child("myfile3_10K_tab.txt")
		  fld_file2  = fld_folder.Child("myfile3_10K_comma.txt")
		  fld_file3  = fld_folder.Child("myfile3_10K_output.txt")
		  
		  Dim ttst3 As New clDataTable("x")
		  
		  ttst3.load_from_text(fld_file1, New clRowParser_full(Chr(9)), True)
		  
		  Dim ttst4 As New clDataTable("x")
		  
		  ttst4.load_from_text(fld_file2, New clRowParser_full(","), True)
		  
		  
		  ttst4.save_as_text(fld_file3, New clRowParser_full(";"), True)
		  
		  Dim k2 As Integer=1
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_005()
		  System.DebugLog("START test_001")
		  
		  Dim rtst As clDataRow
		  
		  Dim ttst As New clDataTable("T1")
		  
		  rtst = New clDataRow
		  rtst.set_cell("aaa",1234)
		  rtst.set_cell("bbb","abcd")
		  rtst.set_cell("ccc",123.456)
		  
		  ttst.append_row(rtst)
		  
		  rtst = New clDataRow
		  rtst.set_cell("aaa",1235)
		  rtst.set_cell("bbb","abce")
		  rtst.set_cell("ddd",987.654)
		  
		  ttst.append_row(rtst)
		  
		  ttst.debug_dump
		  
		  
		  Dim cols() As clDataSerie
		  
		  cols = ttst.get_columns("aaa","bbb","ddd")
		  
		  cols(1).rename("bB1")
		  
		  
		  
		  
		  Dim k As Integer = 1
		  
		  
		End Sub
	#tag EndMethod


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
	#tag EndViewBehavior
End Module
#tag EndModule
