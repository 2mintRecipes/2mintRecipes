import 'dart:io';
import 'dart:ui';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:getwidget/getwidget.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

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
  final ImagePicker _picker = ImagePicker();
  final cloudinary = CloudinaryPublic('x2mint', '2mint-recipes');
  File? _image;

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
    _confirmPasswordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          SafeArea(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  filterQuality: FilterQuality.low,
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.white.withOpacity(1),
                    BlendMode.darken,
                  ),
                  image: const AssetImage("assets/images/bg.jpg"),
                ),
              ),
            ),
          ),
          getBody(),
        ],
      ),
    );
  }

  Widget getBody() {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 90, sigmaY: 90),
        child: SingleChildScrollView(
          controller: ScrollController(),
          padding:
              const EdgeInsets.only(left: 30, right: 30, top: 20, bottom: 20),
          child: Column(
            children: [
              const Text(
                "Cập nhật",
                style: TextStyle(
                  fontSize: 26,
                  color: Colors.white,
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
        ),
      ),
    );
  }

  getAvatar() {
    return _image != null
        ? FileImage(_image!)
        : const AssetImage("assets/images/avatar.jpg");
  }

  Widget getBasicInfo() {
    return Column(
      children: [
        GFAvatar(
          backgroundImage: getAvatar(),
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
              child: const Text(
                'Chụp ảnh',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(width: 10),
            OutlinedButton(
              onPressed: () {
                _getFromGallery();
              },
              child: const Text(
                'Thư viện',
                style: TextStyle(color: Colors.white),
              ),
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
        color: Colors.white.withOpacity(.4),
      ),
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
                  color: Colors.white,
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
                    .map(
                      (item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          // style: const TextStyle(
                          //   fontSize: 14,
                          // ),
                        ),
                      ),
                    )
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
                child: const Text(
                  'Lưu',
                  style: TextStyle(color: Colors.white),
                ),
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
        color: Colors.white.withOpacity(.4),
      ),
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
                  color: Colors.white,
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
                child: const Text(
                  'Lưu',
                  style: TextStyle(color: Colors.white),
                ),
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
        color: const Color.fromARGB(39, 105, 171, 120),
      ),
      child: Column(children: const [
        Text(
          "Thông tin đăng nhập",
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        //here
      ]),
    );
  }

  /// Get from gallery
  _getFromGallery() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _image = File(image.path);
      });

      try {
        CloudinaryResponse response = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(
            image.path,
            resourceType: CloudinaryResourceType.Image,
          ),
        );

        print(response.secureUrl);
      } on CloudinaryException catch (e) {
        print(e.message);
        print(e.request);
      }
    }
  }

  /// Get from Camera
  _getFromCamera() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        _image = File(image.path);
      });

      try {
        CloudinaryResponse response = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(
            image.path,
            resourceType: CloudinaryResourceType.Image,
          ),
        );

        print(response.secureUrl);
      } on CloudinaryException catch (e) {
        print(e.message);
        print(e.request);
      }
    }
  }
}
