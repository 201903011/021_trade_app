import 'package:minimals/theme/use_theme.dart';
import 'package:minimals/utils/global_utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomDatePicker extends StatefulWidget {
  final DateTime initialDate;
  final DateTime minDate;
  final DateTime maxDate;
  final void Function(DateTime) onDateSelected;

  const CustomDatePicker({
    super.key,
    required this.initialDate,
    required this.minDate,
    required this.maxDate,
    required this.onDateSelected,
  });

  @override
  CustomDatePickerState createState() => CustomDatePickerState();
}

class CustomDatePickerState extends State<CustomDatePicker> {
  late int selectedDay;
  late int selectedMonth;
  late int selectedYear;

  late List<int> days;
  late List<int> years;

  final FixedExtentScrollController _dayController = FixedExtentScrollController();
  final FixedExtentScrollController _monthController = FixedExtentScrollController();
  final FixedExtentScrollController _yearController = FixedExtentScrollController();

  @override
  void initState() {
    super.initState();
    selectedDay = widget.initialDate.day;
    selectedMonth = widget.initialDate.month;
    selectedYear = widget.initialDate.year;

    // Generate years based on min and max dates
    years = List.generate(
      widget.maxDate.year - widget.minDate.year + 1,
      (index) => widget.minDate.year + index,
    );

    days = _generateDays();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToInitialDate();
    });
  }

  List<int> _generateDays() {
    int daysInMonth = DateTime(selectedYear, selectedMonth + 1, 0).day;
    return List.generate(daysInMonth, (index) => index + 1); // 1 to daysInMonth
  }

  void _scrollToInitialDate() {
    final dayIndex = selectedDay - 1;
    final monthIndex = selectedMonth - 1;
    final yearIndex = years.indexOf(selectedYear);

    _dayController.jumpToItem(dayIndex);
    _monthController.jumpToItem(monthIndex);
    _yearController.jumpToItem(yearIndex);
  }

  void _onDateChanged() {
    DateTime selectedDate = DateTime(selectedYear, selectedMonth, selectedDay);
    if (selectedDate.isAfter(widget.maxDate)) {
      selectedDate = widget.maxDate;
    }
    if (selectedDate.isBefore(widget.minDate)) {
      selectedDate = widget.minDate;
    }

    setState(() {
      selectedDay = selectedDate.day;
      selectedMonth = selectedDate.month;
      selectedYear = selectedDate.year;
    });

    widget.onDateSelected(selectedDate);
  }

  @override
  Widget build(BuildContext context) {
    final theme = useTheme(context);
    final baseTheme = theme.theme;
    final customTheme = theme.customTheme;

    return Container(
      height: 250,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Day picker
          Expanded(
            child: ListWheelScrollView.useDelegate(
              controller: _dayController,
              itemExtent: 40,
              diameterRatio: 1.5, // Ensures only three options visible
              physics: const FixedExtentScrollPhysics(),
              onSelectedItemChanged: (index) {
                setState(() {
                  selectedDay = _generateDays()[index % _generateDays().length]; // Loop days
                });
                _onDateChanged();
              },
              childDelegate: ListWheelChildLoopingListDelegate(
                children: _generateDays().map((day) {
                  return Center(
                    child: Text(addLeadingZero(day.toString()),
                        style: selectedDay == day
                            ? baseTheme.textTheme.headlineMedium?.copyWith(color: customTheme.palette.text.primary, decoration: TextDecoration.none)
                            : baseTheme.textTheme.headlineMedium?.copyWith(color: customTheme.palette.text.secondary, decoration: TextDecoration.none)),
                  );
                }).toList(),
              ),
            ),
          ),

          // Month picker
          Expanded(
            child: ListWheelScrollView.useDelegate(
              controller: _monthController,
              itemExtent: 40,
              diameterRatio: 1.5,
              physics: const FixedExtentScrollPhysics(),
              onSelectedItemChanged: (index) {
                setState(() {
                  if (index == 12) {
                    selectedMonth = 1;
                    selectedYear++;
                  } else if (index == -1) {
                    selectedMonth = 12;
                    selectedYear--;
                  } else {
                    selectedMonth = (index % 12) + 1;
                  }
                  _generateDays();
                });
                _onDateChanged();
              },
              childDelegate: ListWheelChildLoopingListDelegate(
                children: List.generate(12, (index) {
                  String monthName = DateFormat.MMMM().format(DateTime(0, index + 1));
                  return Center(
                    child: Text(getShortMonth(monthName),
                        style: selectedMonth == (index + 1)
                            ? baseTheme.textTheme.headlineMedium?.copyWith(color: customTheme.palette.text.primary, decoration: TextDecoration.none)
                            : baseTheme.textTheme.headlineMedium?.copyWith(color: customTheme.palette.text.secondary, decoration: TextDecoration.none)),
                  );
                }),
              ),
            ),
          ),

          // Year picker
          Expanded(
            child: ListWheelScrollView.useDelegate(
              controller: _yearController,
              itemExtent: 40,
              diameterRatio: 1.5, // Ensures only three options visible
              physics: const FixedExtentScrollPhysics(),
              onSelectedItemChanged: (index) {
                setState(() {
                  selectedYear = years[index % years.length]; // Loop years
                  _generateDays(); // Update the days for the new year
                });
                _onDateChanged();
              },
              childDelegate: ListWheelChildLoopingListDelegate(
                children: years.map((year) {
                  return Center(
                    child: Text(year.toString(),
                        style: selectedYear == year
                            ? baseTheme.textTheme.headlineMedium?.copyWith(color: customTheme.palette.text.primary, decoration: TextDecoration.none)
                            : baseTheme.textTheme.headlineMedium?.copyWith(color: customTheme.palette.text.secondary, decoration: TextDecoration.none)),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
