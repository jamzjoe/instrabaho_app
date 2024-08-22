import 'package:flutter/material.dart';

class NewPasswordScreen extends StatelessWidget {
  const NewPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Forgot Password',
          style: TextStyle(
            fontSize: 14,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView(
        children: [
          const SizedBox(height: 20),
          const Center(
            child: Text("Create a New Password",
            style: TextStyle(fontSize: 24, color: Colors.black, fontWeight: FontWeight.bold),),
          ),
          const SizedBox(height: 20),
          TextFormField(
            obscureText: true,
            //leading: Icon(Icons.lock_person_outlined),
            decoration: const InputDecoration(
              labelText: 'New Password',
            ),
          ),
          TextFormField(
            obscureText: true,
            //leading: Icon(Icons.lock_person_outlined),
            decoration: const InputDecoration(
              labelText: 'Confirm New Password',
            ),
          ),
        ],
        
      )

      
    );
  }
}