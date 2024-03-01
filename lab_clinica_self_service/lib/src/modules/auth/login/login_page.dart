import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:lab_clinica_core/lab_clinica_core.dart';
import 'package:lab_clinica_self_service/src/core/un_focus_extension.dart';
import 'package:lab_clinica_self_service/src/modules/auth/login/login_controller.dart';
import 'package:signals_flutter/signals_flutter.dart';
import 'package:validatorless/validatorless.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with MessagesViewMixin {
  final formKey = GlobalKey<FormState>();
  final emailEC = TextEditingController();
  final passwordEC = TextEditingController();
  final controller = Injector.get<LoginController>();

  @override
  void initState() {
    messageListener(controller);
    effect(() {
      if (controller.logged) {
        Navigator.of(context).pushReplacementNamed('/home');
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    emailEC.dispose();
    passwordEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sizeOf = MediaQuery.sizeOf(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          constraints: BoxConstraints(
            minHeight: sizeOf.height,
          ),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                'assets/images/background_login.png',
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(40),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(16)),
              constraints: BoxConstraints(
                maxWidth: sizeOf.width * .8,
              ),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    const Text(
                      'Login',
                      style: LabClinicaTheme.titleStyle,
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    TextFormField(
                      controller: emailEC,
                      onTapOutside: (event) => context.unFocus(),
                      validator: Validatorless.multiple([
                        Validatorless.email('Digite um email valido!'),
                        Validatorless.required('Digite um Email!')
                      ]),
                      decoration: const InputDecoration(
                        label: Text("E-mail"),
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Watch(
                      (_) {
                        return TextFormField(
                          controller: passwordEC,
                          obscureText: controller.obscurePassword,
                          onTapOutside: (event) => context.unFocus(),
                          validator:
                              Validatorless.required("Password obrigátorio!"),
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              onPressed: () => controller.passwordToggle(),
                              icon: Icon(controller.obscurePassword
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                            ),
                            label: const Text("Password"),
                          ),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    SizedBox(
                      width: sizeOf.width * .8,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: () {
                          final valid =
                              formKey.currentState?.validate() ?? false;
                          if (valid) {
                           controller.login(emailEC.text, passwordEC.text);
                          }
                        },
                        child: const Text("Entrar"),
                      ),
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
}
