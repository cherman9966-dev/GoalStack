import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../widgets/animations/animated_fire_logo.dart';
import 'package:goalstack/home/features/presentation/widgets/utils/custom_widgets/primary_gradient_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isPasswordVisible = false;
  bool _rememberMe = false;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/log_background_fon.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 22.0,
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 32.0,
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF122246).withOpacity(0.5),
                      Color(0xFF091428).withOpacity(0.5),
                    ],
                  ),

                  borderRadius: BorderRadius.circular(32),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AnimatedFireLogo(
                      mainLogoPath: 'assets/images/fire_logo.png', size: 75,
                      sparkPath: 'assets/icons/flame_icon.png',
                    ),
                    const SizedBox(height: 15),

                    // 4. Заголовки
                    const Text(
                      'Welcome to GoalStack',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'A simple place to keep your momentum—quietly,\ndaily, and without extra distractions.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // 5. Поле Email
                    _buildTextFieldLabel('Email'),
                    _buildTextField(
                      hint: 'e.g. name@example.com',
                      controller: _emailController,
                    ),
                    const SizedBox(height: 10),

                    // 6. Поле Password
                    _buildTextFieldLabel('Password'),
                    _buildPasswordField(controller: _passwordController),
                    const SizedBox(height: 16),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _rememberMe = !_rememberMe;
                            });
                          },
                          child: Row(
                            children: [
                              Icon(
                                _rememberMe
                                    ? Icons.check_circle
                                    : Icons.circle_outlined,
                                color: _rememberMe
                                    ? const Color(0xFFFF6B00)
                                    : Colors.white54,
                                size: 25,
                              ),
                              const SizedBox(width: 8),
                              const Text(
                                'Remember me',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),

                        GestureDetector(
                          onTap: () {},
                          child: const Text(
                            'Forgot Password?',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // 8. Кнопка Log in
                    PrimaryGradientButton(
                      text: 'Log in',
                      onPressed: () {
                        if (_emailController.text.trim().isEmpty ||
                            _passwordController.text.trim().isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Row(
                                children: [
                                  Icon(
                                    Icons.info_outline,
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      'Please enter your Email and Password',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              backgroundColor: const Color(0xFFFF6B00),
                              behavior: SnackBarBehavior.floating,
                              margin: const EdgeInsets.only(
                                bottom: 32,
                                left: 24,
                                right: 24,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              elevation: 10,
                              duration: const Duration(seconds: 3),
                            ),
                          );
                        } else {
                          context.go('/my_topic_page');
                        }
                      },
                    ),
                    const SizedBox(height: 16),

                    Row(
                      children: [
                        const Expanded(
                          child: Divider(color: Colors.white24, thickness: 1),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            'or',
                            style: TextStyle(
                              color: Colors.white54,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        const Expanded(
                          child: Divider(color: Colors.white24, thickness: 1),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    _buildSocialButton(
                      'Log in with Google',
                      'assets/icons/google_logo.png',
                    ),
                    const SizedBox(height: 12),
                    _buildSocialButton(
                      'Log in with Apple',
                      'assets/icons/apple_icon.png',
                    ),
                    const SizedBox(height: 20),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't have an account? ",
                          style: TextStyle(color: Colors.white70, fontSize: 14),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: const Text(
                            'Sign up',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                              decorationColor: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // --- Допоміжні віджети ---

  Widget _buildTextFieldLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          text,
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String hint,
    required TextEditingController controller,
  }) {
    return TextField(
      controller: controller,
      style: const TextStyle(color: Colors.black, fontSize: 16),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.black38, fontSize: 14),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildPasswordField({required TextEditingController controller}) {
    return TextField(
      controller: controller,
      style: const TextStyle(color: Colors.black, fontSize: 16),
      obscureText: !_isPasswordVisible,
      decoration: InputDecoration(
        hintText: 'Must contain at least 6 characters',
        hintStyle: const TextStyle(color: Colors.black38, fontSize: 14),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        suffixIcon: IconButton(
          icon: Icon(
            _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
            color: Colors.grey,
          ),
          onPressed: () =>
              setState(() => _isPasswordVisible = !_isPasswordVisible),
        ),
      ),
    );
  }

  Widget _buildSocialButton(String text, String assetPath) {
    return SizedBox(
      width: double.infinity,
      height: 45,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
          elevation: 0,
        ),
        onPressed: () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(assetPath, height: 24), // Іконка соцмережі
            const SizedBox(width: 12),
            Text(
              text,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
