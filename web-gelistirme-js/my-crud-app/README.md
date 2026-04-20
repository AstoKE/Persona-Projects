# Task Manager – React CRUD App

Web Geliştirme JavaScript eğitim projesi. React + Vite + Tailwind CSS kullanılarak geliştirilmiştir.

## Özellikler

- Görev **Ekle** (Create)
- Görev **Listele** ve ara/filtrele (Read)
- Görev **Düzenle** (Update)
- Görev **Sil** (Delete)
- Tamamlandı / Bekliyor toggle
- Kategori ve öncelik etiketleri
- Anlık istatistik (Toplam / Tamamlanan / Bekleyen)

## Kullanılan Teknolojiler

| Teknoloji | Versiyon |
|-----------|---------|
| React     | 18.x    |
| Vite      | 5.x     |
| Tailwind CSS | 3.x |

## Kurulum ve Çalıştırma

```bash
# Bağımlılıkları yükle
npm install

# Geliştirme sunucusunu başlat
npm run dev

# Build al
npm run build
```

## Proje Yapısı

```
src/
├── Components/
│   ├── ItemCard.jsx   – Tek görev kartı (düzenle / sil / tamamla)
│   ├── ItemForm.jsx   – Ekle / güncelle formu
│   └── ItemList.jsx   – Liste + arama + filtre
├── Pages/
│   └── HomePage.jsx   – Ana sayfa, tüm state yönetimi
├── Interfaces/
│   └── Task.js        – Task arayüzü, yardımcı fonksiyonlar
├── App.jsx
├── main.jsx
└── index.css
```

## Deploy (Netlify)

1. GitHub'a push et
2. netlify.com → "Add new site" → GitHub repo seç
3. Build command: `npm run build`
4. Publish directory: `dist`
5. Deploy!
