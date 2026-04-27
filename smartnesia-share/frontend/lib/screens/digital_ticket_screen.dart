import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:intl/intl.dart';
import '../services/auth_service.dart';

class DigitalTicketScreen extends StatefulWidget {
  final dynamic ticket;
  const DigitalTicketScreen({super.key, required this.ticket});

  @override
  State<DigitalTicketScreen> createState() => _DigitalTicketScreenState();
}

class _DigitalTicketScreenState extends State<DigitalTicketScreen> {
  String _userName = 'Pengguna';

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    final user = await AuthService.getUser();
    if (user['name'] != null && user['name']!.isNotEmpty) {
      setState(() {
        _userName = user['name']!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    DateTime date = DateTime.parse(widget.ticket['selectedDate']);
    String bookingId = widget.ticket['bookingId'];
    String destinationName = widget.ticket['destination']['name'];

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text('Digital Ticket', style: TextStyle(color: Color(0xFF0D47A1), fontWeight: FontWeight.bold)),
        backgroundColor: Colors.grey.shade50,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF0D47A1)),
        actions: const [Icon(Icons.more_vert, color: Color(0xFF0D47A1)), SizedBox(width: 16)],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Ticket Card
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [BoxShadow(color: Colors.grey.shade200, blurRadius: 20, offset: const Offset(0, 10))],
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('NUSANTARA PASS', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 10, letterSpacing: 1.5)),
                            const SizedBox(height: 4),
                            Text('Priority Domestic', style: TextStyle(color: Colors.grey.shade600, fontSize: 14)),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(color: const Color(0xFF0D47A1), borderRadius: BorderRadius.circular(10)),
                          child: const Icon(Icons.confirmation_num, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  
                  // QR Code
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 40),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: const Color(0xFF0D47A1), width: 2),
                    ),
                    child: Center(
                      child: QrImageView(
                        data: '$bookingId-$_userName',
                        version: QrVersions.auto,
                        size: 200.0,
                        backgroundColor: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text('$bookingId-${_userName.toUpperCase()}', style: const TextStyle(color: Colors.grey, letterSpacing: 2, fontSize: 12)),
                  
                  const SizedBox(height: 24),
                  
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('PASSENGER NAME', style: TextStyle(color: Colors.grey, fontSize: 10, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 4),
                            Text(_userName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Text('TYPE', style: TextStyle(color: Colors.grey, fontSize: 10, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 4),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(color: Colors.greenAccent.shade100, borderRadius: BorderRadius.circular(10)),
                              child: const Text('DOMESTIC', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 10)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: Divider(color: Colors.grey, indent: 24, endIndent: 24, thickness: 1, height: 1), // Dash line is tricky, simple divider
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('DESTINATION', style: TextStyle(color: Colors.grey, fontSize: 10, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                const Icon(Icons.location_on_outlined, size: 14, color: Color(0xFF0D47A1)),
                                const SizedBox(width: 4),
                                SizedBox(
                                  width: 120, 
                                  child: Text(destinationName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14), maxLines: 2, overflow: TextOverflow.ellipsis),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Text('BOOKING ID', style: TextStyle(color: Colors.grey, fontSize: 10, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 4),
                            Text(bookingId, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('DATE', style: TextStyle(color: Colors.grey, fontSize: 10, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 4),
                            Text(DateFormat('dd MMM yyyy').format(date), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Text('TIME', style: TextStyle(color: Colors.grey, fontSize: 10, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 4),
                            const Text('08:30 AM', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                          ],
                        ),
                      ],
                    ),
                  ),

                  Container(
                    margin: const EdgeInsets.all(24),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(15)),
                    child: Row(
                      children: [
                        const Icon(Icons.info_outline, color: Color(0xFF0D47A1)),
                        const SizedBox(width: 12),
                        Expanded(child: Text('Please arrive at least 30 minutes before the scheduled time for verification.', style: TextStyle(color: Colors.grey.shade700, fontSize: 12))),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0D47A1),
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.download, color: Colors.white, size: 18),
                  SizedBox(width: 8),
                  Text('Save to Gallery', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey.shade300,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                elevation: 0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.share, color: Colors.black87, size: 18),
                  SizedBox(width: 8),
                  Text('Share Ticket', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () {},
              child: const Text('Having trouble scanning? Contact Support >', style: TextStyle(color: Color(0xFF0D47A1), fontWeight: FontWeight.bold, fontSize: 12)),
            ),
          ],
        ),
      ),
    );
  }
}
