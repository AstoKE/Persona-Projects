// ─────────────────────────────────────────────────────────────
// pages/cart_page.dart
// Sepet Sayfası – ürün listesi, toplam fiyat, satın al simülasyonu
// ─────────────────────────────────────────────────────────────

import 'package:flutter/material.dart';
import '../models/product.dart';

class CartPage extends StatefulWidget {
  final List<Product> cartItems;
  final void Function(Product) onRemove;

  const CartPage({super.key, required this.cartItems, required this.onRemove});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  bool _ordered = false;

  double get _total =>
      widget.cartItems.fold(0, (sum, p) => sum + p.price);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sepetim (${widget.cartItems.length})',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue.shade800,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: Colors.grey.shade50,
      body: _ordered
          ? _buildSuccessView(context)
          : widget.cartItems.isEmpty
              ? _buildEmptyCart()
              : _buildCartList(),
      bottomNavigationBar: widget.cartItems.isNotEmpty && !_ordered
          ? _buildBottomBar(context)
          : null,
    );
  }

  // ── Dolu sepet ──────────────────────────────────────────────
  Widget _buildCartList() {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: widget.cartItems.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (_, i) {
        final p = widget.cartItems[i];
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                p.imageUrl,
                width: 56,
                height: 56,
                fit: BoxFit.contain,
                errorBuilder: (_, __, ___) =>
                    const Icon(Icons.image_not_supported, size: 40),
              ),
            ),
            title: Text(p.name, maxLines: 2, overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
            subtitle: Text(p.category,
                style: TextStyle(color: Colors.blue.shade700, fontSize: 11)),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '₺${p.price.toStringAsFixed(0)}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.blue.shade800, fontSize: 14,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {});
                    widget.onRemove(p);
                  },
                  child: const Icon(Icons.delete_outline, color: Colors.red, size: 20),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // ── Boş sepet ───────────────────────────────────────────────
  Widget _buildEmptyCart() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.shopping_cart_outlined, size: 80, color: Colors.grey.shade300),
          const SizedBox(height: 16),
          const Text('Sepetiniz boş', style: TextStyle(fontSize: 18, color: Colors.grey)),
          const SizedBox(height: 8),
          const Text('Ürün eklemek için listeye dönün.',
              style: TextStyle(fontSize: 13, color: Colors.grey)),
        ],
      ),
    );
  }

  // ── Başarı ekranı ────────────────────────────────────────────
  Widget _buildSuccessView(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.check_circle, size: 90, color: Colors.green),
            const SizedBox(height: 20),
            const Text(
              'Siparişiniz Alındı!',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Teşekkürler! Siparişiniz en kısa sürede\nhazırlanacak.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey, height: 1.5),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () =>
                  Navigator.popUntil(context, (route) => route.isFirst),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade800,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14)),
              ),
              child: const Text('Ana Sayfaya Dön',
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }

  // ── Alt çubuk ───────────────────────────────────────────────
  Widget _buildBottomBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, -2))],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Toplam', style: TextStyle(fontSize: 15, color: Colors.grey)),
              Text(
                '₺${_total.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 22, fontWeight: FontWeight.bold, color: Colors.blue.shade800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () => setState(() => _ordered = true),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue.shade800,
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 52),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            ),
            child: const Text('Satın Al',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
