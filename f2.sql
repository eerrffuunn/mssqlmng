DECLARE Prod_Id_curs CURSOR FOR SELECT ID FROM Product --making cursor to  itterate over private key
DECLARE @Prod_Id int --declaring a product id var to save 

Open Prod_Id_curs

FETCH NEXT FROM Prod_Id_curs INTO @Prod_Id --saving id of products
WHILE @@FETCH_STATUS = 0 --till there is no more id
BEGIN
--mofify recomndedage column of ptoduct by
UPDATE Product SET RecommendedAge =
(
--extracting data from xml tag
SELECT Description.value('(product/recommended_age)[1]', 'varchar(max)')
--wherever given cursor is same as id extract data
AS RecommendedAge FROM Product WHERE ID = @Prod_Id
)

--and place extracted data here
WHERE ID=@Prod_Id

UPDATE Product

--REMOVING NOT NULL AGE TAGS
    SET Description.modify('delete product/recommended_age')	WHERE ID = @Prod_Id
        AND Description.value('(product/recommended_age)[1]', 'varchar(max)') IS NOT NULL



    FETCH next FROM Prod_Id_curs INTO @Prod_Id

END
close Prod_Id_curs
DEALLOCATE Prod_Id_curs
