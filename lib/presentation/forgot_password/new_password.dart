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
          const SizedBox(height: 50),
          const Center(
            child: Text("Create a New Password",
            style: TextStyle(fontSize: 24, color: Colors.black, fontWeight: FontWeight.bold),),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left:20.0, right:20.0,),
            child: TextFormField(
              obscureText: true,
              decoration: const InputDecoration(
                  labelText: 'New Password',
                  labelStyle: TextStyle(color: Colors.black), // Default label color
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    borderSide: BorderSide(color: Colors.grey), // Default border color
                  ),

                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    borderSide: BorderSide(color: Colors.grey, width: 1.5), // Default border color when enabled
                  ),

                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    borderSide: BorderSide(color: Colors.blue, width: 2.0), // Border color when focused
                  ),
                  
                  prefixIcon: Icon(Icons.lock_outline_rounded),
                  fillColor: Colors.black12,
                  filled: true,
                  contentPadding: EdgeInsets.only(left: 20.0),
                        ),
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