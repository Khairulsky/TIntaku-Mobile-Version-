import 'package:flutter/material.dart';
import '../../widgets/custom_bottom_nav.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FA),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // HEADER PROFILE
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xff46C6D9), Color(0xff6EDBE8)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 10),

                    CircleAvatar(
                      radius: 45,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.person,
                        size: 55,
                        color: Color(0xff46C6D9),
                      ),
                    ),

                    const SizedBox(height: 12),

                    const Text(
                      "Chairul Anwar",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 4),

                    const Text(
                      "chairul@email.com",
                      style: TextStyle(color: Colors.white70, fontSize: 13),
                    ),

                    const SizedBox(height: 12),

                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.workspace_premium,
                            color: Colors.amber,
                            size: 18,
                          ),
                          SizedBox(width: 5),
                          Text(
                            "Gold Member",
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // STATUS PESANAN
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.symmetric(vertical: 18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _OrderStatus(
                      icon: Icons.pending_actions,
                      title: "Diproses",
                      count: "2",
                    ),
                    _OrderStatus(
                      icon: Icons.local_shipping,
                      title: "Dikirim",
                      count: "1",
                    ),
                    _OrderStatus(
                      icon: Icons.check_circle,
                      title: "Selesai",
                      count: "15",
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // MENU
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    _menuTile(Icons.person_outline, "Informasi Akun"),

                    _divider(),

                    _menuTile(Icons.location_on_outlined, "Alamat Pengiriman"),

                    _divider(),

                    _menuTile(Icons.history, "Riwayat Pembelian"),

                    _divider(),

                    _menuTile(Icons.favorite_border, "Produk Favorit"),

                    _divider(),

                    _menuTile(Icons.support_agent, "Pusat Bantuan"),

                    _divider(),

                    _menuTile(Icons.settings_outlined, "Pengaturan"),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // LOGOUT
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    onPressed: () {},
                    icon: const Icon(Icons.logout, color: Colors.white),
                    label: const Text(
                      "Keluar",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),

      bottomNavigationBar: const CustomBottomNav(selectedIndex: 4),
    );
  }

  static Widget _divider() {
    return const Divider(height: 1, indent: 15, endIndent: 15);
  }

  static Widget _menuTile(IconData icon, String title) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xff46C6D9)),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () {},
    );
  }
}

class _OrderStatus extends StatelessWidget {
  final IconData icon;
  final String title;
  final String count;

  const _OrderStatus({
    required this.icon,
    required this.title,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: Color(0xff46C6D9), size: 28),
        const SizedBox(height: 5),
        Text(
          count,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text(title, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}
