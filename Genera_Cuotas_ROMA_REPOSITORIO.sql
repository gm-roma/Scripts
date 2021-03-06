/*************************************** INICIO GENERA CUOTA *************************************/
	USE ROMA_REPOSITORIO;
	Declare @Periodo Char(6) = 202207, @Fl_Actualizar_CuotasGenerales Bit = 0

	Drop Table If Exists #OSLP 
	Drop Table If Exists #CuotasNew
	Drop Table If Exists #Ven
	Drop Table If Exists #XrelfamcatgrupoX
	Drop Table If Exists #Cuotas
	Drop Table If Exists #Data
	Drop Table If Exists #Data2
	Drop Table If Exists #Cuotas_Full
	Drop Table If Exists #Fact_Ventas
	Drop Table If Exists #Fact_Cuotas
	Drop Table If Exists #Fact_Ventas2
	Drop Table If Exists #Fact_Ventas3
	Drop Table If Exists #Ica
	Drop Table If Exists #FactorVTA
	Drop Table If Exists #Result
	Drop Table If Exists #FactorCob
	Drop Table If Exists #Categorias_xMesas
	Drop Table If Exists #TmpFact_Ventas
	Drop Table If Exists #CarteraInicial
	Drop Table If Exists #tmpBase

	Create Table #Cuotas (CodPrv Varchar(20), CodCat Char(3), CodCanal Char(2), CodSede Char(2), CuotaTot Decimal(18,2))
		
	Declare @Version Smallint
	If Not Exists(Select * From Carga.T_Cuotas_Generales Where Periodo = @Periodo)
		Or @Fl_Actualizar_CuotasGenerales = 1
	Begin		
		Select @Version = IsNull(Max(Version), 0)+1 From Carga.T_Cuotas_Generales
		Where Periodo = @Periodo

		Insert Into Carga.T_Cuotas_Generales(Periodo, Version, CodPrv, CodCat, CodCan, Proveedor, CatJes, Categoria, Canal,
		AY, AP, AV, CN, CH, PS, IC, NZ, AN)
		Select @Periodo Periodo, @Version Version, CodPrv, CodCat, CodCanal, Proveedor, CatJes, NomCat Categoria, Canal, 
		AY, AP, AV, CN, CH, PS, IC, NZ, AN 			
		From Temp.CuotaGeneral_Full	
	End	

	;With dt As (Select Max(Version) Version From Carga.T_Cuotas_Generales Where Periodo = @Periodo)
	Select * 
	Into #Ica
	-- Select *
	From Carga.T_Cuotas_Generales
	Where Periodo = @Periodo And Version In (Select Version From dt)	

	--select * from Carga.T_Cuotas_Generales	where Version = 3 and periodo = 202207

	Insert Into #Cuotas 
	Select CodPrv, CodCat, CodCan CodCanal, 'CN' CodSede, CN From #Ica --Where IsNull(CN, 0) > 0
	Union All
	Select CodPrv, CodCat, CodCan CodCanal, 'CH' CodSede, CH From #Ica --Where IsNull(CH, 0)  > 0
	Union All
	Select CodPrv, CodCat, CodCan CodCanal, 'PS' CodSede, PS From #Ica --Where IsNull(PS, 0) > 0
	Union All
	Select CodPrv, CodCat, CodCan CodCanal, 'IC' CodSede, IC From #Ica --Where IsNull(IC, 0) > 0
	Union All
	Select CodPrv, CodCat, CodCan CodCanal, 'NZ' CodSede, NZ From #Ica --Where IsNull(NZ, 0) > 0
	Union All
	Select CodPrv, CodCat, CodCan CodCanal, 'AY' CodSede, AY From #Ica --Where IsNull(AY, 0) > 0
	Union All
	Select CodPrv, CodCat, CodCan CodCanal, 'AP' CodSede, AP From #Ica --Where IsNull(AP, 0) > 0
	Union All
	Select CodPrv, CodCat, CodCan CodCanal, 'AV' CodSede, AV From #Ica --Where IsNull(AV, 0) > 0
	Union All
	Select CodPrv, CodCat, CodCan CodCanal, 'AN' CodSede, AN From #Ica --Where IsNull(AN, 0) > 0

	-- Drop Table #Categorias_xMesas
	Select Distinct a.*, b.IdMesa, c.IdPrv, c.IdCat_xPrv 
	Into #Categorias_xMesas
	-- Select *
	From Temp.Categorias_xMesas a
	Inner Join ROMA_DATAMART.ventas.DimMesas b On a.[Cod Mesa]= b.CodMesa
	Inner Join ROMA_DATAMART.ventas.vw_Dim_Categorias_xProveedor c On a.[Cod Prv] = c.CodPrv And a.[Cod Cat] = c.CodCat

	--Select * From #Categorias_xMesas Where idprv = 147
	
	Select * Into #OSLP From SrvSAP.Roma_Productiva.dbo.OSLP

	Select Distinct SlpCode CodVen, SlpName NomVen, U_BKS_CodCart CodCar, U_BKS_Mesa CodMesa, 
	U_BKS_CodSed CodSede, U_BKS_CODSUP CodSup, U_BKP_GRUPO CodCan, U_BKS_CodSed CodSedeNew
	Into #Ven
	From #OSLP 
	Where U_BKS_ESTATUS = 'A'

	   
	Insert Into #Ven
	Select Distinct CodVen, NomVen, CodCar, CodMesa, CodSede, CodSup, '01' CodCan, CodSedeNew 
	From #Ven Where codven = 1821
	
	Insert Into #Ven
	Select Distinct CodVen, NomVen, CodCar, CodMesa, 'AN' CodSede, CodSup, '07' CodCan, 'AN' CodSedeNew 
	From #Ven Where codven = 1593
	
	Insert Into #Ven
	Select Distinct CodVen, NomVen, CodCar, CodMesa, 'PS' CodSede, CodSup, '07' CodCan, 'PS' CodSedeNew 
	From #Ven Where codven = 72

	Insert Into #Ven
	Select Distinct CodVen, NomVen, CodCar, CodMesa, 'CN' CodSede, CodSup, '07' CodCan, 'CN' CodSedeNew 
	From #Ven Where codven = 72
	
	Insert Into #Ven
	Select Distinct CodVen, NomVen, CodCar, CodMesa, 'NZ' CodSede, CodSup, '07' CodCan, 'NZ' CodSedeNew 
	From #Ven Where codven = 1201
	
	Insert Into #Ven
	Select Distinct CodVen, NomVen, CodCar, CodMesa, 'AP' CodSede, CodSup, '02' CodCan, 'AP' CodSedeNew 
	From #Ven Where codven = 2290

	Insert Into #Ven
	Select Distinct CodVen, NomVen, CodCar, CodMesa, 'AV' CodSede, CodSup, '01' CodCan, 'AV' CodSedeNew 
	From #Ven Where codven = 1737

	--Select * From #Ven Where codven in (1821, 1983)

	Select Distinct a.*, codmesa, CodVen, CodCar
	Into #CuotasNew
	From #Cuotas a 
	Inner Join (Select Distinct CodVen, CodMesa, CodSedeNew, CodCan, CodCar From #Ven) b 
	On a.codsede = b.codsedenew Collate SQL_Latin1_General_CP1_CI_AS
	And a.codcanal = b.codcan Collate SQL_Latin1_General_CP1_CI_AS 
	Where cuotatot > 0
	

	Select Distinct a.*, b.IdPrv, cm.IdCat_xPrv, IdSede, IdCan, cm.IdMesa
	Into #Cuotas_Full
	-- Select *
	From #CuotasNew a
	Inner Join ROMA_DATAMART.Ventas.DimProveedores b On a.CodPrv = b.CodPrv
	Inner Join ROMA_DATAMART.Ventas.Dim_Categorias_xProveedor c On b.IdPrv = c.IdPrv And a.CodCat = c.CodCat
	Inner Join ROMA_DATAMART.Ventas.Dim_vw_Canales d On a.CodCanal = d.CodCan Collate SQL_Latin1_General_CP1_CI_AS
	Inner Join ROMA_DATAMART.Ventas.DimSedes e On a.CodSede = e.CodSede
	Inner Join ROMA_DATAMART.Ventas.DimMesas f On a.CodMesa Collate SQL_Latin1_General_CP1_CI_AS = f.CodMesa
	Inner Join #Categorias_xMesas cm On a.codmesa Collate SQL_Latin1_General_CP1_CI_AS = cm.[cod mesa] 
	And a.codprv Collate SQL_Latin1_General_CP1_CI_AS = cm.[cod prv] 
	And a.codcat Collate SQL_Latin1_General_CP1_CI_AS = cm.[cod cat]
	Where CuotaTot > 0 

	;With dt As (Select a.Periodo, FactorCob, a.Origen, a.CodCat, a.CodPrv 
				From temp.Factor_dCob a
				Where Periodo = @Periodo And FactorCob > 0)
	Select CodPrv, CodCat, 
	Max(Case When Origen = 'Minorista' Then FactorCob Else 0 End) fMin,
	Max(Case When Origen = 'Mayorista' Then FactorCob Else 0 End) fMay
	Into #FactorCob
	From dt
	Group By CodPrv, CodCat

	--Drop Table If Exists #Fact_Ventas
	Select Distinct a.* 
	Into #Fact_Ventas
	From ROMA_DATAMART.Planillas.Fact_Ventas a
	Inner Join ROMA_DATAMART.Ventas.DimClientes b On a.IdCliente = b.IdCli
	Where Left(FechaKey, 6) >= Convert(Char(6), DateAdd(Month,-6, Cast(@Periodo+'01' As Date)), 112)
			And Left(FechaKey, 6) <> @Periodo 
			And b.TiCliente <> 'EM' And IdCartera <> 0


	;With dtVen As (Select distinct IdVen, IdCan, a.u_bkp_grupo From #OSLP a	
				Inner Join ROMA_DATAMART.ventas.DimVendedores b On a.slpcode=b.CodVen
				Inner Join ROMA_DATAMART.ventas.Dim_vw_Canales c On a.u_bkp_grupo collate SQL_Latin1_General_CP1_CI_AS = c.CodCan)
	Select a.* 
	Into #TmpFact_Ventas
	--Select *
	From #Fact_Ventas a
	Inner Join dtVen b On a.IdVendedor = b.IdVen And a.IdCanal = b.IdCan
					
	Truncate Table #Fact_Ventas
	Insert Into #Fact_Ventas
	Select * From #TmpFact_Ventas

	Update #Fact_Ventas Set IdCanal = 7 Where IdCanal In (8,9) -- And IdProveedor = 7
	-- Lee las Carteras Iniciales
		
	Drop Table If Exists #CarteraInicialSAP
	Select * 
	Into #CarteraInicialSAP
	From SrvSAP.Roma_Productiva. Reportes.Registro_CarteraInicial Where Periodo = 202207

	Update #CarteraInicialSAP Set codsedenew = codsede

	Drop Table If Exists #CarteraTotal
	;With dt As (Select Distinct a.periodo, a.codmesa, a.codsedenew, a.codsede, a.codcanal, b.CodPrv, b.CodCat, a.codcar
				From #CarteraInicialSAP a
				Inner Join #Cuotas_Full b On a.codsedenew Collate SQL_Latin1_General_CP1_CI_AS = b.CodSede 
				And a.codcanal Collate SQL_Latin1_General_CP1_CI_AS = b.CodCanal 
				And a.codmesa = b.codmesa and a.codcar = b.CodCar
				Where CuotaTot > 0)
	Select a.*, b.IdMesa, c.IdSede, d.IdCan IdCanal, e.IdCartera, p.IdPrv, cp.IdCat_xPrv
	Into #CarteraTotal
	From dt a
	Inner Join ROMA_DATAMART.ventas.DimMesas b On a.codmesa Collate SQL_Latin1_General_CP1_CI_AS = b.CodMesa
	Inner Join ROMA_DATAMART.ventas.DimProveedores p On a.CodPrv Collate SQL_Latin1_General_CP1_CI_AS = p.CodPrv
	Inner Join ROMA_DATAMART.ventas.Dim_Categorias_xProveedor cp On p.IdPrv = cp.IdPrv 
		And a.CodCat Collate SQL_Latin1_General_CP1_CI_AS = cp.CodCat
	Inner Join ROMA_DATAMART.ventas.DimSedes c On a.codsedenew Collate SQL_Latin1_General_CP1_CI_AS = c.CodSede
	Inner Join ROMA_DATAMART.ventas.DimCanales d On a.codcanal Collate SQL_Latin1_General_CP1_CI_AS = d.CodCan
	Inner Join ROMA_DATAMART.ventas.DimCarterasNew e On a.codcar Collate SQL_Latin1_General_CP1_CI_AS = e.CodCartera

	Drop Table If Exists #tmpBase_Prev
	Select Distinct a.*, IdCartera, 0 OrdenVta, Convert(Decimal(18, 0), 0.0) VtaPrm, 0 Fl0, Convert(Decimal(18, 2), 0.00) Peso, 
	a.CodSede CodSedeSAP, Convert(Decimal(18, 0), 0.0) Cuota_xLinea, 
	Convert(Decimal(18, 0), 0.0) VtaMin, Convert(Decimal(18, 0), 0.0) VtaMax,
	Convert(Decimal(18, 0), 0.0) VtaMdn
	Into #tmpBase_Prev
	-- Select *
	From #Cuotas_Full a
	Inner Join #CarteraTotal b On a.IdPrv = b.IdPrv And a.IdCat_xPrv = b.IdCat_xPrv
	And a.IdSede = b.IdSede And a.IdCan = b.IdCanal	And a.idMesa = b.IdMesa And a.CodCar = b.codcar

	;With dt As (Select distinct * From #Categorias_xMesas)
	Select a.*, Cast(0.00 As Decimal(18, 2)) VtaPrm_Tot
	Into #tmpBase
	-- Select *
	From #tmpBase_Prev a
	Inner Join ROMA_DATAMART.ventas.DimMesas x On a.IdMesa = x.IdMesa		
	Inner Join dt b On a.CodPrv = b.[Cod Prv]  Collate SQL_Latin1_General_CP1_CI_AS			
	And x.CodMesa = b.[Cod Mesa] Collate SQL_Latin1_General_CP1_CI_AS And a.idmesa = b.idmesa
	And a.CodCat = b.[Cod Cat] Collate SQL_Latin1_General_CP1_CI_AS

							
	;With dt As (Select IdSede, IdMesa, IdCanal, IdProveedor, IdCat_xPrv, IdCartera, 
				Convert(Decimal(18,0), Avg(TotalIGV)) TotalIGV_AVG,
				Convert(Decimal(18,0), Min(TotalIGV)) TotalIGV_Min,
				Convert(Decimal(18,0), Max(TotalIGV)) TotalIGV_Max				
				From (Select Left(FechaKey, 6) Periodo, IdSede, IdMesa, IdCanal, IdProveedor, IdCat_xPrv, IdCartera, 
						Sum(TotalIGV) TotalIGV
						From #Fact_Ventas 
						Group By Left(FechaKey, 6), IdSede, IdMesa, IdCanal, IdProveedor, IdCat_xPrv, IdCartera
						Having Sum(TotalIGV) > 0) dt
				Group By IdSede, IdMesa, IdCanal, IdProveedor, IdCat_xPrv, IdCartera)
	Update a Set VtaPrm = TotalIGV_AVG, VtaMin = TotalIGV_Min, VtaMax = TotalIGV_Max
	-- Select * 
	From #tmpBase a
	Inner Join dt b On a.IdSede = b.IdSede And a.IdMesa = b.IdMesa And a.IdCan = b.IdCanal
	And a.IdPrv = b.IdProveedor And a.IdCat_xPrv = b.IdCat_xPrv And a.IdCartera = b.IdCartera
		--parada
	;With dt As (Select CodPrv, CodSede, IdMesa, CodCanal, CodCat, Min(VtaPrm) VtaPrm_Min 
				From #tmpBase 
				Where VtaPrm > 0
				Group By CodPrv, CodSede, IdMesa, CodCanal, CodCat)	
	Update a Set VtaPrm = VtaPrm_Min, fl0 = 1
	From #tmpBase a
	Inner Join dt b On a.CodPrv = b.CodPrv And a.CodSede = b.CodSede And a.IdMesa = b.IdMesa 
	And a.CodCanal = b.CodCanal And a.CodCat = b.CodCat 
	Where VtaPrm = 0
	   	 
	;With dt As (Select CodPrv, IdMesa, CodCanal, CodCat, Min(VtaPrm) VtaPrm_Min 
				From #tmpBase 
				Where VtaPrm > 0
				Group By CodPrv, IdMesa, CodCanal, CodCat)	
	Update a Set VtaPrm = VtaPrm_Min, fl0 = 2
	From #tmpBase a
	Inner Join dt b On a.CodPrv = b.CodPrv And a.IdMesa = b.IdMesa
	And a.CodCanal = b.CodCanal And a.CodCat = b.CodCat 
	Where VtaPrm = 0
	   
	;With dt As (Select CodPrv, CodSede, CodCanal, CodCat, Min(VtaPrm) VtaPrm_Min 
				From #tmpBase 
				Where VtaPrm > 0
				Group By CodPrv, CodSede, CodCanal, CodCat)	
	Update a Set VtaPrm = VtaPrm_Min, fl0 = 3
	From #tmpBase a
	Inner Join dt b On a.CodPrv = b.CodPrv And a.CodSede = b.CodSede
	And a.CodCanal = b.CodCanal And a.CodCat = b.CodCat 
	Where VtaPrm = 0

	;With dt As (Select CodPrv, b.Zona, CodCanal, CodCat, Min(VtaPrm) VtaPrm_Min 
				From #tmpBase a
				Inner Join ROMA_DATAMART.ventas.DimSedes b On a.IdSede = b.IdSede
				Where VtaPrm > 0
				Group By CodPrv, Zona, CodCanal, CodCat)		
	Update a Set VtaPrm = VtaPrm_Min, fl0 = 4
	From #tmpBase a
	Inner Join ROMA_DATAMART.ventas.DimSedes x On a.IdSede = x.IdSede
	Inner Join dt b On a.CodPrv = b.CodPrv And x.Zona = b.Zona
	And a.CodCanal = b.CodCanal And a.CodCat = b.CodCat 
	Where VtaPrm = 0

	--Select * From #cuotas_Full Where codprv Like '%0066' And Codsede = 'AV' And CodCat = '009'
	--Select * From #tmpBase Where codprv Like '%0066' And Codsede = 'IC' And CodCat = '033'

	Drop Table If Exists #tmpPrv  
	Create Table #tmpPrv (CodPrv Varchar(10))
	Insert Into #tmpPrv Values ('PM00000066')
	Insert Into #tmpPrv Values ('PM00000052')
	Insert Into #tmpPrv Values ('PM00000022')
	Insert Into #tmpPrv Values ('PM00000083')
	Insert Into #tmpPrv Values ('PM00000037')
	Insert Into #tmpPrv Values ('PM00000071')
	Insert Into #tmpPrv Values ('PM00000062')
	Insert Into #tmpPrv Values ('PM00000019')
	Insert Into #tmpPrv Values ('PM00000021')
	Insert Into #tmpPrv Values ('PM00000084')
	Insert Into #tmpPrv Values ('PM00000095')
	Insert Into #tmpPrv Values ('PM00000096')
	Insert Into #tmpPrv Values ('PM00000097')
	Insert Into #tmpPrv Values ('PM00000090')
	Insert Into #tmpPrv Values ('PM00000089')
	Insert Into #tmpPrv Values ('PM00000056')
	Insert Into #tmpPrv Values ('PM00000068')
	Insert Into #tmpPrv Values ('PM00000091')
		
--End

	;With dt As (Select CodSede, IdMesa, CodCanal, CodPrv, CodCat, Count(Distinct IdCartera) Qtd
				From #tmpBase 
				Where VtaPrm = 0					
				And CodPrv Not In (Select * From #tmpPrv)
				Group By CodSede, IdMesa, CodCanal, CodPrv, CodCat
				Having Count(Distinct IdCartera) = 1)
	Update a Set VtaPrm = 1, fl0 = 5
	From #tmpBase a
	Inner Join dt b On a.CodPrv = b.CodPrv And a.CodSede = b.CodSede
	And a.CodCanal = b.CodCanal And a.CodCat = b.CodCat 


--End

	Update #tmpBase Set VtaPrm = 1, Fl0 = 7 Where VtaPrm = 0 -- and CodMesa = '029'

	;With dt As (Select CodPrv, CodSede, CodCat, Min(VtaPrm) VtaPrm_Min, Avg(VtaPrm) VtaPrm_Avg  
				From #tmpBase 
				Where VtaPrm > 0
				Group By CodPrv, CodSede, CodCat)	
	Update a Set VtaPrm = VtaPrm_Min, fl0 = 6
	--Select *
	From #tmpBase a
	Inner Join dt b On a.CodPrv = b.CodPrv And a.CodSede = b.CodSede
	--And a.CodCanal = b.CodCanal 
	And a.CodCat = b.CodCat 
	Where CodMesa = '029' --And VtaPrm = 0

	Update a Set VtaPrm = B.VtaPrm
	--Select * 
	From #tmpBase a, (
	Select VtaPrm From #tmpBase Where CodCat = '029' And CodVen = 613) b
	Where a.CodCat = '029' And a.CodVen = 577
--End


	;With dt As (Select IdSede, IdMesa, IdCan, IdPrv, IdCat_xPrv, IdCartera, VtaPrm, 
				Sum(VtaPrm) Over(Partition By IdSede, IdMesa, IdCan, IdPrv, IdCat_xPrv) VtaPrm_Tot,
				ROW_NUMBER() Over(Partition By IdSede, IdMesa, IdCan, IdPrv, IdCat_xPrv Order By VtaPrm) Orden
				From #tmpBase
				Where CodPrv Not In (Select * From #tmpPrv))	
	Update a Set Peso = Convert(Decimal(18, 2), 1.00*a.VtaPrm/b.VtaPrm_Tot), OrdenVta = b.Orden, VtaPrm_Tot=b.VtaPrm_Tot
	From #tmpBase a
	Inner Join dt b On a.IdSede = b.IdSede And a.IdMesa = b.IdMesa And a.IdCan = b.IdCan 
	And a.IdPrv = b.IdPrv And a.IdCat_xPrv = b.IdCat_xPrv And a.IdCartera = b.IdCartera
	
	;With dt As (Select IdSede, IdCan, IdPrv, IdCat_xPrv, IdCartera, VtaPrm, 
				Sum(VtaPrm) Over(Partition By IdSede, IdCan, IdPrv, IdCat_xPrv) VtaPrm_Tot,
				ROW_NUMBER() Over(Partition By IdSede, IdCan, IdPrv, IdCat_xPrv Order By VtaPrm) Orden
				From #tmpBase
				Where CodPrv In (Select * From #tmpPrv) 
				--And IdCat_xPrv = 50 And IdMesa = 27
				--Order By IdMesa dESC
				)
	--Select *
	Update a Set Peso = Convert(Decimal(18, 2), 1.00*a.VtaPrm/b.VtaPrm_Tot), OrdenVta = b.Orden, VtaPrm_Tot=b.VtaPrm_Tot
	From #tmpBase a
	Inner Join dt b On a.IdSede = b.IdSede And a.IdCan = b.IdCan 
	And a.IdPrv = b.IdPrv And a.IdCat_xPrv = b.IdCat_xPrv And a.IdCartera = b.IdCartera
		
	update #tmpBase set peso = 0.15 where CodVen = 2093 and CodCat = 036
		
	--Update #tmpBase Set CodSedeSAP = 'AY' Where CodSede In ('AY', 'AV', 'AP')		

	;With dt As
	(Select *, peso - 1 Dif
		From (Select IdSede, CodSedeSAP, IdPrv, IdCan, IdCat_xPrv, IdMesa, Sum(Peso) Peso, Max(OrdenVta) OrdenMax
			From #tmpBase 
			Group By IdSede, CodSedeSAP, IdPrv, IdCan, IdCat_xPrv, IdMesa
			Having Sum(Peso) > 1.00) dt)
	Update a Set Peso = a.Peso - Dif
	--Select *
	From #tmpBase a
	Inner Join dt b On a.IdSede = b.IdSede And a.IdPrv = b.IdPrv And a.IdCan = b.IdCan 
	And a.IdMesa = b.IdMesa And a.IdCat_xPrv = b.IdCat_xPrv And a.OrdenVta = b.OrdenMax
	Where a.CodPrv Not In (Select * From #tmpPrv)

	;With dt As
	(Select *, peso - 1 Dif
			From (Select IdSede, CodSedeSAP, IdPrv, IdCan, IdCat_xPrv, Sum(Peso) Peso, Max(OrdenVta) OrdenMax
			From #tmpBase 
			Group By IdSede, CodSedeSAP, IdPrv, IdCan, IdCat_xPrv
			Having Sum(Peso) > 1.00) dt)
	Update a Set Peso = a.Peso - Dif
	From #tmpBase a
	Inner Join dt b On a.IdSede = b.IdSede And a.IdPrv = b.IdPrv And a.IdCan = b.IdCan 
	And a.IdCat_xPrv = b.IdCat_xPrv And a.OrdenVta = b.OrdenMax
	Where a.CodPrv In (Select * From #tmpPrv)


	;With dt As
	(Select *, 1 - peso Dif
			From (Select IdSede, CodSedeSAP, IdPrv, IdCan, IdCat_xPrv, IdMesa, Sum(Peso) Peso, Min(OrdenVta) OrdenMin
			From #tmpBase 
			Group By IdSede, CodSedeSAP, IdPrv, IdCan, IdCat_xPrv, IdMesa
			Having Sum(Peso) < 1.00) dt)
	Update a Set Peso = a.Peso + Dif
	From #tmpBase a
	Inner Join dt b On a.IdSede = b.IdSede And a.IdPrv = b.IdPrv And a.IdCan = b.IdCan 
	And a.IdMesa = b.IdMesa And a.IdCat_xPrv = b.IdCat_xPrv And a.OrdenVta = b.OrdenMin
	Where a.CodPrv Not In (Select * From #tmpPrv)

	--select * from #tmpbase where codprv = 'PM00000066' and codven = 1581
	;With dt As
	(Select *, 1 - peso Dif
		From (Select IdSede, CodSedeSAP, IdPrv, IdCan, IdCat_xPrv, Sum(Peso) Peso, Min(OrdenVta) OrdenMin
		From #tmpBase 
		Where CodPrv In (Select * From #tmpPrv)
		Group By IdSede, CodSedeSAP, IdPrv, IdCan, IdCat_xPrv
		Having Sum(Peso) < 1.00) dt)
	Update a Set Peso = a.Peso + Dif
	From #tmpBase a
	Inner Join dt b On a.IdSede = b.IdSede And a.IdPrv = b.IdPrv And a.IdCan = b.IdCan 
	And a.IdCat_xPrv = b.IdCat_xPrv And a.OrdenVta = b.OrdenMin
	Where a.CodPrv In (Select * From #tmpPrv)

	Update #tmpBase Set Cuota_xLinea = CuotaTot*Peso

	update #tmpBase set peso = 0.01 , Cuota_xLinea = 1 where codcat in(35,36,37,38,150) and peso <= 0
		
	Select a.*, b.CodCartera, c.slpcode Codven2, c.slpname NomVen, /*CodMesa, */p.NomPrvAbr, c.u_bks_codsup
	Into #Result
	-- Select Count(*)
	--Select *
	From #tmpBase a
	Inner Join ROMA_DATAMART.Ventas.DimCarterasNew b On a.IdCartera = b.IdCartera
	Inner Join ROMA_DATAMART.Ventas.DimMesas m On a.IdMesa = m.IdMesa
	Inner Join ROMA_DATAMART.Ventas.DimProveedores p On a.IdPrv = p.IdPrv
	Inner Join #OSLP c 
		On b.CodCartera = c.U_BKS_CodCart Collate SQL_Latin1_General_CP1_CI_AS 
		And m.CodMesa = c.u_bks_Mesa Collate SQL_Latin1_General_CP1_CI_AS 
	Where u_bks_estatus = 'A'
	

	Truncate Table Temp.tmp_mov_cuotas
	Insert Into Temp.tmp_mov_cuotas
	Select Distinct @Periodo periodo, CodSedeSAP sede, codven, nomven, codprv, 'FAM000' codfam, NomPrvAbr, Cuota_xLinea cuota, 
	Right('000'+Ltrim(CodCat), 3) codgrupo, 
	0 cuotamay, Peso FactorCuota, CuotaTot, CodSede, Null, CodCanal, CodMesa, u_bks_codsup
	-- Select *
	From #Result dt
	Where Cuota_xLinea>0 
	--select * from #result where codprv = 'PM00000027' and codven = 1581

	Update Temp.tmp_mov_cuotas Set codfam = 'DMA000' Where codprv Like '%000027' And codgrupo = '083'
	Update Temp.tmp_mov_cuotas Set codfam = 'DMF000' Where codprv Like '%000027' And codgrupo = '085'
	Update Temp.tmp_mov_cuotas Set codfam = 'DMP000' Where codprv Like '%000027' And codgrupo = '086'
	Update Temp.tmp_mov_cuotas Set codfam = 'DMS000' Where codprv Like '%000027' And codgrupo = '087'
	Update Temp.tmp_mov_cuotas Set codfam = 'DMB000' Where codprv Like '%000027' And codgrupo = '123'
	Update Temp.tmp_mov_cuotas Set codfam = 'DMU000' Where codprv Like '%000027' And codgrupo = '149'
	Update Temp.tmp_mov_cuotas Set codfam = 'DMN000' Where codprv Like '%000027' And codgrupo = '189'
	Update Temp.tmp_mov_cuotas Set codfam = 'DML000' Where codprv Like '%000027' And codgrupo = '190'
	Update Temp.tmp_mov_cuotas Set codfam = 'DME000' Where codprv Like '%000027' And codgrupo = '191'

	Update a Set FactorCobertura = (Case When a.CodPrv = 'PM00000066' And codmesa In ('009', '015', '019', '020') Then 0.25 Else 1 End)
											*(Case When grupovnd = '01' Then b.fMin Else b.fMay End)		
	-- Select *
	From temp.tmp_mov_cuotas a
	Inner Join #FactorCob b On a.codprv = b.CodPrv And a.codgrupo = b.CodCat





/*************************************** FIN GENERA CUOTA *************************************/

Select * From SrvSAP.Roma_Productiva.reportes.tmp_mov_cuotas

Insert Into SrvSAP.Roma_Productiva.reportes.tmp_mov_cuotas
Select periodo, sede, codven, nomven, codprv, codfam, nomprv, cuota, codgrupo, cuotamay, FactorCuota FactorVenta, 
CuotaTot Cuota_dVtaTot, CodSede CodSedeNew, FactorCobertura, GrupoVnd
-- Select *
From temp.tmp_mov_cuotas

/**********************************************************************************************/


Select *
From temp.tmp_mov_cuotas where codven = 1413

Select sum(cuota)
From temp.tmp_mov_cuotas WHERE codprv = 'PM00000097'

Select codprv, codgrupo, sum(cuota)
From temp.tmp_mov_cuotas where codprv = 'PM00000027'
group by codprv, codgrupo
order by codgrupo