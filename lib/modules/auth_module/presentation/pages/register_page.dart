import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lo2ta/core/theme/app_theme.dart';
import 'package:lo2ta/modules/auth_module/domain/entities/user_entity.dart';
import 'package:lo2ta/modules/auth_module/presentation/cubits/auth_cubit.dart';
import 'package:lo2ta/modules/auth_module/presentation/widgets/glass_container.dart';
import 'package:lo2ta/modules/auth_module/presentation/widgets/premium_button.dart';
import 'package:lo2ta/modules/store_module/dashboard/presentation/pages/main_wrapper.dart';
import 'package:lo2ta/modules/user_module/main_screen/presentation/pages/main_screen.dart';
class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  UserRole _selectedRole = UserRole.user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(title: const Text('Create Account'), elevation: 0),
      body: Stack(
        children: [
          Container(decoration: BoxDecoration(gradient: AppTheme.premiumGradient)),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                   const SizedBox(height: 40),
                   Text(
                     "Join LO2TA",
                     style: Theme.of(context).textTheme.headlineLarge?.copyWith(color: Colors.white),
                   ),
                   const SizedBox(height: 40),
                   GlassContainer(
                    padding: const EdgeInsets.all(24),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(controller: _nameController, decoration: const InputDecoration(hintText: 'Full Name', prefixIcon: Icon(Icons.person_outline))),
                          const SizedBox(height: 16),
                          TextFormField(controller: _emailController, decoration: const InputDecoration(hintText: 'Email', prefixIcon: Icon(Icons.email_outlined))),
                          const SizedBox(height: 16),
                          TextFormField(controller: _passwordController, obscureText: true, decoration: const InputDecoration(hintText: 'Password', prefixIcon: Icon(Icons.lock_outline))),
                          const SizedBox(height: 24),
                          Row(
                            children: [
                              _buildRoleOption("User", UserRole.user),
                              const SizedBox(width: 12),
                              _buildRoleOption("Store Owner", UserRole.storeOwner),
                            ],
                          ),
                          const SizedBox(height: 32),
                          BlocConsumer<AuthCubit, AuthState>(
                            listener: (context, state) {
                              if (state is Authenticated) { Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => state.user.role == UserRole.user ? const MainScreen() : const StoreMainWrapper()), (route) => false); }
                              else if (state is AuthError) { ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message))); }
                            },
                            builder: (context, state) => PremiumButton(text: 'CREATE ACCOUNT', isLoading: state is AuthLoading, onPressed: () { if (_formKey.currentState!.validate()) context.read<AuthCubit>().register(_emailController.text.trim(), _passwordController.text.trim(), _nameController.text.trim(), _selectedRole); }),
                          ),
                        ],
                      ),
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

  Widget _buildRoleOption(String label, UserRole role) {
    bool isSelected = _selectedRole == role;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedRole = role),
        child: AnimatedContainer(
          duration: 300.ms,
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.white.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
                color: isSelected ? AppTheme.primaryColor : Colors.transparent,
                width: 2),
          ),
          child: Center(
            child: Text(
              label,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: isSelected ? AppTheme.primaryColor : Colors.white,
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
