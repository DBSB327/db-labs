use BD_Sale

--Ïîñòàâêè

--1
CREATE PROCEDURE spisok_postavki_za_period
AS
BEGIN
SELECT * 
FROM spisok_postavki
WHERE id_spisok_postavki in (SELECT id_spisok_postavki FROM spisok_tovarov WHERE id_tovar in (SELECT id_tovar FROM tovar WHERE id_tovar in 
(SELECT id_tovar FROM price_list WHERE data = '2023-06-03')))
END

--2
CREATE PROCEDURE ST_postavlennyh_po_postavshiku
AS
BEGIN
SELECT *
FROM spisok_tovarov
WHERE id_spisok_postavki in (SELECT id_spisok_postavki FROM spisok_postavki WHERE id_postavki in (SELECT id_postavki FROM postavki
WHERE id_postavshik in (SELECT id_postavshik FROM postavshik WHERE nazvanie = 'BOSCH')))
END

--3
CREATE PROCEDURE ST_postavlennyh_po_tipu_tovara
AS
BEGIN
SELECT *
FROM spisok_postavki
WHERE id_spisok_postavki in (SELECT id_spisok_postavki FROM spisok_tovarov WHERE id_tovar in (SELECT id_tovar FROM tovar WHERE tovar = 'Òåôàëü'))
END

--4
CREATE PROCEDURE postavki_po_tovaram_za_period
AS
BEGIN
SELECT *
FROM postavki
WHERE id_postavki in (SELECT id_postavki FROM spisok_postavki WHERE id_spisok_postavki in (SELECT id_spisok_postavki FROM spisok_tovarov WHERE id_tovar in (SELECT id_tovar FROM tovar WHERE tovar = 'iPhone')) )
END

--5
CREATE PROCEDURE izmeneniye_sen
AS
BEGIN
UPDATE price_list SET cena = 134
WHERE data >= '2022-09-01' and data <= '2022-12-01';
END


--6
CREATE PROCEDURE oplata_po_postavkam
AS
BEGIN
SELECT *
FROM oplata
WHERE id_zakaz in (SELECT id_zakaz FROM zakaz WHERE id_zakaz in (SELECT id_zakaz FROM spisok_tovarov WHERE id_spisok_postavki IN (
SELECT id_spisok_postavki FROM spisok_postavki WHERE id_postavki in (SELECT id_postavki FROM postavki WHERE data BETWEEN ('2023-06-03')and('2023-07-03')))))
END



--Ïğîäàæè

--1
CREATE PROCEDURE spisok_prodaj_za_period_po_tovaram
AS
BEGIN
DECLARE @id_zaka INT

SELECT @id_zaka = id_zakaz 
FROM zakaz
WHERE id_sostoyanie	= (SELECT id_sostoyanie FROM sostoyanie WHERE sostoyanie = 'Íîâûé') and data >= '2023-06-03' and data <= '2023-07-03'

SELECT id_tovar, kol_vo
FROM spisok_tovarov
WHERE id_zakaz = @id_zaka
END

--2 
CREATE PROCEDURE zakazy_klienta
AS
BEGIN
SELECT *
FROM zakaz
WHERE id_klient in (SELECT id_klient FROM klient WHERE id_klient = 1) and data BETWEEN ('2023-06-03')and('2023-07-03')
END

--3 
CREATE PROCEDURE izmenenie_sen
AS
BEGIN
UPDATE price_list SET cena = 1340
WHERE data >= '2023-06-03' and data <= '2023-07-03';
END

--4	
CREATE PROCEDURE aktualnyi_price_list
AS
BEGIN
SELECT *
FROM price_list;
END

--5 
CREATE PROCEDURE oplata_po_prodajam
AS
BEGIN
SELECT id_oplata, summa, id_zakaz
FROM oplata
WHERE data >= '2023-06-03' and data <= '2023-06-03'
END

--6
CREATE PROCEDURE oplata_po_vidu
AS
BEGIN
SELECT summa
FROM oplata
WHERE id_vid_oplaty = (SELECT id_vid_oplaty from vid_oplaty WHERE vid_oplaty = 'Íàëè÷íàÿ îïëàòà') and data >= '2023-06-03' and data <= '2023-07-03'
END

--7	
CREATE PROCEDURE prodaji_po_sotrudnikam
AS
BEGIN
SELECT *
FROM zakaz
WHERE id_sotrudnik  = 1
END


--8 
CREATE PROCEDURE prodaji_po_rayonu
AS
BEGIN
SELECT*
FROM zakaz
WHERE id_klient in (SELECT id_klient FROM klient WHERE id_rayon in (SELECT id_rayon FROM rayon WHERE rayon = 'Îêòÿáğñêèé'))
END


--9 
CREATE PROCEDURE kontakty_klientov
AS
BEGIN
SELECT kontakty
FROM kontakty
WHERE id_klient = (SELECT id_klient FROM klient WHERE id_klient = 2)
END



--10	
CREATE PROCEDURE zakazy_po_tipu_prodaj
AS
BEGIN
SELECT id_zakaz, id_tip_prodaj
FROM zakaz
END


--11	
CREATE PROCEDURE zakazy_po_tipu_zakaza
AS
BEGIN
SELECT id_zakaz, id_tip_zakaza
FROM zakaz
END


--12 
CREATE PROCEDURE ostatok_tovara_
AS
BEGIN
DECLARE @id_kol INT
SELECT @id_kol = kol_vo
FROM spisok_tovarov
WHERE id_spisok_postavki = 1;

DECLARE @id_koll INT
SELECT @id_koll = kol_vo
FROM spisok_postavki
WHERE id_spisok_postavki = 1;

print (@id_koll - @id_kol) 
END