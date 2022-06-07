import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF009289),
              Color(0xFF0167B2),
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/logo.png',
                scale: 0.8,
              ),
              SizedBox(height: screenSize.height * .15),
              SizedBox(
                height: 49,
                width: screenSize.width * .8,
                child: ElevatedButton(
                  onPressed: () {},
                  style:
                      ElevatedButton.styleFrom(primary: Colors.grey.shade200),
                  child: Container(
                    child: Image.asset('assets/images/google.png'),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
