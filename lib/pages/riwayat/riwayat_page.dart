import 'package:flutter/material.dart';
import '../../widgets/custom_bottom_nav.dart';

class RiwayatPage extends StatelessWidget {
  const RiwayatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Riwayat"),
      ),
      body: const Center(
        child: Text(
          "Halaman Riwayat",
          style: TextStyle(fontSize: 24),
        ),
      ),
      bottomNavigationBar: const CustomBottomNav(
        selectedIndex: 3,
      ),
    );
  }
}