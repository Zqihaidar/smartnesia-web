import 'package:flutter/material.dart';
import 'booking_screen.dart';

class TourismScreen extends StatelessWidget {
  const TourismScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> destinations = [
      {
        'name': 'Pura Luhur Uluwatu',
        'location': 'Bali, Indonesia',
        'price': 150000,
        'rating': 4.9,
        'description': 'Nikmati pertunjukan Tari Kecak yang megah dengan latar belakang matahari terbenam di tebing karang.',
        'image': 'https://upload.wikimedia.org/wikipedia/commons/thumb/1/1a/Pura_Uluwatu.jpg/640px-Pura_Uluwatu.jpg'
      },
      {
        'name': 'Gunung Bromo',
        'location': 'Jawa Timur, Indonesia',
        'price': 34000,
        'rating': 4.8,
        'description': 'Saksikan pemandangan sunrise yang tak terlupakan di salah satu kawah vulkanik paling eksotis.',
        'image': 'https://upload.wikimedia.org/wikipedia/commons/thumb/8/8e/Bromo-Semeru-Batok-Widodaren.jpg/640px-Bromo-Semeru-Batok-Widodaren.jpg'
      },
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              radius: 16,
              backgroundColor: Colors.blue.shade100,
              child: const Icon(Icons.person, color: Color(0xFF1E5BB2), size: 20),
            ),
            const SizedBox(width: 8),
            const Text('SmartNesia', style: TextStyle(color: Color(0xFF1E5BB2), fontWeight: FontWeight.bold)),
          ],
        ),
        actions: [
          IconButton(icon: const Icon(Icons.search, color: Color(0xFF1E5BB2)), onPressed: () {}),
        ],
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Wisata SmartNesia', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black87)),
            const SizedBox(height: 8),
            const Text('Temukan keajaiban nusantara di ujung jari Anda.', style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 20),
            
            // Search Bar
            Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Icon(Icons.search, color: Colors.grey),
                  ),
                  const Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Cari destinasi impian...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(4),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0D47A1),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Icon(Icons.tune, color: Colors.white, size: 20),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            
            // Filter Chips
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildChip('Terdekat', true),
                  _buildChip('Pantai', false),
                  _buildChip('Gunung', false),
                  _buildChip('Budaya', false),
                ],
              ),
            ),
            const SizedBox(height: 24),
            
            // Destinations List
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: destinations.length,
              itemBuilder: (context, index) {
                final dest = destinations[index];
                return _buildDestinationCard(context, dest);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChip(String label, bool isSelected) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF0D47A1) : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.black87,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }

  Widget _buildDestinationCard(BuildContext context, Map<String, dynamic> dest) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.grey.shade200, blurRadius: 10, offset: const Offset(0, 5)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                child: Image.network(
                  dest['image'],
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 16,
                right: 16,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.star, color: Colors.orange, size: 16),
                      const SizedBox(width: 4),
                      Text('${dest['rating']}', style: const TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 16,
                left: 16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      dest['name'],
                      style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold, shadows: [Shadow(color: Colors.black54, blurRadius: 5)]),
                    ),
                    Row(
                      children: [
                        const Icon(Icons.location_on, color: Colors.white, size: 14),
                        const SizedBox(width: 4),
                        Text(
                          dest['location'],
                          style: const TextStyle(color: Colors.white, shadows: [Shadow(color: Colors.black54, blurRadius: 5)]),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(dest['description'], style: const TextStyle(color: Colors.grey, height: 1.5)),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => BookingScreen(destination: dest)),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF0D47A1),
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        ),
                        child: const Text('BOOKING', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      ),
                    ),
                    const SizedBox(width: 15),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.greenAccent.shade100,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.bookmark_border, color: Colors.green),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
