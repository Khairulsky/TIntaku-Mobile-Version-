import 'package:flutter/material.dart';

class AddEditAddressPage extends StatefulWidget {
  final Map<String, String>? initialAddress;
  final int? addressIndex;

  const AddEditAddressPage({
    super.key,
    this.initialAddress,
    this.addressIndex,
  });

  @override
  State<AddEditAddressPage> createState() => _AddEditAddressPageState();
}

class _AddEditAddressPageState extends State<AddEditAddressPage> {
  late final TextEditingController namaController;
  late final TextEditingController phoneController;
  late final TextEditingController kotaController;
  late final TextEditingController kabController;
  late final TextEditingController kecController;
  late final TextEditingController kelController;
  late final TextEditingController detailController;

  bool get isEdit => widget.initialAddress != null;

  @override
  void initState() {
    super.initState();
    final addr = widget.initialAddress ?? {};
    namaController = TextEditingController(text: addr['nama'] ?? '');
    phoneController = TextEditingController(text: addr['phone'] ?? '');
    kotaController = TextEditingController(text: addr['kota'] ?? '');
    kabController = TextEditingController(text: addr['kabupaten'] ?? '');
    kecController = TextEditingController(text: addr['kecamatan'] ?? '');
    kelController = TextEditingController(text: addr['kelurahan'] ?? '');
    detailController = TextEditingController(text: addr['detail'] ?? '');
  }

  @override
  void dispose() {
    namaController.dispose();
    phoneController.dispose();
    kotaController.dispose();
    kabController.dispose();
    kecController.dispose();
    kelController.dispose();
    detailController.dispose();
    super.dispose();
  }

  void _saveAddress() {
    final newAddr = {
      'nama': namaController.text.trim(),
      'phone': phoneController.text.trim(),
      'kota': kotaController.text.trim(),
      'kabupaten': kabController.text.trim(),
      'kecamatan': kecController.text.trim(),
      'kelurahan': kelController.text.trim(),
      'detail': detailController.text.trim(),
    };

    // Validasi minimal
    if (newAddr['nama']!.isEmpty || newAddr['phone']!.isEmpty || newAddr['detail']!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Nama, No. Telp, dan Detail alamat harus diisi')),
      );
      return;
    }

    Navigator.of(context).pop({'address': newAddr, 'index': widget.addressIndex});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          isEdit ? 'Ubah Alamat Pengiriman' : 'Tambah Alamat Pengiriman',
          style: const TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Kartu Formulir
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildInputField('Nama Penerima', namaController, Icons.person),
                      const SizedBox(height: 16),
                      _buildInputField('No. Telepon', phoneController, Icons.phone, keyboardType: TextInputType.phone),
                      const SizedBox(height: 16),
                      _buildInputField('Kota', kotaController, Icons.location_city),
                      const SizedBox(height: 16),
                      _buildInputField('Kabupaten / Desa', kabController, Icons.home),
                      const SizedBox(height: 16),
                      _buildInputField('Kecamatan', kecController, Icons.map),
                      const SizedBox(height: 16),
                      _buildInputField('Kelurahan', kelController, Icons.place),
                      const SizedBox(height: 16),
                      _buildInputField('Detail Alamat', detailController, Icons.description, keyboardType: TextInputType.text, maxLines: 4),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // Tombol Aksi
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        side: const BorderSide(color: Color(0xff46C6D9), width: 2),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: () => Navigator.pop(context),
                      child: const Text(
                        'Batal',
                        style: TextStyle(
                          color: Color(0xff46C6D9),
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff46C6D9),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: _saveAddress,
                      child: const Text(
                        'Simpan',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(
    String label,
    TextEditingController controller,
    IconData icon, {
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          minLines: maxLines == 1 ? 1 : 3,
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: const Color(0xff46C6D9), size: 20),
            hintText: 'Masukkan $label',
            hintStyle: TextStyle(color: Colors.grey.shade400),
            filled: true,
            fillColor: Colors.grey.shade50,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Color(0xff46C6D9), width: 2),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          ),
        ),
      ],
    );
  }
}
