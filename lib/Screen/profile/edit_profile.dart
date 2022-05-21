import 'dart:io';
import 'dart:ui';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:getwidget/getwidget.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:x2mint_recipes/components/input.dart';
import 'package:x2mint_recipes/dto/user.dto.dart';
import 'package:x2mint_recipes/services/cloudinary.service.dart';
import 'package:x2mint_recipes/services/user.service.dart';
import 'package:x2mint_recipes/utils/app_ui.dart';

class EditProfile extends StatefulWidget {
  static const routeName = '/EditProfile';
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  late String fullName,
      username,
      sex,
      phone,
      address,
      email,
      password,
      reEnterPassword;
  String? fullNameError,
      usernameError,
      sexError,
      phoneError,
      addressError,
      emailError,
      passwordError,
      reEnterPasswordError;

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
    _confirmPasswordVisible = false;
    fullName = "";
    username = "";
    sex = "";
    phone = "";
    address = "";
    email = "";
    password = "";
    reEnterPassword = "";

    fullNameError = null;
    usernameError = null;
    sexError = null;
    phoneError = null;
    addressError = null;
    emailError = null;
    passwordError = null;
    reEnterPasswordError = null;
  }

  void resetErrorText() {
    setState(() {
      fullNameError = null;
      usernameError = null;
      sexError = null;
      phoneError = null;
      addressError = null;
      emailError = null;
      passwordError = null;
      reEnterPasswordError = null;
    });
  }

  bool validateProfileInfo() {
    resetErrorText();
    bool isValid = true;
    if (fullName.isEmpty) {
      setState(() {
        fullNameError = "       Please enter a FullName";
      });
      isValid = false;
    }
    if (username.isEmpty) {
      setState(() {
        usernameError = "       Please enter a Username";
      });
      isValid = false;
    }

    return isValid;
  }

  bool validateLoginInfo() {
    resetErrorText();

    bool isValid = true;

    RegExp emailExp = RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

    if (username.isEmpty) {
      setState(() {
        usernameError = "       Please enter a Username";
      });
      isValid = false;
    }
    if (email.isEmpty) {
      setState(() {
        emailError = "       Please enter a Email";
      });
      isValid = false;
    }
    if (!emailExp.hasMatch(email)) {
      setState(() {
        emailError = "       Email is invalid";
      });
      isValid = false;
    }

    if (password.isEmpty) {
      setState(() {
        passwordError = "       Please enter a password";
      });
      isValid = false;
    }
    if (reEnterPassword.isEmpty) {
      setState(() {
        reEnterPassword = "       Please confirm password";
      });
      isValid = false;
    }

    if (password != reEnterPassword) {
      setState(() {
        reEnterPasswordError = "       Passwords do not match";
      });
      isValid = false;
    }

    return isValid;
  }

  void submitLoginInfo() {
    if (validateLoginInfo()) {
      {
        () {
          if (_formKeyCreInfo.currentState!.validate()) {
            _formKeyCreInfo.currentState!.save();
          }
        };
      }
    }
  }

  void submitProfileInfo() {
    if (validateProfileInfo()) {
      {
        () async {
          if (_formKeyUserInfo.currentState!.validate()) {
            _formKeyUserInfo.currentState!.save();
            await _updateUserInfo();
          }
        };
      }
    }
  }

  String? _selectedGender;
  String? _avatar;

  final List<String> genderItems = ['Male', 'Female', 'Other'];
  final List<IconData> genderIcons = [
    Icons.male,
    Icons.female,
    Icons.more_horiz
  ];

  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;
  final _formKeyUserInfo = GlobalKey<FormState>();
  final _formKeyCreInfo = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  final UserService _userService = UserService();
  final CloudinaryService _cloudinaryService = CloudinaryService();
  File? _image;
  String? _imagePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(children: [
          SafeArea(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  filterQuality: FilterQuality.low,
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(.6),
                    BlendMode.darken,
                  ),
                  image: const AssetImage("assets/images/bg.jpg"),
                ),
              ),
            ),
          ),
          ClipRRect(
            child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                child: SingleChildScrollView(
                  controller: ScrollController(),
                  padding: const EdgeInsets.only(
                      left: 30, right: 30, top: UI.topPadding, bottom: 20),
                  child: getBody(),
                )),
          ),
        ]));
  }

  Widget getBody() {
    return Column(
      children: [
        const Text(
          "Edit Profile",
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
    );
  }

  getAvatar() {
    return _image != null
        ? FileImage(_image!)
        : const NetworkImage(
            'https://res.cloudinary.com/x2mint/image/upload/v1652892076/2mintRecipes/fxpssnnxl0urdlynqhkz.png');
    // : const AssetImage("assets/images/avatar.jpg");
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
            Padding(
              padding:
                  const EdgeInsets.only(top: 3, bottom: 3, left: 10, right: 10),
              child: SizedBox(
                height: 40,
                child: ElevatedButton.icon(
                  onPressed: () {
                    _getFromCamera();
                  },

                  ///
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                    backgroundColor: UI.appColor,
                    shape: RoundedRectangleBorder(
                      //to set border radius to button
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  icon: const Icon(Icons.add_a_photo),
                  label: const Text(
                    "Camera",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Padding(
              padding:
                  const EdgeInsets.only(top: 3, bottom: 3, left: 10, right: 10),
              child: SizedBox(
                height: 40,
                child: ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      _getFromGallery();
                    });
                  },

                  ///
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                    backgroundColor: UI.appColor,
                    shape: RoundedRectangleBorder(
                      //to set border radius to button
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  icon: const Icon(Icons.photo_library),
                  label: const Text(
                    "Album",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget getUserInfo() {
    return Container(
      padding: const EdgeInsets.only(bottom: 10, top: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white.withOpacity(.4),
      ),
      child: Form(
        key: _formKeyUserInfo,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                "Personal Info",
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 10),
            // chỗ này
            InputField(
              prefixIcon: Icons.badge,
              onChanged: (value) {
                if (fullNameError != null) {
                  setState(() {
                    fullNameError = null;
                  });
                }
                setState(() {
                  fullName = value;
                });
              },
              labelText: "FullName",
              errorText: fullNameError,
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.next,
              autoFocus: true,
              textEditingController: _fullNameController,
            ),
            InputField(
              prefixIcon: Icons.account_circle,
              onChanged: (value) {
                if (usernameError != null) {
                  setState(() {
                    usernameError = null;
                  });
                }
                setState(() {
                  username = value;
                });
              },
              labelText: "Username",
              errorText: usernameError,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              autoFocus: true,
              textEditingController: _usernameController,
            ),
            Container(
              padding:
                  const EdgeInsets.only(left: 5, top: 10, bottom: 5, right: 10),
              margin: const EdgeInsets.only(left: 30, right: 30, bottom: 5),
              decoration: BoxDecoration(
                  color: Colors.black.withOpacity(.2),
                  borderRadius: BorderRadius.circular(15)),
              child: DropdownButtonFormField2(
                value: _selectedGender,
                style: const TextStyle(
                  fontSize: 20,
                  overflow: TextOverflow.ellipsis,
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.people,
                    color: Colors.white.withOpacity(.5),
                    size: 30,
                  ),
                  isDense: true,
                  border: InputBorder.none,
                ),
                isExpanded: true,
                hint: Text(
                  'Sex',
                  style: TextStyle(
                    fontSize: 20,
                    overflow: TextOverflow.ellipsis,
                    color: Colors.white.withOpacity(.5),
                  ),
                ),
                icon: Icon(
                  Icons.expand_more,
                  color: Colors.white.withOpacity(.5),
                  size: 30,
                ),
                dropdownDecoration: BoxDecoration(
                    color: Colors.black.withOpacity(.6),
                    borderRadius: BorderRadius.circular(15)),
                items: genderItems
                    .map(
                      (item) => DropdownMenuItem<String>(
                          value: item,
                          child: Row(
                            children: [
                              Text(
                                item + "  ",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white.withOpacity(.5),
                                    fontWeight: FontWeight.normal),
                              ),
                              Icon(
                                genderIcons[genderItems.indexOf(item)],
                                size: 30,
                                color: Colors.white.withOpacity(.5),
                              )
                            ],
                          )),
                    )
                    .toList(),
                validator: (value) {
                  if (value == null) {
                    return 'Choose a sex';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _selectedGender = value as String;
                  });
                },
                onSaved: (value) {
                  _selectedGender = value.toString();
                },
              ),
            ),

            InputField(
              prefixIcon: Icons.phone,
              onChanged: (value) {
                if (phoneError != null) {
                  setState(() {
                    phoneError = null;
                  });
                }
                setState(() {
                  phone = value;
                });
              },
              labelText: "Phone",
              errorText: phoneError,
              keyboardType: TextInputType.phone,
              textInputAction: TextInputAction.next,
              autoFocus: true,
              textEditingController: _phoneController,
            ),
            InputField(
              prefixIcon: Icons.location_on,
              onChanged: (value) {
                if (addressError != null) {
                  setState(() {
                    addressError = null;
                  });
                }
                setState(() {
                  address = value;
                });
              },
              labelText: "Address",
              errorText: addressError,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              autoFocus: true,
              textEditingController: _addressController,
            ),
            const SizedBox(height: 10),
            getUpdateProfileInfoButton(),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }

  Future _updateUserInfo() async {
    if (_imagePath != null) {
      _avatar = await _cloudinaryService.uploadImage(_imagePath!);
      print(_avatar);

      UserDto data = UserDto(
        fullName: _fullNameController.text,
        username: _usernameController.text,
        address: _addressController.text,
        phone: _phoneController.text,
        gender: _selectedGender,
        avatar: _avatar,
      );
      var re = await _userService.update(data);
      print(re);
    } else {
      print("============");
    }
  }

  Widget getUserConfidentialInfo() {
    return Container(
      padding: const EdgeInsets.only(top: 10, right: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white.withOpacity(.4),
      ),
      child: Form(
        key: _formKeyCreInfo,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                "Confidential Info",
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 10),
            InputField(
              prefixIcon: Icons.alternate_email,
              onChanged: (value) {
                if (emailError != null) {
                  setState(() {
                    emailError = null;
                  });
                }
                setState(() {
                  email = value;
                });
              },
              labelText: "Email",
              errorText: emailError,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              autoFocus: true,
              textEditingController: _emailController,
            ),
            InputField(
              prefixIcon: Icons.lock,
              onChanged: (value) {
                if (passwordError != null) {
                  setState(() {
                    passwordError = null;
                  });
                }
                setState(() {
                  password = value;
                });
              },
              labelText: "Password",
              errorText: passwordError,
              keyboardType: TextInputType.visiblePassword,
              textInputAction: TextInputAction.next,
              autoFocus: true,
              textEditingController: _passwordController,
            ),
            InputField(
              prefixIcon: Icons.lock,
              onChanged: (value) {
                if (reEnterPasswordError != null) {
                  setState(() {
                    reEnterPasswordError = null;
                  });
                }
                setState(() {
                  reEnterPassword = value;
                });
              },
              labelText: "Confirm Password",
              errorText: reEnterPasswordError,
              keyboardType: TextInputType.visiblePassword,
              textInputAction: TextInputAction.next,
              autoFocus: true,
              textEditingController: _confirmPasswordController,
            ),
            const SizedBox(
              height: 10,
            ),
            getUpdateLoginInfoButton(),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }

  Widget getUpdateLoginInfoButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 3, bottom: 3, left: 10, right: 10),
      child: SizedBox(
        height: 40,
        child: ElevatedButton.icon(
          onPressed: submitLoginInfo,

          ///
          style: TextButton.styleFrom(
            primary: Colors.white,
            backgroundColor: UI.appColor,
            shape: RoundedRectangleBorder(
              //to set border radius to button
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          icon: const Icon(Icons.save),
          label: const Text(
            "Save",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 15, color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget getUpdateProfileInfoButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 3, bottom: 3, left: 10, right: 10),
      child: SizedBox(
        height: 40,
        child: ElevatedButton.icon(
          onPressed: submitProfileInfo,

          ///
          style: TextButton.styleFrom(
            primary: Colors.white,
            backgroundColor: UI.appColor,
            shape: RoundedRectangleBorder(
              //to set border radius to button
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          icon: const Icon(Icons.save),
          label: const Text(
            "Save",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 15, color: Colors.white),
          ),
        ),
      ),
    );
  }

  _getFromGallery() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _image = File(image.path);
        _imagePath = image.path;
      });
    }
  }

  _getFromCamera() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        _image = File(image.path);
        _imagePath = image.path;
      });
    }
  }
}
