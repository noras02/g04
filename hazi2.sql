CREATE TABLE maszkolt_ugyfel (
    login VARCHAR(255) MASKED with (FUNCTION = 'default()'),
    email VARCHAR(255) MASKED with  (FUNCTION = 'email()'),
    nev VARCHAR(255) MASKED WITH (FUNCTION = 'partial(1,"XXX",1)'),
    szulev INT MASKED with (FUNCTION = 'random(1,1000)'),
    nem VARCHAR(1),
    cim VARCHAR(255)
);
INSERT INTO maszkolt_ugyfel (login, email, nev, szulev, nem, cim)
select
    login,
    email,
    nev,
    szulev,
    nem,
    cim
    from Results;
--lekérdezés
SELECT*FROM maszkolt_ugyfel;
-- felhasználó létrehozása
CREATE USER webshop_user without LOGIN;
GRANT SELECT ON maszkolt_ugyfel TO webshop_user
EXECUTE as user='webshop_user';
SELECT * FROM maszkolt_ugyfel
REVERT