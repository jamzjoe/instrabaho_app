import 'package:flutter/material.dart';

class NewPasswordScreen extends StatelessWidget {
  const NewPasswordScreen({super.key});

  Future<void> _dialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            content: SizedBox(
              width: 150,
              height: 400,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/forgot_password_img.jpg',
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Congratulations !',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  const Column(
                    children: [
                      Text(
                        'Password Reset successful\n'
                        'You\'ll be redirected to\n'
                        'the login screen now \n',
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                    ),
                ],
              ),
            ],
          ),
        ));
      },
    );
  }

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
              child: Text(
                "Create a New Password",
                style: TextStyle(
                    fontSize: 24,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(
                left: 20.0,
                right: 20.0,
              ),
              child: TextFormField(
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'New Password',
                  labelStyle:
                      TextStyle(color: Colors.black), // Default label color
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    borderSide:
                        BorderSide(color: Colors.grey), // Default border color
                  ),

                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    borderSide: BorderSide(
                        color: Colors.grey,
                        width: 1.5), // Default border color when enabled
                  ),

                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    borderSide: BorderSide(
                        color: Colors.blue,
                        width: 2.0), // Border color when focused
                  ),

                  prefixIcon: Icon(Icons.lock_outline_rounded),
                  fillColor: Colors.black12,
                  filled: true,
                  contentPadding: EdgeInsets.only(left: 20.0),
                ),
              ),
            ),
            const SizedBox(height: 20), // Space before the progress bar
            Padding(
              padding: const EdgeInsets.only(
                left: 20.0,
                right: 20.0,
              ),
              child: TextFormField(
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Confirm New Password',
                  labelStyle:
                      TextStyle(color: Colors.black), // Default label color
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    borderSide:
                        BorderSide(color: Colors.grey), // Default border color
                  ),

                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    borderSide: BorderSide(
                        color: Colors.grey,
                        width: 1.5), // Default border color when enabled
                  ),

                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    borderSide: BorderSide(
                        color: Colors.blue,
                        width: 2.0), // Border color when focused
                  ),

                  prefixIcon: Icon(Icons.lock_outline_rounded),
                  fillColor: Colors.black12,
                  filled: true,
                  contentPadding: EdgeInsets.only(left: 20.0),
                ),
              ),
            ),
            const SizedBox(height: 400), // Space before the progress bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  LinearProgressIndicator(
                    value: 1,
                    backgroundColor: Colors.grey[300],
                    color: Colors.black,
                    minHeight: 6, // Set height of the progress bar
                    borderRadius: BorderRadius.circular(10),
                  ),

                  const SizedBox(
                      height: 15), // Space between progress bar and the button
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () => _dialogBuilder(context),
                    child: const Text('Verify',
                        style: TextStyle(fontSize: 14, color: Colors.white)),
                  )
                ],
              ),
            ),
          ],
        ));
  }
}
