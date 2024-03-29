CREATE TABLE [Reports].[CommissionsManagerReport] (
    [Period]                           VARCHAR (6)      NULL,
    [TerritoryCode]                    VARCHAR (120)    NULL,
    [TerritoryName]                    VARCHAR (120)    NULL,
    [SupplierCode]                     VARCHAR (20)     NULL,
    [SupplierName]                     VARCHAR (100)    NULL,
    [CategoryCode]                     CHAR (3)         NULL,
    [CategoryName]                     VARCHAR (100)    NULL,
    [ManagerCode]                      NVARCHAR (8)     COLLATE SQL_Latin1_General_CP850_CI_AS NOT NULL,
    [ManagerName]                      NVARCHAR (120)   COLLATE SQL_Latin1_General_CP850_CI_AS NULL,
    [SalePreviousMonth]                DECIMAL (38, 2)  NULL,
    [SalePreviousMonthSub]             DECIMAL (38, 2)  NULL,
    [SalePreviousMonthTotal]           DECIMAL (38, 2)  NULL,
    [Goal]                             DECIMAL (38, 2)  NULL,
    [GoalSub]                          DECIMAL (38, 2)  NULL,
    [GoalTotal]                        DECIMAL (38, 2)  NULL,
    [Sale]                             DECIMAL (38, 2)  NULL,
    [SaleSub]                          DECIMAL (38, 2)  NULL,
    [SaleTotal]                        DECIMAL (38, 2)  NULL,
    [ProjectedSale]                    NUMERIC (38, 6)  NULL,
    [ProjectedSaleSub]                 NUMERIC (38, 6)  NULL,
    [ProjectedSaleTotal]               NUMERIC (38, 6)  NULL,
    [ProjectedSalePercentage]          NUMERIC (38, 6)  NULL,
    [ProjectedSalePercentageSub]       DECIMAL (10, 4)  NULL,
    [ProjectedSalePercentageTotal]     DECIMAL (10, 4)  NULL,
    [Portfolio]                        INT              NULL,
    [PortfolioSub]                     INT              NULL,
    [PortfolioTotal]                   INT              NULL,
    [CoverageFactor]                   DECIMAL (18, 5)  NULL,
    [CoverageFactorSub]                DECIMAL (18, 4)  NULL,
    [CoverageFactorTotal]              DECIMAL (18, 4)  NULL,
    [CoverageGoal]                     DECIMAL (18, 2)  NULL,
    [CoverageGoalSub]                  DECIMAL (18, 2)  NULL,
    [CoverageGoalMax]                  DECIMAL (18, 2)  NULL,
    [Coverage]                         INT              NULL,
    [CoverageSub]                      INT              NULL,
    [CoverageTotal]                    INT              NULL,
    [ProjectedCoverage]                NUMERIC (36, 13) NULL,
    [ProjectedCoverageSub]             NUMERIC (36, 13) NULL,
    [ProjectedCoverageTotal]           NUMERIC (36, 13) NULL,
    [ProjectedCoveragePercentage]      NUMERIC (38, 13) NOT NULL,
    [ProjectedCoveragePercentageSub]   DECIMAL (10, 4)  NULL,
    [ProjectedCoveragePercentageTotal] DECIMAL (10, 4)  NULL,
    [Returns]                          DECIMAL (38, 2)  NULL,
    [ReturnsSub]                       DECIMAL (38, 2)  NULL,
    [ReturnsTotal]                     DECIMAL (38, 2)  NULL,
    [ProjectedReturns]                 NUMERIC (38, 6)  NULL,
    [ProjectedReturnsSub]              NUMERIC (38, 6)  NULL,
    [ProjectedReturnsTotal]            NUMERIC (38, 6)  NULL,
    [ProjectedReturnsPercentage]       NUMERIC (38, 6)  NOT NULL,
    [ProjectedReturnsPercentageSub]    DECIMAL (10, 4)  NULL,
    [ProjectedReturnsPercentageTotal]  DECIMAL (10, 4)  NULL,
    [ValidDays]                        INT              NULL,
    [PassedDays]                       INT              NULL,
    [RemainingDays]                    INT              NULL,
    [CategoryCount]                    INT              NULL,
    [ProportionalPercentage]           DECIMAL (10, 4)  NULL,
    [Scale]                            NUMERIC (18, 2)  NULL,
    [ExcessPercentage]                 NUMERIC (5, 2)   NULL,
    [CommissionSaleBase]               NUMERIC (24, 4)  NULL,
    [CommissionCobBase]                NUMERIC (24, 4)  NULL,
    [CommissionSale]                   DECIMAL (18, 2)  NULL,
    [CommissionSaleSub]                DECIMAL (18, 2)  NULL,
    [CommissionSaleTotal]              DECIMAL (18, 2)  NULL,
    [CommissionCoverage]               DECIMAL (18, 2)  NULL,
    [CommissionCoverageSub]            DECIMAL (18, 2)  NULL,
    [CommissionCoverageTotal]          DECIMAL (18, 2)  NULL,
    [CommissionTotal]                  DECIMAL (18, 2)  NULL,
    [CommissionTotalSub]               DECIMAL (18, 2)  NULL,
    [CommissionTotalTotal]             DECIMAL (18, 2)  NULL,
    [Salary]                           DECIMAL (18, 2)  NULL
);


GO

