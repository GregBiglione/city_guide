import 'package:city_guide/presentation/login/login_view_model.dart';
import 'package:city_guide/presentation/ressource/color_manager.dart';
import 'package:city_guide/presentation/ressource/value_manager.dart';
import 'package:flutter/material.dart';

import '../ressource/asset_manager.dart';
import '../ressource/route_manager.dart';
import '../ressource/string_manager.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  // TODO pass login use case
  final LoginViewModel _viewModel = LoginViewModel(null);
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  _bind() {
    _viewModel.start();
    _emailController.addListener(() =>
        _viewModel.setUserEmail(_emailController.text));
    _passwordController.addListener(() =>
        _viewModel.setUserPassword(_passwordController.text));
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _getContentWidget();
  }

  Widget _getContentWidget() => Scaffold(
    backgroundColor: ColorManager.white,
    body: Container(
      padding: const EdgeInsets.only(
        top: AppPadding.p100,
      ),
      color: ColorManager.white,
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const Image(image: AssetImage(ImageAsset.splashLogo)),
              const SizedBox(height: AppSize.s28,),
              _emailWidget(),
              const SizedBox(height: AppSize.s28,),
              _passwordWidget(),
              const SizedBox(height: AppSize.s28,),
              _loginButtonWidget(),
              _forgetPasswordAndRegister(),
            ],
          ),
        ),
      ),
    ),
  );

  //----------------------------------------------------------------------------
  // Email widget
  //----------------------------------------------------------------------------

  Widget _emailWidget() => Padding(
    padding: const EdgeInsets.only(
      left: AppPadding.p28,
      right: AppPadding.p28,
    ),
    child: StreamBuilder<bool>(
      stream: _viewModel.outputIsUserEmailValid,
      builder: (context, snapshot) {
        return TextFormField(
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            hintText: AppString.email,
            labelText: AppString.email,
            errorText: (snapshot.data ?? true)
                ? null
                : AppString.emailError,
          ),
        );
      },
    ),
  );

  //----------------------------------------------------------------------------
  // Password widget
  //----------------------------------------------------------------------------

  Widget _passwordWidget() => Padding(
    padding: const EdgeInsets.only(
      left: AppPadding.p28,
      right: AppPadding.p28,
    ),
    child: StreamBuilder<bool>(
      stream: _viewModel.outputIsUserPasswordValid,
      builder: (context, snapshot) {
        return TextFormField(
          controller: _passwordController,
          keyboardType: TextInputType.visiblePassword,
          decoration: InputDecoration(
            hintText: AppString.password,
            labelText: AppString.password,
            errorText: (snapshot.data ?? true)
                ? null
                : AppString.passwordError,
          ),
        );
      },
    ),
  );

  //----------------------------------------------------------------------------
  // Login button widget
  //----------------------------------------------------------------------------

  Widget _loginButtonWidget() => Padding(
    padding: const EdgeInsets.only(
      left: AppPadding.p28,
      right: AppPadding.p28,
    ),
    child: StreamBuilder<bool>(
      stream: _viewModel.outputIsAllInputValid,
      builder: (context, snapshot) {
        return SizedBox(
          width: double.infinity,
          height: AppSize.s40,
          child: ElevatedButton(
              onPressed: (snapshot.data ?? false)
                  ? () {
                      _viewModel.login();
                    }
                  : null,
            child: const Text(
              AppString.login,
            ),
          ),
        );
      },
    ),
  );

  //----------------------------------------------------------------------------
  // Forget password & register
  //----------------------------------------------------------------------------

  Widget _forgetPasswordAndRegister() => Padding(
    padding: const EdgeInsets.only(
      top: AppPadding.p8,
      right: AppPadding.p28,
      left: AppPadding.p28,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          onPressed: () {
            Navigator.pushReplacementNamed(
                context, Routes.forgotPasswordRoute);
          },
          child: Text(
            AppString.forgetPassword,
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.pushReplacementNamed(
                context, Routes.registerRoute);
          },
          child: Text(
            AppString.registerText,
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
      ],
    ),
  );
}
