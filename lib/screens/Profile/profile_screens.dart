import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:keyperion/constants/api.dart';
import 'package:keyperion/utils/auth_manager.dart';
import 'package:http/http.dart' as http;

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  State<ProfileScreen> createState() => _ProfileStateScreen();
}

class _ProfileStateScreen extends State<ProfileScreen>{
  String _name = 'Loading...';
  String _email = 'Loading...';
  String _image = 'Loading...';
  bool _isLoading = true;
  bool _hasUnit = false;

  @override
  void initState() {
    super.initState();
    _fetchUserInfo();
  }

  Future<void> _fetchUserInfo() async{

    final token = AuthManager().getToken();

    final url = Uri.parse(Api.me);

    try{
      final res = await http.get(
          url,
          headers: {
            'Content-Type':'application/json',
            'Authorization':'Bearer $token',
          }
      );

      final resData = jsonDecode(res.body);


      if(resData['status'] == true){
        setState(() {
          _name = resData['data']['name'];
          _email = resData['data']['email'];
          _image = resData['data']['img'];
          _hasUnit = resData['data']['has_user_joined'];
          _isLoading = false;
        });
      }


    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error Fetching Data'),backgroundColor: Colors.red,)
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            const Text(
              'Profile',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 24),


            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 4),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Color(0xFFE2D4FF),

                backgroundImage: !_isLoading && _image != 'Loading...'
                    ? NetworkImage(_image)
                    : null,
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white, strokeWidth: 2)
                    : (_image == 'Loading...'
                    ? const Text('👤', style: TextStyle(fontSize: 45))
                    : null),
              ),
            ),
            const SizedBox(height: 16),

            // ================= ৩. ইউজার নাম ও ইমেইল =================
            Text(
              _name,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              _email,
              style: TextStyle(
                fontSize: 13,
                color: Colors.black45,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 24),

            // ================= ৪. ইউনিট জয়েন কার্ড =================
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.02),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Unit',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black38,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'No unit joined',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1E1E1E),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text(
                      'Join',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // ================= ৫. সেটিংস অপশন লিস্ট =================
            _buildSettingTile(
              icon: Icons.person_outline_rounded,
              title: 'Account settings',
              subtitle: 'Edit your profile informations',
              onTap: () {},
            ),
            _buildSettingTile(
              icon: Icons.chat_bubble_outline_rounded,
              title: 'Support',
              subtitle: 'Facing any issue? Contact with platform admin',
              onTap: () {},
            ),
            _buildSettingTile(
              icon: Icons.settings_outlined,
              title: 'Settings',
              subtitle: 'Change password, privacy policy, faq...',
              onTap: () {},
            ),
            _buildSettingTile(
              icon: Icons.delete_outline_rounded,
              title: 'Delete account',
              subtitle: 'Delete your account from Keyperion Living',
              isDestructive: true,
              onTap: () {},
            ),
            _buildSettingTile(
              icon: Icons.logout_rounded,
              title: 'Logout',
              subtitle: 'After logging out you have to login again with your credentials',
              isLogout: true,
              onTap: () {},
            ),
            const SizedBox(height: 40), // স্ক্রল সেফটি প্যাডিং
          ],
        ),
      ),
    );
  }

  // কাস্টম সেটিংস টাইল উইজেট মেকার
  Widget _buildSettingTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    bool isDestructive = false,
    bool isLogout = false,
  }) {
    // কালার স্কিম নির্ধারণ (লগআউটের জন্য লাল ব্যাকগ্রাউন্ড, ডিলিটের জন্য লাল টেক্সট)
    Color iconBgColor = isLogout ? const Color(0xFFE53935) : const Color(0xFFF8F9FA);
    Color iconColor = isLogout ? Colors.white : (isDestructive ? const Color(0xFFE53935) : Colors.black);
    Color titleColor = (isDestructive || isLogout) ? const Color(0xFFE53935) : Colors.black87;

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Row(
          children: [
            // বাম পাশের গোল আইকন কন্টেইনার
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: iconBgColor,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: iconColor, size: 22),
            ),
            const SizedBox(width: 14),

            // মাঝখানের টেক্সট সেকশন
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: titleColor,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black38,
                      height: 1.2,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),

            // ডান পাশের অ্যারো আইকন
            const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 16,
              color: Colors.black26,
            ),
          ],
        ),
      ),
    );
  }
}