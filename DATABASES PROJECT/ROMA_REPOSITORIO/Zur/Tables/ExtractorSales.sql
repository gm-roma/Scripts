CREATE TABLE [Zur].[ExtractorSales] (
    [SupplierCode]            VARCHAR (20)    NULL,
    [CompanyCode]             VARCHAR (20)    NULL,
    [DocumentType]            CHAR (2)        NULL,
    [DocumentNumber]          VARCHAR (30)    NOT NULL,
    [DocumentDate]            DATE            NOT NULL,
    [ReasonCreditNote]        VARCHAR (7)     NOT NULL,
    [Origin]                  VARCHAR (14)    NOT NULL,
    [CustomerCode]            VARCHAR (25)    NOT NULL,
    [CustomerChannelName]     VARCHAR (100)   NULL,
    [BussinesType]            VARCHAR (100)   NULL,
    [SellerCode]              SMALLINT        NULL,
    [SellerChannelName]       VARCHAR (100)   NULL,
    [Route]                   VARCHAR (10)    NULL,
    [ItemNumber]              SMALLINT        NOT NULL,
    [ProductCode]             VARCHAR (20)    NULL,
    [MinUnitQuantity]         DECIMAL (18, 4) NULL,
    [MinUnitType]             VARCHAR (3)     NOT NULL,
    [MaxUnitQuantity]         DECIMAL (18, 4) NULL,
    [MaxUnitType]             CHAR (3)        NULL,
    [Currency]                VARCHAR (3)     NOT NULL,
    [SaleWithoutTax]          DECIMAL (18, 4) NULL,
    [SaleWithTax]             DECIMAL (18, 4) NULL,
    [Discount]                DECIMAL (18, 4) NULL,
    [SaleType]                VARCHAR (1)     NOT NULL,
    [ComboCode]               VARCHAR (1)     NOT NULL,
    [PromotionCode]           VARCHAR (1)     NOT NULL,
    [ReferenceDocumentType]   CHAR (2)        NULL,
    [ReferenceDocumentNumber] VARCHAR (30)    NOT NULL,
    [ReferenceDocumentDate]   DATE            NOT NULL,
    [ProccessDate]            DATETIME        NOT NULL,
    [ref1]                    VARCHAR (1)     NOT NULL,
    [ref2]                    VARCHAR (1)     NOT NULL,
    [ref3]                    VARCHAR (1)     NOT NULL,
    [ref4]                    VARCHAR (1)     NOT NULL,
    [ref5]                    VARCHAR (1)     NOT NULL,
    [ref6]                    VARCHAR (1)     NOT NULL,
    [ref7]                    VARCHAR (1)     NOT NULL,
    [ref8]                    VARCHAR (1)     NOT NULL,
    [ref9]                    VARCHAR (1)     NOT NULL,
    [ref10]                   VARCHAR (1)     NOT NULL,
    [Period]                  VARCHAR (6)     NULL
);


GO

