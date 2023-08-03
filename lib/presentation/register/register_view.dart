import 'dart:io';

import 'package:city_guide/app/di/di.dart';
import 'package:city_guide/data/mapper/mapper.dart';
import 'package:city_guide/presentation/register/register_view_model.dart';
import 'package:city_guide/presentation/ressource/value_manager.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';

import '../common/state_renderer/state_renderer_implementer.dart';
import '../ressource/asset_manager.dart';
import '../ressource/color_manager.dart';
import '../ressource/route_manager.dart';
import '../ressource/string_manager.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final RegisterViewModel _viewModel = instance<RegisterViewModel>();
  final ImagePicker imagePicker = instance<ImagePicker>();
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
      top: AppPadding.p30,
    ),
    color: ColorManager.white,
    child: SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            const Image(image: AssetImage(ImageAsset.splashLogo)),
            const SizedBox(height: AppSize.s12,),
            _usernameWidget(),
            const SizedBox(height: AppSize.s12,),
            _mobilePhoneRowWidget(),
            const SizedBox(height: AppSize.s12,),
            _emailWidget(),
            const SizedBox(height: AppSize.s12,),
            _passwordWidget(),
            const SizedBox(height: AppSize.s12,),
            _profilePictureWidget(),
            const SizedBox(height: AppSize.s12,),
            _registerButtonWidget(),
            _alreadyHaveAccountWidget(),
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
              hideMainText: true,
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
      height: AppSize.s40,
      decoration: BoxDecoration(
        border: Border.all(
          color: ColorManager.grey1,
        ),
        borderRadius: BorderRadius.circular(AppSize.s6),
      ),
      child: GestureDetector(
        child: _getMediaWidget(),
        onTap: () {
          _showPicturePicker(context);
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

  Widget _registerButtonWidget() => Padding(
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
  );

  //----------------------------------------------------------------------------
  // Show picture picker
  //----------------------------------------------------------------------------

  _showPicturePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
            child: Wrap(
              children: [
                ListTile(
                  leading: const Icon(
                    Icons.camera,
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward,
                  ),
                  title: const Text(
                    AppString.photoGallery,
                  ),
                  onTap: () {
                    _imageFromGallery();
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.camera_alt_rounded,
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward,
                  ),
                  title: const Text(
                    AppString.photoCamera,
                  ),
                  onTap: () {
                    _imageFromCamera();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
        );
      },
    );
  }

  //----------------------------------------------------------------------------
  // Already have account widget
  //----------------------------------------------------------------------------

  Widget _alreadyHaveAccountWidget() => Padding(
    padding: const EdgeInsets.only(
      top: AppPadding.p8,
      right: AppPadding.p28,
      left: AppPadding.p28,
    ),
    child: TextButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      child: Text(
        AppString.haveAccount,
        style: Theme.of(context).textTheme.titleSmall,
      ),
    ),
  );

  //----------------------------------------------------------------------------
  // Set image from gallery
  //----------------------------------------------------------------------------

  _imageFromGallery() async {
    var image = await imagePicker.pickImage(source: ImageSource.gallery);
    _viewModel.setProfilePicture(File(image?.path ?? ""));
  }

  //----------------------------------------------------------------------------
  // Set image from camera
  //----------------------------------------------------------------------------

  _imageFromCamera() async {
    var image = await imagePicker.pickImage(source: ImageSource.camera);
    _viewModel.setProfilePicture(File(image?.path ?? ""));
  }
}
