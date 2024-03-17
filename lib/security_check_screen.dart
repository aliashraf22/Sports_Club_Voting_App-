import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn/bloc/security_check/security_check_cubit.dart';
import 'package:learn/landing_page.dart';

class SecurityCheckScreen extends StatefulWidget {
  const SecurityCheckScreen({super.key});

  @override
  State<SecurityCheckScreen> createState() => _SecurityCheckScreenState();
}

class _SecurityCheckScreenState extends State<SecurityCheckScreen> {
  @override
  void initState() {
    super.initState();
    context.read<SecurityCheckCubit>().checkIfSecure();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocConsumer<SecurityCheckCubit, SecurityCheckState>(
          listener: (context, state) {
            if (state is SecurityCheckLoaded) {
              if (state.isSecure) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const LandingPage(),
                  ),
                );
              } else {
                _showErrorDialog();
              }
            }
          },
          builder: (context, state) {
            if (state is SecurityCheckLoaded) {
              return const SizedBox();
            }

            return const CircularProgressIndicator.adaptive();
          },
        ),
      ),
    );
  }

  void _showErrorDialog() {
    if (context.mounted) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const AlertDialog(
          title: Text('Security Issue'),
          content: Text("Application is running in an insecure state"),
        ),
      );
    }
  }
}
