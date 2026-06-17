import 'package:flutter/material.dart';
import '../keranjang/keranjang_page.dart';
import '../checkout/checkout_page.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailPage extends StatelessWidget {
  final String namaProduk;
  final String deskripsi;
  final String harga;
  final String gambar;

  const DetailPage({
    super.key,
    required this.namaProduk,
    required this.deskripsi,
    required this.harga,
    required this.gambar,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Detail Produk",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.chat_bubble_outline,
                color: Colors.black),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.shopping_cart_outlined,
                color: Colors.black),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert,
                color: Colors.black),
          ),
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [

            /// GAMBAR PRODUK
            Container(
              color: Colors.white,
              width: double.infinity,
              height: 320,
              child: Hero(
                tag: namaProduk,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(
                    gambar,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 8),

            /// INFO PRODUK
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [

                  Text(
                    namaProduk,
                    style: GoogleFonts.poppins(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Row(
                    children: const [
                      Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 18,
                      ),
                      SizedBox(width: 5),
                      Text("4.8"),
                      SizedBox(width: 10),
                      Text("236 Ulasan"),
                      SizedBox(width: 10),
                      Text("236 Terjual"),
                    ],
                  ),

                  const SizedBox(height: 12),

                  Text(
                    harga,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Row(
                    children: const [
                      Icon(
                        Icons.inventory_2_outlined,
                        size: 18,
                        color: Colors.grey,
                      ),
                      SizedBox(width: 5),
                      Text(
                        "Stok tersedia : 20",
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),

            /// BENEFIT
            Container(
              color: Colors.white,
              padding:
                  const EdgeInsets.symmetric(
                vertical: 15,
                horizontal: 10,
              ),
              child: Row(
                children: [
                  _benefitItem(
                    Icons.verified_user,
                    "100% Original",
                    "Produk original",
                  ),
                  _benefitItem(
                    Icons.workspace_premium,
                    "Garansi Resmi",
                    "Garansi pabrik",
                  ),
                  _benefitItem(
                    Icons.local_shipping,
                    "Pengiriman",
                    "Cepat",
                  ),
                  _benefitItem(
                    Icons.inventory,
                    "Packaging",
                    "Aman",
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),

            /// DESKRIPSI
            Container(
              color: Colors.white,
              child: ExpansionTile(
                initiallyExpanded: true,
                title: const Text(
                  "Deskripsi Produk",
                  style: TextStyle(
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.all(16),
                    child: Text(deskripsi),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),

            /// SPESIFIKASI
            Container(
              color: Colors.white,
              child: ExpansionTile(
                initiallyExpanded: true,
                title: const Text(
                  "Spesifikasi Produk",
                  style: TextStyle(
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
                children: const [

                  ListTile(
                    dense: true,
                    title: Text("Merk"),
                    trailing: Text("Epson"),
                  ),

                  ListTile(
                    dense: true,
                    title: Text("Kode Produk"),
                    trailing: Text("664"),
                  ),

                  ListTile(
                    dense: true,
                    title: Text("Warna"),
                    trailing: Text("Black"),
                  ),

                  ListTile(
                    dense: true,
                    title: Text("Isi Bersih"),
                    trailing: Text("70 ml"),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),

            /// ULASAN
            Container(
              color: Colors.white,
              padding:
                  const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [

                  const Text(
                    "Ulasan Pembeli",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                 ListTile(
  contentPadding: EdgeInsets.zero,
  leading: const CircleAvatar(),
  title: const Text("Andi Saputra"),

  subtitle: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [

      const SizedBox(height: 4),

      Row(
        children: List.generate(
          5,
          (index) => const Icon(
            Icons.star,
            color: Colors.amber,
            size: 16,
          ),
        ),
      ),

      const SizedBox(height: 5),

      const Text(
        "Original dan kualitas cetak bagus.",
      ),
    ],
  ),

  trailing: const Text(
    "15 Mei",
    style: TextStyle(fontSize: 12),
  ),
),

                  const Divider(),

                 ListTile(
  contentPadding: EdgeInsets.zero,
  leading: const CircleAvatar(),
  title: const Text("Siti Nurhaliza"),

  subtitle: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [

      const SizedBox(height: 4),

      Row(
        children: List.generate(
          4,
          (index) => const Icon(
            Icons.star,
            color: Colors.amber,
            size: 16,
          ),
        ),
      ),

      const SizedBox(height: 5),

      const Text(
        "Tinta original, hasil cetak pekat.",
      ),
    ],
  ),

  trailing: const Text(
    "12 Mei",
    style: TextStyle(fontSize: 12),
  ),
),
                ],
              ),
            ),

            const SizedBox(height: 8),

            /// PRODUK TERKAIT
            Container(
              color: Colors.white,
              padding:
                  const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [

                  const Text(
                    "Produk Terkait",
                    style: TextStyle(
                      fontWeight:
                          FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),

                  const SizedBox(height: 15),

                  SizedBox(
                    height: 180,
                    child: ListView(
                      scrollDirection:
                          Axis.horizontal,
                      children: List.generate(
                        5,
                        (index) => Container(
                          width: 120,
                          margin:
                              const EdgeInsets.only(
                                  right: 10),
                          decoration:
                              BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius
                                    .circular(10),
                            border: Border.all(
                              color: Colors.grey
                                  .shade300,
                            ),
                          ),
                          child: Column(
                            children: [

                              Expanded(
                                child: Padding(
                                  padding:
                                      const EdgeInsets
                                          .all(10),
                                  child: ClipRRect(
                                    borderRadius:
                                        BorderRadius
                                            .circular(
                                                12),
                                    child:
                                        Image.asset(
                                      gambar,
                                      fit: BoxFit
                                          .contain,
                                    ),
                                  ),
                                ),
                              ),

                              const Padding(
                                padding:
                                    EdgeInsets.all(
                                        8),
                                child: Text(
                                  "Tinta Epson 664",
                                  maxLines: 2,
                                  overflow:
                                      TextOverflow
                                          .ellipsis,
                                ),
                              ),

                              const Padding(
                                padding:
                                    EdgeInsets.only(
                                        bottom:
                                            10),
                                child: Text(
                                  "Rp75.000",
                                  style:
                                      TextStyle(
                                    fontWeight:
                                        FontWeight
                                            .bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 100),
          ],
        ),
      ),

      bottomNavigationBar: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(15),
        child: Row(
          children: [

            Expanded(
              child: OutlinedButton(
                onPressed: () {

  int index = globalCartItems.indexWhere(
    (item) => item["nama"] == namaProduk,
  );

  if (index != -1) {
    globalCartItems[index]["jumlah"]++;
  } else {
    globalCartItems.add({
      "nama": namaProduk,
      "gambar": gambar,
      "harga": int.parse(
        harga.replaceAll(RegExp(r'[^\d]'), ''),
      ),
      "jumlah": 1,
    });
  }

  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text("Produk berhasil ditambahkan ke keranjang"),
    ),
  );

  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => const KeranjangPage(),
    ),
  );
},
                child: const Text(
                  "+ Keranjang",
                ),
              ),
            ),

            const SizedBox(width: 10),

            Expanded(
              child: ElevatedButton(
                style:
                    ElevatedButton.styleFrom(
                  backgroundColor:
                      Color(0xff46C6D9),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          const CheckoutPage(),
                    ),
                  );
                },
                child: const Text(
                  "Beli Sekarang",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _benefitItem(
    IconData icon,
    String title,
    String subtitle,
  ) {
    return Expanded(
      child: Column(
        children: [
          Icon(icon, size: 28),

          const SizedBox(height: 8),

          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),

          const SizedBox(height: 3),

          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 10,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}