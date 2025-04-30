import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storyq/common.dart';
import 'package:storyq/data/model/user.dart';
import 'package:storyq/provider/auth/auth_provider.dart';
import 'package:storyq/provider/settings/theme_provider.dart';
import 'package:storyq/static/register_result_state.dart';

class RegisterScreen extends StatefulWidget {
  final Function() onLogin;
  final Function() onRegister;

  const RegisterScreen({
    super.key,
    required this.onLogin,
    required this.onRegister,
  });

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final nameController = TextEditingController();

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameController.dispose();
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
                    const SizedBox(height: 80),
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
                      controller: nameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppLocalizations.of(context)!.formValidator(
                            AppLocalizations.of(context)!.nameTextField,
                          );
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: AppLocalizations.of(context)!.nameTextField,
                        labelStyle: Theme.of(context).textTheme.labelMedium,
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppLocalizations.of(
                            context,
                          )!.formValidator("email");
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
                          return AppLocalizations.of(
                            context,
                          )!.formValidator("password");
                        } else if (value.length < 8) {
                          return AppLocalizations.of(
                            context,
                          )!.formPasswordMinimum;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),

                    Consumer<AuthProvider>(
                      builder: (context, value, child) {
                        return switch (value.registerResultState) {
                          RegisterLoadingState() => Center(
                            child: CircularProgressIndicator(),
                          ),
                          RegisterErrorState(error: var message) => Builder(
                            builder: (context) {
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(message),
                                    backgroundColor:
                                        Theme.of(context).colorScheme.error,
                                  ),
                                );
                                value.setRegisterResultState(
                                  RegisterNoneState(),
                                );
                              });
                              return ElevatedButton(
                                onPressed: () async {
                                  if (formKey.currentState!.validate()) {
                                    final User user = User(
                                      name: nameController.text,
                                      email: emailController.text,
                                      password: passwordController.text,
                                    );

                                    await value.register(user);
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  minimumSize: Size.fromHeight(42),
                                  backgroundColor:
                                      Theme.of(context).colorScheme.onSurface,
                                ),
                                child: Text(
                                  AppLocalizations.of(context)!.registerButton,
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
                          RegisterLoadedState() => Builder(
                            builder: (context) {
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                widget.onRegister();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      AppLocalizations.of(
                                        context,
                                      )!.successfulRegistration,
                                    ),
                                  ),
                                );
                                value.setRegisterResultState(
                                  RegisterNoneState(),
                                );
                              });

                              return ElevatedButton(
                                onPressed: () async {
                                  if (formKey.currentState!.validate()) {
                                    final User user = User(
                                      name: nameController.text,
                                      email: emailController.text,
                                      password: passwordController.text,
                                    );

                                    await value.register(user);
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  minimumSize: Size.fromHeight(42),
                                  backgroundColor:
                                      Theme.of(context).colorScheme.onSurface,
                                ),
                                child: Text(
                                  AppLocalizations.of(context)!.registerButton,
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
                                final User user = User(
                                  name: nameController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                );

                                await value.register(user);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size.fromHeight(42),
                              backgroundColor:
                                  Theme.of(context).colorScheme.onSurface,
                            ),
                            child: Text(
                              AppLocalizations.of(context)!.registerButton,
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
                      onPressed: () => widget.onLogin(),
                      child: Text(
                        AppLocalizations.of(context)!.loginButton,
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
