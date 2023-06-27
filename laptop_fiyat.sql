-- 1 ) Verilerimizi g�r�nt�leyelim ...

select * from laptop_price

-- 2 ) Sadece istedi�imiz s�tunlar� g�r�nt�leyebiliriz ...

select Company , Product , Price_euros from laptop_price

-- 3 "as" komutu ile s�tun ad�nda de�i�iklik yapabiliriz ...

select Company , Product , Ram , Price_euros as [Euro Cinsinden Fiyat�] from laptop_price

-- 4 ) "+" sembol�n� kullanarak iki s�tun aras�nda birle�tirme i�lemi yapabiliriz ...

select Company + '-' + Product as [Marka ve �r�n]  from laptop_price

-- 5 ) Laptop fiyatlar�n� k���kten b�y��e s�ralamak istersek a�a��daki order by ifadesi ile sorgu yazabiliriz ...

select * from laptop_price order by Price_euros

-- 6 ) Laptop fiyatlar�n� b�y�kten k����e s�ralamak istersek a�a��daki order by ifadesi ile sorgu yazabiliriz ...

select * from laptop_price order by Price_euros desc

-- 7 ) Sadece Apple markal� laptoplar� g�rmek istiyoruz diyelim , bunun i�in "where" komutu ile a�a��daki gibi 
-- bir sorgu yazmal�y�z ...

select * from laptop_price where Company = 'Apple'

-- 8 ) Hem Apple hem Asus markal� ara�lar� g�rmek i�in "where" ve "or" ifadelerini a�a��daki gibi kullan-
-- mal�y�z ...

select * from laptop_price where Company = 'Apple' or Company = 'Asus'

-- 9 ) Hem 8 GB ram hem de �r�n�n markas�n�n Lenovo olmas�n� istemi� olal�m , "and" ve "where"
-- ifadeleri ile a�a��daki gibi bir sorgu yazabiliriz ...

select * from laptop_price where Company = 'Lenovo' and Ram = '8GB'

-- 10 ) Fiyat� 2000 Euro alt�nda olan �r�nlere bakal�m ve onlar� b�y�kten k����e s�ralayal�m ...

select * from laptop_price where Price_euros < 2000 order by Price_euros desc

-- 11 ) Marka ismi "A" ile ba�layanlar� g�rmek i�in "LIKE" komutunu kullan�r�z ...

select * from laptop_price where Company like 'A%'

-- 12 ) Marka ismi "e" ile bitenleri g�relim ...

select * from laptop_price where Company like '%e'

-- 13 ) Marka isminde "a" harfi bulunanlar� g�relim ...

select * from laptop_price where Company like '%a%'

-- 14 ) Marka isminin ba��nda "A" harfi olmayanlar� g�rmek i�in "not" ifadesi kullan�l�r ...

select * from laptop_price where Company not like 'A%'

-- 15 ) Marka ismi A harfi ile ba�lay�p e harfi ile biten markalar i�in a�a��daki gibi sorgu yaz�labilir ...

select * from laptop_price where Company like 'A%e'

-- 16 - �kinci harfi "s" olan markalar i�in a�a��daki gibi bir sorgu yaz�labilir ... 

select * from laptop_price where Company like '_s%'

-- 17 - Ba� harfi "A" veya "D" olanlar� g�rmek i�in a�a��daki gibi bir sorgu yaz�l�r ...

select * from laptop_price where Company like '[AD]%'

-- 18 - Fiyat� 1000 ile 2500 aras�ndaki olan �r�nleri g�rmek i�in 'between' komutunu kullanabiliriz ...

select * from laptop_price where Price_euros  between 1000 and 2500

--  19 - Hem Windows 10 hem de Linux i�letim sistemine sahip �r�nleri g�rmek istiyorsak "IN" ifadesi ile bunu
-- k�sa yoldan yapabiliriz ...

select * from laptop_price where OpSys in('Windows 10' , 'Linux')

-- 20 - Gruplama i�lemlerinde 'group by' kullan�r�z �r�nleri markalar�na g�re grupland�ral�m ve ka� adet var g�relim ...

select Company , count(*) as [�r�n Adet] from laptop_price group by Company

-- 21 Markalar�n �r�nlerinin ortalama fiyatlar�n� bulal�m ...

select Company , avg(Price_euros) as [Ortalama Fiyat] from laptop_price group by Company

-- 22 - Hem marka hem de �r�n�n tipine g�re grupland�rma yapal�m ...

select Company , TypeName , max(Price_euros) as [Maksimum Fiyat] from laptop_price group by Company , TypeName

-- 23 - ��letim sistemlerine g�re grupland�rma yapal�m ama sadece fiyat� 3000 euro alt�nda olan �r�nler i�in ...

select OpSys , count(Company) as [Marka Adedi] , avg(Price_euros) as [Ortalama Fiyatlar�] from laptop_price
where Price_euros <= 3000 group by OpSys

-- 24 - Having ile gruplad���m�z s�tuna filtreleme yapabiliriz ...

select Company , avg(Price_euros) as [Ortalama Fiyat] from laptop_price 
group by Company having avg(Price_euros) > 1500

-- 25 if ifadelerini kullanarak marka say�s� hakk�nda bilgi sahibi olal�m ...

declare @say� int
select @say� = COUNT(distinct(Company)) from laptop_price 
if @say� < 10 
begin 
print 'Marka say�s� 10 dan azd�r'
end
else if @say� >= 10 and @say� <= 15
begin
print 'Marka say�s� 10-15 aras�ndad�r ...'
end
else
begin 
print 'Marka say�s� 15 den fazlad�r ... '
end

-- 26 - case when kullanarak �rnek yapal�m ...

SELECT *,CASE
WHEN Price_euros < 1000 THEN 'Ucuz'
WHEN Price_euros > 1000 AND Price_euros <= 3000 THEN 'Ortalama Fiyat'
WHEN Price_euros > 3000 THEN 'Pahal�'
END AS [Fiyat Durumu]
FROM laptop_price

-- 27 - iif ile i�letim sistemi durumu hakk�nda bilgilendirme yapal�m ...

select * , iif(OpSys = 'macOS' , 'Bu �r�n Apple a aittir' , 'Bu �r�n Apple a ait de�ildir') as 
[��letim Sistemi Bilgilendirme] from laptop_price

-- 28 - Marka k�sm� null olan yerleri update edelim ...

update laptop_price set Company = 'Marka Bilinmiyor' where Company is null

select * from laptop_price where Company = 'Marka Bilinmiyor'

-- 29 - 16 GB Ram e sahip olan �r�nleri �a��rabilce�imiz bir procedure olu�tural�m ...

create proc ram as
begin
select * from laptop_price where Ram = '16GB'
end

exec ram

-- 30 ��ine atad���m�z de�i�kenden fiyat� y�ksek olanlar� g�steren bir trigger yazal�m ...

create proc urun_fiyat(@x int) 
as begin
select * from laptop_price where Price_euros > @x
end

exec urun_fiyat 1900 -- 1900 euro dan pahal� �r�nler