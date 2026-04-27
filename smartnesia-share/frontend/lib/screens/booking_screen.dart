import 'package:flutter/material.dart';
import 'payment_screen.dart';
import 'package:intl/intl.dart';

class BookingScreen extends StatefulWidget {
  final Map<String, dynamic> destination;

  const BookingScreen({super.key, required this.destination});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  DateTime _selectedDate = DateTime(2026, 5, 7);
  int _adultCount = 2;
  int _childCount = 1;

  void _generateDays() {
    // Just a visual representation for the calendar UI
  }

  @override
  Widget build(BuildContext context) {
    int childPrice = (widget.destination['price'] * 0.5).round();
    int totalPrice = (widget.destination['price'] * _adultCount) + (childPrice * _childCount);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Booking Wisata', style: TextStyle(color: Color(0xFF0D47A1), fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF0D47A1)),
        actions: const [Icon(Icons.more_vert, color: Color(0xFF0D47A1)), SizedBox(width: 16)],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Stepper
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildStepperStep('1', 'TANGGAL', true),
                Expanded(child: Divider(color: Colors.grey.shade300, thickness: 2)),
                _buildStepperStep('2', 'DETAIL', false),
                Expanded(child: Divider(color: Colors.grey.shade300, thickness: 2)),
                _buildStepperStep('3', 'BAYAR', false),
              ],
            ),
            const SizedBox(height: 30),
            
            // Tanggal
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Pilih Tanggal Kunjungan', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                Text(DateFormat('MMM yyyy').format(_selectedDate), style: const TextStyle(color: Color(0xFF0D47A1), fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 16),
            
            // Dummy Calendar view
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: Colors.grey.shade50, borderRadius: BorderRadius.circular(20)),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const [
                      Text('MIN', style: TextStyle(color: Colors.grey, fontSize: 12)),
                      Text('SEN', style: TextStyle(color: Colors.grey, fontSize: 12)),
                      Text('SEL', style: TextStyle(color: Colors.grey, fontSize: 12)),
                      Text('RAB', style: TextStyle(color: Colors.grey, fontSize: 12)),
                      Text('KAM', style: TextStyle(color: Colors.grey, fontSize: 12)),
                      Text('JUM', style: TextStyle(color: Colors.grey, fontSize: 12)),
                      Text('SAB', style: TextStyle(color: Colors.grey, fontSize: 12)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildCalDay('5', false),
                      _buildCalDay('6', false),
                      _buildCalDay('7', true), // Selected
                      _buildCalDay('8', false),
                      _buildCalDay('9', false),
                      _buildCalDay('10', false),
                      _buildCalDay('11', false),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Icon(Icons.info_outline, color: Colors.green, size: 16),
                const SizedBox(width: 8),
                Expanded(child: Text('Tiket berlaku hingga 24 jam setelah waktu kunjungan terpilih.', style: TextStyle(color: Colors.grey.shade600, fontSize: 12))),
              ],
            ),
            const SizedBox(height: 30),

            // Jumlah Tamu
            const Text('Jumlah Tamu', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            const SizedBox(height: 16),
            _buildGuestSelector('Dewasa', 'Usia 12 thn ke atas', _adultCount, (val) => setState(() => _adultCount = val), Icons.person, Colors.blue.shade100),
            const SizedBox(height: 16),
            _buildGuestSelector('Anak-anak', 'Usia 2 - 11 thn', _childCount, (val) => setState(() => _childCount = val), Icons.child_care, Colors.greenAccent.shade100),
            
            const SizedBox(height: 30),

            // Rincian Destinasi Card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF0D47A1),
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: NetworkImage('https://www.transparenttextures.com/patterns/cubes.png'), // Subtle pattern
                  fit: BoxFit.cover,
                  opacity: 0.2,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('RINCIAN DESTINASI', style: TextStyle(color: Colors.white70, fontSize: 10, letterSpacing: 1.5)),
                  const SizedBox(height: 8),
                  Text('${widget.destination['name']} - Paket Wisata Pagi', style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Icon(Icons.calendar_today, color: Colors.white70, size: 16),
                      const SizedBox(width: 8),
                      Text('${DateFormat('EEEE, d MMM yyyy').format(_selectedDate)}', style: const TextStyle(color: Colors.white70, fontSize: 12)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.people, color: Colors.white70, size: 16),
                      const SizedBox(width: 8),
                      Text('$_adultCount Dewasa, $_childCount Anak-anak', style: const TextStyle(color: Colors.white70, fontSize: 12)),
                    ],
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
          boxShadow: [BoxShadow(color: Colors.grey.shade200, blurRadius: 10, offset: const Offset(0, -5))],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('TOTAL ESTIMASI', style: TextStyle(color: Colors.grey, fontSize: 10, letterSpacing: 1)),
                    Text('IDR $totalPrice', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87)),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(color: Colors.greenAccent.shade100, borderRadius: BorderRadius.circular(10)),
                  child: const Text('Hemat 10%', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 12)),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PaymentScreen(
                    destination: widget.destination,
                    totalPrice: totalPrice,
                    adultCount: _adultCount,
                    childCount: _childCount,
                    selectedDate: _selectedDate,
                  )),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0D47A1),
                minimumSize: const Size(double.infinity, 55),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text('Lanjutkan ke Pembayaran', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                  SizedBox(width: 8),
                  Icon(Icons.arrow_forward, color: Colors.white),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepperStep(String number, String label, bool isActive) {
    return Column(
      children: [
        CircleAvatar(
          radius: 14,
          backgroundColor: isActive ? const Color(0xFF0D47A1) : Colors.grey.shade200,
          child: Text(number, style: TextStyle(color: isActive ? Colors.white : Colors.grey, fontSize: 12, fontWeight: FontWeight.bold)),
        ),
        const SizedBox(height: 4),
        Text(label, style: TextStyle(color: isActive ? const Color(0xFF0D47A1) : Colors.grey, fontSize: 10, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildCalDay(String day, bool isSelected) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF0D47A1) : Colors.transparent,
        shape: BoxShape.circle,
      ),
      child: Text(day, style: TextStyle(color: isSelected ? Colors.white : Colors.black87, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildGuestSelector(String title, String subtitle, int count, Function(int) onChanged, IconData icon, Color iconBg) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.grey.shade200)),
      child: Row(
        children: [
          CircleAvatar(backgroundColor: iconBg, child: Icon(icon, color: Colors.black54)),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Text(subtitle, style: const TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
          ),
          IconButton(onPressed: () => onChanged(count > 0 ? count - 1 : 0), icon: const Icon(Icons.remove_circle_outline), color: Colors.grey),
          Text('$count', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          IconButton(onPressed: () => onChanged(count + 1), icon: const Icon(Icons.add_circle, color: Color(0xFF0D47A1))),
        ],
      ),
    );
  }
}
