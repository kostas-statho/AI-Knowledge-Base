-- ================================================
-- Template generated from Template Explorer using:
-- Create Inline Function (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the function.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[CCC_IsInternalManager]
(	
    @uid_personwantsorg as varchar(38)
)
RETURNS TABLE 
AS
RETURN 
(
	WITH RecursiveCTE AS 
    (
    select 
	    hho.UID_PersonHead as uid_person, 
        p.InternalName as ManagerName,
        p.IsExternal,
        1 as level
	from personwantsorg pwo 
		join helperHeadperson hho on hho.uid_person = pwo.UID_PersonOrdered and hho.XOrigin > 0
        join person p on hho.UID_PersonHead = p.uid_person
    --where pwo.UID_PersonOrdered = '56ccc59d-b8ad-4e51-866f-be822fdfc9d2'
    where pwo.uid_personwantsorg = @uid_personwantsorg
    
    UNION ALL

    -- Recursive member: references RecursiveCTE
    select  
        p.UID_Person,
        p.InternalName,
        p.IsExternal,
        r.level +1
    from HelperHeadPerson hhp
    JOIN person p ON p.UID_Person = hhp.UID_PersonHead
    join RecursiveCTE r on r.uid_person = hhp.UID_Person

    )
    SELECT TOP 1 * FROM RecursiveCTE
    where RecursiveCTE.IsExternal = 0
)
GO
