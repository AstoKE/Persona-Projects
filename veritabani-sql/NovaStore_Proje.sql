-- ============================================================
--  NovaStore E-Ticaret Veri Yonetim Sistemi
--  Hazırlayan : [Ad Soyad]
--  Tarih       : 2026-04-20
-- ============================================================

-- ============================================================
-- BOLUM 1: Veri Tabani Olusturma (DDL)
-- ============================================================

-- Veri tabanını sil (varsa) ve yeniden olustur
IF EXISTS (SELECT name FROM sys.databases WHERE name = 'NovaStoreDB')
    DROP DATABASE NovaStoreDB;
GO

CREATE DATABASE NovaStoreDB;
GO

USE NovaStoreDB;
GO

-- -----------------------------------------------
-- Tablo A: Categories (Kategoriler)
-- -----------------------------------------------
CREATE TABLE Categories (
    CategoryID   INT          IDENTITY(1,1) PRIMARY KEY,
    CategoryName VARCHAR(50)  NOT NULL
);
GO

-- -----------------------------------------------
-- Tablo B: Products (Urunler)
-- -----------------------------------------------
CREATE TABLE Products (
    ProductID   INT            IDENTITY(1,1) PRIMARY KEY,
    ProductName VARCHAR(100)   NOT NULL,
    Price       DECIMAL(10,2),
    Stock       INT            DEFAULT 0,
    CategoryID  INT            REFERENCES Categories(CategoryID)
);
GO

-- -----------------------------------------------
-- Tablo C: Customers (Musteriler)
-- -----------------------------------------------
CREATE TABLE Customers (
    CustomerID INT          IDENTITY(1,1) PRIMARY KEY,
    FullName   VARCHAR(50),
    City       VARCHAR(20),
    Email      VARCHAR(100) UNIQUE
);
GO

-- -----------------------------------------------
-- Tablo D: Orders (Siparisler)
-- -----------------------------------------------
CREATE TABLE Orders (
    OrderID     INT            IDENTITY(1,1) PRIMARY KEY,
    CustomerID  INT            REFERENCES Customers(CustomerID),
    OrderDate   DATETIME       DEFAULT GETDATE(),
    TotalAmount DECIMAL(10,2)
);
GO

-- -----------------------------------------------
-- Tablo E: OrderDetails (Siparis Detaylari - Ara Tablo)
-- -----------------------------------------------
CREATE TABLE OrderDetails (
    DetailID  INT IDENTITY(1,1) PRIMARY KEY,
    OrderID   INT REFERENCES Orders(OrderID),
    ProductID INT REFERENCES Products(ProductID),
    Quantity  INT
);
GO

-- ============================================================
-- BOLUM 2: Veri Girisi (DML - INSERT)
-- ============================================================

-- -----------------------------------------------
-- Gorev 1: 5 Kategori ekle
-- -----------------------------------------------
INSERT INTO Categories (CategoryName) VALUES
    ('Elektronik'),
    ('Giyim'),
    ('Kitap'),
    ('Kozmetik'),
    ('Ev ve Yasam');
GO

-- -----------------------------------------------
-- Gorev 2: En az 10-12 Urun ekle
-- -----------------------------------------------
INSERT INTO Products (ProductName, Price, Stock, CategoryID) VALUES
    -- Elektronik (CategoryID = 1)
    ('Laptop',              12000.00,  15, 1),
    ('Akilli Telefon',       8500.00,  30, 1),
    ('Kulaklik',             1200.00,  50, 1),
    ('Tablet',               5500.00,  18, 1),
    -- Giyim (CategoryID = 2)
    ('T-Shirt',               199.00, 100, 2),
    ('Kot Pantolon',          450.00,  60, 2),
    ('Mont',                  850.00,  25, 2),
    -- Kitap (CategoryID = 3)
    ('Roman Kitabi',           75.00, 200, 3),
    ('Programlama Rehberi',   180.00,  90, 3),
    -- Kozmetik (CategoryID = 4)
    ('Ruj',                   150.00,  80, 4),
    ('Nemlendirici',          250.00,  45, 4),
    -- Ev ve Yasam (CategoryID = 5)
    ('Avize',                1800.00,  10, 5),
    ('Yatak Ortusu',          600.00,  25, 5);
GO

-- -----------------------------------------------
-- Gorev 3: 5-6 Musteri kaydi olustur
-- -----------------------------------------------
INSERT INTO Customers (FullName, City, Email) VALUES
    ('Ahmet Yilmaz',  'Istanbul', 'ahmet.yilmaz@mail.com'),
    ('Fatma Demir',   'Ankara',   'fatma.demir@mail.com'),
    ('Mehmet Kaya',   'Izmir',    'mehmet.kaya@mail.com'),
    ('Ayse Celik',    'Bursa',    'ayse.celik@mail.com'),
    ('Ali Ozturk',    'Antalya',  'ali.ozturk@mail.com'),
    ('Zeynep Arslan', 'Konya',    'zeynep.arslan@mail.com');
GO

-- -----------------------------------------------
-- Gorev 4: 8-10 Siparis ve Siparis Detaylari
-- -----------------------------------------------
INSERT INTO Orders (CustomerID, OrderDate, TotalAmount) VALUES
    (1, '2024-01-10', 13200.00),   -- Ahmet: Laptop + Kulaklik
    (2, '2024-01-15',   449.00),   -- Fatma: 2 T-Shirt + Kitap
    (3, '2024-01-20',  8500.00),   -- Mehmet: Telefon
    (4, '2024-02-05',  1300.00),   -- Ayse: Nemlendirici + Ruj + Kot Pantolon
    (1, '2024-02-14',  5500.00),   -- Ahmet: Tablet
    (5, '2024-02-20',   255.00),   -- Ali: 2 Roman + Programlama Kitabi
    (6, '2024-03-01',  1800.00),   -- Zeynep: Avize
    (2, '2024-03-10',   850.00),   -- Fatma: Mont
    (3, '2024-03-22',  1200.00),   -- Mehmet: Kulaklik
    (4, '2024-04-01',   600.00);   -- Ayse: Yatak Ortusu
GO

INSERT INTO OrderDetails (OrderID, ProductID, Quantity) VALUES
    -- Siparis 1: Ahmet - Laptop + Kulaklik
    (1, 1, 1),
    (1, 3, 1),
    -- Siparis 2: Fatma - 2 T-Shirt + Roman
    (2, 5, 2),
    (2, 8, 1),
    -- Siparis 3: Mehmet - Akilli Telefon
    (3, 2, 1),
    -- Siparis 4: Ayse - Nemlendirici + Ruj + Kot Pantolon
    (4, 11, 1),
    (4, 10, 1),
    (4, 6, 1),
    -- Siparis 5: Ahmet - Tablet
    (5, 4, 1),
    -- Siparis 6: Ali - 2 Roman + Programlama Kitabi
    (6, 8, 2),
    (6, 9, 1),
    -- Siparis 7: Zeynep - Avize
    (7, 12, 1),
    -- Siparis 8: Fatma - Mont
    (8, 7, 1),
    -- Siparis 9: Mehmet - Kulaklik
    (9, 3, 1),
    -- Siparis 10: Ayse - Yatak Ortusu
    (10, 13, 1);
GO

-- ============================================================
-- BOLUM 3: Sorgulama ve Analiz (DQL)
-- ============================================================

-- -----------------------------------------------
-- Sorgu 1: Temel Listeleme
-- Stok miktari 20'den az olan urunler (AZALAN sirali)
-- -----------------------------------------------
SELECT
    ProductName  AS UrunAdi,
    Stock        AS StokAdedi
FROM Products
WHERE Stock < 20
ORDER BY Stock DESC;
GO

-- -----------------------------------------------
-- Sorgu 2: Veri Birlestirme (INNER JOIN)
-- Hangi musteri, hangi tarihte siparis vermis?
-- -----------------------------------------------
SELECT
    c.FullName      AS MusteriAdi,
    c.City          AS Sehir,
    o.OrderDate     AS SiparisTarihi,
    o.TotalAmount   AS ToplamTutar
FROM Customers c
INNER JOIN Orders o ON c.CustomerID = o.CustomerID
ORDER BY o.OrderDate;
GO

-- -----------------------------------------------
-- Sorgu 3: Coklu Birlestirme (5 Tablo JOIN)
-- Ahmet Yilmaz'in aldigi urunlerin detayi
-- -----------------------------------------------
SELECT
    c.FullName       AS MusteriAdi,
    p.ProductName    AS UrunAdi,
    p.Price          AS BirimFiyat,
    cat.CategoryName AS Kategori
FROM Customers c
JOIN Orders       o   ON c.CustomerID  = o.CustomerID
JOIN OrderDetails od  ON o.OrderID     = od.OrderID
JOIN Products     p   ON od.ProductID  = p.ProductID
JOIN Categories   cat ON p.CategoryID  = cat.CategoryID
WHERE c.FullName = 'Ahmet Yilmaz';
GO

-- -----------------------------------------------
-- Sorgu 4: Gruplama ve Aggregate
-- Her kategoride kac adet urun var?
-- -----------------------------------------------
SELECT
    cat.CategoryName       AS Kategori,
    COUNT(p.ProductID)     AS UrunSayisi
FROM Categories cat
LEFT JOIN Products p ON cat.CategoryID = p.CategoryID
GROUP BY cat.CategoryName
ORDER BY UrunSayisi DESC;
GO

-- -----------------------------------------------
-- Sorgu 5: Ciro Analizi
-- Her musterinin toplam harcamasi (buyukten kucuge)
-- -----------------------------------------------
SELECT
    c.FullName            AS MusteriAdi,
    SUM(o.TotalAmount)    AS ToplamCiro
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.FullName
ORDER BY ToplamCiro DESC;
GO

-- -----------------------------------------------
-- Sorgu 6: Zaman Analizi
-- Siparisler uzerinden kac gun gecmis?
-- -----------------------------------------------
SELECT
    o.OrderID,
    c.FullName                             AS MusteriAdi,
    o.OrderDate,
    DATEDIFF(DAY, o.OrderDate, GETDATE())  AS GecenGunSayisi
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
ORDER BY GecenGunSayisi DESC;
GO

-- ============================================================
-- BOLUM 4: Ileri Seviye Veri Tabani Nesneleri
-- ============================================================

-- -----------------------------------------------
-- Gorev 1: VIEW olusturma - vw_SiparisOzet
-- -----------------------------------------------
CREATE VIEW vw_SiparisOzet AS
    SELECT
        c.FullName       AS MusteriAdi,
        o.OrderDate      AS SiparisTarihi,
        p.ProductName    AS UrunAdi,
        cat.CategoryName AS Kategori,
        od.Quantity      AS Adet,
        p.Price          AS BirimFiyat,
        (od.Quantity * p.Price) AS SatirToplami
    FROM Customers c
    JOIN Orders       o   ON c.CustomerID = o.CustomerID
    JOIN OrderDetails od  ON o.OrderID    = od.OrderID
    JOIN Products     p   ON od.ProductID = p.ProductID
    JOIN Categories   cat ON p.CategoryID = cat.CategoryID;
GO

-- View kullanimi ornegi:
-- SELECT * FROM vw_SiparisOzet ORDER BY SiparisTarihi DESC;
-- SELECT MusteriAdi, SUM(SatirToplami) AS Toplam FROM vw_SiparisOzet GROUP BY MusteriAdi;

-- -----------------------------------------------
-- Gorev 2: Yedekleme (Backup)
-- -----------------------------------------------
-- NOT: Calistirmadan once C:\Yedek\ klasorunu olusturun.
BACKUP DATABASE NovaStoreDB
    TO DISK = 'C:\Yedek\NovaStoreDB.bak'
    WITH FORMAT, INIT,
         NAME   = 'NovaStoreDB Full Backup',
         STATS  = 10;
GO

-- ============================================================
-- EKSTRA: Faydali Kontrol Sorgulari
-- ============================================================

-- Tum tablolardaki kayit sayilari
SELECT 'Categories'  AS Tablo, COUNT(*) AS Kayit FROM Categories  UNION ALL
SELECT 'Products',             COUNT(*)           FROM Products    UNION ALL
SELECT 'Customers',            COUNT(*)           FROM Customers   UNION ALL
SELECT 'Orders',               COUNT(*)           FROM Orders      UNION ALL
SELECT 'OrderDetails',         COUNT(*)           FROM OrderDetails;
GO

-- Stok durumu ozeti
SELECT
    cat.CategoryName,
    COUNT(p.ProductID) AS UrunSayisi,
    SUM(p.Stock)       AS ToplamStok,
    MIN(p.Price)       AS MinFiyat,
    MAX(p.Price)       AS MaxFiyat,
    AVG(p.Price)       AS OrtFiyat
FROM Categories cat
LEFT JOIN Products p ON cat.CategoryID = p.CategoryID
GROUP BY cat.CategoryName;
GO
