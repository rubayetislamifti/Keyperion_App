import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NoUnitScreen extends StatelessWidget{
  const NoUnitScreen({super.key});

  @override

  Widget build(BuildContext context){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/images/house.png',
          width: 180,
          height: 180,
        ),
        const SizedBox(height: 24),

        const Text(
          'No Unit Joined',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color:  Colors.black,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Join a unit to see the details here',
          style: TextStyle(fontSize: 14, color: Colors.black45),
        ),
        const SizedBox(height: 32),

        SizedBox(
          width: 180,
          height: 52,
          child: ElevatedButton(onPressed: (){},
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30)
            ),
          ),
           child: const Text(

            'Join unit',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
           ) 
           
           ),
        )
      ],
    );
  }
}