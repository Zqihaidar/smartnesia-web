import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:qr_flutter/qr_flutter.dart';

class TicketScreen extends StatefulWidget {
  const TicketScreen({super.key});

  @override
  State<TicketScreen> createState() => _TicketScreenState();
}

class _TicketScreenState extends State<TicketScreen> {
  bool _isLoading = false;
  Map<String, dynamic>? _ticketData;
  String? _errorMessage;

  Future<void> _generateTicket() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
      _ticketData = null;
    });

    try {
      final response = await http.post(
        Uri.parse('http://10.0.2.2:7071/api/ProcessTicket'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'userId': 'user-budi-123', 'serviceId': 'WISATA-001'}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _ticketData = data['ticket'];
        });
      } else {
        setState(() {
          _errorMessage = "Gagal memproses tiket. Status: ${response.statusCode}";
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = "Kesalahan koneksi ke server: $e";
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('E-Ticket', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.confirmation_number_outlined, size: 80, color: Color(0xFF1E5BB2)),
              const SizedBox(height: 20),
              const Text(
                'Generate Tiket Digital Anda',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              const Text(
                'Tiket digital ini diamankan dengan enkripsi dan validasi terpusat. Gunakan tiket ini saat di lokasi.',
                style: TextStyle(color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              if (_isLoading)
                const CircularProgressIndicator()
              else if (_ticketData != null)
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(color: Colors.grey.shade300, blurRadius: 10, offset: const Offset(0, 5)),
                    ],
                  ),
                  child: Column(
                    children: [
                      QrImageView(
                        data: _ticketData!['qrHash'],
                        version: QrVersions.auto,
                        size: 200.0,
                        backgroundColor: Colors.white,
                      ),
                      const SizedBox(height: 15),
                      Text('ID Tiket: ${_ticketData!['id']}', style: const TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 5),
                      Text('Status: ${_ticketData!['status']}', style: const TextStyle(color: Colors.green, fontWeight: FontWeight.w600)),
                    ],
                  ),
                )
              else if (_errorMessage != null)
                Text(_errorMessage!, style: const TextStyle(color: Colors.red), textAlign: TextAlign.center),
              
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _isLoading ? null : _generateTicket,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1E5BB2),
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: Text(_ticketData == null ? 'GENERATE TIKET' : 'GENERATE ULANG', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
              ),
              const SizedBox(height: 40),
              
              const Align(
                alignment: Alignment.centerLeft,
                child: Text('Promo Tiket Spesial', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 10),
              _buildPromoTicket('Diskon 50% Borobudur', 'Berlaku s.d 30 Okt', Colors.orange),
              _buildPromoTicket('Buy 1 Get 1 Raja Ampat', 'Kuota Terbatas!', Colors.blue),
              _buildPromoTicket('Cashback 20% E-Samsat', 'Bayar pajak untung', Colors.green),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPromoTicket(String title, String subtitle, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Icon(Icons.local_offer, color: color, size: 30),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontWeight: FontWeight.bold, color: color.withOpacity(0.8), fontSize: 16)),
                const SizedBox(height: 4),
                Text(subtitle, style: const TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Klaim $title berhasil!')));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: color,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
              minimumSize: const Size(0, 30),
            ),
            child: const Text('KLAIM', style: TextStyle(color: Colors.white, fontSize: 12)),
          ),
        ],
      ),
    );
  }
}
