--ORTALAMA TESL�MAT S�RES�

SELECT 
	U.ID,
	U.NAMESURNAME,
	AVG(DATEDIFF(HOUR,O.DATE_,I.DATE_)) ORTALAMATESLIMAT_SURESI,
	SUM(O.TOTALPRICE) AS TOPLAMSIPARIS_TUTARI,
	COUNT(O.ID) AS SIPARISSAYISI,
	MAX(DATEDIFF(HOUR,O.DATE_,I.DATE_))	 ENUZUN_TESLIMATSURESI_SAAT,
	MIN(DATEDIFF(HOUR,O.DATE_,I.DATE_))	 ENKISA_TESLIMATSURESI_SAAT

FROM ORDERS O
	INNER JOIN USERS U ON U.ID=O.USERID
	INNER JOIN ADDRESS A ON A.ID=O.ADDRESSID
	INNER JOIN CITIES CT ON CT.ID=A.CITYID
	INNER JOIN TOWNS T ON T.ID=A.TOWNID
	INNER JOIN DISTRICTS D ON D.ID=A.DISTRICTID
	INNER JOIN PAYMENTS P ON P.ORDERID=O.ID
	INNER JOIN INVOICES I ON I.ORDERID=O.ID
	INNER JOIN ORDERDETAILS OD ON OD.ORDERID=O.ID
	INNER JOIN ITEMS ITM ON ITM.ID=OD.ITEMID

GROUP BY
	U.ID,
	U.NAMESURNAME

HAVING 
	AVG(DATEDIFF(HOUR,O.DATE_,I.DATE_))>22

ORDER BY 
	4 DESC