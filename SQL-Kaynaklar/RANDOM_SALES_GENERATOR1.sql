USE ETRADE2
--TRUNCATE TABLE SALES


DECLARE @I AS INT=1
DECLARE @ITEMID AS INT
DECLARE @DATE AS DATETIME
DECLARE @CUSTOMERID AS INT
DECLARE @CUSTOMERNAME AS VARCHAR(100)
DECLARE @CUSTOMERBIRTHDATE AS DATE
DECLARE @CUSTOMERGENDER AS VARCHAR(10)
DECLARE @DISTRICT AS VARCHAR(100)
DECLARE @REGION AS VARCHAR(100)
DECLARE @AMOUNT AS INT
DECLARE @ITEMCOUNT AS INT
DECLARE @CITY AS VARCHAR(100)
DECLARE @PRICEFACTOR AS FLOAT=1
DECLARE @HOUR INT
DECLARE @MINUTE INT
DECLARE @SECOND INT
DECLARE @BRANCHID AS INT
DECLARE @BRANCH AS VARCHAR(100)
DECLARE @RAND AS INT 
WHILE @I<=50000
BEGIN
SET @HOUR=RAND()*22
IF  @HOUR<8 
	SET @HOUR=8
SET @MINUTE=RAND()*60
	SET @SECOND=RAND()*60
SET @RAND=RAND()*10000
	SELECT @CITY=CITYNAME,@REGION=REGION FROM CITIES WHERE @RAND BETWEEN RANDOMBEG AND RANDOMEND

	SELECT top 1 @CUSTOMERID=ID,@CUSTOMERNAME=NAMESURNAME,@CUSTOMERBIRTHDATE=BIRTHDATE,
		@DISTRICT=TOWN,@CUSTOMERGENDER=GENDER
	FROM DBO.CUSTOMERS WHERE CITY=@CITY    ORDER BY NEWID()

	SET @ITEMCOUNT=RAND()*9
	DECLARE @K AS INT=0
	WHILE @K<=@ITEMCOUNT
	BEGIN
		SET @RAND=RAND()*365
		SET @DATE=DATEADD(DAY,@RAND,'20190101')
		SET @DATE=DATEADD(HOUR,@HOUR,@DATE)
		SET @DATE=DATEADD(MINUTE,@MINUTE,@DATE)
		SET @DATE=DATEADD(SECOND ,@SECOND,@DATE)
		SET @AMOUNT=(RAND()*10)+1
		SET @RAND=RAND()*10
	
		IF @RAND BETWEEN 0 AND 5 
			SET @PRICEFACTOR=1
		IF @RAND=6 
			SET @PRICEFACTOR=0.8
		IF @RAND=7 
			SET @PRICEFACTOR=0.9
		IF @RAND=8
			SET @PRICEFACTOR=1.1
		IF @RAND=9 
			SET @PRICEFACTOR=1.2
		IF @RAND=10 
			SET @PRICEFACTOR=1.4
		SET @RAND =RAND()*28000
 
		INSERT INTO SALES (FICHENO,DATE_,ITEMCODE,ITEMNAME,BRAND,CATEGORY1,CATEGORY2,CATEGORY3,CATEGORY4,
		AMOUNT,PRICE,TOTALPRICE,CUSTOMERCODE,CUSTOMERNAME,CUSTOMERBIRHTDATE,CUSTOMERGENDER,
		BRANCH,CITY,DISTRICT,REGION)
		SELECT TOP 1 
		REPLICATE('0',10-LEN(@I))+CONVERT(VARCHAR,@I),@DATE,ITEMCODE,ITEMNAME,BRAND,CATEGORY1,CATEGORY2,CATEGORY3,CATEGORY4,
		@AMOUNT,SALEPRICE,@AMOUNT*SALEPRICE*@PRICEFACTOR,@CUSTOMERID,@CUSTOMERNAME,@CUSTOMERBIRTHDATE,@CUSTOMERGENDER,
		@CITY,@CITY,@DISTRICT,@REGION
		FROM ITEMS WHERE SALEPRICE>0.1 AND ID>=@RAND ORDER BY ID 

SET @K=@K+1
END
 
SET @I=@I+1
END

 