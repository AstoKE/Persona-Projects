# Mini Katalog – Flutter Uygulaması

Flutter ile geliştirilmiş e-ticaret katalog uygulaması. Persona Projects – Mobil Uygulama Geliştirme eğitim projesi.

## Ekranlar

| Ekran | Açıklama |
|-------|---------|
| Ana Sayfa | Karşılama ekranı, kategori navigasyonu |
| Ürün Listesi | GridView, arama, kategori filtresi, sepet sayacı |
| Ürün Detayı | Görsel, açıklama, özellikler, sepete ekle/çıkar |
| Sepet | Ürün listesi, toplam fiyat, satın al simülasyonu |

## Kullanılan Flutter Sürümü

Flutter 3.x (Dart 3.0+)

## Çalıştırma Adımları

```bash
# Bağımlılıkları yükle
flutter pub get

# Emülatörü başlat (Android Studio üzerinden)
# veya fiziksel cihaz bağla

# Çalıştır
flutter run

# Release APK al
flutter build apk --release
```

## Proje Yapısı

```
lib/
├── main.dart                        # Giriş noktası, tema tanımları
├── models/
│   └── product.dart                 # Product modeli + demo veri
├── pages/
│   ├── home_page.dart               # Ana sayfa
│   ├── product_list_page.dart       # Ürün listesi (GridView)
│   ├── product_detail_page.dart     # Ürün detayı
│   └── cart_page.dart               # Sepet
└── widgets/
    └── product_card.dart            # Tekrar kullanılabilir ürün kartı
```

## Öğrenme Hedefleri

- [x] Stateless & Stateful Widget kullanımı
- [x] GridView.builder ile liste oluşturma
- [x] Navigator.push / pop sayfa geçişleri
- [x] Route Arguments ile veri taşıma
- [x] setState ile state güncelleme (sepet)
- [x] Image.network ile görsel yükleme
- [x] Arama ve filtreleme mantığı
- [x] CustomScrollView + SliverAppBar
- [x] SnackBar bildirimleri
