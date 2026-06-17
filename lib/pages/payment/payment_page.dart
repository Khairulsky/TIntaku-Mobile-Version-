import 'package:flutter/material.dart';
import '../success/success_page.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

// Baris gantung _NavigatorPageState di sini sudah dihapus

class _PaymentPageState extends State<PaymentPage> {
  // Set nilai awal kosong "" agar sesuai screenshot (belum ada yang dipilih)
  String selectedMethod = ""; 

  // Widget Helper untuk membuat desain grup box pembungkus kategori
  Widget buildCategoryGroup(List<Widget> items) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: List.generate(items.length * 2 - 1, (index) {
          if (index.isOdd) {
            return Divider(height: 1, color: Colors.grey.shade100);
          }
          return items[index ~/ 2];
        }),
      ),
    );
  }

  // Widget Helper untuk Item List Metode Pembayaran
  Widget buildPaymentItem({
    required String value,
    required String title,
    required String subtitle,
    required Widget logo,
  }) {
    bool isSelected = selectedMethod == value;
    return InkWell(
      onTap: () {
        setState(() {
          selectedMethod = value;
        });
      },
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            // Custom Radio Circle Indicator
            Container(
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? const Color(0xff46C6D9) : Colors.grey.shade300,
                  width: isSelected ? 6 : 2,
                ),
              ),
            ),
            const SizedBox(width: 16),
            
            // Logo / Icon Box
            logo,
            const SizedBox(width: 16),
            
            // Text Informasi (Title & Deskripsi)
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            
            // Chevron Arrow Right
            Icon(
              Icons.arrow_forward_ios,
              size: 14,
              color: Colors.grey.shade400,
            ),
          ],
        ),
      ),
    );
  }

  // Helper untuk membuat visual badge brand
  Widget buildLogoBadge(String text, Color color) {
    return Container(
      width: 45,
      height: 30,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(6),
      ),
      alignment: Alignment.center,
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 10,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFAFAFA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: const BackButton(color: Colors.black),
        title: const Text(
          "Metode Pembayaran",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Pilih metode pembayaran yang ingin digunakan",
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 20),

            // ================= CATEGORY 1: E-WALLET =================
            const Text(
              "E-Wallet",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            const SizedBox(height: 8),
            buildCategoryGroup([
              buildPaymentItem(
                value: "DANA",
                title: "DANA",
                subtitle: "Bayar cepat dan praktis",
                logo: buildLogoBadge("DANA", Colors.blue.shade700),
              ),
              buildPaymentItem(
                value: "OVO",
                title: "OVO",
                subtitle: "Pembayaran aman dengan OVO",
                logo: buildLogoBadge("OVO", Colors.purple.shade800),
              ),
              buildPaymentItem(
                value: "ShopeePay",
                title: "ShopeePay",
                subtitle: "Bayar dengan ShopeePay",
                logo: buildLogoBadge("SPay", Colors.orange.shade800),
              ),
              buildPaymentItem(
                value: "GoPay",
                title: "GoPay",
                subtitle: "Bayar dengan GoPay",
                logo: buildLogoBadge("GoPay", Colors.teal.shade600),
              ),
              buildPaymentItem(
                value: "LinkAja",
                title: "LinkAja",
                subtitle: "Bayar dengan LinkAja",
                logo: buildLogoBadge("Link", Colors.red.shade700),
              ),
            ]),

            // ================= CATEGORY 2: TRANSFER BANK =================
            const Text(
              "Transfer Bank (Virtual Account)",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            const SizedBox(height: 8),
            buildCategoryGroup([
              buildPaymentItem(
                value: "BCA",
                title: "BCA Virtual Account",
                subtitle: "Bayar melalui BCA Virtual Account",
                logo: buildLogoBadge("BCA", Colors.blue.shade900),
              ),
              buildPaymentItem(
                value: "Mandiri",
                title: "Mandiri Virtual Account",
                subtitle: "Bayar melalui Mandiri Virtual Account",
                logo: buildLogoBadge("MANDIRI", Colors.blue.shade400),
              ),
              buildPaymentItem(
                value: "BNI",
                title: "BNI Virtual Account",
                subtitle: "Bayar melalui BNI Virtual Account",
                logo: buildLogoBadge("BNI", Colors.orange.shade700),
              ),
              buildPaymentItem(
                value: "BRI",
                title: "BRI Virtual Account",
                subtitle: "Bayar melalui BRI Virtual Account",
                logo: buildLogoBadge("BRI", Colors.blueAccent),
              ),
            ]),

            // ================= CATEGORY 3: LAINNYA =================
            const Text(
              "Lainnya",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            const SizedBox(height: 8),
            buildCategoryGroup([
              buildPaymentItem(
                value: "Minimarket",
                title: "Bayar di Minimarket",
                subtitle: "Alfamart / Indomaret",
                logo: const SizedBox(
                  width: 45,
                  child: Icon(Icons.storefront, color: Colors.black54, size: 28),
                ),
              ),
              buildPaymentItem(
                value: "COD",
                title: "COD (Bayar di Tempat)",
                subtitle: "Bayar saat pesanan diterima",
                logo: const SizedBox(
                  width: 45,
                  child: Icon(Icons.payments_outlined, color: Colors.black54, size: 28),
                ),
              ),
            ]),
            const SizedBox(height: 40),
          ],
        ),
      ),

      // ================= BOTTOM BAR ACTION =================
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: SafeArea(
          child: Row(
            children: [
              // Total Pembayaran (Sisi Kiri)
              const Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Total Pembayaran",
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "Rp240.000",
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              
              // Tombol Bayar Dinamis (Sisi Kanan)
              SizedBox(
                height: 50,
                width: 210,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: selectedMethod.isEmpty 
                        ? Colors.grey.shade300 
                        : const Color(0xff46C6D9),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: selectedMethod.isEmpty
                      ? null 
                      : () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const SuccessPage(),
                            ),
                          );
                        },
                  child: Text(
                    selectedMethod.isEmpty 
                        ? "Pilih Metode Pembayaran" 
                        : "Bayar Sekarang",
                    style: TextStyle(
                      color: selectedMethod.isEmpty ? Colors.grey.shade600 : Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
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