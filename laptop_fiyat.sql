-- 1 ) Verilerimizi görüntüleyelim ...

select * from laptop_price

-- 2 ) Sadece istediðimiz sütunlarý görüntüleyebiliriz ...

select Company , Product , Price_euros from laptop_price

-- 3 "as" komutu ile sütun adýnda deðiþiklik yapabiliriz ...

select Company , Product , Ram , Price_euros as [Euro Cinsinden Fiyatý] from laptop_price

-- 4 ) "+" sembolünü kullanarak iki sütun arasýnda birleþtirme iþlemi yapabiliriz ...

select Company + '-' + Product as [Marka ve Ürün]  from laptop_price

-- 5 ) Laptop fiyatlarýný küçükten büyüðe sýralamak istersek aþaðýdaki order by ifadesi ile sorgu yazabiliriz ...

select * from laptop_price order by Price_euros

-- 6 ) Laptop fiyatlarýný büyükten küçüðe sýralamak istersek aþaðýdaki order by ifadesi ile sorgu yazabiliriz ...

select * from laptop_price order by Price_euros desc

-- 7 ) Sadece Apple markalý laptoplarý görmek istiyoruz diyelim , bunun için "where" komutu ile aþaðýdaki gibi 
-- bir sorgu yazmalýyýz ...

select * from laptop_price where Company = 'Apple'

-- 8 ) Hem Apple hem Asus markalý araçlarý görmek için "where" ve "or" ifadelerini aþaðýdaki gibi kullan-
-- malýyýz ...

select * from laptop_price where Company = 'Apple' or Company = 'Asus'

-- 9 ) Hem 8 GB ram hem de ürünün markasýnýn Lenovo olmasýný istemiþ olalým , "and" ve "where"
-- ifadeleri ile aþaðýdaki gibi bir sorgu yazabiliriz ...

select * from laptop_price where Company = 'Lenovo' and Ram = '8GB'

-- 10 ) Fiyatý 2000 Euro altýnda olan ürünlere bakalým ve onlarý büyükten küçüðe sýralayalým ...

select * from laptop_price where Price_euros < 2000 order by Price_euros desc

-- 11 ) Marka ismi "A" ile baþlayanlarý görmek için "LIKE" komutunu kullanýrýz ...

select * from laptop_price where Company like 'A%'

-- 12 ) Marka ismi "e" ile bitenleri görelim ...

select * from laptop_price where Company like '%e'

-- 13 ) Marka isminde "a" harfi bulunanlarý görelim ...

select * from laptop_price where Company like '%a%'

-- 14 ) Marka isminin baþýnda "A" harfi olmayanlarý görmek için "not" ifadesi kullanýlýr ...

select * from laptop_price where Company not like 'A%'

-- 15 ) Marka ismi A harfi ile baþlayýp e harfi ile biten markalar için aþaðýdaki gibi sorgu yazýlabilir ...

select * from laptop_price where Company like 'A%e'

-- 16 - Ýkinci harfi "s" olan markalar için aþaðýdaki gibi bir sorgu yazýlabilir ... 

select * from laptop_price where Company like '_s%'

-- 17 - Baþ harfi "A" veya "D" olanlarý görmek için aþaðýdaki gibi bir sorgu yazýlýr ...

select * from laptop_price where Company like '[AD]%'

-- 18 - Fiyatý 1000 ile 2500 arasýndaki olan ürünleri görmek için 'between' komutunu kullanabiliriz ...

select * from laptop_price where Price_euros  between 1000 and 2500

--  19 - Hem Windows 10 hem de Linux iþletim sistemine sahip ürünleri görmek istiyorsak "IN" ifadesi ile bunu
-- kýsa yoldan yapabiliriz ...

select * from laptop_price where OpSys in('Windows 10' , 'Linux')

-- 20 - Gruplama iþlemlerinde 'group by' kullanýrýz ürünleri markalarýna göre gruplandýralým ve kaç adet var görelim ...

select Company , count(*) as [Ürün Adet] from laptop_price group by Company

-- 21 Markalarýn ürünlerinin ortalama fiyatlarýný bulalým ...

select Company , avg(Price_euros) as [Ortalama Fiyat] from laptop_price group by Company

-- 22 - Hem marka hem de ürünün tipine göre gruplandýrma yapalým ...

select Company , TypeName , max(Price_euros) as [Maksimum Fiyat] from laptop_price group by Company , TypeName

-- 23 - Ýþletim sistemlerine göre gruplandýrma yapalým ama sadece fiyatý 3000 euro altýnda olan ürünler için ...

select OpSys , count(Company) as [Marka Adedi] , avg(Price_euros) as [Ortalama Fiyatlarý] from laptop_price
where Price_euros <= 3000 group by OpSys

-- 24 - Having ile grupladýðýmýz sütuna filtreleme yapabiliriz ...

select Company , avg(Price_euros) as [Ortalama Fiyat] from laptop_price 
group by Company having avg(Price_euros) > 1500

-- 25 if ifadelerini kullanarak marka sayýsý hakkýnda bilgi sahibi olalým ...

declare @sayý int
select @sayý = COUNT(distinct(Company)) from laptop_price 
if @sayý < 10 
begin 
print 'Marka sayýsý 10 dan azdýr'
end
else if @sayý >= 10 and @sayý <= 15
begin
print 'Marka sayýsý 10-15 arasýndadýr ...'
end
else
begin 
print 'Marka sayýsý 15 den fazladýr ... '
end

-- 26 - case when kullanarak örnek yapalým ...

SELECT *,CASE
WHEN Price_euros < 1000 THEN 'Ucuz'
WHEN Price_euros > 1000 AND Price_euros <= 3000 THEN 'Ortalama Fiyat'
WHEN Price_euros > 3000 THEN 'Pahalý'
END AS [Fiyat Durumu]
FROM laptop_price

-- 27 - iif ile iþletim sistemi durumu hakkýnda bilgilendirme yapalým ...

select * , iif(OpSys = 'macOS' , 'Bu Ürün Apple a aittir' , 'Bu Ürün Apple a ait deðildir') as 
[Ýþletim Sistemi Bilgilendirme] from laptop_price

-- 28 - Marka kýsmý null olan yerleri update edelim ...

update laptop_price set Company = 'Marka Bilinmiyor' where Company is null

select * from laptop_price where Company = 'Marka Bilinmiyor'

-- 29 - 16 GB Ram e sahip olan ürünleri çaðýrabilceðimiz bir procedure oluþturalým ...

create proc ram as
begin
select * from laptop_price where Ram = '16GB'
end

exec ram

-- 30 Ýçine atadýðýmýz deðiþkenden fiyatý yüksek olanlarý gösteren bir trigger yazalým ...

create proc urun_fiyat(@x int) 
as begin
select * from laptop_price where Price_euros > @x
end

exec urun_fiyat 1900 -- 1900 euro dan pahalý ürünler