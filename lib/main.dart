// import 'package:flutter/material.dart';
// import 'dart:async';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.green), // Change seed color to green
//         useMaterial3: true,
//         scaffoldBackgroundColor: Colors.white, // Change background to white
//       ),
//       home: const SplashScreen(),
//     );
//   }
// }
//
// // SplashScreen Widget
// class SplashScreen extends StatefulWidget {
//   const SplashScreen({Key? key}) : super(key: key);
//
//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();
//     // Navigate to LoginPage after 3 seconds
//     Timer(const Duration(seconds: 3), () {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => const LoginPage()),
//       );
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [Colors.green, Colors.black], // Ubah warna gradien menjadi hijau dan hitam
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//         ),
//         child: Center(
//           child: AnimatedOpacity(
//             opacity: 1.0,
//             duration: const Duration(seconds: 1),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Image.asset(
//                   'images/mahkota.png',
//                   height: 150,
//                   width: 300,
//                 ),
//                 const SizedBox(height: 10), // Ubah nilai ini untuk mengatur jarak
//                 const Text(
//                   'NOVAL RIZKY',
//                   style: TextStyle(
//                     fontSize: 28,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// // LoginPage Widget
// class LoginPage extends StatefulWidget {
//   const LoginPage({super.key});
//
//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }
//
// class _LoginPageState extends State<LoginPage> {
//   // Controllers to capture username and password input
//   final TextEditingController _usernameController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   bool _isPasswordVisible = false;
//
//   // Simple function to handle login action
//   void _handleLogin() {
//     String username = _usernameController.text;
//     String password = _passwordController.text;
//
//     if (username == "noval" && password == "152022171") {
//       Navigator.push(
//         context,
//         MaterialPageRoute(builder: (context) => const HomePage()),
//       );
//       _usernameController.clear();
//       _passwordController.clear();
//     } else {
//       _showErrorDialog();
//     }
//   }
//
//   // Function to show error dialog
//   void _showErrorDialog() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Login Error'),
//           content: const Text('Username atau password salah.'),
//           actions: <Widget>[
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: const Text('OK'),
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   // Navigate to the Register Page
//   void _navigateToRegisterPage() {
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => const RegisterPage()),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Sign Up'),
//         backgroundColor: Colors.green, // Change AppBar color to green
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Center(
//           child: SingleChildScrollView(
//             child: Container(
//               padding: const EdgeInsets.all(20.0),
//               decoration: BoxDecoration(
//                 color: Colors.white, // Set container color to white
//                 borderRadius: BorderRadius.circular(15.0),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.grey.withOpacity(0.3),
//                     spreadRadius: 5,
//                     blurRadius: 7,
//                     offset: const Offset(0, 3),
//                   ),
//                 ],
//               ),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   Image.asset(
//                     'images/mahkota.png',
//                     height: 100,
//                     width: 220,
//                   ),
//                   const SizedBox(height: 16),
//                   const SizedBox(height: 32),
//                   TextField(
//                     controller: _usernameController,
//                     decoration: const InputDecoration(
//                       labelText: 'Username',
//                       border: OutlineInputBorder(),
//                       prefixIcon: Icon(Icons.person),
//                     ),
//                   ),
//                   const SizedBox(height: 16),
//                   TextField(
//                     controller: _passwordController,
//                     obscureText: !_isPasswordVisible,
//                     decoration: InputDecoration(
//                       labelText: 'Password',
//                       border: const OutlineInputBorder(),
//                       prefixIcon: const Icon(Icons.lock),
//                       suffixIcon: IconButton(
//                         icon: Icon(
//                           _isPasswordVisible
//                               ? Icons.visibility
//                               : Icons.visibility_off,
//                         ),
//                         onPressed: () {
//                           setState(() {
//                             _isPasswordVisible = !_isPasswordVisible;
//                           });
//                         },
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 16),
//                   ElevatedButton(
//                     onPressed: _handleLogin,
//                     style: ElevatedButton.styleFrom(
//                       padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0),
//                       minimumSize: const Size(400, 50), // Mengatur ukuran minimum tombol (lebar, tinggi)
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(30.0),
//                       ),
//                       backgroundColor: Colors.green, // Ubah warna tombol menjadi hijau
//                     ),
//                     child: const Text('Login', style: TextStyle(fontSize: 18, color: Colors.white)), // Ubah warna teks tombol menjadi putih
//                   ),
//                   const SizedBox(height: 16),
//                   const Text("Tidak mempunyai akun?", style: TextStyle(fontSize: 16)),
//                   TextButton(
//                     onPressed: _navigateToRegisterPage,
//                     style: TextButton.styleFrom(
//                       foregroundColor: Colors.blue, // Ubah warna teks tombol menjadi biru
//                     ),
//                     child: const Text(
//                       'Daftar Sekarang',
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold, // Membuat teks menjadi bercetak tebal
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// // RegisterPage Widget
// class RegisterPage extends StatelessWidget {
//   const RegisterPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final TextEditingController _nameController = TextEditingController();
//     final TextEditingController _usernameController = TextEditingController();
//     final TextEditingController _passwordController = TextEditingController();
//     final TextEditingController _confirmPasswordController = TextEditingController();
//
//     void _handleRegister() {
//       String name = _nameController.text;
//       String username = _usernameController.text;
//       String password = _passwordController.text;
//       String confirmPassword = _confirmPasswordController.text;
//
//       print('Name: $name, Username: $username, Password: $password, Confirm Password: $confirmPassword');
//     }
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Register'),
//         backgroundColor: Colors.green, // Change AppBar color to green
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text(
//               'Register',
//               style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 32),
//             TextField(
//               controller: _nameController,
//               decoration: const InputDecoration(
//                 labelText: 'Nama',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             const SizedBox(height: 16),
//             TextField(
//               controller: _usernameController,
//               decoration: const InputDecoration(
//                 labelText: 'Username',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             const SizedBox(height: 16),
//             TextField(
//               controller: _passwordController,
//               obscureText: true,
//               decoration: const InputDecoration(
//                 labelText: 'Password',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             const SizedBox(height: 16),
//             TextField(
//               controller: _confirmPasswordController,
//               obscureText: true,
//               decoration: const InputDecoration(
//                 labelText: 'Konfirmasi Password',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             const SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: _handleRegister,
//               child: const Text('Daftar', style: TextStyle(color: Colors.white)), // Change button text color to white
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.green, // Change button color to green
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// // HomePage Widget
// class HomePage extends StatelessWidget {
//   const HomePage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Selamat Datang'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.logout, color: Colors.red),
//             onPressed: () {
//               Navigator.pop(context);
//             },
//           ),
//         ],
//         automaticallyImplyLeading: false,
//         backgroundColor: Colors.green, // Change AppBar color to green
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text(
//               'Selamat Datang!',
//               style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 20),
//             const Icon(Icons.check_circle, size: 100, color: Colors.green),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'splashscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const SplashScreen(),
    );
  }
}
