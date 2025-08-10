import 'package:flutter/material.dart';
import 'package:flutter_app/providers/auth_provider.dart';
import 'package:flutter_app/screens/main_tab_screen.dart';
import 'package:flutter_app/screens/forgot_password_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_app/l10n/app_localizations.dart';
import 'package:flutter_app/constants/app_colors.dart';

class AuthScreen extends StatefulWidget {
  final bool isLogin;

  const AuthScreen({super.key, required this.isLogin});

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  String _email = '';
  String _fullName = '';
  String _username = '';
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _fullNameController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();

    if (widget.isLogin) {
      Provider.of<AuthProvider>(context, listen: false)
          .signIn(_email, _passwordController.text)
          .then((_) {
        _showSuccessDialog("Account sign-in successfully");
      });
    } else {
      Provider.of<AuthProvider>(context, listen: false)
          .signUp(_fullName, _email, _passwordController.text, username: _username)
          .then((_) {
        _showSuccessDialog("Account created successfully");
      });
    }
  }

  void _showSuccessDialog(String message) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Row(
          children: [
            Icon(
              Icons.check_circle,
              color: AppColors.success,
              size: 28,
            ),
            const SizedBox(width: 10),
            Text(
              'Success',
              style: TextStyle(
                fontFamily: 'Suwannaphum-Regular',
                fontWeight: FontWeight.bold,
                color: AppColors.success,
              ),
            ),
          ],
        ),
        content: Text(
          message,
          style: const TextStyle(
            fontFamily: 'Suwannaphum-Regular',
            fontSize: 16,
          ),
        ),
        actions: [
          Container(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(ctx).pop();
                Navigator.of(context).pushReplacement(
                  PageRouteBuilder(
                    transitionDuration: const Duration(milliseconds: 500),
                    pageBuilder: (context, animation, secondaryAnimation) => const MainTabScreen(),
                    transitionsBuilder: (context, animation, secondaryAnimation, child) {
                      return FadeTransition(
                        opacity: animation,
                        child: child,
                      );
                    },
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.success,
                foregroundColor: AppColors.textLight,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                AppLocalizations.of(context)!.closeButton,
                style: TextStyle(
                  fontFamily: 'Suwannaphum-Regular',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.backgroundGradient,
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withOpacity(0.3),
                        spreadRadius: 5,
                        blurRadius: 15,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.shopping_bag,
                    size: 80,
                    color: AppColors.textLight,
                  ),
                ),
                const SizedBox(height: 40),
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 2,
                        blurRadius: 15,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Text(
                          widget.isLogin ? AppLocalizations.of(context)!.welcomeBack : AppLocalizations.of(context)!.createAccount,
                          style: const TextStyle(
                            fontFamily: 'Suwannaphum-Regular',
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                        const SizedBox(height: 30),
                        if (!widget.isLogin) ...[
                          // Full Name field
                          TextFormField(
                            controller: _fullNameController,
                            decoration: InputDecoration(
                              hintText: AppLocalizations.of(context)!.fullNameLabel,
                              prefixIcon: const Icon(Icons.person, color: AppColors.primary),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                borderSide: const BorderSide(color: AppColors.primary),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                borderSide: const BorderSide(color: AppColors.primary),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                borderSide: const BorderSide(color: AppColors.primary, width: 2.0),
                              ),
                              contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                            ),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return AppLocalizations.of(context)!.fullNameError;
                              }
                              // Check if first letter is uppercase
                              if (value.trim().isNotEmpty && !RegExp(r'^[A-Z]').hasMatch(value.trim())) {
                                return AppLocalizations.of(context)!.fullNameError;
                              }
                              return null;
                            },
                            onSaved: (v) => _fullName = (v ?? '').trim(),
                          ),
                          const SizedBox(height: 20),
                        ],
                        TextFormField(
                          decoration: InputDecoration(
                            hintText: AppLocalizations.of(context)!.emailLabel,
                            prefixIcon: const Icon(Icons.email, color: AppColors.primary),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              borderSide: const BorderSide(color: AppColors.primary),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              borderSide: const BorderSide(color: AppColors.primary),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              borderSide: const BorderSide(color: AppColors.primary, width: 2.0),
                            ),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return AppLocalizations.of(context)!.emailError;
                            }
                            // Must include @ symbol
                            if (!value.contains('@')) {
                              return AppLocalizations.of(context)!.emailError;
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _email = value!.trim();
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: _passwordController,
                          decoration: InputDecoration(
                            hintText: AppLocalizations.of(context)!.passwordLabel,
                            prefixIcon: const Icon(Icons.lock, color: AppColors.primary),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              borderSide: const BorderSide(color: AppColors.textSecondary),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              borderSide: const BorderSide(color: AppColors.textSecondary),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              borderSide: const BorderSide(color: AppColors.primary, width: 2.0),
                            ),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                                color: AppColors.textSecondary,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isPasswordVisible = !_isPasswordVisible;
                                });
                              },
                            ),
                          ),
                          obscureText: !_isPasswordVisible,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return AppLocalizations.of(context)!.passwordError;
                            }
                            if (value.length < 6) {
                              return AppLocalizations.of(context)!.passwordError;
                            }
                            return null;
                          },
                          onChanged: (value) {
                            if (!widget.isLogin) {
                              _formKey.currentState!.validate();
                            }
                          },
                        ),
                        if (!widget.isLogin) ...[
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: _confirmPasswordController,
                            decoration: InputDecoration(
                              hintText: AppLocalizations.of(context)!.confirmPasswordLabel,
                              prefixIcon: const Icon(Icons.lock_outline, color: AppColors.primary),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                borderSide: const BorderSide(color: AppColors.textSecondary),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                borderSide: const BorderSide(color: AppColors.textSecondary),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                borderSide: const BorderSide(color: AppColors.primary, width: 2.0),
                              ),
                              contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _isConfirmPasswordVisible ? Icons.visibility : Icons.visibility_off,
                                  color: AppColors.textSecondary,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                                  });
                                },
                              ),
                            ),
                            obscureText: !_isConfirmPasswordVisible,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return AppLocalizations.of(context)!.passwordMismatchError;
                              }
                              if (value != _passwordController.text) {
                                return AppLocalizations.of(context)!.passwordMismatchError;
                              }
                              return null;
                            },
                            onChanged: (value) {
                              _formKey.currentState!.validate();
                            },
                          ),
                        ],
                        if (widget.isLogin) ...[
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) => const ForgotPasswordScreen(),
                                  ),
                                );
                              },
                              child: Text(
                                AppLocalizations.of(context)!.forgotPassword,
                                style: const TextStyle(
                                  color: AppColors.textSecondary,
                                  fontFamily: 'Suwannaphum-Regular',
                                ),
                              ),
                            ),
                          ),
                        ],
                        const SizedBox(height: 30),
                        Container(
                          width: double.infinity,
                          height: 55,
                          decoration: BoxDecoration(
                            gradient: AppColors.primaryGradient,
                            borderRadius: BorderRadius.circular(30.0),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primary.withOpacity(0.4),
                                spreadRadius: 2,
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: ElevatedButton(
                            onPressed: _submit,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                            ),
                            child: Text(
                              widget.isLogin ? AppLocalizations.of(context)!.signIn : AppLocalizations.of(context)!.signUp,
                              style: const TextStyle(
                                fontFamily: 'Suwannaphum-Regular',
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: AppColors.textLight,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              widget.isLogin ? AppLocalizations.of(context)!.doesNotHaveAccount : AppLocalizations.of(context)!.alreadyHaveAccount,
                              style: const TextStyle(
                                color: AppColors.textSecondary,
                                fontFamily: 'Suwannaphum-Regular',
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (context) => AuthScreen(isLogin: !widget.isLogin),
                                  ),
                                );
                              },
                              child: Text(
                                widget.isLogin ? AppLocalizations.of(context)!.signUp : AppLocalizations.of(context)!.signIn,
                                style: const TextStyle(
                                  color: AppColors.primary,
                                  fontFamily: 'Suwannaphum-Regular',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
