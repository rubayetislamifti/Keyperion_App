import 'dart:ui';

import 'package:flutter/material.dart';

class AccountSettingsScreen extends StatefulWidget{
  const AccountSettingsScreen({super.key});

  State<AccountSettingsScreen> createState() => _AccountSettingStateScreen();
}

class _AccountSettingStateScreen extends State<AccountSettingsScreen>{
  final TextEditingController _nameController = TextEditingController(text: 'Md. Abid Hasan');
  final TextEditingController _emailController = TextEditingController(text: 'example@gmail.com');
  final TextEditingController _locationController = TextEditingController(text: 'Dhaka, Bangladesh');

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _locationController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20, vertical: 12
                ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        size: 18,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const Expanded(
                    child: Padding(
                        padding: EdgeInsets.only(right: 42),
                      child: Center(
                        child: Text(
                          'Account Settings',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black
                          ),
                        ),
                      ),
                    )
                  )
                ],
              ),
            ),
              Expanded(
                child: SingleChildScrollView(
                 physics: const BouncingScrollPhysics(),
                 padding: const EdgeInsets.symmetric(horizontal: 20),
                 child: Column(
                   children: [
                     const SizedBox(height: 20),

                     Stack(
                       children: [
                         Container(
                           decoration: BoxDecoration(
                             shape: BoxShape.circle,
                             border: Border.all(color: Colors.white, width: 2),
                             boxShadow: [
                               BoxShadow(
                                 color: Colors.black.withOpacity(0.04),
                                 blurRadius: 10,
                                 offset: const Offset(0, 4)
                               )
                             ]
                           ),
                           child: const CircleAvatar(
                             radius: 52,
                             backgroundColor: Color(0xFFE2D4FF),
                             child: Text(
                               '👤',
                               style: TextStyle(fontSize: 45)
                             ),
                           ),
                         ),
                         Positioned(
                           bottom: 0, right: 0,
                           child: Container(
                             padding: const EdgeInsets.all(8),
                             decoration: BoxDecoration(
                               color: Colors.white,
                               borderRadius: BorderRadius.circular(12),
                               boxShadow: [
                                 BoxShadow(
                                   color: Colors.black.withOpacity(0.06),
                                   blurRadius: 8,
                                   offset: const Offset(0, 2)
                                 )
                               ]
                             ),
                             child: const Icon(
                               Icons.edit_outlined,
                               size: 18,
                               color: Colors.black87,
                             ),
                           ),
                         )
                       ],
                     ),
                     const SizedBox(height: 32),

                     _buildInputField(
                       controller: _nameController,
                       icon: Icons.person_outline_rounded,
                       hintText: 'Full Name',
                     ),
                     _buildInputField(
                       controller: _emailController,
                       icon: Icons.mail_outline_rounded,
                       hintText: 'Email Address',
                     ),
                     _buildInputField(
                       controller: _locationController,
                       icon: Icons.location_on_outlined,
                       hintText: 'Location',
                     ),
                   ],
                 ),
                )
              ),

            Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 24, top: 10),
              child: SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(onPressed: (){},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1E1E1E),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28),
                      )
                    ),
                    child: const Text(
                      'Save Changes',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                ),
              ),
            )
            ],
          ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required IconData icon,
    required String hintText,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.01),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.black87,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.black26, fontSize: 14),
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Icon(icon, color: Colors.black54, size: 20),
          ),
          prefixIconConstraints: const BoxConstraints(minWidth: 40),
          border: InputBorder.none, // কোনো ডিফল্ট বর্ডার থাকবে না
          contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        ),
      ),
    );
  }
}