import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:instrabaho_app/constant/router/router_names.dart';

class ForgotPasswordVerificationScreen extends StatelessWidget {
  const ForgotPasswordVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

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
      body: Padding(
        padding: const EdgeInsets.only(top: 60.0),
        child: Column(
          children: [
            const Center(
              child: Text(
                'Verify',
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16), // Added space between "Verify" and the subtitle
            const Text(
              'Please enter the code we\'ve sent you',
              style: TextStyle(
                fontSize: 12,
                color: Colors.black45,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 32), // Added spacing before the OTP fields
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildOTPBox(screenWidth, context),
                _buildOTPBox(screenWidth, context),
                _buildOTPBox(screenWidth, context),
                _buildOTPBox(screenWidth, context),
              ],
            ),
            
            const SizedBox(height: 32), // Added spacing before the OTP fields
            const Text(
              'Didn\'t receive the code?',
              style: TextStyle(
                fontSize: 12,
                color: Colors.black45,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              'Resend Code',
              style: TextStyle(
                fontSize: 12,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 150), // Space before the progress bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  LinearProgressIndicator(
                    value: 0.5, 
                    backgroundColor: Colors.grey[300], 
                    color: Colors.black,
                    minHeight: 6, // Set height of the progress bar
                    borderRadius: BorderRadius.circular(10),
                  ),
                  const SizedBox(height: 15), // Space between progress bar and the button
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),

                  onPressed: () => context.pushNamed(RouterNames.new_password),

                  child: const Text('Verify',
                  style: TextStyle(fontSize: 14, color: Colors.white)),
                  )
                ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildOTPBox(double screenWidth, BuildContext context) {
    return SizedBox(
      width: screenWidth * 0.15, // Adjust width based on screen size
      child: TextFormField(
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 24),
        keyboardType: TextInputType.number,
        maxLength: 1, // Only allow one digit per box
        decoration: InputDecoration(
          counterText: "", // Hide character counter
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(width: 2.0, color: Colors.black12), // Box border
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(width: 2.0, color: Colors.black), // Box border when focused
          ),
        ),
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus(); // Move to next box when filled
          }
        },
      ),
    );
  }
}

