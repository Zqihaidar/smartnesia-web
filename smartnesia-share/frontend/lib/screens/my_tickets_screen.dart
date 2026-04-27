import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'digital_ticket_screen.dart';

class MyTicketsScreen extends StatefulWidget {
  const MyTicketsScreen({super.key});

  @override
  State<MyTicketsScreen> createState() => _MyTicketsScreenState();
}

class _MyTicketsScreenState extends State<MyTicketsScreen> {
  List<dynamic> _tickets = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadTickets();
  }

  Future<void> _loadTickets() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> ticketsStr = prefs.getStringList('my_tickets') ?? [];
    setState(() {
      _tickets = ticketsStr.map((t) => jsonDecode(t)).toList();
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 16,
              backgroundColor: Colors.black87,
              child: const Icon(Icons.person, color: Colors.white, size: 20),
            ),
            const SizedBox(width: 8),
            const Text('Nusantara', style: TextStyle(color: Color(0xFF0D47A1), fontWeight: FontWeight.bold)),
            const Spacer(),
            IconButton(icon: const Icon(Icons.search, color: Color(0xFF0D47A1)), onPressed: () {}),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black87),
        automaticallyImplyLeading: false,
      ),
      body: _tickets.isEmpty
          ? const Center(child: Text('Belum ada tiket yang dipesan.', style: TextStyle(color: Colors.grey)))
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('TRAVEL HISTORY', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 10, letterSpacing: 1.5)),
                  const SizedBox(height: 8),
                  const Text('My Tickets', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black87)),
                  const SizedBox(height: 24),
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Upcoming', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      Text('${_tickets.length} Active', style: const TextStyle(color: Colors.grey, fontSize: 12)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _tickets.length,
                    itemBuilder: (context, index) {
                      final t = _tickets[index];
                      DateTime d = DateTime.parse(t['selectedDate']);
                      return _buildTicketCard(context, t, d);
                    },
                  ),

                  // Static Past Tickets
                  const SizedBox(height: 24),
                  const Text('Past', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  _buildPastTicketCard('Tanah Lot Temple', 'Sep 12, 2023', '4 People', 'https://upload.wikimedia.org/wikipedia/commons/thumb/c/cd/TanahLot_2014.JPG/640px-TanahLot_2014.JPG'),
                  _buildPastTicketCard('Bromo Sunrise Tour', 'Aug 30, 2023', '2 People', 'https://upload.wikimedia.org/wikipedia/commons/thumb/8/8e/Bromo-Semeru-Batok-Widodaren.jpg/640px-Bromo-Semeru-Batok-Widodaren.jpg'),
                ],
              ),
            ),
    );
  }

  Widget _buildTicketCard(BuildContext context, dynamic ticket, DateTime date) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                ticket['destination']['image'],
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(child: Text(ticket['destination']['name'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16))),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(color: Colors.greenAccent.shade100, borderRadius: BorderRadius.circular(10)),
                        child: const Text('ACTIVE', style: TextStyle(color: Colors.green, fontSize: 8, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.calendar_today, size: 12, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text(DateFormat('MMM d, yyyy').format(date), style: const TextStyle(color: Colors.grey, fontSize: 12)),
                      const Spacer(),
                      const Text('08:30 AM', style: TextStyle(color: Colors.grey, fontSize: 12)), // Hardcoded time
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.people, size: 14, color: Colors.black87),
                          const SizedBox(width: 4),
                          Text('${ticket['adultCount'] + ticket['childCount']} People', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => DigitalTicketScreen(ticket: ticket)),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF0D47A1),
                          minimumSize: const Size(80, 30),
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        ),
                        child: const Text('View QR', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPastTicketCard(String name, String date, String people, String imgUrl) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(imgUrl, width: 60, height: 60, fit: BoxFit.cover),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(child: Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14))),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(10)),
                            child: const Text('COMPLETED', style: TextStyle(color: Colors.black54, fontSize: 8, fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text('$date • $people', style: const TextStyle(color: Colors.grey, fontSize: 12)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                child: const Text('Rebook Trip >', style: TextStyle(color: Color(0xFF0D47A1), fontWeight: FontWeight.bold, fontSize: 12)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
