import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'my_tickets_screen.dart'; // We'll create this next
import 'home_screen.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class PaymentScreen extends StatefulWidget {
  final Map<String, dynamic> destination;
  final int totalPrice;
  final int adultCount;
  final int childCount;
  final DateTime selectedDate;

  const PaymentScreen({
    super.key,
    required this.destination,
    required this.totalPrice,
    required this.adultCount,
    required this.childCount,
    required this.selectedDate,
  });

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  bool _isProcessing = false;
  String _selectedMethod = 'GoPay';

  void _processPayment() async {
    setState(() {
      _isProcessing = true;
    });

    await Future.delayed(const Duration(seconds: 2));

    // Save ticket to SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    List<String> ticketsStr = prefs.getStringList('my_tickets') ?? [];
    List<dynamic> tickets = ticketsStr.map((t) => jsonDecode(t)).toList();

    tickets.add({
      'destination': widget.destination,
      'totalPrice': widget.totalPrice,
      'adultCount': widget.adultCount,
      'childCount': widget.childCount,
      'selectedDate': widget.selectedDate.toIso8601String(),
      'status': 'ACTIVE',
      'bookingId':
          'BK-${DateTime.now().millisecondsSinceEpoch.toString().substring(5)}'
    });

    await prefs.setStringList(
        'my_tickets', tickets.map((t) => jsonEncode(t)).toList());

    if (mounted) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          title: const Icon(Icons.check_circle, color: Colors.green, size: 60),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Pembayaran Berhasil!',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              const Text('E-tiket Anda sudah tersedia.',
                  textAlign: TextAlign.center),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const MainTabBarView()),
                  (route) => false,
                );
                // We should theoretically navigate to MyTickets, but home is fine for now
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0D47A1),
                minimumSize: const Size(double.infinity, 40),
              ),
              child: const Text('LIHAT TIKET SAYA',
                  style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    int adminFee = 5000;
    int finalTotal = widget.totalPrice + adminFee;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Konfirmasi Pesanan',
            style: TextStyle(
                color: Color(0xFF0D47A1), fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF0D47A1)),
        actions: const [
          Icon(Icons.more_vert, color: Color(0xFF0D47A1)),
          SizedBox(width: 16)
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Destination Summary
            Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(20)),
                        child: Image.network(
                          widget.destination['image'],
                          height: 150,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        top: 10,
                        left: 10,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.9),
                              borderRadius: BorderRadius.circular(10)),
                          child: const Text('DESTINASI',
                              style: TextStyle(
                                  color: Color(0xFF0D47A1),
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.destination['name'],
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            const Icon(Icons.calendar_today,
                                size: 16, color: Color(0xFF0D47A1)),
                            const SizedBox(width: 8),
                            Text(DateFormat('EEEE, d MMM yyyy')
                                .format(widget.selectedDate)),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            const Icon(Icons.people,
                                size: 16, color: Color(0xFF0D47A1)),
                            const SizedBox(width: 8),
                            Text(
                                '${widget.adultCount} Dewasa, ${widget.childCount} Anak'),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            const Icon(Icons.local_activity,
                                size: 16, color: Color(0xFF0D47A1)),
                            const SizedBox(width: 8),
                            const Text('Tiket Terusan + Kecak'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // Rincian Harga
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Rincian Harga',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(10)),
                  child: const Text('IDR',
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 10)),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(20)),
              child: Column(
                children: [
                  _buildPriceRow(
                      'Tiket Dewasa (x${widget.adultCount})',
                      'Rp ${widget.destination['price'] * widget.adultCount}',
                      false),
                  const SizedBox(height: 10),
                  _buildPriceRow(
                      'Tiket Anak (x${widget.childCount})',
                      'Rp ${(widget.destination['price'] * 0.5).round() * widget.childCount}',
                      false),
                  const SizedBox(height: 10),
                  _buildPriceRow(
                      'Biaya Layanan SmartNesia', 'Rp $adminFee', false),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Divider(),
                  ),
                  _buildPriceRow('Total Tagihan', 'Rp $finalTotal', true),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // Metode Pembayaran
            const Text('Pilih Metode Pembayaran',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 16),
            _buildPaymentMethod('GoPay', 'Saldo: Rp 450.200',
                'assets/gopay.png', Colors.blue), // Image placeholders or icons
            _buildPaymentMethod('OVO Cash', 'Pembayaran instan',
                'assets/ovo.png', Colors.purple),
            _buildPaymentMethod('Bank Transfer (VA)', 'BCA, Mandiri, BNI',
                'assets/bank.png', Colors.indigo),

            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: Colors.greenAccent.shade100,
                  borderRadius: BorderRadius.circular(15)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.verified_user,
                      color: Colors.green, size: 20),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text('Transaksi Aman & Terjamin',
                            style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                                fontSize: 12)),
                        SizedBox(height: 4),
                        Text(
                            'Pembayaran Anda dilindungi oleh sistem keamanan SmartNesia. E-tiket akan langsung tersedia setelah pembayaran berhasil.',
                            style:
                                TextStyle(color: Colors.green, fontSize: 10)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.shade200,
                blurRadius: 10,
                offset: const Offset(0, -5))
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('TOTAL BAYAR',
                    style: TextStyle(
                        color: Colors.grey, fontSize: 10, letterSpacing: 1)),
                Text('Rp $finalTotal',
                    style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0D47A1))),
              ],
            ),
            ElevatedButton(
              onPressed: _isProcessing ? null : _processPayment,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0D47A1),
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 15),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)),
              ),
              child: _isProcessing
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                          color: Colors.white, strokeWidth: 2))
                  : Row(
                      children: const [
                        Text('Bayar Sekarang',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                        SizedBox(width: 8),
                        Icon(Icons.arrow_forward,
                            color: Colors.white, size: 18),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPriceRow(String label, String value, bool isTotal) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: TextStyle(
                fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
                color: isTotal ? Colors.black87 : Colors.grey.shade700)),
        Text(value,
            style: TextStyle(
                fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
                fontSize: isTotal ? 18 : 14,
                color: isTotal ? const Color(0xFF0D47A1) : Colors.black87)),
      ],
    );
  }

  Widget _buildPaymentMethod(
      String title, String subtitle, String iconPath, Color iconColor) {
    bool isSelected = _selectedMethod == title;
    return GestureDetector(
      onTap: () => setState(() => _selectedMethod = title),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
              color:
                  isSelected ? const Color(0xFF0D47A1) : Colors.grey.shade200,
              width: isSelected ? 2 : 1),
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: iconColor.withOpacity(0.1),
              child: Icon(Icons.account_balance_wallet,
                  color:
                      iconColor), // Using standard icon as placeholder for image
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text(subtitle,
                      style: const TextStyle(color: Colors.grey, fontSize: 12)),
                ],
              ),
            ),
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                    color: isSelected ? const Color(0xFF0D47A1) : Colors.grey),
              ),
              child: isSelected
                  ? Center(
                      child: CircleAvatar(
                          radius: 8, backgroundColor: const Color(0xFF0D47A1)))
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
