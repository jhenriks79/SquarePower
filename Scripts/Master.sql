:setvar path "<YOUR FILE PATH>"
--:r $(path)0_CleanupAllTables.sql

:r $(path)1_SetupExternalTables.sql
:r $(path)2_PaymentsExternal.sql
:r $(path)3_PaymentsMaster.sql
:r $(path)4_ItemizationsExternal.sql
:r $(path)5_ItemizationsMaster.sql
:r $(path)6_LocationSummaries.sql