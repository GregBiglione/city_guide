import 'dart:io';

import 'package:city_guide/app/di/di.dart';
import 'package:city_guide/data/mapper/mapper.dart';
import 'package:city_guide/presentation/register/register_view_model.dart';
import 'package:city_guide/presentation/ressource/value_manager.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../common/state_renderer/state_renderer_implementer.dart';
import '../ressource/asset_manager.dart';
import '../ressource/color_manager.dart';
import '../ressource/string_manager.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final RegisterViewModel _viewModel = instance<RegisterViewModel>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  _bind() {
    _viewModel.start();
    _usernameController.addListener(() =>
        _viewModel.setUsername(_usernameController.text),
    );
    _mobileNumberController.addListener(() =>
        _viewModel.setMobileNumber(_mobileNumberController.text),
    );
    _emailController.addListener(() =>
        _viewModel.setEmail(_emailController.text),
    );
    _passwordController.addListener(() =>
        _viewModel.setPassword(_passwordController.text),
    );
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    _usernameController.dispose();
    _mobileNumberController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: AppBar(
        elevation: AppSize.s0,
        iconTheme: IconThemeData(
          color: ColorManager.primary,
        ),
        backgroundColor: ColorManager.white,
      ),
      body: StreamBuilder<FlowState>(
        stream: _viewModel.outputState,
        builder: (context, snapshot) {
          return Center(
            child: snapshot.data?.getWidgetScreen(
                context,
                _getContentWidget(),
                    () {
                  _viewModel.register();
                }
            ) ?? _getContentWidget(),
          );
        },
      ),
    );
  }

  Widget _getContentWidget() => Container(
    padding: const EdgeInsets.only(
      top: AppPadding.p60,
    ),
    color: ColorManager.white,
    child: SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            const Image(image: AssetImage(ImageAsset.splashLogo)),
            const SizedBox(height: AppSize.s28,),
            _usernameWidget(),
            const SizedBox(height: AppSize.s28,),
            _mobilePhoneRowWidget(),
            const SizedBox(height: AppSize.s28,),
            _emailWidget(),
            const SizedBox(height: AppSize.s28,),
            _passwordWidget(),
            const SizedBox(height: AppSize.s28,),
            _profilePictureWidget(),
            //_registerButtonWidget(),
            //_forgetPasswordAndRegister(),
          ],
        ),
      ),
    ),
  );

  //----------------------------------------------------------------------------
  // Name widget
  //----------------------------------------------------------------------------

  Widget _usernameWidget() => Padding(
    padding: const EdgeInsets.only(
      left: AppPadding.p28,
      right: AppPadding.p28,
    ),
    child: StreamBuilder<String?>(
      stream: _viewModel.outputErrorUsername,
      builder: (context, snapshot) {
        return TextFormField(
          controller: _usernameController,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            hintText: AppString.name,
            labelText: AppString.name,
            errorText: snapshot.data,
          ),
        );
      },
    ),
  );

  //----------------------------------------------------------------------------
  // Country code & mobile phone widget
  //----------------------------------------------------------------------------

  Widget _mobilePhoneRowWidget() => Center(
    child: Padding(
      padding: const EdgeInsets.only(
        left: AppPadding.p28,
        right: AppPadding.p28,
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: CountryCodePicker(
              onChanged: (country) {
                // Update View model with selected country ---------------------
                _viewModel.setCountryCode(country.dialCode ?? EMPTY);
              },
              initialSelection: "+33",
              showCountryOnly: true,
              showOnlyCountryWhenClosed: true,
              favorite: const ["+966", "+02", "+39"],
            ),
          ),
          Expanded(
            flex: 3,
            child: _mobilePhoneWidget(),
          ),
        ],
      ),
    ),
  );

  //----------------------------------------------------------------------------
  // Mobile phone widget
  //----------------------------------------------------------------------------

  Widget _mobilePhoneWidget() => StreamBuilder<String?>(
    stream: _viewModel.outputErrorMobileNumber,
    builder: (context, snapshot) {
      return TextFormField(
        controller: _mobileNumberController,
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
          hintText: AppString.mobileNumber,
          labelText: AppString.mobileNumber,
          errorText: snapshot.data,
        ),
      );
    },
  );

  //----------------------------------------------------------------------------
  // Email widget
  //----------------------------------------------------------------------------

  Widget _emailWidget() => Padding(
    padding: const EdgeInsets.only(
      left: AppPadding.p28,
      right: AppPadding.p28,
    ),
    child: StreamBuilder<String?>(
      stream: _viewModel.outputErrorEmail,
      builder: (context, snapshot) {
        return TextFormField(
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            hintText: AppString.email,
            labelText: AppString.email,
            errorText: snapshot.data,
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
    child: StreamBuilder<String?>(
      stream: _viewModel.outputErrorPassword,
      builder: (context, snapshot) {
        return TextFormField(
          controller: _passwordController,
          keyboardType: TextInputType.visiblePassword,
          decoration: InputDecoration(
            hintText: AppString.password,
            labelText: AppString.password,
            errorText: snapshot.data,
          ),
        );
      },
    ),
  );

  //----------------------------------------------------------------------------
  // Profile picture widget
  //----------------------------------------------------------------------------

  Widget _profilePictureWidget() => Padding(
    padding: const EdgeInsets.only(
      left: AppPadding.p28,
      right: AppPadding.p28,
    ),
    child: Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: ColorManager.lightGrey,
        ),
      ),
      child: GestureDetector(
        child: _getMediaWidget(),
        onTap: () {
          //_showPicturePicker(context);
        },
      ),
    ),
  );

  //----------------------------------------------------------------------------
  // Media widget
  //----------------------------------------------------------------------------

  Widget _getMediaWidget() => Padding(
    padding: const EdgeInsets.only(
        left: AppPadding.p8,
        right: AppPadding.p8
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Flexible(
          child: Text(AppString.profilePicture),
        ),
        Flexible(
          child: StreamBuilder<File?>(
            stream: _viewModel.outputIsProfilePictureValid,
            builder: (context, snapshot) {
              return _imagePicked(snapshot.data);
            },
          ),
        ),
        Flexible(
          child: SvgPicture.asset(ImageAsset.photoCameraIc),
        ),
      ],
    ),
  );

  //----------------------------------------------------------------------------
  // Widget image picked
  //----------------------------------------------------------------------------

  Widget _imagePicked(File? image) {
    if(image != null && image.path.isNotEmpty) {
      return Image.file(image);
    }
    else {
      return Container();
    }
  }

  //----------------------------------------------------------------------------
  // Register button widget
  //----------------------------------------------------------------------------

  /*Widget _registerButtonWidget() => Padding(
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
              _viewModel.register();
            }
                : null,
            child: const Text(
              AppString.register,
            ),
          ),
        );
      },
    ),
  );*/
}
