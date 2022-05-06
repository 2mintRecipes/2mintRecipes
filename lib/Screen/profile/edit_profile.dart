import 'dart:html';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_first/app_ui.dart';
import 'package:flutter_first/components/input.dart';
import 'package:flutter_first/components/search_cart.dart';
import 'package:getwidget/getwidget.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:image_picker/image_picker.dart';

import '../../database.dart';

class EditProfile extends StatefulWidget {
  static const routeName = '/EditProfile';
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final List<String> genderItems = [
    'Male',
    'Female',
  ];
  String? selectedGender;
  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;
  final _formKeyUserInfo = GlobalKey<FormState>();
  final _formKeyCreInfo = GlobalKey<FormState>();

  // late File imageFile;

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
    _confirmPasswordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: getBody(),
    );
  }

  Widget getBody() {
    return SingleChildScrollView(
      controller: ScrollController(),
      padding: const EdgeInsets.only(left: 30, right: 30, top: 20, bottom: 20),
      child: Column(
        children: [
          const Text(
            "Cập nhật",
            style: TextStyle(
              fontSize: 26,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          getBasicInfo(),
          const SizedBox(height: 20),
          getUserInfo(),
          const SizedBox(height: 20),
          getUserConfidentialInfo(),
        ],
      ),
    );
  }

  Widget getBasicInfo() {
    return Column(
      children: [
        const GFAvatar(
          backgroundImage: AssetImage("assets/images/nong-nao-doll.jpg"),
          shape: GFAvatarShape.circle,
          size: 150,
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OutlinedButton(
              onPressed: () {
                _getFromCamera();
              },
              child: const Text('Chụp ảnh'),
            ),
            const SizedBox(width: 10),
            OutlinedButton(
              onPressed: () {
                _getFromGallery();
              },
              child: const Text('Thư viện'),
            ),
          ],
        ),
      ],
    );
  }

  Widget getUserInfo() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: const Color.fromARGB(39, 105, 171, 120)),
      child: Form(
        key: _formKeyUserInfo,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Thông tin cá nhân",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                  prefixIcon: const Icon(Icons.account_circle_sharp),
                  hintText: 'Họ tên',
                  hintStyle: const TextStyle(fontSize: 14),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                  prefixIcon: const Icon(Icons.verified_user_sharp),
                  hintText: 'Username',
                  hintStyle: const TextStyle(fontSize: 14),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField2(
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.people),
                  //Add isDense true and zero Padding.
                  //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                  isDense: true,
                  // contentPadding: EdgeInsets.zero,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  //Add more decoration as you want here
                  //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                ),
                isExpanded: true,
                hint: const Text(
                  'Giới tính',
                  // style: TextStyle(fontSize: 14),
                ),
                icon: const Icon(
                  Icons.arrow_drop_down,
                  color: Colors.black45,
                ),
                // iconSize: 30,
                // buttonHeight: 60,
                // buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                dropdownDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                items: genderItems
                    .map((item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            // style: const TextStyle(
                            //   fontSize: 14,
                            // ),
                          ),
                        ))
                    .toList(),
                validator: (value) {
                  if (value == null) {
                    return 'Chọn giới tính';
                  }
                },
                onChanged: (value) {
                  //Do something when changing the item if you want.
                },
                onSaved: (value) {
                  selectedGender = value.toString();
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                  prefixIcon: const Icon(Icons.phone),
                  hintText: 'Số điện thoại',
                  hintStyle: const TextStyle(fontSize: 14),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                  prefixIcon: const Icon(Icons.location_on),
                  hintText: 'Địa chỉ',
                  hintStyle: const TextStyle(fontSize: 14),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              OutlinedButton(
                onPressed: () {
                  if (_formKeyUserInfo.currentState!.validate()) {
                    _formKeyUserInfo.currentState!.save();
                  }
                },
                child: const Text('Lưu'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getUserConfidentialInfo() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: const Color.fromARGB(39, 105, 171, 120)),
      child: Form(
        key: _formKeyCreInfo,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Thông tin đăng nhập",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                  prefixIcon: const Icon(Icons.alternate_email_outlined),
                  hintText: 'Email',
                  hintStyle: const TextStyle(fontSize: 14),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                obscureText: !_passwordVisible,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                  prefixIcon: const Icon(Icons.verified_user_sharp),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                  ),
                  hintText: 'Mật khẩu',
                  hintStyle: const TextStyle(fontSize: 14),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                obscureText: !_confirmPasswordVisible,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                  prefixIcon: const Icon(Icons.verified_user_sharp),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _confirmPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      setState(() {
                        _confirmPasswordVisible = !_confirmPasswordVisible;
                      });
                    },
                  ),
                  hintText: 'Nhập lại mật khẩu',
                  hintStyle: const TextStyle(fontSize: 14),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              OutlinedButton(
                onPressed: () {
                  if (_formKeyCreInfo.currentState!.validate()) {
                    _formKeyCreInfo.currentState!.save();
                  }
                },
                child: const Text('Lưu'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getUserConfidentialInfo() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: const Color.fromARGB(39, 105, 171, 120)),
      child: Column(children: [
        Text(
          "Thông tin đăng nhập",
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        Input(
            icon: Icons.alternate_email_outlined,
            hintText: 'Email',
            isPassword: false,
            isEmail: true,
            textController: emailController),
        SizedBox(height: 10),
        Input(
            icon: Icons.lock_outline,
            hintText: 'Mật khẩu',
            isPassword: true,
            isEmail: false,
            textController: passwordController),
        SizedBox(height: 10),
        Input(
            icon: Icons.lock_outline,
            hintText: 'Nhập lại mật khẩu',
            isPassword: true,
            isEmail: false,
            textController: passwordController),
      ]),
    );
  }

  /// Get from gallery
  _getFromGallery() async {
    // PickedFile pickedFile = await ImagePicker().getImage(
    //   source: ImageSource.gallery,
    //   maxWidth: 1800,
    //   maxHeight: 1800,
    // );
    // if (pickedFile != null) {
    //   setState(() {
    //     imageFile = File(pickedFile.path);
    //   });
    // }
  }

  /// Get from Camera
  _getFromCamera() async {
    // PickedFile pickedFile = await ImagePicker().getImage(
    //   source: ImageSource.camera,
    //   maxWidth: 1800,
    //   maxHeight: 1800,
    // );
    // if (pickedFile != null) {
    //   setState(() {
    //     imageFile = File(pickedFile.path);
    //   });
    // }
  }
}
