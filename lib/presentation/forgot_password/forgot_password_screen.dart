import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:instrabaho_app/constant/router/router_names.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  String? _selectedOption;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: screenHeight * 0.1,
        ),
        child: ListView(
          children: <Widget>[
            const Center(
              child: Text(
                "Forgot Password?",
                style: TextStyle(
                    fontSize: 25,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: screenHeight * 0.01,
                horizontal: screenWidth * 0.15,
              ),
              child: Image.asset(
                'assets/images/forgot_password_img.jpg',
                width: screenWidth * 0.6,
                height: screenHeight * 0.3,
                fit: BoxFit.contain,
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 16.0,
              ),
              child: Center(
                child: Text(
                  'Where would you like to receive a \nVerification Code?',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedOption = 'sms';
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: _selectedOption == 'sms'
                              ? Colors.blueAccent
                              : Colors.black,
                          width: 3.0,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Icon(
                            Icons.message,
                            color: _selectedOption == 'sms'
                                ? Colors.blueAccent
                                : Colors.black,
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              children: [
                                const Text(
                                  'via SMS',
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.black54),
                                ),
                                Text(
                                  '+63 949*****99',
                                  style: TextStyle(
                                    color: _selectedOption == 'sms'
                                        ? Colors.blueAccent
                                        : Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedOption = 'email';
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: _selectedOption == 'email'
                              ? Colors.blueAccent
                              : Colors.black,
                          width: 3.0,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Icon(
                            Icons.email_rounded,
                            color: _selectedOption == 'email'
                                ? Colors.blueAccent
                                : Colors.black,
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              children: [
                                const Text(
                                  'via Email',
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.black54),
                                ),
                                Text(
                                  'andyd****@email.com',
                                  style: TextStyle(
                                    color: _selectedOption == 'email'
                                        ? Colors.blueAccent
                                        : Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: screenHeight * 0.03,
                horizontal: screenWidth * 0.05,
              ),
              child: SizedBox(
                width: screenWidth * 0.9,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () => context
                      .pushNamed(RouterNames.forgot_password_verification),
                  child: const Text('Next',
                      style: TextStyle(fontSize: 14, color: Colors.white)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
