// ─────────────────────────────────────────────────────────────
// models/product.dart
// Ürün veri modeli – fromJson / toJson destekli
// ─────────────────────────────────────────────────────────────

class Product {
  final int id;
  final String name;
  final String category;
  final double price;
  final String description;
  final String imageUrl;
  final double rating;

  const Product({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.description,
    required this.imageUrl,
    this.rating = 4.0,
  });

  // JSON'dan model oluşturma
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id:          json['id']          as int,
      name:        json['title']       as String,
      category:    json['category']    as String,
      price:       (json['price'] as num).toDouble(),
      description: json['description'] as String,
      imageUrl:    json['image']       as String,
      rating:      (json['rating']?['rate'] as num?)?.toDouble() ?? 4.0,
    );
  }

  // Modeli JSON'a çevirme
  Map<String, dynamic> toJson() => {
    'id':          id,
    'title':       name,
    'category':    category,
    'price':       price,
    'description': description,
    'image':       imageUrl,
  };
}

// ─────────────────────────────────────────────────────────────
// Demo / simülasyon verisi (API yokken kullanılır)
// ─────────────────────────────────────────────────────────────
final List<Product> demoProducts = [
  const Product(
    id: 1,
    name: 'iPhone 15 Pro',
    category: 'Elektronik',
    price: 42999.99,
    description: 'Apple\'ın en güçlü akıllı telefonu. A17 Pro çip, titanyum kasa ve gelişmiş kamera sistemi.',
    imageUrl: 'https://fakestoreapi.com/img/81fAn-6IuAL._AC_SX679_.jpg',
    rating: 4.8,
  ),
  const Product(
    id: 2,
    name: 'MacBook Pro 14"',
    category: 'Elektronik',
    price: 75999.99,
    description: 'M3 Pro çipli MacBook Pro. Profesyonel kullanım için tasarlanmış güçlü laptop.',
    imageUrl: 'https://fakestoreapi.com/img/61IBBVJvSDL._AC_SY879_.jpg',
    rating: 4.9,
  ),
  const Product(
    id: 3,
    name: 'AirPods Pro 2',
    category: 'Elektronik',
    price: 8999.99,
    description: 'Aktif Gürültü Engelleme ve Uyarlanabilir Ses özellikleriyle AirPods Pro.',
    imageUrl: 'https://fakestoreapi.com/img/71-3HjGNDUL._AC_SY879._SX._UX._SY._UY_.jpg',
    rating: 4.7,
  ),
  const Product(
    id: 4,
    name: 'iPad Air',
    category: 'Elektronik',
    price: 27999.99,
    description: 'M2 çipli iPad Air. Üretkenlik ve yaratıcılık için mükemmel tablet.',
    imageUrl: 'https://fakestoreapi.com/img/51UDEzMJVpL._AC_UL640_FMwebp_QL65_.jpg',
    rating: 4.6,
  ),
  const Product(
    id: 5,
    name: 'Nike Air Max 270',
    category: 'Giyim',
    price: 3499.99,
    description: 'Max Air yastıklama teknolojisiyle rahat ve şık spor ayakkabı.',
    imageUrl: 'https://fakestoreapi.com/img/71pWzhdJNwL._AC_UL640_FMwebp_QL65_.jpg',
    rating: 4.3,
  ),
  const Product(
    id: 6,
    name: 'Levi\'s 501 Kot Pantolon',
    category: 'Giyim',
    price: 1299.99,
    description: 'Klasik kesim, dayanıklı denim kumaş. Her kombinasyona uygun.',
    imageUrl: 'https://fakestoreapi.com/img/71YXzeOuslL._AC_UY879_.jpg',
    rating: 4.1,
  ),
  const Product(
    id: 7,
    name: 'Clean Code – Robert C. Martin',
    category: 'Kitap',
    price: 349.99,
    description: 'Yazılım geliştirme dünyasının klasiklerinden. Temiz kod yazmanın sanatı.',
    imageUrl: 'https://fakestoreapi.com/img/81Zt42ioCgL._AC_SX679_.jpg',
    rating: 4.9,
  ),
  const Product(
    id: 8,
    name: 'Flutter & Dart Rehberi',
    category: 'Kitap',
    price: 199.99,
    description: 'Başlangıçtan ileri seviyeye Flutter ile mobil uygulama geliştirme.',
    imageUrl: 'https://fakestoreapi.com/img/51eg55uqpJL._AC_UX679_.jpg',
    rating: 4.5,
  ),
];
