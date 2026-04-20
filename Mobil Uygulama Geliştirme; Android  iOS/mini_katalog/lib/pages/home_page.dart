// ─────────────────────────────────────────────────────────────
// pages/home_page.dart
// Ana Sayfa – karşılama ekranı ve navigasyon
// ─────────────────────────────────────────────────────────────

import 'package:flutter/material.dart';
import 'product_list_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blue.shade800, Colors.indigo.shade600],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Header ──────────────────────────────────────
                const Icon(Icons.storefront, size: 56, color: Colors.white70),
                const SizedBox(height: 16),
                const Text(
                  'Mini Katalog',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Ürünleri keşfet, sepetine ekle,\nfırsatları kaçırma!',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 15,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 48),

                // ── Kategori kartları ───────────────────────────
                const Text(
                  'Kategoriler',
                  style: TextStyle(color: Colors.white70, fontSize: 13, letterSpacing: 1),
                ),
                const SizedBox(height: 12),
                _CategoryGrid(context),
                const Spacer(),

                // ── CTA Butonu ──────────────────────────────────
                SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: ElevatedButton.icon(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const ProductListPage()),
                    ),
                    icon: const Icon(Icons.grid_view_rounded),
                    label: const Text(
                      'Tüm Ürünleri Gör',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.blue.shade800,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _CategoryGrid(BuildContext context) {
    final cats = [
      {'icon': Icons.phone_android, 'label': 'Elektronik'},
      {'icon': Icons.checkroom,     'label': 'Giyim'},
      {'icon': Icons.menu_book,     'label': 'Kitap'},
      {'icon': Icons.home,          'label': 'Diğer'},
    ];
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 4,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      childAspectRatio: 0.85,
      children: cats.map((c) {
        return GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ProductListPage(filterCategory: c['label'] as String),
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(c['icon'] as IconData, color: Colors.white, size: 26),
                const SizedBox(height: 6),
                Text(
                  c['label'] as String,
                  style: const TextStyle(color: Colors.white, fontSize: 10),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
