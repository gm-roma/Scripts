CREATE TABLE [J&J].[Vendedores] (
    [CodigoVendedor]     SMALLINT      NULL,
    [NombreVendedor]     VARCHAR (100) NULL,
    [Exclusivo]          VARCHAR (1)   NULL,
    [supervisor]         VARCHAR (1)   NULL,
    [CodigoMesa]         VARCHAR (1)   NULL,
    [VendedorPadre]      VARCHAR (1)   NULL,
    [CodigoDistribuidor] VARCHAR (50)  NULL,
    [FeRegistro]         VARCHAR (12)  NULL
);


GO

