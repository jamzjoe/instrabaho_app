import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
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
            const SizedBox(height: 16),
            const Text(
              'Please enter the code we\'ve sent you',
              style: TextStyle(
                fontSize: 12,
                color: Colors.black45,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildOTPBox(screenWidth, context),
                _buildOTPBox(screenWidth, context),
                _buildOTPBox(screenWidth, context),
                _buildOTPBox(screenWidth, context),
              ],
            ),
            const SizedBox(height: 32),
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
            const Spacer(), // Pushes the remaining content to the bottom
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    '1 of 2',
                    textAlign: TextAlign.end,
                  ),
                  LinearProgressIndicator(
                    value: 0.5,
                    backgroundColor: Colors.grey[300],
                    color: Colors.black,
                    minHeight: 6,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  const SizedBox(height: 15),

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onPressed: () => context.pushNamed(RouterNames.new_password),
                      child: const Text(
                        'Verify',
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      ),
                    ),
                  
                  const Gap(20), //
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
      width: screenWidth * 0.17,
      child: TextFormField(
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 24),
        keyboardType: TextInputType.number,
        maxLength: 1,
        decoration: InputDecoration(
          counterText: "",
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(width: 2.0, color: Colors.black12),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(width: 2.0, color: Colors.black),
          ),
        ),
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          }
        },
      ),
    );
  }
}
