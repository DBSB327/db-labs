use BD_Sale

--1
insert into tip_tovara(tip_tovara)
values('Электрический инструмент'),
('Электротехника')

--2
insert into tovar(tovar, comments, photo, id_tip_tovara ) 
values('Электродрель', 'no comment', 'photo1.png', '1'),
('Тефаль', 'no comment', 'photo2.png', '1')

--3
insert into tip_postavshika(tip_postavshika)
values('Субподрядчик'),
('Дистрибьютор')

--4
insert into tip_postavki(tip_postavki)
values('Прямая поставка'),
('Поставка через дистрибьютор')

--5
insert into tip_prodaj(tip_prodaj)
values('Розничная продажа'),
('Оптовая продажа')

--6
insert into price_list(cena, data, comments, id_tovar)
values('3200', '06-03-2023', 'no comment', '1'),
('750', '07-03-2023', 'no comment', '2')

--7
insert into vid_oplaty(vid_oplaty)
values('Наличная оплата'),
('Оплата банковской картой'),
('Электронная оплата')

--8
insert into doljnost(doljnost)
values('Менеджер'),
('Продавец')

--9
insert into sotrudnik(fam, imya, otch, id_doljnost)
values('Арыков', 'Азамат', 'Байматович', '1'),
('Садыков', 'Элчибек', 'Кошойбекович', '2')

--10
insert into sostoyanie(sostoyanie)
values('Новый'),
('Б\У'),
('Возврат')

--11
insert into tip_zakaza(tip_zakaza)
values('Обычный заказ'),
('Предзаказ')

--12
insert into tip_klienta(tip_klienta)
values('Физическое лицо'),
('Юридическое лицо')

--13
insert into rayon(rayon)
values('Октябрский'),
('Свердловский')

--14
insert into klient(fam, imya, otch, passport, password, login, mesto_raboty, skidka, id_rayon, id_tip_klienta)
values('Султанов', 'Темирлан', 'Мукашевич', 'ID23653', 'tem213', 'UserTem', 'defaultplace', '0', '1', '1'),
('Константинов', 'Иван', 'Кириллович', 'ID54638', 'ivan123', 'UserIvan', 'defaultplace', '0', '2', '2')

--15
insert into tip_kontaktov(tip_kontaktov)
values('Телефон'),
('eMail')

--16
insert into kontakty(kontakty, id_klient, id_tip_kontaktov)
values('0707123456', '1', '1'),
('ivan@gmail.com', '2', '2')

--17
insert into postavshik(nazvanie, fam, imya, otch, id_tip_postavshika)
values('BOSCH', 'Курманбеков', 'Канат', 'Максутович', '1'),
('Vitek', 'Бейшакунов', 'Адилет', 'Токтобекович', '2')

--18
insert into postavki(nomer_doc, data, comments, id_postavshik, id_tip_postavki)
values('46536', '06-03-2023', 'no comment', '1', '1'),
('28486', '07-03-2023', 'no comment', '2', '2')

--19
insert into zakaz(data, nomer_doc, comments, id_klient, id_tip_zakaza, id_sostoyanie, id_tip_prodaj, id_sotrudnik)
values('06-03-2023', '54267', 'no comments', '1', '1', '1', '1', '1'),
('07-03-2023', '41892', 'no comments', '2', '2', '1', '1', '2')

--20
insert into oplata(data, summa, comments, id_zakaz, id_vid_oplaty)
values('06-03-2023', '3200', 'no comment', '1', '1'),
('07-03-2023', '1000', 'no comment', '2', '1')

--21
insert into spisok_postavki(cena, kol_vo, srok_godnosti, comments, id_postavki)
values('3200', '1', '06-03-2028', 'no comment', '1'),
('1000', '1', '06-03-2028', 'no comment', '1')

--22
insert into oplata_postovki(data, summa, comments, id_postavki)
values('06-03-2023', '3200', 'no comment', '1'),
('07-03-2023', '1000', 'no comment', '2')


--23
insert into spisok_tovarov(cena, kol_vo, id_zakaz, id_tovar, id_spisok_postavki)
values('3200', '1', '1', '1', '1'),
('1000', '1', '2', '2', '2')
