import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../widgets/custom_bottom_nav.dart';
import 'package:google_fonts/google_fonts.dart';
import '../keranjang/keranjang_page.dart';
import '../detail/detail_page.dart';
import '../produk/produk_page.dart';

class BerandaPage extends StatelessWidget {
  const BerandaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF46C6D9), Color(0xFFB8EEF5), Color(0xFFF7F7F7)],
            stops: [0.0, 0.25, 0.6],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // HEADER
                  Row(
  crossAxisAlignment: CrossAxisAlignment.center,
  children: [

    // Logo
    SizedBox(
      width: 80,
      height: 80,
      child: Image.asset(
        "assets/img/logo_tintaku.png",
        fit: BoxFit.contain,
      ),
    ),

    const SizedBox(width: 12),

    // Judul
    Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Toko Tintaku",
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "Solusi Tinta Printer Anda",
            style: TextStyle(
              color: Colors.grey.shade700,
              fontSize: 10,
            ),
          ),
        ],
      ),
    ),

    // Chat
    Column(
      mainAxisSize: MainAxisSize.min,
      children: const [
        Icon(Icons.chat_bubble_outline, size: 30),
        SizedBox(height: 4),
        Text(
          "Chat",
          style: TextStyle(fontSize: 12),
        ),
      ],
    ),

    const SizedBox(width: 20),

    // Notifikasi
    Stack(
      clipBehavior: Clip.none,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(Icons.notifications_none, size: 30),
            SizedBox(height: 4),
            Text(
              "Notifikasi",
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),

        Positioned(
          right: -4,
          top: -4,
          child: Container(
            width: 18,
            height: 18,
            decoration: const BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                "3",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  ],
),
                  const SizedBox(height: 20),

                  // SEARCH
                  Container(
                    height: 48,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 8,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const TextField(
                      decoration: InputDecoration(
                        hintText: "Cari tinta printer...",
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 14),
                        prefixIcon: Icon(
                          Icons.search,
                          color: Color(0xff46C6D9),
                          size: 24,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // BANNER SLIDER
                  Column(
                    children: [
                      CarouselSlider(
                        options: CarouselOptions(
                          height: 200,
                          viewportFraction: 1.0,
                          autoPlay: true,
                          autoPlayInterval: const Duration(seconds: 3),
                          autoPlayAnimationDuration: const Duration(
                            milliseconds: 800,
                          ),
                        ),
                        items:
                            [
                              "assets/img/banner1.png",
                              "assets/img/banner2.png",
                              "assets/img/banner3.png",
                              "assets/img/banner4.png",
                              "assets/img/banner5.png",
                            ].map((item) {
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.asset(
                                  item,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              );
                            }).toList(),
                      ),
                    ],
                  ),

                  const SizedBox(height: 25),
                  // KATEGORI
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Kategori",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      GestureDetector(
                        onTap: () {},
                        child: const Row(
                          children: [
                            Text(
                              "Lihat Semua",
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(width: 4),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 12,
                              color: Colors.blue,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  SizedBox(
                    height: 150,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        _categoryCard("Tinta HP", "assets/img/brand/HP.png"),

                        const SizedBox(width: 12),

                        _categoryCard(
                          "Tinta Canon",
                          "assets/img/brand/CANON.png",
                        ),

                        const SizedBox(width: 12),

                        _categoryCard(
                          "Tinta Epson",
                          "assets/img/brand/EPSON.png",
                        ),

                        const SizedBox(width: 12),

                        _categoryCard(
                          "Tinta Brother",
                          "assets/img/brand/BROTHER.png",
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 25),
                  // JUDUL
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Produk Populer",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      GestureDetector(
                        onTap: () {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => const ProdukPage(),
    ),
  );
},
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Lihat Semua",
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                              ),
                            ),
                            SizedBox(width: 4),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 12,
                              color: Colors.blue,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 15),

                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 4,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 15,
                          mainAxisSpacing: 15,
                          childAspectRatio: 0.62,
                        ),
                  itemBuilder: (context, index) {
  if (index == 0) {
    return _productCard(
      context,
      "Tinta Epson Black",
      "assets/img/epson_hitam.png.jpeg",
      "Rp 200.000",
    );
  } else if (index == 1) {
    return _productCard(
      context,
      "Tinta Epson Yellow",
      "assets/img/epson_yellow.png.jpeg",
      "Rp 200.000",
    );
  } else if (index == 2) {
    return _productCard(
      context,
      "Tinta HP Black",
      "assets/img/hp_hitam.png.jpeg",
      "Rp 220.000",
    );
  } else {
    return _productCard(
      context,
      "Tinta Canon Black",
      "assets/img/canon_hitam.png.jpeg",
      "Rp 250.000",
    );
  }

},
                  ),
                ],
              ),
            ),
          ),
        ),
      ),

      bottomNavigationBar: const CustomBottomNav(selectedIndex: 0),
    );
  }

 Widget _productCard(
  BuildContext context,
  String nama,
  String gambar,
  String harga,
) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.red.shade500,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    "-20%",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.favorite_border,
                    size: 16,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),

          // Gambar Produk
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Image.asset(
                gambar,
                fit: BoxFit.contain,
              ),
            ),
          ),

          // Detail Produk
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Text(
                  nama,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    height: 1.3,
                  ),
                ),

                const SizedBox(height: 6),

                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 14),
                    const SizedBox(width: 2),
                    Text(
                      "4.9",
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontSize: 11,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      "(120)",
                      style: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                Text(
                  harga,
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 36,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff46C6D9),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 0,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const DetailPage(
                                  namaProduk: "Tinta Epson 003 Black Original",
                                  harga: "Rp 200.000",
                                  gambar: "assets/img/epson_hitam.png.jpeg",
                                  deskripsi: "Tinta berkualitas tinggi untuk kebutuhan cetak sehari-hari.",
                                ),
                              ),
                            );
                          },
                          child: const Text(
                            "Detail",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 8),

                    Container(
                      width: 38,
                      height: 38,
                      decoration: BoxDecoration(
                        color: const Color(0xff46C6D9),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: IconButton(
                              padding: EdgeInsets.zero,
                              onPressed: () {

                                globalCartItems.add({
                                  "nama": "Tinta Epson 003 Black Original",
                                  "gambar": "assets/img/epson_hitam.png.jpeg",
                                  "harga": 200000,
                                  "jumlah": 1,
                                });

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const KeranjangPage(),
                                  ),
                                );
                              },
                        icon: const Icon(
                        Icons.shopping_cart_outlined,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget _categoryCard(String title, String imagePath) {
    return Container(
      width: 150,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE5E7EB)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo Brand
            Image.asset(imagePath, height: 50, fit: BoxFit.contain),

            const SizedBox(height: 12),

            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),

            const SizedBox(height: 4),

            Text(
              "Lihat Produk",
              style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _menuIcon(IconData icon, String title) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: const Color(0xff46C6D9),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Icon(icon, color: Colors.white, size: 28),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
