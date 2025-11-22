import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _rememberMe = false;
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8F4F1),
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Check if it's mobile view
          bool isMobile = constraints.maxWidth < 800;

          if (isMobile) {
            // Mobile view - only show login section
            return Center(
              child: SingleChildScrollView(
                child: _buildLoginCard(),
              ),
            );
          } else {
            // Desktop view - show both sections
            return Row(
              children: [
                // Left section - Login
                Expanded(
                  flex: 1,
                  child: Center(
                    child: SingleChildScrollView(
                      child: _buildLoginCard(),
                    ),
                  ),
                ),
                // Right section - Welcome
                Expanded(
                  flex: 1,
                  child: _buildWelcomeSection(),
                ),
              ],
            );
          }
        },
      ),
    );
  }

  Widget _buildLoginCard() {
    return Container(
      width: 440.w,
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      padding: EdgeInsets.all(40.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // App Logo
          Container(
            width: 80.w,
            height: 80.w,
            decoration: BoxDecoration(
              color: const Color(0xFF4A9B8E),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Icon(
              FontAwesomeIcons.fileMedical,
              color: Colors.white,
              size: 40.w,
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            'Scanner',
            style: TextStyle(
              fontSize: 14,
              color: const Color(0xFF4A9B8E),
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 32.h),

          // Title
          Text(
            'Login to your account',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF2C3E50),
            ),
          ),
          SizedBox(height: 32.h),

          // Google Sign In Button
          SizedBox(
            width: double.infinity,
            height: 50.h,
            child: ElevatedButton.icon(
              onPressed: () {
                // Handle Google sign in
              },
              icon: FaIcon(
                FontAwesomeIcons.google,
                size: 20.w,
              ),
              label: const Text(
                'Sign in with Google',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: const Color(0xFF2C3E50),
                elevation: 0,
                side: BorderSide(
                  color: Colors.grey.shade300,
                  width: 1,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
            ),
          ),
          SizedBox(height: 24.h),

          // Divider with text
          Row(
            children: [
              Expanded(child: Divider(color: Colors.grey.shade300)),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Text(
                  'Or use e-mail address',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                  ),
                ),
              ),
              Expanded(child: Divider(color: Colors.grey.shade300)),
            ],
          ),
          SizedBox(height: 24.h),


          // Email field
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Email',
                style: TextStyle(
                  fontSize: 14,
                  color: const Color(0xFF2C3E50),
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 8.h),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: 'Enter your email',
                  prefixIcon: Icon(
                    Icons.email_outlined,
                    color: Colors.grey.shade500,
                    size: 20.w,
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade50,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: const BorderSide(color: Color(0xFF4A9B8E)),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 14.h,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),

          // Password field
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Password',
                style: TextStyle(
                  fontSize: 14,
                  color: const Color(0xFF2C3E50),
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 8.h),
              TextFormField(
                controller: _passwordController,
                obscureText: _obscurePassword,
                decoration: InputDecoration(
                  hintText: 'Enter your password',
                  prefixIcon: Icon(
                    Icons.lock_outline,
                    color: Colors.grey.shade500,
                    size: 20.w,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: Colors.grey.shade500,
                      size: 20.w,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade50,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: const BorderSide(color: Color(0xFF4A9B8E)),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 14.h,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),

          // Remember me and Forgot password
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 20.w,
                    height: 20.h,
                    child: Checkbox(
                      value: _rememberMe,
                      onChanged: (value) {
                        setState(() {
                          _rememberMe = value ?? false;
                        });
                      },
                      activeColor: const Color(0xFF4A9B8E),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    'Remember me',
                    style: TextStyle(
                      fontSize: 14,
                      color: const Color(0xFF2C3E50),
                    ),
                  ),
                ],
              ),
              TextButton(
                onPressed: () {
                  // Handle forgot password
                },
                child: Text(
                  'Forgot password?',
                  style: TextStyle(
                    fontSize: 14,
                    color: const Color(0xFFE74C3C),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 24.h),

          // Login button
          SizedBox(
            width: double.infinity,
            height: 50.h,
            child: ElevatedButton(
              onPressed: () {
                // Handle login
                context.go('/dashboard'); // GoRouter navigation
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF78909C),
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              child: const Text(
                'Login now',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          SizedBox(height: 24.h),


          // Sign up link
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Don't have an account? ",
                style: TextStyle(
                  fontSize: 14,
                  color: const Color(0xFF2C3E50),
                ),
              ),
              TextButton(
                onPressed: () {
                  // Handle sign up navigation
                },
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: Size(0, 0),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  'Join free today',
                  style: TextStyle(
                    fontSize: 14,
                    color: const Color(0xFFE74C3C),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWelcomeSection() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFFB8E6DC),
            const Color(0xFFD4F1EA),
          ],
        ),
      ),
      child: Stack(
        children: [
          // Decorative circles
          Positioned(
            top: -50,
            left: -50,
            child: Container(
              width: 150.w,
              height: 150.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF7FCFC0).withOpacity(0.3),
              ),
            ),
          ),
          Positioned(
            top: 60,
            right: -40,
            child: Container(
              width: 180.w,
              height: 180.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF7FCFC0).withOpacity(0.4),
              ),
            ),
          ),
          Positioned(
            bottom: 200,
            left: 50,
            child: Container(
              width: 80.w,
              height: 80.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF7FCFC0).withOpacity(0.3),
              ),
            ),
          ),
          Positioned(
            bottom: -80,
            left: -60,
            child: Container(
              width: 200.w,
              height: 200.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF7FCFC0).withOpacity(0.2),
              ),
            ),
          ),
          Positioned(
            bottom: -100,
            right: -80,
            child: Container(
              width: 250.w,
              height: 250.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF7FCFC0).withOpacity(0.25),
              ),
            ),
          ),

          // Content
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 60.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'WELCOME BACK!',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF2C3E50),
                      letterSpacing: 2,
                    ),
                  ),
                  SizedBox(height: 24.h),
                  Text(
                    'You\'re just one step away from a\nhigh-quality digital prescription\nexperience.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF2C3E50),
                      height: 1.4,
                    ),
                  ),
                  SizedBox(height: 40.h),

                  // Prescription illustration
                  Container(
                    width: 200.w,
                    height: 200.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Document base
                        Container(
                          width: 140.w,
                          height: 180.w,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.r),
                            border: Border.all(
                              color: const Color(0xFF2C5F5F),
                              width: 3,
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(16.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Header lines
                                Container(
                                  height: 4.h,
                                  width: 80.w,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF4A9B8E),
                                    borderRadius: BorderRadius.circular(2.r),
                                  ),
                                ),
                                SizedBox(height: 4.h),
                                Container(
                                  height: 4.h,
                                  width: 60.w,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF4A9B8E).withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(2.r),
                                  ),
                                ),
                                SizedBox(height: 16.h),
                                // Content lines
                                ...List.generate(
                                  6,
                                      (index) => Padding(
                                    padding: EdgeInsets.only(bottom: 8.h),
                                    child: Container(
                                      height: 3.h,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFB8E6DC),
                                        borderRadius: BorderRadius.circular(2.r),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // Green bar on top
                        Positioned(
                          top: 0,
                          child: Container(
                            width: 140.w,
                            height: 12.h,
                            decoration: BoxDecoration(
                              color: const Color(0xFF4A9B8E),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(8.r),
                                topRight: Radius.circular(8.r),
                              ),
                            ),
                          ),
                        ),
                        // Medical icon
                        Positioned(
                          top: 40,
                          right: 20,
                          child: Container(
                            padding: EdgeInsets.all(8.w),
                            decoration: BoxDecoration(
                              color: const Color(0xFF4A9B8E),
                              shape: BoxShape.circle,
                            ),
                            child: FaIcon(
                              FontAwesomeIcons.fileMedical,
                              color: Colors.white,
                              size: 16.w,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 40.h),

                  // Features text
                  Text(
                    'Streamline your healthcare workflow with\ndigital prescriptions, secure patient records,\nand instant access to medical history.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: const Color(0xFF2C3E50).withOpacity(0.8),
                      height: 1.6,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}