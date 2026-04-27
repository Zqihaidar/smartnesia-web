import 'package:flutter/material.dart';

class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Layanan Publik', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               // Search
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search, color: Colors.grey),
                    hintText: 'Cari layanan publik...',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 15),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // Status Card
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.blue.shade100),
                  boxShadow: [
                    BoxShadow(color: Colors.grey.shade100, blurRadius: 10),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Status Pengajuan', style: TextStyle(fontWeight: FontWeight.bold)),
                        TextButton(onPressed: () {}, child: const Text('Lihat Detail')),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Perpanjangan e-KTP', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                            Text('Selesai pada 01 Okt 2024', style: TextStyle(color: Colors.grey, fontSize: 12)),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.orange.shade50,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text('50%', style: TextStyle(color: Colors.orange.shade800, fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    LinearProgressIndicator(
                      value: 0.5,
                      backgroundColor: Colors.grey.shade200,
                      color: const Color(0xFF1E5BB2),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              const Text('Kependudukan', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              _buildServiceItem('KTP Digital', 'Akses identitas kependudukan digital (IKD)', Icons.badge),
              _buildServiceItem('Kartu Keluarga', 'Minta dan kelola kartu keluarga anda', Icons.family_restroom),
              
              const SizedBox(height: 24),
              const Text('Bisnis & Perizinan', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              _buildServiceItem('NIB (Nomor Induk Berusaha)', 'Pendaftaran dan cetak NIB', Icons.business_center),
              _buildServiceItem('Sertifikasi Halal', 'Pengajuan proses sertifikasi halal', Icons.verified),

              const SizedBox(height: 24),
              const Text('Pajak & Retribusi', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              _buildServiceItem('E-Samsat', 'Pembayaran pajak kendaraan bermotor', Icons.directions_car),
              
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildServiceItem(String title, String subtitle, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFF1E5BB2).withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: const Color(0xFF1E5BB2)),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                const SizedBox(height: 4),
                Text(subtitle, style: const TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: Colors.grey),
        ],
      ),
    );
  }
}
