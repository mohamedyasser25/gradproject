import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gp2023/modules/_common/onboarding/first_app_screen.dart';
import 'package:gp2023/modules/_hr/job_applications/review_application_screen.dart';
import 'package:gp2023/shared/caching/cache_helper.dart';
import 'package:gp2023/shared/constants/constants.dart';
import 'package:gp2023/shared/models/JobApplicationModel.dart';
import 'package:gp2023/shared/styles/colors.dart';

import '../../modules/_common/signup/signup_screen.dart';
import '../../modules/_hr/company_regiseter/company_register_screen.dart';

Widget logoIcon() => const Center(
      child: Image(
        image: AssetImage('assets/images/workable.png'),
        height: 200,
        width: 200,
      ),
    );

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  bool isUpperCase = true,
  double radius = 3.0,
  required Function function,
  required String text,
}) =>
    Container(
      width: width,
      height: 50.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: background,
      ),
      child: MaterialButton(
        onPressed: () => function(),
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );

Widget defaultTextButton({
  required Function function,
  required String text,
}) =>
    TextButton(
      onPressed: () => function(),
      child: Text(
        text.toUpperCase(),
      ),
    );

Widget defaultFormField({
  required TextEditingController controller,
  TextInputType? type,
  IconData? prefix,
  String? label,
  IconData? suffix,
  int maxLine = 1,
  bool isPassword = false,
  bool isClickable = true,
  bool expands = false,
  Function? validate,
  Function? suffixPressed,
  Function? onSubmit,
  Function? onChange,
  Function? onTap,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      enabled: isClickable,
      onFieldSubmitted: onSubmit != null ? (val) => onSubmit(val) : null,
      onChanged: onChange != null ? (val) => onChange(val) : null,
      onTap: onTap != null ? () => onTap() : null,
      validator: validate != null
          ? (val) => validate(val)
          : (value) =>
              value == null || value == '' || value == " " ? 'Please fill this field' : null,
      maxLines: maxLine,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          prefix,
          color: const Color(0xff1B75BC),
        ),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: suffixPressed != null ? () => suffixPressed() : null,
                icon: Icon(
                  suffix,
                  color: const Color(0xff1B75BC),
                ),
              )
            : null,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
    );

Widget myDivider() => Padding(
      padding: const EdgeInsetsDirectional.only(
        start: 20.0,
      ),
      child: Container(
        width: double.infinity,
        height: 1.0,
        color: Colors.grey[300],
      ),
    );

void navigateTo(context, Widget widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => widget,
      ),
    );

void navigateAndFinish(
  context,
  widget,
) =>
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
      (route) {
        return false;
      },
    );

void showToast({
  required String text,
  required ToastStates state,
}) =>
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 3,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0,
    );

// enum
// ignore: constant_identifier_names
enum ToastStates { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastStates state) {
  Color color;

  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }

  return color;
}

Widget initiateDrawer(BuildContext context) {
  return Drawer(
    child: ListView(
      // Important: Remove any padding from the ListView.
      padding: EdgeInsets.zero,
      children: <Widget>[
        UserAccountsDrawerHeader(
          onDetailsPressed: () {},
          accountName: Text(CacheHelper.getData(key: 'name')),
          accountEmail: Text(CacheHelper.getData(key: 'email')),
          currentAccountPicture: GestureDetector(
            onTap: () {},
            child: const CircleAvatar(
              backgroundImage: NetworkImage(
                'https://www.seekpng.com/png/detail/115-1150053_avatar-png-transparent-png-royalty-free-default-user.png',
              ),

              // child: Icon(
              //   Icons.person,
              //   size: 60,
              //   color: Colors.white,
              // ),
            ),
          ),
          decoration: const BoxDecoration(
            color: Color(0xff1B75BC),
          ),
        ),
        ListTile(
          leading: const Icon(
            Icons.edit_note,
            color: Color(0xff1B75BC),
          ),
          title: const Text('My Cv'),
          onTap: () {
            // navigateTo(context, const CreateCVPersonalInfoScreen());
            navigateTo(
                context,
                ReviewApplicationScreen(
                    application:
                        JobApplicationModel(applicantID: CacheHelper.getData(key: 'uId'))));
          },
        ),
        ListTile(
          leading: const Icon(Icons.help_outline, color: Color(0xff1B75BC)),
          title: const Text('Help'),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(
            Icons.logout,
            color: Colors.red,
          ),
          title: const Text(
            'Logout',
            style: TextStyle(
              color: Colors.red,
            ),
          ),
          onTap: () {
            CacheHelper.removeData(key: 'name');
            CacheHelper.removeData(key: 'email');
            CacheHelper.removeData(key: 'uId');
            CacheHelper.removeData(key: 'companyName');
            CacheHelper.removeData(key: 'isApplicant');

            navigateAndFinish(context, const FirstAppScreen());
          },
        ),
      ],
    ),
  );
}

Widget initiateHrDrawer(BuildContext context) {
  return Drawer(
    child: ListView(
      // Important: Remove any padding from the ListView.
      padding: EdgeInsets.zero,
      children: <Widget>[
        UserAccountsDrawerHeader(
          onDetailsPressed: () {},
          accountName: Text(CacheHelper.getData(key: 'name') ?? 'account_name'),
          accountEmail: Text(CacheHelper.getData(key: 'email') ?? 'email'),
          currentAccountPicture: GestureDetector(
            onTap: () {},
            child: const CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://www.seekpng.com/png/detail/115-1150053_avatar-png-transparent-png-royalty-free-default-user.png'),

              // child: Icon(
              //   Icons.person,
              //   size: 60,
              //   color: Colors.white,
              // ),
            ),
          ),
          decoration: const BoxDecoration(
            color: defaultColor,
          ),
        ),
        ListTile(
          leading: const Icon(Icons.edit_note),
          title: const Text('Edit hr profile'),
          onTap: () {
            navigateTo(context, SignupScreen());
          },
        ),
        ListTile(
          leading: const Icon(Icons.edit_note),
          title: const Text('Edit company details'),
          onTap: () {
            navigateTo(context, const CompanyRegisterScreen());
          },
        ),
        ListTile(
          leading: const Icon(Icons.logout),
          title: const Text('Logout'),
          onTap: () {
            CacheHelper.removeData(key: 'name');
            CacheHelper.removeData(key: 'email');
            CacheHelper.removeData(key: 'uId');
            CacheHelper.removeData(key: 'companyName');
            CacheHelper.removeData(key: 'isApplicant');
            navigateAndFinish(context, const FirstAppScreen());
          },
        ),
      ],
    ),
  );
}

Widget defaultDropDownList({
  required String value,
  required Function onChange,
  required List<DropdownMenuItem<String>> items,
}) {
  return Container(
    width: double.infinity,
    decoration: BoxDecoration(
      border: Border.all(color: Colors.blueAccent),
      borderRadius: BorderRadius.circular(20),
      color: Colors.white,
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: DropdownButtonFormField<String>(
        isExpanded: true,
        validator: (value) => value == defaultDropDownListValue ? 'Please fill this field' : null,
        icon: const Icon(Icons.arrow_drop_down),
        iconSize: 30.0,

        // underline: const SizedBox(),

        style: const TextStyle(
          color: Colors.black54,
          fontSize: 18.0,
        ),
        // Must be one of items.value.

        value: value,

        onChanged: (val) => onChange(val),
        decoration: const InputDecoration.collapsed(hintText: ''),
        items: items,
      ),
    ),
  );
}

Widget dropDownListTitle(String title) {
  return Text(title,
      style: const TextStyle(fontSize: 15, color: Color(0xff1B75BC), fontWeight: FontWeight.w700));
}

Widget defaultDatePicker(TextEditingController controller, context, Function then, String label) =>
    SizedBox(
      child: defaultFormField(
        controller: controller,
        type: TextInputType.datetime,
        prefix: Icons.calendar_month,
        label: label,
        onTap: () {
          showDatePicker(
            builder: (BuildContext context, Widget? child) {
              return child!;
            },
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.parse('1950-01-01'),
            lastDate: DateTime.now(),
          ).then((value) => then(value));
        },
      ),
    );

Widget defaultTimePicker(TextEditingController controller, context, Function then, String label) =>
    SizedBox(
      child: defaultFormField(
        controller: controller,
        type: TextInputType.datetime,
        prefix: Icons.watch_later_outlined,
        label: label,
        onTap: () {
          print('xxxx 1');
          showTimePicker(
            builder: (BuildContext context, Widget? child) {
              return child!;
            },
            context: context,
            initialTime: TimeOfDay.now(),
          ).then((value) {
            print('xxxx 2');
            then(value);
          });
        },
      ),
    );

class MyAutocompleteField extends StatefulWidget {
  final void Function(List<String> selectedSkills)? onSkillsSelected;

  const MyAutocompleteField({Key? key, this.onSkillsSelected}) : super(key: key);

  @override
  _MyAutocompleteFieldState createState() => _MyAutocompleteFieldState();
}

class _MyAutocompleteFieldState extends State<MyAutocompleteField> {
  final TextEditingController _controller = TextEditingController();
  final List<String> _selectedSuggestions = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TypeAheadField<String>(
          textFieldConfiguration: TextFieldConfiguration(
            controller: _controller,
            decoration: InputDecoration(
              border: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue, width: 2.0),
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              hintText: 'Enter a value',
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 12.0,
              ),
              filled: true,
              fillColor: Colors.white,
              hintStyle: TextStyle(
                color: Colors.grey.withOpacity(0.8),
              ),
            ),
          ),
          suggestionsCallback: (pattern) async {
            final List<String> filteredSkills = skillsList
                .where((skill) => skill.toLowerCase().contains(pattern.toLowerCase()))
                .toList();
            return filteredSkills;
          },
          itemBuilder: (context, suggestion) {
            return ListTile(
              title: Text(suggestion),
            );
          },
          onSuggestionSelected: (suggestion) {
            setState(() {
              _controller.clear();
              _selectedSuggestions.add(suggestion);
              if (widget.onSkillsSelected != null) {
                widget.onSkillsSelected!(_selectedSuggestions);
              }
            });
          },
          noItemsFoundBuilder: (context) {
            return Text(
              'No suggestions found.',
              style: TextStyle(
                fontStyle: FontStyle.italic,
                color: Colors.grey.withOpacity(0.8),
              ),
            );
          },
          suggestionsBoxDecoration: SuggestionsBoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            // color: Colors.white,
            // boxShadow: [
            //   BoxShadow(
            //     color: Colors.grey.withOpacity(0.5),
            //     spreadRadius: 1,
            //     blurRadius: 5,
            //     offset: Offset(0, 2), // changes position of shadow
            //   ),
            // ],
          ),
          animationDuration: const Duration(milliseconds: 300),
          hideOnLoading: true,
          hideOnError: true,
          keepSuggestionsOnLoading: false,
          keepSuggestionsOnSuggestionSelected: false,
          autoFlipDirection: true,
        ),
        const SizedBox(height: 16.0),
        Wrap(
          children: _selectedSuggestions.map((suggestion) {
            return Chip(
              label: Text(
                suggestion,
              ),
              labelStyle: const TextStyle(color: Colors.white, fontSize: 15),
              backgroundColor: const Color(0xff1B75BC),
              onDeleted: () {
                setState(() {
                  _selectedSuggestions.remove(suggestion);
                  if (widget.onSkillsSelected != null) {
                    widget.onSkillsSelected!(_selectedSuggestions);
                  }
                });
              },
            );
          }).toList(),
        ),
        const SizedBox(height: 16.0),
      ],
    );
  }
}

class ListField extends StatefulWidget {
  final void Function(List<String> selectedSkills)? onSkillsSelected;

  const ListField({Key? key, this.onSkillsSelected}) : super(key: key);

  @override
  ListFieldState createState() => ListFieldState();
}

class ListFieldState extends State<ListField> {
  final TextEditingController controller = TextEditingController();
  final List<String> selectedSuggestions = [];
  final _textKey = GlobalKey<FormFieldState>();
  bool _isErrorVisible = false;
  String _errorMessage = "";

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      dropDownListTitle('Requirments'),
      const SizedBox(
        height: 10,
      ),
      TextFormField(
        key: _textKey,
        controller: controller,
        validator: (value) {
          if ((selectedSuggestions.isEmpty)) {
            return 'Please enter at least one requirement';
          }
          return null;
        },
      ),
      if (_isErrorVisible)
        Text(
          _errorMessage,
          style: const TextStyle(
            color: Colors.red,
          ),
        ),
      ElevatedButton(
        onPressed: () {
          if (controller.text.isEmpty || controller.text == null) {
            setState(() {
              _isErrorVisible = true;
              _errorMessage = 'Please enter a value';
            });
          } else {
            setState(() {
              selectedSuggestions.add(controller.text);
              controller.clear();
              _isErrorVisible = false;

              if (widget.onSkillsSelected != null) {
                widget.onSkillsSelected!(selectedSuggestions);
              }
            });
          }
        },
        child: const Text('Add Item'),
      ),
      Column(
        children: selectedSuggestions.map((suggestion) {
          return ListTile(
              key: UniqueKey(),
              title: Text(suggestion),
              trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    setState(() {
                      selectedSuggestions.remove(suggestion);
                      if (widget.onSkillsSelected != null) {
                        widget.onSkillsSelected!(selectedSuggestions);
                      }
                    });
                  }));
        }).toList(),
      ),
      const SizedBox(
        height: 15.0,
      )
    ]);
  }
}
