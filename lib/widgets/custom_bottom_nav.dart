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
            height: 48,
            width: 48,
            decoration: BoxDecoration(
              gradient: isSelected
                  ? LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        const Color(0xff46C6D9),
                        const Color(0xff2BA8C6),
                      ],
                    )
                  : LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.grey.shade100,
                        Colors.grey.shade200,
                      ],
                    ),
              shape: BoxShape.circle,
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: const Color(0xff46C6D9).withValues(alpha: 0.4),
                        blurRadius: 12,
                        offset: const Offset(0, 6),
                      ),
                      BoxShadow(
                        color: const Color(0xff46C6D9).withValues(alpha: 0.2),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ]
                  : [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
            ),
            child: Icon(
              icon,
              color: isSelected ? Colors.white : Colors.grey.shade600,
              size: 28,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            title,
            style: TextStyle(
              fontSize: 11,
              color: isSelected ? const Color(0xff46C6D9) : Colors.grey.shade600,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
              letterSpacing: isSelected ? 0.3 : 0,
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
