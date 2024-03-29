CREATE TABLE [Ventas].[Fact_Digitacion] (
    [Id]              INT             IDENTITY (1, 1) NOT NULL,
    [ped_fecinicio]   DATETIME        NULL,
    [ped_fecfin]      DATETIME        NULL,
    [ped_fecregistro] DATETIME        NULL,
    [fec_pedido]      DATETIME        NULL,
    [IdCli]           INT             NULL,
    [IdPrd]           SMALLINT        NULL,
    [IdCartera]       SMALLINT        NULL,
    [IdVen]           SMALLINT        NULL,
    [Soles]           NUMERIC (38, 2) NULL,
    [UMES]            NUMERIC (38, 6) NULL,
    [Cartera]         SMALLINT        NULL,
    [PartitionMonth]  INT             NULL,
    [CliCodFull]      VARCHAR (20)    NULL,
    [CliCod]          VARCHAR (20)    NULL,
    [IdMesa]          SMALLINT        NULL,
    [IdSup]           SMALLINT        NULL,
    [IdSede]          SMALLINT        NULL,
    [IdCan]           SMALLINT        NULL,
    [PartitionDay]    INT             NULL,
    [Cantidad]        DECIMAL (18, 5) NULL,
    [FechaKey]        INT             NULL,
    [IdVen_Final]     SMALLINT        NULL,
    [IdVen_Original]  SMALLINT        NULL,
    [IdProducto]      SMALLINT        NULL,
    [IdCarteraNew]    SMALLINT        NULL,
    [IdHora]          INT             NULL,
    [Cantidad_OC]     DECIMAL (18, 2) NULL,
    [MonIGV_OC]       DECIMAL (18, 2) NULL,
    [UMES_OC]         DECIMAL (18, 2) NULL,
    [IdAlmacen]       SMALLINT        NULL,
    [IdPedido]        INT             NULL,
    [TiPedido]        CHAR (3)        NULL,
    [CoMotivo]        VARCHAR (4)     NULL,
    [IdJefe_dVenta]   SMALLINT        NULL,
    [Item]            SMALLINT        NULL,
    [peso]            DECIMAL (18, 5) NULL,
    [idTipoPedido]    SMALLINT        NULL,
    [factorVenta]     DECIMAL (18, 2) NULL,
    [factorCob]       DECIMAL (18, 2) NULL,
    [factorDono]      SMALLINT        NULL,
    [Pedidos]         VARCHAR (20)    NULL,
    [NoPedidos]       VARCHAR (20)    NULL,
    [PedidosxCli]     INT             NULL,
    [NoPedidosxCli]   INT             NULL,
    [IdCat_xPrv]      INT             NULL,
    CONSTRAINT [PK_Fact_Digitacion] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_Fact_Digitacion_DimCanales] FOREIGN KEY ([IdCan]) REFERENCES [Ventas].[DimCanales] ([IdCan]),
    CONSTRAINT [FK_Fact_Digitacion_DimCarteras] FOREIGN KEY ([IdCarteraNew]) REFERENCES [Ventas].[DimCarteras] ([IdCartera]),
    CONSTRAINT [FK_Fact_Digitacion_DimClientes] FOREIGN KEY ([IdCli]) REFERENCES [Ventas].[DimClientes] ([IdCli]),
    CONSTRAINT [FK_Fact_Digitacion_DimFechas] FOREIGN KEY ([FechaKey]) REFERENCES [Ventas].[DimFechas] ([FechaKey]),
    CONSTRAINT [FK_Fact_Digitacion_DimHora] FOREIGN KEY ([IdHora]) REFERENCES [Ventas].[DimHora] ([IdHora]),
    CONSTRAINT [FK_Fact_Digitacion_DimMesas] FOREIGN KEY ([IdMesa]) REFERENCES [Ventas].[DimMesas] ([IdMesa]),
    CONSTRAINT [FK_Fact_Digitacion_DimMotivosPedido] FOREIGN KEY ([CoMotivo]) REFERENCES [Ventas].[DimMotivosPedido] ([CodMotivo]),
    CONSTRAINT [FK_Fact_Digitacion_DimProductos] FOREIGN KEY ([IdProducto]) REFERENCES [Ventas].[DimProductos] ([IdPro]),
    CONSTRAINT [FK_Fact_Digitacion_DimSedes] FOREIGN KEY ([IdSede]) REFERENCES [Ventas].[DimSedes] ([IdSede]),
    CONSTRAINT [FK_Fact_Digitacion_DimVendedores] FOREIGN KEY ([IdVen]) REFERENCES [Ventas].[DimVendedores] ([IdVen])
);


GO

