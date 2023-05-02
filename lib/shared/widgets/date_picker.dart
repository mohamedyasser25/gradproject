import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePicker extends StatefulWidget {
  final Function(DateTime) onSelectDate;
  final TextEditingController datePickerController;
  TextStyle textStyle;
  Color cursorColor;
  InputBorder border;
  Icon? trailingIcon;
  String hintText;
  bool? isOptionalField;
  bool? enabled;

  DatePicker({
    Key? key,
    required this.datePickerController,
    required this.onSelectDate,
    required this.hintText,
    this.isOptionalField,
    this.enabled,
    this.cursorColor = Colors.white,
    this.trailingIcon,
    this.textStyle = const TextStyle(
      fontSize: 14,
      color: Colors.white,
    ),
    this.border = const UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.white),
    ),
  }) : super(key: key);

  @override
  _DatePickerState createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  DateTime _selectedDate = DateTime.now();
  final DateFormat _dateFormat = DateFormat("dd/MM/yyyy");

  _selectDate() async {
    final DateTime? picked = await showDatePicker(
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: const ColorScheme.light(
                primary: Colors.blue,
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  primary: Colors.blueAccent, // button text color
                ),
              ),
            ),
            child: child!,
          );
        },
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime(2030),
    );

    if (picked != null && picked != _selectedDate) {
      _selectedDate = picked;
      widget.datePickerController.text =
          (_dateFormat.format(picked)).toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: widget.enabled ?? true,
      controller: widget.datePickerController,
      style: widget.textStyle,
      cursorColor: widget.cursorColor,
      readOnly: true,
      decoration: InputDecoration(
        suffixIcon: widget.trailingIcon,
        hintText: widget.hintText,
        hintStyle: widget.textStyle,
        filled: false,
        isDense: true,
        focusedBorder: widget.border,
        enabledBorder: widget.border,
        border: widget.border,
      ),
      onTap: () async {
        await _selectDate();
        widget.onSelectDate(_selectedDate);
      },
    );
  }
}
