import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'register_screen.dart';
import '../services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();

  Future<void> _loginSimulated(String defaultName) async {
    final email = _emailController.text.trim().isEmpty ? 'user@gmail.com' : _emailController.text.trim();
    await AuthService.saveUser(defaultName, email);
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainTabBarView()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Top Blue Header
            Container(
              height: 350,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xFF1E5BB2),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: const SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.cloud_done, color: Colors.white, size: 60),
                    SizedBox(height: 10),
                    Text(
                      'SMART\nNESIA',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                    SizedBox(height: 30),
                    Text(
                      'Sign in to your Account',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Enter your email and password to continue',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            // Login Form
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                   // Google Login Button
                  ElevatedButton.icon(
                    onPressed: () => _loginSimulated('Pengguna Google'),
                    icon: const Icon(Icons.g_mobiledata, size: 30, color: Colors.black54),
                    label: const Text('Continue with Google', style: TextStyle(color: Colors.black87)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 50),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                        side: BorderSide(color: Colors.grey.shade300),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Row(
                    children: [
                      Expanded(child: Divider()),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text("Or login with", style: TextStyle(color: Colors.grey)),
                      ),
                      Expanded(child: Divider()),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Email Field
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email/Phone number',
                      hintText: 'budi.pratama@gmail.com',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Password Field
                  TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      hintText: '••••••••',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      suffixIcon: const Icon(Icons.visibility_off, color: Colors.grey),
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Remember Me & Forgot Password
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            value: true,
                            onChanged: (value) {},
                            activeColor: const Color(0xFF1E5BB2),
                          ),
                          const Text('Remember me', style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text('Forgot Password?', style: TextStyle(color: Color(0xFF1E5BB2))),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Login Button
                  ElevatedButton(
                    onPressed: () => _loginSimulated('Pengguna Email'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1E5BB2),
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: const Text('LOGIN', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account? ", style: TextStyle(color: Colors.grey)),
                      TextButton(
                         onPressed: () {
                           Navigator.push(
                             context,
                             MaterialPageRoute(builder: (context) => const RegisterScreen()),
                           );
                         },
                         child: const Text('Sign Up', style: TextStyle(color: Color(0xFF1E5BB2), fontWeight: FontWeight.bold)),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

