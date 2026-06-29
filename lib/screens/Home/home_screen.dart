import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:keyperion/constants/api.dart';
import 'package:keyperion/screens/Appointments/appointments_screen.dart';
import 'package:keyperion/screens/Chat/chat_screen.dart';
import 'package:keyperion/screens/Home/unit/no_unit_screen.dart';
import 'package:keyperion/screens/Home/unit/unit_dashboard_screen.dart';
import 'package:keyperion/screens/Maintenance/maintenance_screen.dart';
import 'package:keyperion/screens/Profile/profile_screens.dart';
import 'package:keyperion/utils/auth_manager.dart';
import 'package:keyperion/widgets/bottom_nav_bar.dart';
import 'package:keyperion/widgets/header.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget{
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>{
  String _name = 'Loading...';
  String _email = 'Loading...';
  String _image = 'Loading...';
  bool _isLoading = true;
  bool _hasUnit = false;
  int _currentIndex = 0;

  late final List<Widget> _pages;

  @override
  void initState(){
    super.initState();
    _fetchUserInfo();
    _pages = [
      const UnitDashboardScreen(),
      const MaintenanceScreen(),
      const ChatScreen(),
      const AppointmentsScreen(),
      const ProfileScreen()
    ];
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
 Widget build(BuildContext context){
  return Scaffold(
    backgroundColor: const Color(0xFFF8F9FA),
    body: SafeArea(
      child: _isLoading ? const Center(child: CircularProgressIndicator(
        color: Colors.black,
        strokeWidth: 3,
      )) : Column(
        children: [
          if(_currentIndex != 4)
            Header(name: _name, email: _email, image: _image),

          // Expanded(child: _hasUnit ? const UnitDashboardScreen() : const NoUnitScreen())
          Expanded(child: _pages[_currentIndex])
        ],
      ),
      
    ),
    bottomNavigationBar: BottomNavBar(
      currentIndex: _currentIndex,
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });
      },
    ),
  );
 } 
}