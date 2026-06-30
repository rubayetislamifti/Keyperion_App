import 'dart:ui';

import 'package:flutter/material.dart';

class AccountSettingsScreen extends StatefulWidget{
  const AccountSettingsScreen({super.key});

  State<AccountSettingsScreen> createState() => _AccountSettingStateScreen();
}

class _AccountSettingStateScreen extends State<AccountSettingsScreen>{
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

                     Stack()
                   ],
                 ),
                )
              )
            ],
          ),
      ),
    );
  }
}