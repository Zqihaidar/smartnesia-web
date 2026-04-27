import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _userName = 'Pengguna';
  String _userEmail = 'email@domain.com';

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    final user = await AuthService.getUser();
    setState(() {
      if (user['name'] != null && user['name']!.isNotEmpty) {
        _userName = user['name']!;
      }
      if (user['email'] != null && user['email']!.isNotEmpty) {
        _userEmail = user['email']!;
      }
    });
  }

  void _handleLogout() async {
    await AuthService.logout();
    if (mounted) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Profile & Pengaturan', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
             children: [
                Center(
                  child: Column(
                    children: [
                      const CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.blueAccent,
                        child: Icon(Icons.person, size: 50, color: Colors.white),
                      ),
                      const SizedBox(height: 16),
                      Text(_userName, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                      Text(_userEmail, style: const TextStyle(color: Colors.grey)),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.green.shade50,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text('Akun Terverifikasi', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Activity Summary', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade50,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(Icons.assignment, color: Colors.blue),
                            SizedBox(height: 10),
                            Text('12', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                            Text('Layanan Publik', style: TextStyle(color: Colors.blue)),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.green.shade50,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(Icons.confirmation_number, color: Colors.green),
                            SizedBox(height: 10),
                            Text('08', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                            Text('E-ticketing', style: TextStyle(color: Colors.green)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Account Settings', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                ),
                const SizedBox(height: 10),
                _buildSettingItem(Icons.person_outline, 'Data Diri', 'Manage your personal information', () {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Fitur edit Data Diri')));
                }),
                _buildSettingItem(Icons.history, 'Riwayat Aktivitas', 'Track your activities & service history', () {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Menampilkan Riwayat')));
                }),
                _buildSettingItem(Icons.security, 'Keamanan', 'Password and biometric settings', () {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Pengaturan Keamanan')));
                }),
                _buildSettingItem(Icons.help_outline, 'Pusat Bantuan', 'FAQ, support via chat, calls', () {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Menghubungi Pusat Bantuan')));
                }),
                
                const SizedBox(height: 20),
                ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.logout, color: Colors.red),
                  ),
                  title: const Text('Keluar', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
                  subtitle: const Text('Sign out from this device', style: TextStyle(color: Colors.grey)),
                  onTap: _handleLogout,
                ),
             ],
          ),
        ),
      ),
    );
  }

  Widget _buildSettingItem(IconData icon, String title, String subtitle, VoidCallback onTap) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: const Color(0xFF1E5BB2)),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(subtitle, style: const TextStyle(color: Colors.grey)),
      trailing: const Icon(Icons.chevron_right, color: Colors.grey),
      onTap: onTap,
    );
  }
}
