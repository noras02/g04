/*1. Készítsünk nézetet VSZOBA néven, amely megjeleníti a szobák adatai mellett a megfelelő szálláshely nevét, helyét és a csillagok számát is!

Az oszlopoknak nem szükséges külön nevet adni!
Teszteljük is a nézetet, pl: SELECT * FROM VSZOBA*/
create or alter view vszoba as
SELECT sz.*, szh.szallas_nev, szh.hely, szh.csillagok_szama
from szallashely szh join szoba sz on szh.szallas_id = sz.szallas_fk

select * from vszoba
/*2 Készítsen tárolt eljárást SPUgyfelFoglalasok, amely a paraméterként megkapott ügyfél azonosítóhoz tartozó foglalások adatait listázza!
Teszteljük a tárolt eljárás működését, pl: EXEC SPUgyfelFoglalasok 'laszlo2'
*/
create or alter procedure SPUgyfelFoglalasok
-- paraméterek
@ugyfelazon nvarchar (40)
AS
BEGIN
--sql kód
SELECT *
from Foglalas
where ugyfel_fk = @ugyfelazon
end
exec SPUgyfelFoglalasok 'laszlo2'
/*
3. Készítsen skalár értékű függvényt UDFFerohely néven, amely visszaadja, hogy a paraméterként megkapott foglalás azonosítóhoz hány férőhelyes szoba tartozik!
a. Teszteljük a függvény működését!
*/
create or alter function udfferohely
(
-- paraméterek
  @fazon int
)
returns int-- visszaadott érték típusa
as
BEGIN
DECLARE @ferhoely INT
select @ferohely = sz.FEROHELY
from 
where f.FOGLALAS_PK = @fazon
return @ferohely --visszaadott érték
(
  SELECT sz.ferohely
  FROM FOGLALAS F JOIN SZOBA SZ ON F.SZOBA_FK = SZ.SZOBA_ID
  WHERE F.UGYFEL_FK = @fazon
)
end
select dbo.udfferohely(650)
/*
4. Készítsünk tárolt eljárást SPRangsor néven, amely rangsorolja a szálláshelyeket a foglalások száma alapján (a legtöbb foglalás legyen a rangsorban az első). A listában a szállás azonosítója, neve és a rangsor szerinti helyezés jelenjen meg - holtverseny esetén ugrással (ne sűrűn)! 
a. Teszteljük a tárolt eljárást, pl: EXEC SPRangsor
*/

/*
5. Készítsünk nézetet VFoglalasreszletek néven, amely a következő adatokat jeleníti meg: foglalás azonosítója, az ügyfél neve, a szálláshely neve és helye, a foglalás kezdete és vége, és a szoba száma. 

a. Az oszlopokat nevezzük el értelemszerűen! 
b. Teszteljük a nézet működését, pl: SELECT * FROM VFoglalasreszletek
*/

/*
6.
Készítsen tábla értékű függvényt NEPTUNKÓD_UDFFoglalasnelkuliek néven, amely azon ügyfelek adatait listázza, akik még nem foglaltak egyszer sem az adott évben adott hónapjában! A függvény paraméterként kapja meg a foglalás évét és hónapját! (Itt is a METTOL dátummal dolgozzunk) 
a. Teszteljük is a függvény működését, pl: SELECT * FROM dbo.UJAENB_UDFFoglalasnelkuliek(2016, 10)
*/


