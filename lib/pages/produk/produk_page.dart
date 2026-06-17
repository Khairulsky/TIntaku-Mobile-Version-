import 'package:flutter/material.dart';
import '../../widgets/custom_bottom_nav.dart';
import '../detail/detail_page.dart';
import '../keranjang/keranjang_page.dart';

class ProdukPage extends StatefulWidget {
  const ProdukPage({super.key});

  @override
  State<ProdukPage> createState() => _ProdukPageState();
}

class _ProdukPageState extends State<ProdukPage> {
  int selectedCategory = 0;

  final List<String> categories = ["Tinta Epson", "Tinta HP", "Tinta Canon"];

  final List<Map<String, String>> epsonProducts = [
    {"name": "Tinta Epson Warna Hitam", "image": "assets/img/epson_hitam.png.jpeg", "price": "Rp.200.000"},
    {"name": "Tinta Epson Warna Yellow", "image": "assets/img/epson_yellow.png.jpeg", "price": "Rp.200.000"},
    {"name": "Tinta Epson Warna Magenta", "image": "assets/img/epson_magenta.png.jpeg", "price": "Rp.200.000"},
    {"name": "Tinta Epson Warna Cyan", "image": "assets/img/epson_cyan.png.jpeg", "price": "Rp.200.000"},
  ];

  final List<Map<String, String>> hpProducts = [
    {"name": "Tinta HP Warna Hitam", "image": "assets/img/hp_hitam.png.jpeg", "price": "Rp.220.000"},
    {"name": "Tinta HP Warna Yellow", "image": "assets/img/hp_yellow.png.jpeg", "price": "Rp.220.000"},
  ];

  final List<Map<String, String>> canonProducts = [
    {"name": "Tinta Canon Warna Hitam", "image": "assets/img/canon_hitam.png.jpeg", "price": "Rp.250.000"},
  ];

  List<Map<String, String>> get currentProducts {
    switch (selectedCategory) {
      case 0:
        return epsonProducts;
      case 1:
        return hpProducts;
      case 2:
        return canonProducts;
      default:
        return epsonProducts;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF7F7F7),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              const SizedBox(height: 10),
              const SizedBox(height: 20),
              Container(
                height: 50,
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8)]),
                child: const TextField(decoration: InputDecoration(hintText: "Cari tinta printer...", border: InputBorder.none, prefixIcon: Icon(Icons.search))),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 42,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    bool active = selectedCategory == index;
                    return GestureDetector(
                      onTap: () => setState(() => selectedCategory = index),
                      child: Container(
                        margin: const EdgeInsets.only(right: 10),
                        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                        decoration: BoxDecoration(color: active ? const Color(0xff46C6D9) : Colors.white, borderRadius: BorderRadius.circular(25), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 5)]),
                        child: Text(categories[index], style: TextStyle(color: active ? Colors.white : Colors.black87, fontWeight: FontWeight.w600)),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 25),
              Expanded(
                child: GridView.builder(
                  itemCount: currentProducts.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 15, mainAxisSpacing: 15, childAspectRatio: 0.62),
                  itemBuilder: (context, index) {
                    return productCard(context, currentProducts[index]["name"]!, currentProducts[index]["image"]!, currentProducts[index]["price"]!);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomNav(selectedIndex: 2),
    );
  }

  Widget productCard(BuildContext context, String name, String image, String price) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15), boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 5)]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3), decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(10)), child: const Text("20%", style: TextStyle(color: Colors.white, fontSize: 10))),
          const SizedBox(height: 8),
          Expanded(flex: 3, child: Center(child: image.isNotEmpty ? Hero(tag: name, child: ClipRRect(borderRadius: BorderRadius.circular(12), child: Image.asset(image, fit: BoxFit.contain))) : const Icon(Icons.inventory_2, size: 70, color: Colors.grey))),
          const SizedBox(height: 8),
          Text(name, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
          const SizedBox(height: 5),
          const Row(children: [Icon(Icons.star, color: Colors.amber, size: 14), SizedBox(width: 3), Text("4.8", style: TextStyle(fontSize: 11, color: Colors.grey))]),
          const SizedBox(height: 5),
          Text(price, style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 14)),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 32,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: const Color(0xff46C6D9)),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => DetailPage(namaProduk: name, harga: price, gambar: image, deskripsi: "Tinta berkualitas tinggi untuk kebutuhan cetak sehari-hari.")));
                    },
                    child: const Text("Detail", style: TextStyle(color: Colors.white, fontSize: 11)),
                  ),
                ),
              ),
              const SizedBox(width: 5),
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(color: const Color(0xff46C6D9), borderRadius: BorderRadius.circular(8)),
                child: IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    int index = globalCartItems.indexWhere((item) => item["nama"] == name);
                    if (index != -1) {
                      globalCartItems[index]["jumlah"]++;
                    } else {
                      globalCartItems.add({
                        "nama": name,
                        "gambar": image,
                        "harga": int.parse(price.replaceAll("Rp.", "").replaceAll(".", "").trim()),
                        "jumlah": 1,
                      });
                    }

                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Produk berhasil ditambahkan ke keranjang")));

                    Navigator.push(context, MaterialPageRoute(builder: (_) => const KeranjangPage()));
                  },
                  icon: const Icon(Icons.shopping_cart_outlined, color: Colors.white, size: 20),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
