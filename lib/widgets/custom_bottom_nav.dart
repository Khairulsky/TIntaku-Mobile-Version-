import 'package:flutter/material.dart';

import '../pages/beranda/beranda_page.dart';
import '../pages/keranjang/keranjang_page.dart';
import '../pages/produk/produk_page.dart';
import '../pages/riwayat/riwayat_page.dart';
import '../pages/profile/profile_page.dart';

class CustomBottomNav extends StatelessWidget {
  final int selectedIndex;

  const CustomBottomNav({super.key, required this.selectedIndex});

  Widget navItem({
    required BuildContext context,
    required IconData icon,
    required String title,
    required bool isSelected,
    required Widget page,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => page),
        );
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 42,
            width: 42,
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xffB9EAF6) : Colors.transparent,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.black, size: 26),
          ),
          const SizedBox(height: 5),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: Colors.black,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 85,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xffEAEAEA))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          navItem(
            context: context,
            icon: Icons.home,
            title: "Beranda",
            isSelected: selectedIndex == 0,
            page: const BerandaPage(),
          ),

          navItem(
            context: context,
            icon: Icons.shopping_cart_outlined,
            title: "Keranjang",
            isSelected: selectedIndex == 1,
            page: const KeranjangPage(),
          ),

          navItem(
            context: context,
            icon: Icons.shopping_bag_outlined,
            title: "Produk",
            isSelected: selectedIndex == 2,
            page: const ProdukPage(),
          ),

          navItem(
            context: context,
            icon: Icons.receipt_long_outlined,
            title: "Riwayat",
            isSelected: selectedIndex == 3,
            page: const RiwayatPage(),
          ),

          navItem(
            context: context,
            icon: Icons.person_outline,
            title: "Profile",
            isSelected: selectedIndex == 4,
            page: const ProfilePage(),
          ),
        ],
      ),
    );
  }
}
