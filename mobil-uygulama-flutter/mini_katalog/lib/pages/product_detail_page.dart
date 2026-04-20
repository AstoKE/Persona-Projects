// ─────────────────────────────────────────────────────────────
// pages/product_detail_page.dart
// Ürün Detay Sayfası – Route Arguments ile veri taşıma
// ─────────────────────────────────────────────────────────────

import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductDetailPage extends StatefulWidget {
  final Product product;
  final bool inCart;
  final VoidCallback onCartToggle;

  const ProductDetailPage({
    super.key,
    required this.product,
    required this.inCart,
    required this.onCartToggle,
  });

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  late bool _inCart;

  @override
  void initState() {
    super.initState();
    _inCart = widget.inCart;
  }

  @override
  Widget build(BuildContext context) {
    final p = widget.product;

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          // ── Üst Görsel Alanı ────────────────────────────────
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            backgroundColor: Colors.blue.shade800,
            foregroundColor: Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                color: Colors.grey.shade100,
                padding: const EdgeInsets.all(24),
                child: Image.network(
                  p.imageUrl,
                  fit: BoxFit.contain,
                  errorBuilder: (_, __, ___) => const Icon(
                    Icons.image_not_supported, size: 80, color: Colors.grey,
                  ),
                ),
              ),
            ),
          ),

          // ── Detay İçeriği ────────────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Kategori etiketi
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      p.category,
                      style: TextStyle(
                        color: Colors.blue.shade700,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Ürün adı
                  Text(
                    p.name,
                    style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Fiyat + Puan
                  Row(
                    children: [
                      Text(
                        '₺${p.price.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue.shade800,
                        ),
                      ),
                      const Spacer(),
                      const Icon(Icons.star, color: Colors.amber, size: 18),
                      const SizedBox(width: 4),
                      Text(
                        '${p.rating.toStringAsFixed(1)} / 5.0',
                        style: const TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Açıklama başlığı
                  const Text(
                    'Ürün Açıklaması',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    p.description,
                    style: const TextStyle(
                      fontSize: 14, color: Colors.black54, height: 1.6,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Teknik Özellikler (demo)
                  const Text(
                    'Özellikler',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  _SpecRow('Kategori', p.category),
                  _SpecRow('Değerlendirme', '${p.rating.toStringAsFixed(1)} / 5.0'),
                  _SpecRow('Stok Durumu', 'Stokta Var'),
                  _SpecRow('Kargo', 'Ücretsiz Kargo'),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),

      // ── Sepet Butonu ─────────────────────────────────────────
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
        child: ElevatedButton.icon(
          onPressed: () {
            setState(() => _inCart = !_inCart);
            widget.onCartToggle();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(_inCart ? '${p.name} sepete eklendi!' : '${p.name} sepetten çıkarıldı.'),
                backgroundColor: _inCart ? Colors.green : Colors.orange,
                duration: const Duration(seconds: 2),
                behavior: SnackBarBehavior.floating,
              ),
            );
          },
          icon: Icon(_inCart ? Icons.remove_shopping_cart : Icons.add_shopping_cart),
          label: Text(
            _inCart ? 'Sepetten Çıkar' : 'Sepete Ekle',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: _inCart ? Colors.orange.shade700 : Colors.blue.shade800,
            foregroundColor: Colors.white,
            minimumSize: const Size(double.infinity, 54),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          ),
        ),
      ),
    );
  }

  Widget _SpecRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 120,
            child: Text(label, style: const TextStyle(color: Colors.grey, fontSize: 13)),
          ),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
        ],
      ),
    );
  }
}
