import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:keyperion/constants/api.dart';
import 'package:keyperion/screens/Auth/register_screen.dart';
import 'package:http/http.dart' as http;
import 'package:keyperion/screens/Home/home_screen.dart';
import 'package:keyperion/utils/auth_manager.dart';

class LoginScreen extends StatefulWidget{
  final String? email;
  const LoginScreen({super.key, this.email});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>{
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _rememberMe = false;
  bool _isLoading = false;

  @override
  void dispose(){
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  void initState(){
    super.initState();
      if(widget.email != null){
        _emailController.text = widget.email!;
      }
  }

  Future<void> _loginUser() async{
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please Fill in all fields')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final url = Uri.parse(Api.login);

    try{
      final res = await http.post(
        url,
        headers: {
         'Content-Type': 'application/json' 
        },
        body: jsonEncode({
          'email':email,
          'password':password,
        }),
      );

      if(res.statusCode == 200){
        final resData = jsonDecode(res.body);

        AuthManager().saveToken(resData['data']['token']);
        String successMessage = resData['message'] ?? 'Login Successfull';
        if(mounted){
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(successMessage),backgroundColor: Colors.green,));

            Navigator.push(context, 
              MaterialPageRoute(builder: (context)=> const HomeScreen())
            );
        }
      }else{
        final resData = jsonDecode(res.body);

        String errorMessage = resData['message'] ?? 'Login Failed';
        if(mounted){
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(errorMessage),backgroundColor: Colors.red,));
        }
      }
    }catch(e){
      if(mounted){
        ScaffoldMessenger.of(context).showSnackBar(
         const SnackBar(content: Text('Network Error: Please check your internet connection')),
        );
      }
    }
    finally{
      if(mounted){
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 60),
                  Center(
                    child: Image.asset(
                      'assets/images/logo.png',
                      width: 200,
                      height: 60,
                    ),
                  ),
                  const SizedBox(height: 60),

                  Center(
                    child: Column(
                      children: [
                        const Text(
                          'Sign In',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          "Welcome back! Please Login",
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                        const SizedBox(height: 48),
                      ],
                    ),
                  ),

                  TextField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      hintText: 'Email/Username',
                      hintStyle: const TextStyle(color: Colors.black),
                      prefixIcon: const Icon(Icons.email_outlined, color: Colors.black),
                      filled: true,
                      fillColor: Colors.black.withValues(alpha: 0.07),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: BorderSide.none
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  TextField(
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      hintText: 'Password',
                      hintStyle: const TextStyle(color: Colors.black),
                      prefixIcon: const Icon(Icons.lock_outline, color: Colors.black),
                      suffixIcon: IconButton(icon: Icon(
                        _obscurePassword ? Icons.visibility_off : Icons.visibility,
                        color: Colors.black,
                      ),
                        onPressed: (){
                          setState(() => _obscurePassword = !_obscurePassword);
                        },
                      ),
                      filled: true,
                      fillColor: Colors.black.withValues(alpha: 0.07),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Checkbox(value: _rememberMe,
                            onChanged: (val)=>setState(() => _rememberMe = val!),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                            side: BorderSide(color: Colors.grey.shade400),
                          ),
                          const Text(
                            'Remember Me',
                            style: TextStyle(color: Colors.black54, fontSize: 13),
                          ),
                        ],
                      ),

                      TextButton(
                        onPressed: (){},
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              'Forgot Password?',
                              style: TextStyle(color: Colors.black),
                            ),
                            const SizedBox(height: 4),
                            Container(
                              height: 1,
                              width: 115,
                              color: Colors.black,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 24),

                  SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null: _loginUser, 
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF000000),
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: _isLoading ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      ) : const Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold, color: Colors.white
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  Row(
                    children: [
                      Expanded(
                          child: Divider(color: Colors.grey.shade300, thickness: 0.8)
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          "or continue with",
                          style: TextStyle(color: Colors.grey, fontSize: 14, fontWeight: FontWeight.w400),
                        ),
                      ),
                      Expanded(child: Divider(color: Colors.grey.shade300, thickness: 0.8)),
                    ],
                  ),
                  const SizedBox(height: 24),


                  Center(
                    child: GestureDetector(
                      onTap: (){
                        //API
                      },
                      child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.05),
                                  spreadRadius: 1,
                                  blurRadius: 8,
                                  offset: const Offset(0, 2)
                              ),
                            ],
                            border: Border.all(color: Colors.grey.shade100),
                          ),
                          child: const FaIcon(
                            FontAwesomeIcons.google,
                            size: 24,
                            color: Color(0xFFDB4437),
                          )
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't have an account? ",
                          style: TextStyle(color: Colors.black),
                        ),
                        GestureDetector(
                          onTap: (){
                            Navigator.push(context,
                            MaterialPageRoute(builder: (context)=> const RegisterScreen()),
                            );
                          },
                          child: const Text(
                            "Register",
                            style: TextStyle(
                              color: Color(0xFF000000),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            )
        ),
      ),
    );
  }
}