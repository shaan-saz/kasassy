import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:kasassy/data/repositories/authentication_repository.dart';
import 'package:kasassy/features/app/bloc/app_bloc.dart';
import 'package:kasassy/features/login/cubit/login_cubit.dart';
import 'package:kasassy/features/login/widgets/google_login_button.dart';

class LoginPage extends StatelessWidget {
  const LoginPage._({Key? key}) : super(key: key);

  static Page route() {
    return MaterialPage<void>(
      child: BlocProvider<LoginCubit>(
        create: (context) => LoginCubit(
          authenticationRepository: context.read<AuthenticationRepository>(),
          appBloc: context.read<AppBloc>(),
        ),
        child: const LoginPage._(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: BlocListener<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state.status.isSubmissionFailure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(
                  content: Text('Authentication Failure'),
                ),
              );
          }
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              Text(
                'Kasassy',
                style: TextStyle(
                  fontSize: 100,
                  fontFamily: 'Italianno',
                  color: Colors.brown,
                ),
              ),
              GoogleLoginButton(),
            ],
          ),
        ),
      ),
    );
  }
}
