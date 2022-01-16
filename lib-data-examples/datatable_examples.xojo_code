#tag Module
Protected Module datatable_examples
	#tag Method, Flags = &h0
		Sub example_001()
		  
		  dim wnd as  window2
		  
		  '
		  ' Create a table
		  '
		  dim sales as new clDataTable("Sales")
		  
		  call sales.add_column(new clDataSerie("country", "France","France"))
		  call sales.add_column(new clDataSerie("city","Paris","Marseille"))
		  call sales.add_column(new clDataSerie("net_sales", 6543, 87654))
		  call sales.add_column(new clDataSerie("costs", 1955, 43221))
		  
		  wnd = new window2
		  wnd.set_datatable sales
		  wnd.ShowModal
		  
		  '
		  ' Create a view on the table
		  '
		  dim sales_sub as clDataTable = sales.select_columns("city","net_sales","costs")
		  
		  wnd = new window2
		  wnd.set_datatable sales_sub, "setup"
		  wnd.ShowModal
		  
		  '
		  ' Add a new row to physical table
		  '
		  dim dr as new clDataRow
		  dr.set_cell("city","Brussels")
		  dr.set_cell("net_sales", 67645)
		  dr.set_cell("costs", 46221)
		  sales.append_row(dr)
		  
		  wnd = new window2
		  wnd.set_datatable sales_sub, "add row"
		  wnd.ShowModal
		  
		  
		  '
		  ' Add a physical column to the view
		  '
		  sales_sub.allow_local_columns = true
		  
		  dim temp() as variant
		  
		  dim net_sales as clAbstractDataSerie =  sales_sub.get_column("net_sales")
		  dim costs as clAbstractDataSerie = sales_sub.get_column("costs")
		  
		  for k as integer = 0 to net_sales.row_count()-1
		    temp.append(net_sales.get_element_as_number(k) - costs.get_element_as_number(k) )
		  next
		  
		  call sales_sub.add_column(new clDataSerie("margin", temp))
		  
		  wnd = new window2
		  wnd.set_datatable sales_sub, "Add column"
		  wnd.ShowModal
		  
		  dr = new clDataRow
		  dr.set_cell("country","Belgium")
		  dr.set_cell("city","Namur")
		  dr.set_cell("net_sales", 37645)
		  dr.set_cell("costs", 22222)
		  sales.append_row(dr)
		  
		  
		  wnd = new window2
		  wnd.set_datatable sales_sub,"Add row to physical table"
		  wnd.ShowModal
		  
		  dim sales_sub2 as clDataTable = sales_sub.clone(True)
		  
		  wnd = new window2
		  wnd.set_datatable sales_sub2, "Clone+preserve"
		  wnd.ShowModal
		  
		  sales_sub2 = sales_sub.clone(False)
		  
		  wnd = new window2
		  wnd.set_datatable sales_sub2,"Clone+clone"
		  wnd.ShowModal
		  
		  
		  
		  
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
