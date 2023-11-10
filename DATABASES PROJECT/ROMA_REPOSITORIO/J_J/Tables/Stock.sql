CREATE TABLE [J&J].[Stock] (
    [CodigoDistribuidor]        VARCHAR (50)    NULL,
    [CodigoAlmacen]             VARCHAR (20)    NULL,
    [NombreAlmacen]             NVARCHAR (100)  NULL,
    [CodigoProveedor]           NVARCHAR (15)   NULL,
    [Proveedor]                 NVARCHAR (100)  NULL,
    [CodigoProducto]            NVARCHAR (20)   NULL,
    [StockEnUnidadDeConsumo]    INT             NULL,
    [UnidadDeMedidaDeConsumo]   VARCHAR (3)     NULL,
    [StockEnUnidadDeCompra]     NUMERIC (14, 4) NULL,
    [UnidadDeMedidaDeCompra]    NVARCHAR (20)   NULL,
    [ValorStock]                NUMERIC (14, 4) NULL,
    [FechaStock]                VARCHAR (10)    NULL,
    [IngresosEnUnidadDeConsumo] INT             NULL,
    [ValorIngresos]             NUMERIC (14, 2) NULL,
    [VentasEnUnidadDeConsumo]   INT             NULL,
    [ValorVentas]               NUMERIC (14, 2) NULL,
    [OtrosEnUnidadDeConsumo]    INT             NULL,
    [ValorOtros]                INT             NULL,
    [Periodo]                   INT             NULL,
    [FeRegistro]                VARCHAR (12)    NULL,
    [CodSedeAlmacen]            CHAR (2)        NULL
);


GO

