import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:cupertino_icons/cupertino_icons.dart';
import 'services_screen.dart';
import 'chatbot_screen.dart';
import 'profile_screen.dart';
import 'ticket_screen.dart';
import 'my_tickets_screen.dart';
import 'event_screen.dart';
import 'tourism_screen.dart';
import '../services/auth_service.dart';

class MainTabBarView extends StatefulWidget {
  const MainTabBarView({super.key});

  @override
  State<MainTabBarView> createState() => _MainTabBarViewState();
}

class _MainTabBarViewState extends State<MainTabBarView> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const ServicesScreen(),
    const ChatbotScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF1E5BB2),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.grid_view),
              activeIcon: Icon(Icons.grid_view_rounded),
              label: 'Services'),
          BottomNavigationBarItem(
              icon: Icon(Icons.chat_bubble_outline),
              activeIcon: Icon(Icons.chat_bubble),
              label: 'AI Bot'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              activeIcon: Icon(Icons.person),
              label: 'Profile'),
        ],
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
        // Ambil nama depan saja
        _userName = user['name']!.split(' ')[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            const Icon(Icons.cloud_done, color: Color(0xFF1E5BB2), size: 28),
            const SizedBox(width: 8),
            const Text('SmartNesia',
                style: TextStyle(
                    color: Colors.black87, fontWeight: FontWeight.bold)),
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon:
                  const Icon(Icons.notifications_none, color: Colors.black54)),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Greeting
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Good morning,',
                          style: TextStyle(color: Colors.grey, fontSize: 14)),
                      const SizedBox(height: 4),
                      Text('Halo, $_userName 👋',
                          style: const TextStyle(
                              color: Colors.black87,
                              fontSize: 22,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.blue.shade100,
                    child: const Icon(Icons.person,
                        color: Color(0xFF1E5BB2), size: 30),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Search
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search, color: Colors.grey),
                    hintText: 'Cari layanan publik atau destinasi...',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 15),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // Grid Icons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildMenuIcon(context, Icons.account_balance,
                      'Layanan\nPublik', Colors.blue, () {
                    // Navigasi ke ServicesScreen (Karena ada di BottomNav, kita bisa arahkan menggunakan Navigator langsung atau ganti index. Di sini kita push untuk simpel)
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ServicesScreen()));
                  }),
                  _buildMenuIcon(
                      context, Icons.landscape, 'Wisata', Colors.green, () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const TourismScreen()));
                  }),
                  _buildMenuIcon(context, Icons.confirmation_number, 'Tiket',
                      Colors.orange, () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MyTicketsScreen()));
                  }),
                  _buildMenuIcon(
                      context, Icons.event, 'Event', Colors.purple,
                      () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const EventScreen()));
                  }),
                ],
              ),
              const SizedBox(height: 24),
              // Banner
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E5BB2),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  children: [
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              'Vaksinasi Booster Ke-2 Kini Tersedia di Puskesmas Terdekat',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16)),
                          SizedBox(height: 8),
                          Text(
                              'Daftar sekarang melalui aplikasi PeduliLindungi',
                              style: TextStyle(
                                  color: Colors.white70, fontSize: 12)),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    Image.network(
                        'https://cdn-icons-png.flaticon.com/512/3050/3050525.png',
                        height: 60,
                        color: Colors.white),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // Recommendations
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Rekomendasi untuk Kamu',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  TextButton(
                      onPressed: () {}, child: const Text('Lihat semua')),
                ],
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 200,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildTourismCard('Wisata & Kebudayaan', 'Gunung Bromo',
                        'Rp 34,000', Colors.orange),
                    _buildTourismCard('Wisata & Kebudayaan', 'Pulau Wayag',
                        'Rp 50,000', Colors.blue),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuIcon(BuildContext context, IconData icon, String label,
      Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(height: 8),
          Text(label,
              textAlign: TextAlign.center,
              style:
                  const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _buildTourismCard(
      String category, String title, String price, Color color) {
    return Container(
      width: 160,
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.shade200,
              blurRadius: 10,
              offset: const Offset(0, 5)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 100,
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15), topRight: Radius.circular(15)),
            ),
            child: const Center(
                child: Icon(Icons.landscape, size: 50, color: Colors.white)),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(category,
                    style:
                        TextStyle(color: Colors.grey.shade600, fontSize: 10)),
                const SizedBox(height: 4),
                Text(title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 14)),
                const SizedBox(height: 8),
                Text(price,
                    style: const TextStyle(
                        color: Color(0xFF1E5BB2),
                        fontWeight: FontWeight.bold,
                        fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
