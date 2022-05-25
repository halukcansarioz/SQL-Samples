--KULLANICI ADI AD SOYAD   �L �L�E SEMT A�IK ADRES
--S�PAR�� ID      TAR�H   TOPLAM TUTAR     �DEME TAR�H�
--BANKA ONAY KODU     FATURA TAR�H�    KARGO F�� NO

SELECT 
	U.USERNAME_ KULLANICIADI,
	U.NAMESURNAME ADSOYAD,
	CT.CITY IL,
	T.TOWN ILCE,
	D.DISTRICT SEMT,
	A.ADDRESSTEXT ADRES,
	O.ID SIPARISID,
	O.DATE_ TARIH,
	O.TOTALPRICE TOPLAMTUTAR,
	P.DATE_ ODEMETARIHI,
	P.APPROVECODE BANKAONAY,
	I.DATE_ FATURATARIHI,
	I.CARGOFICHENO KARGOFISNO
FROM ORDERS O
	INNER JOIN USERS U ON U.ID=O.USERID
	INNER JOIN ADDRESS A ON A.ID=O.ADDRESSID
	INNER JOIN CITIES CT ON CT.ID=A.CITYID
	INNER JOIN TOWNS T ON T.ID=A.TOWNID
	INNER JOIN DISTRICTS D ON D.ID=A.DISTRICTID
	INNER JOIN PAYMENTS P ON P.ORDERID=O.ID
	INNER JOIN INVOICES I ON I.ORDERID=O.ID

WHERE U.NAMESURNAME='CEYDA GEZG�NC�'