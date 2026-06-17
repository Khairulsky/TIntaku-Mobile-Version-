import 'package:flutter/material.dart';
import '../payment/payment_page.dart';
import '../keranjang/keranjang_page.dart';
import '../address/add_edit_address_page.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  String kurir = "JNE";
  String pembayaran = "QRIS";

  // Daftar alamat pengiriman (bisa lebih dari satu)
  List<Map<String, String>> addresses = [];
  int selectedAddressIndex = -1; // -1 berarti belum ada alamat

  // Gunakan list global dari keranjang agar checkout menampilkan item sebenarnya
  List<Map<String, dynamic>> get daftarProduk => globalCartItems;

  // Fungsi hitung total harga otomatis berdasarkan produk yang ada
  int get subtotal {
    int total = 0;
    for (var produk in daftarProduk) {
      total += (produk["harga"] as int) * (produk["jumlah"] as int);
    }
    return total;
  }

  int get totalPembayaran {
    int ongkir = 10000;
    int diskon = 10000;
    return subtotal + ongkir - diskon;
  }

  // Widget untuk Step Bar di atas
  Widget buildStep(bool active, String title, String number) {
    return Column(
      children: [
        CircleAvatar(
          radius: 20,
          backgroundColor: active ? const Color(0xff46C6D9) : Colors.grey.shade300,
          child: Text(
            number,
            style: TextStyle(
              color: active ? Colors.white : Colors.black54,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: TextStyle(
            fontWeight: active ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }

  // Widget untuk Item Produk + Logika Hapus Data
  Widget productItem(Map<String, dynamic> produk, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Gambar Produk
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey.shade100,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                produk["gambar"],
                fit: BoxFit.contain,
              ),
            ),
          ),
          const SizedBox(width: 12),

          // Detail Informasi Produk
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  produk["nama"],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 5),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    "Original",
                    style: TextStyle(fontSize: 11),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Rp${produk["harga"].toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),

          // Kolom Aksi Kanan (Icon Sampah & Plus-Minus)
          SizedBox(
            height: 70,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Tombol Hapus (Icon Sampah) -> Sekarang memicu re-render ui
                InkWell(
                  onTap: () {
                    String namaHapus = produk["nama"];
                    setState(() {
                      globalCartItems.removeAt(index); // Menghapus dari list global
                    });
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("$namaHapus dihapus")));
                  },
                  child: const Icon(
                    Icons.delete_outline,
                    color: Colors.red,
                    size: 22,
                  ),
                ),

                // Pengatur Jumlah Barang
                Container(
                  width: 90,
                  height: 32,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {
                          if (produk["jumlah"] > 1) {
                                setState(() {
                                  produk["jumlah"]--;
                                });
                              }
                        },
                        child: const Icon(Icons.remove, size: 16),
                      ),
                      Text(
                        "${produk["jumlah"]}",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            produk["jumlah"]++;
                          });
                        },
                        child: const Icon(Icons.add, size: 16),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToAddressPage({int? index}) async {
    final isEdit = index != null && index >= 0 && index < addresses.length;
    final result = await Navigator.push<Map<String, dynamic>>(
      context,
      MaterialPageRoute(
        builder: (_) => AddEditAddressPage(
          initialAddress: isEdit ? addresses[index!] : null,
          addressIndex: index,
        ),
      ),
    );

    if (result != null) {
      final newAddr = result['address'] as Map<String, String>;
      final addrIndex = result['index'] as int?;

      setState(() {
        if (addrIndex != null && addrIndex >= 0 && addrIndex < addresses.length) {
          addresses[addrIndex] = newAddr;
          selectedAddressIndex = addrIndex;
        } else {
          addresses.add(newAddr);
          selectedAddressIndex = addresses.length - 1;
        }
      });
    }
  }

  String _formatFullAddress(Map<String, String> a) {
    final parts = <String>[];
    if ((a['detail'] ?? '').isNotEmpty) parts.add(a['detail']!);
    if ((a['kelurahan'] ?? '').isNotEmpty) parts.add('Kel. ${a['kelurahan']}');
    if ((a['kecamatan'] ?? '').isNotEmpty) parts.add('Kec. ${a['kecamatan']}');
    if ((a['kabupaten'] ?? '').isNotEmpty) parts.add('${a['kabupaten']}');
    if ((a['kota'] ?? '').isNotEmpty) parts.add(a['kota']!);
    return parts.join(', ');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        title: const Text(
          "Checkout",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // STEP CHECKOUT
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  buildStep(true, "Keranjang", "✓"),
                  Expanded(
                    child: Container(height: 2, color: const Color(0xff46C6D9)),
                  ),
                  buildStep(true, "Checkout", "2"),
                  Expanded(
                    child: Container(height: 2, color: Colors.grey.shade300),
                  ),
                  buildStep(false, "Pembayaran", "3"),
                ],
              ),
            ),
            const SizedBox(height: 10),

            // KARTU ALAMAT
            Card(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Row(
                          children: [
                            Icon(Icons.location_on, color: Colors.blue),
                            SizedBox(width: 8),
                            Text(
                              "Alamat Pengiriman",
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          ],
                        ),
                        // Tombol Ubah / Tambah akan ditampilkan di dalam body di bawah
                        const SizedBox.shrink(),
                      ],
                    ),
                    const SizedBox(height: 10),
                    // Jika belum ada alamat, tampilkan tombol tambah
                    if (selectedAddressIndex == -1) ...[
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(backgroundColor: const Color(0xff46C6D9)),
                          onPressed: () => _navigateToAddressPage(),
                          child: const Text('Tambah Alamat'),
                        ),
                      ),
                    ] else ...[
                      Text(
                        addresses[selectedAddressIndex]["nama"] ?? '',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 5),
                      Text(addresses[selectedAddressIndex]["phone"] ?? ''),
                      const SizedBox(height: 10),
                      Text(
                        _formatFullAddress(addresses[selectedAddressIndex]),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () => _navigateToAddressPage(index: selectedAddressIndex),
                            child: const Text('Ubah'),
                          ),
                          const SizedBox(width: 8),
                          TextButton(
                            onPressed: () => _navigateToAddressPage(),
                            child: const Text('Tambah'),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),

            // KARTU DAFTAR PRODUK YANG DIPESAN (Dibuat Dinamis Berdasarkan List)
            Card(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Produk yang dipesan",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "${daftarProduk.length} Produk",
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    
                    // Kondisi jika produk kosong atau masih ada
                    daftarProduk.isEmpty
                        ? const Padding(
                            padding: EdgeInsets.symmetric(vertical: 20),
                            child: Text("Tidak ada produk di keranjang.", style: TextStyle(color: Colors.grey)),
                          )
                        : ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: daftarProduk.length,
                            separatorBuilder: (context, index) => Divider(color: Colors.grey.shade300),
                            itemBuilder: (context, index) {
                              return productItem(daftarProduk[index], index);
                            },
                          ),
                    
                    const SizedBox(height: 10),
                    InkWell(
                      onTap: () {},
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Lihat Keranjang",
                            style: TextStyle(color: Color(0xff46C6D9), fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 5),
                          Icon(Icons.arrow_forward_ios, size: 15, color: Color(0xff46C6D9)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),

            // KARTU OPSI PENGIRIMAN
            Card(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Opsi Pengiriman",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: kurir == "JNE" ? const Color(0xff46C6D9) : Colors.grey.shade300,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: RadioListTile<String>(
                        value: "JNE",
                        groupValue: kurir,
                        title: const Text("JNE Reguler"),
                        subtitle: const Text("Estimasi 2-3 Hari"),
                        secondary: const Icon(Icons.local_shipping),
                        onChanged: (value) {
                          setState(() {
                            kurir = value!;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: kurir == "J&T" ? const Color(0xff46C6D9) : Colors.grey.shade300,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: RadioListTile<String>(
                        value: "J&T",
                        groupValue: kurir,
                        title: const Text("J&T Express"),
                        subtitle: const Text("Estimasi 1-2 Hari"),
                        secondary: const Icon(Icons.fire_truck),
                        onChanged: (value) {
                          setState(() {
                            kurir = value!;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),

            // KARTU RINGKASAN PEMBAYARAN (Otomatis Terupdate Saat Produk Dihapus)
            Card(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Ringkasan Pembayaran",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Subtotal (${daftarProduk.length} produk)"),
                        Text("Rp${subtotal.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}" ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Ongkos Kirim"),
                        Text("Rp10.000"),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Diskon"),
                        Text("- Rp10.000", style: TextStyle(color: Colors.red)),
                      ],
                    ),
                    const Divider(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Total Pembayaran",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                        Text(
                          "Rp${(daftarProduk.isEmpty ? 0 : totalPembayaran).toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}",
                          style: const TextStyle(
                            fontSize: 20,
                            color: Color(0xff46C6D9),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),

      // ACTION BAR BOTTOM (Otomatis Ikut Terupdate)
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, -2)),
          ],
        ),
        child: SafeArea(
          child: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Total Pembayaran",
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Rp${(daftarProduk.isEmpty ? 0 : totalPembayaran).toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}",
                      style: const TextStyle(
                        fontSize: 22,
                        color: Color(0xff46C6D9),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff46C6D9),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: daftarProduk.isEmpty
                      ? null // Button mati otomatis jika produk kosong
                      : () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => PaymentPage(
                                orderItems: daftarProduk,
                                totalAmount: totalPembayaran,
                                deliveryAddress: selectedAddressIndex != -1
                                    ? addresses[selectedAddressIndex]
                                    : null,
                              ),
                            ),
                          );
                        },
                  child: const Text(
                    "Lanjut Bayar",
                    style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}