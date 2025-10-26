import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:yosrixia/core/utils/constants.dart';
import 'package:yosrixia/core/widgets/custom_text_form_field.dart';
import 'package:yosrixia/features/appointment_booking/presentation/cubits/slots_cubit/slots_cubit.dart';
import 'package:yosrixia/features/widgets/custom_button.dart';

class AddSlotForm extends StatefulWidget {
  const AddSlotForm({super.key});

  @override
  State<AddSlotForm> createState() => _AddSlotFormState();
}

class _AddSlotFormState extends State<AddSlotForm> {
  // Form controllers and state
  final _formKey = GlobalKey<FormState>();
  final _dateController = TextEditingController();
  final _timeController = TextEditingController();

  // Selected values
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  // Constants
  static const String _dateFormat = 'yyyy-MM-dd';
  static const int _maxDaysInFuture = 365;

  @override
  void dispose() {
    _dateController.dispose();
    _timeController.dispose();
    super.dispose();
  }

  /// Opens date picker and updates the selected date
  Future<void> _selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: _maxDaysInFuture)),
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
        _dateController.text = DateFormat(_dateFormat).format(pickedDate);
      });
    }
  }

  /// Opens time picker and updates the selected time with Arabic formatting
  Future<void> _selectTime() async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
    );

    if (pickedTime != null && pickedTime != _selectedTime) {
      setState(() {
        _selectedTime = pickedTime;
        _timeController.text = _formatTimeForDisplay(pickedTime);
      });
    }
  }

  /// Formats time for display with Arabic AM/PM indicators
  String _formatTimeForDisplay(TimeOfDay time) {
    final localizations = MaterialLocalizations.of(context);
    String formatted = localizations.formatTimeOfDay(
      time,
      alwaysUse24HourFormat: false,
    );

    // Remove AM/PM suffix if present
    formatted = formatted
        .replaceAll(RegExp(r'\s?[ap]\.?m\.?', caseSensitive: false), '')
        .trim();

    // Add Arabic AM/PM suffix
    String suffix = time.period == DayPeriod.am ? 'صباحاً' : 'مساءً';
    return '$formatted $suffix';
  }

  /// Validates and submits the form
  void _submitForm() {
    if (!_formKey.currentState!.validate()) return;

    if (!_isFormValid()) {
      _showErrorSnackBar('الرجاء اختيار التاريخ والوقت');
      return;
    }

    final dateTime = _createDateTime();
    context.read<SlotsCubit>().addSlot(dateTime);
  }

  /// Validates that all required fields are selected
  bool _isFormValid() {
    return _selectedDate != null && _selectedTime != null;
  }

  /// Creates a SlotModel from the selected date and time
  DateTime _createDateTime() {
    final dateTime = DateTime(
      _selectedDate!.year,
      _selectedDate!.month,
      _selectedDate!.day,
      _selectedTime!.hour,
      _selectedTime!.minute,
    );

    return dateTime;
  }

  /// Shows error snackbar with consistent styling
  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  /// Shows success snackbar with consistent styling
  void _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  /// Clears the form after successful submission
  void _clearForm() {
    _dateController.clear();
    _timeController.clear();
    setState(() {
      _selectedDate = null;
      _selectedTime = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SlotsCubit, SlotsState>(
      listener: (context, state) {
        if (state is SlotsAdded) {
          _showSuccessSnackBar(state.success.message);
          _clearForm();
        } else if (state is SlotsError) {
          _showErrorSnackBar(state.failure.message);
        }
      },
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),

            // Date Picker Section
            _buildDatePickerField(),

            const SizedBox(height: 20),

            // Time Picker Section
            _buildTimePickerField(),

            const SizedBox(height: 40),

            // Submit Button Section
            _buildSubmitButton(),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  /// Builds the date picker field
  Widget _buildDatePickerField() {
    return CustomTextFormField(
      labelText: 'التاريخ',
      hintText: 'اختر التاريخ',
      controller: _dateController,
      readOnly: true,
      onTap: _selectDate,
      suffixIcon: const Icon(Icons.calendar_month, color: kSecondaryColor),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'الرجاء اختيار التاريخ';
        }
        return null;
      },
    );
  }

  /// Builds the time picker field
  Widget _buildTimePickerField() {
    return CustomTextFormField(
      labelText: 'الوقت',
      hintText: 'اختر الوقت',
      controller: _timeController,
      readOnly: true,
      onTap: _selectTime,
      suffixIcon: const Icon(Icons.access_time, color: kSecondaryColor),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'الرجاء اختيار الوقت';
        }
        return null;
      },
    );
  }

  /// Builds the submit button with loading state
  Widget _buildSubmitButton() {
    return BlocBuilder<SlotsCubit, SlotsState>(
      builder: (context, state) {
        final isLoading = state is SlotsLoading;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: CustomButton(
            text: isLoading ? 'جاري الإضافة...' : 'إضافة الموعد',
            onPressed: isLoading ? () {} : _submitForm,
            width: double.infinity,
            height: 60,
          ),
        );
      },
    );
  }
}
