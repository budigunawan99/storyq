import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storyq/data/model/user_login.dart';
import 'package:storyq/provider/auth/auth_provider.dart';
import 'package:storyq/provider/settings/theme_provider.dart';
import 'package:storyq/static/login_result_state.dart';

class LoginScreen extends StatefulWidget {
  final Function() onLogin;
  final Function() onRegister;

  const LoginScreen({
    super.key,
    required this.onLogin,
    required this.onRegister,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    const SizedBox(height: 30),
                    context.watch<ThemeProvider>().isDarkMode
                        ? Image.asset(
                          "assets/images/storyq_dark.png",
                          width: 150,
                        )
                        : Image.asset(
                          "assets/images/storyq_light.png",
                          width: 150,
                        ),
                    const SizedBox(height: 30),
                    TextFormField(
                      controller: emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Harap masukkan email Anda!';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Email",
                        labelStyle: Theme.of(context).textTheme.labelMedium,
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Password",
                        labelStyle: Theme.of(context).textTheme.labelMedium,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Harap masukkan password Anda!';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),

                    Consumer<AuthProvider>(
                      builder: (context, value, child) {
                        return switch (value.loginResultState) {
                          LoginLoadingState() => Center(
                            child: CircularProgressIndicator(),
                          ),
                          LoginErrorState(error: var message) => Builder(
                            builder: (context) {
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(message),
                                    backgroundColor:
                                        Theme.of(context).colorScheme.error,
                                  ),
                                );
                                value.setLoginResultState(LoginNoneState());
                              });
                              return ElevatedButton(
                                onPressed: () async {
                                  if (formKey.currentState!.validate()) {
                                    final UserLogin userLogin = UserLogin(
                                      email: emailController.text,
                                      password: passwordController.text,
                                    );

                                    await value.login(userLogin);
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  minimumSize: Size.fromHeight(42),
                                  backgroundColor:
                                      Theme.of(context).colorScheme.onSurface,
                                ),
                                child: Text(
                                  "LOGIN",
                                  style: Theme.of(
                                    context,
                                  ).textTheme.titleSmall?.copyWith(
                                    color:
                                        Theme.of(context).colorScheme.surface,
                                  ),
                                ),
                              );
                            },
                          ),
                          LoginLoadedState() => Builder(
                            builder: (context) {
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                widget.onLogin();
                                value.setLoginResultState(LoginNoneState());
                              });

                              return ElevatedButton(
                                onPressed: () async {
                                  if (formKey.currentState!.validate()) {
                                    final UserLogin userLogin = UserLogin(
                                      email: emailController.text,
                                      password: passwordController.text,
                                    );

                                    await value.login(userLogin);
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  minimumSize: Size.fromHeight(42),
                                  backgroundColor:
                                      Theme.of(context).colorScheme.onSurface,
                                ),
                                child: Text(
                                  "LOGIN",
                                  style: Theme.of(
                                    context,
                                  ).textTheme.titleSmall?.copyWith(
                                    color:
                                        Theme.of(context).colorScheme.surface,
                                  ),
                                ),
                              );
                            },
                          ),
                          _ => ElevatedButton(
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                final UserLogin userLogin = UserLogin(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );

                                await value.login(userLogin);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size.fromHeight(42),
                              backgroundColor:
                                  Theme.of(context).colorScheme.onSurface,
                            ),
                            child: Text(
                              "LOGIN",
                              style: Theme.of(
                                context,
                              ).textTheme.titleSmall?.copyWith(
                                color: Theme.of(context).colorScheme.surface,
                              ),
                            ),
                          ),
                        };
                      },
                    ),
                    const SizedBox(height: 10),
                    TextButton(
                      onPressed: () => widget.onRegister(),
                      child: Text(
                        "REGISTER",
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
