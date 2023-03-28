--Создание бд

use BD_Sale
create table tip_klienta( 
id_tip_klienta INT PRIMARY KEY IDENTITY(1,1), 
tip_klienta NVARCHAR(50) 
) 
 
create table rayon ( 
id_rayon INT PRIMARY KEY IDENTITY(1,1), 
rayon NVARCHAR(50) 
)
 
create table klient 
( 
id_klient INT PRIMARY KEY IDENTITY(1,1), 
fam NVARCHAR(50), 
imya NVARCHAR(50), 
otch NVARCHAR(50), 
passport NVARCHAR(50), 
password NVARCHAR(50), 
login NVARCHAR(50), 
mesto_raboty NVARCHAR(50), 
skidka INT, 
id_rayon INT foreign key  references rayon(id_rayon), 
id_tip_klienta INT foreign key  references tip_klienta(id_tip_klienta) , 
) 
 
create table tip_kontaktov 
( 
id_tip_kontaktov INT PRIMARY KEY IDENTITY(1,1), 
tip_kontaktov NVARCHAR(50) 
) 
 
create table kontakty 
( 
id_kontakty INT PRIMARY KEY IDENTITY(1,1), 
kontakty NVARCHAR(50), 
id_klient INT FOREIGN KEY REFERENCES klient(id_klient), 
id_tip_kontaktov  INT FOREIGN KEY REFERENCES tip_kontaktov (id_tip_kontaktov) 
) 
 
create table tip_zakaza  
( 
id_tip_zakaza INT PRIMARY KEY IDENTITY(1,1), 
tip_zakaza NVARCHAR(50) 
) 
 
 
create table tip_prodaj  
( 
id_tip_prodaj INT PRIMARY KEY IDENTITY(1,1), 
tip_prodaj NVARCHAR(50) 
) 
 
create table sostoyanie  
( 
id_sostoyanie INT PRIMARY KEY IDENTITY(1,1), 
sostoyanie NVARCHAR(50) 
) 
create table doljnost  
( 
id_doljnost  INT PRIMARY KEY IDENTITY(1,1), 
doljnost NVARCHAR(50) 
) 
 
create table sotrudnik 
( 
id_sotrudnik  INT PRIMARY KEY IDENTITY(1,1), 
fam NVARCHAR(50), 
imya NVARCHAR(50), 
otch NVARCHAR(50), 
id_doljnost INT FOREIGN KEY REFERENCES doljnost(id_doljnost) 
) 
 
 
create table zakaz 
( 
id_zakaz INT PRIMARY KEY IDENTITY(1,1), 
data DATE , 
nomer_doc INT, 
comments NVARCHAR(50), 
id_klient INT FOREIGN KEY REFERENCES klient(id_klient), 
id_tip_zakaza INT FOREIGN KEY REFERENCES tip_zakaza(id_tip_zakaza), 
id_sostoyanie INT FOREIGN KEY REFERENCES sostoyanie(id_sostoyanie), 
id_tip_prodaj INT FOREIGN KEY REFERENCES tip_prodaj(id_tip_prodaj), 
id_sotrudnik INT FOREIGN KEY REFERENCES sotrudnik(id_sotrudnik), 
) 
 
 
create table vid_oplaty  
( 
id_vid_oplaty  INT PRIMARY KEY IDENTITY(1,1), 
vid_oplaty NVARCHAR(50) 
) 
 
create table oplata 
( 
id_oplata  INT PRIMARY KEY IDENTITY(1,1), 
data DATE , 
summa INT, 
comments NVARCHAR(50), 
id_zakaz INT FOREIGN KEY REFERENCES zakaz(id_zakaz), 
id_vid_oplaty INT FOREIGN KEY REFERENCES vid_oplaty(id_vid_oplaty) 
) 
 
create table tip_tovara  
( 
id_tip_tovara  INT PRIMARY KEY IDENTITY(1,1), 
tip_tovara NVARCHAR(50) 
) 
 
create table tovar 
( 
id_tovar  INT PRIMARY KEY IDENTITY(1,1), 
tovar NVARCHAR(50), 
comments NVARCHAR(50), 
photo NVARCHAR(50), 
id_tip_tovara INT FOREIGN KEY REFERENCES tip_tovara(id_tip_tovara) 
) 
 
 
create table price_list 
( 
id_price_list INT PRIMARY KEY IDENTITY(1,1), 
cena INT, 
data DATE , 
comments NVARCHAR(50), 
id_tovar INT FOREIGN KEY REFERENCES tovar(id_tovar) 
) 
 
create table tip_postavshika 
( 
id_tip_postavshika  INT PRIMARY KEY IDENTITY(1,1), 
tip_postavshika NVARCHAR(50) 
) 
 
create table postavshik 
( 
id_postavshik INT PRIMARY KEY IDENTITY(1,1), 
nazvanie NVARCHAR(50), 
fam NVARCHAR(50), 
imya NVARCHAR(50), 
otch NVARCHAR(50), 
id_tip_postavshika INT FOREIGN KEY REFERENCES tip_postavshika(id_tip_postavshika) 
) 
 
create table tip_postavki 
( 
id_tip_postavki INT PRIMARY KEY IDENTITY(1,1), 
tip_postavki NVARCHAR(50) 
) 
 
 
create table postavki 
( 
id_postavki INT PRIMARY KEY IDENTITY(1,1), 
nomer_doc INT, 
data DATE , 
comments NVARCHAR(50), 
id_postavshik  INT FOREIGN KEY REFERENCES postavshik (id_postavshik ), 
id_tip_postavki INT FOREIGN KEY REFERENCES tip_postavki(id_tip_postavki) 
) 
 
create table oplata_postovki 
( 
id_oplata_postavki INT PRIMARY KEY IDENTITY(1,1), 
data DATE , 
summa INT, 
comments NVARCHAR(50), 
id_postavki INT FOREIGN KEY REFERENCES postavki(id_postavki) 
) 
 
create table spisok_postavki 
( 
id_spisok_postavki INT PRIMARY KEY IDENTITY(1,1), 
cena INT, 
kol_vo INT, 
srok_godnosti DATE , 
comments NVARCHAR(50), 
id_postavki INT FOREIGN KEY REFERENCES postavki(id_postavki) 
) 
 
create table spisok_tovarov 
( 
id_spisok_tovarov INT PRIMARY KEY IDENTITY(1,1), 
cena INT, 
kol_vo INT, 
id_zakaz INT FOREIGN KEY REFERENCES zakaz(id_zakaz), 
id_tovar INT FOREIGN KEY REFERENCES tovar(id_tovar), 
id_spisok_postavki INT FOREIGN KEY REFERENCES spisok_postavki(id_spisok_postavki) 
)