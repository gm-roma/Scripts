CREATE TABLE [Gloria].[Extractor_Ventas] (
    [iKey]               VARCHAR (50)     NULL,
    [DocEntry]           INT              NULL,
    [NumDoc]             INT              NULL,
    [CardCode]           VARCHAR (15)     NULL,
    [LineNum]            INT              NULL,
    [ItemCode]           VARCHAR (20)     NULL,
    [UnitMsr]            VARCHAR (10)     NULL,
    [QUANTITY]           NUMERIC (19, 6)  NULL,
    [LineTotal]          NUMERIC (19, 6)  NULL,
    [LineVat]            NUMERIC (19, 6)  NULL,
    [ItemName]           VARCHAR (100)    NULL,
    [BaseEntry]          INT              NULL,
    [DiscPrcnt]          NUMERIC (19, 6)  NULL,
    [cdist]              VARCHAR (4)      NULL,
    [cserie]             VARCHAR (4)      NULL,
    [ccorrelativo]       VARCHAR (20)     NULL,
    [contieneItems]      VARCHAR (1)      NULL,
    [ccliente_d]         VARCHAR (20)     NULL,
    [cgruven1]           VARCHAR (5)      NULL,
    [cvendedor]          VARCHAR (5)      NULL,
    [fpedido]            VARCHAR (8)      NULL,
    [ctipdoc]            VARCHAR (2)      NULL,
    [cconpag]            VARCHAR (2)      NULL,
    [femision]           INT              NULL,
    [cmotdoc]            VARCHAR (2)      NULL,
    [fentregaprog]       VARCHAR (8)      NULL,
    [cmoneda]            VARCHAR (3)      NULL,
    [ivtabruto]          NUMERIC (19, 6)  NULL,
    [idsctos]            NUMERIC (19, 6)  NULL,
    [ivtaneto]           VARCHAR (1)      NULL,
    [ivtatot]            NUMERIC (19, 6)  NULL,
    [fanula]             VARCHAR (8)      NULL,
    [flagAnula]          VARCHAR (1)      NULL,
    [fentrega]           VARCHAR (8)      NULL,
    [Npos]               INT              NULL,
    [cmaterial]          VARCHAR (20)     NULL,
    [Cumv]               VARCHAR (5)      NULL,
    [qpedido]            VARCHAR (1)      NULL,
    [qfactura]           NUMERIC (19, 6)  NULL,
    [qentrega]           VARCHAR (1)      NULL,
    [ivtabruto_p]        NUMERIC (19, 6)  NULL,
    [idsctos_p]          NUMERIC (19, 6)  NULL,
    [ivtaneto_p]         VARCHAR (1)      NULL,
    [Sbonif]             VARCHAR (1)      NULL,
    [Scombo]             VARCHAR (1)      NULL,
    [npos_bonif]         VARCHAR (1)      NULL,
    [ctipdoc_ref]        VARCHAR (2)      NULL,
    [cserie_ref]         VARCHAR (7)      NULL,
    [ccorrel_ref]        VARCHAR (10)     NULL,
    [sum_ivtabruto]      NUMERIC (19, 6)  NULL,
    [sum_idsctos]        NUMERIC (19, 6)  NULL,
    [Tipo_Tran]          VARCHAR (2)      NULL,
    [Descuento_cabecera] NUMERIC (19, 6)  NULL,
    [IGV]                NUMERIC (19, 6)  NULL,
    [U_VAR_Anda]         VARCHAR (1)      NULL,
    [U_OK1_Anulada]      VARCHAR (1)      NULL,
    [CardCode2]          VARCHAR (15)     NULL,
    [anulado]            VARCHAR (20)     NULL,
    [gloria]             VARCHAR (1)      NULL,
    [domi]               VARCHAR (3)      NULL,
    [docentrync]         INT              NULL,
    [objtype]            SMALLINT         NULL,
    [U_BKP_CODMESA]      VARCHAR (5)      NULL,
    [comentario]         VARCHAR (MAX)    NULL,
    [U_U_BKS_CODSEDE]    VARCHAR (5)      NULL,
    [VatPrcnt]           NUMERIC (18, 5)  NULL,
    [TaxDate]            DATE             NULL,
    [Valor1]             NUMERIC (15, 4)  NULL,
    [Peso]               NUMERIC (18, 10) NULL,
    [Volumen]            NUMERIC (15, 4)  NULL,
    [U_BKS_LINEA]        VARCHAR (MAX)    NULL,
    [LINEA]              VARCHAR (30)     NULL,
    [UMES]               NUMERIC (38, 21) NULL,
    [Periodo]            INT              NULL,
    [Sucursal]           VARCHAR (50)     NULL,
    [IdSede]             SMALLINT         NULL,
    [codcar]             VARCHAR (5)      NULL,
    [ClasifDeprodeca]    VARCHAR (20)     NULL,
    CONSTRAINT [FK_Extractor_Ventas_DimFechas] FOREIGN KEY ([femision]) REFERENCES [Ventas].[DimFechas] ([FechaKey])
);


GO

CREATE NONCLUSTERED INDEX [Idx_Extractor_Vta_CodSede]
    ON [Gloria].[Extractor_Ventas]([U_U_BKS_CODSEDE] ASC);


GO
