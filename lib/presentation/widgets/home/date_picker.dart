import 'package:flutter/material.dart';

class DatePicker extends StatefulWidget {
  const DatePicker(
    this.initialDate, {
    super.key,
    this.height = 100,
    this.width = 72,
    this.initialSelectedDate,
    this.selectionColor,
    this.selectedTextColor = Colors.white,
    this.dateTextStyle = const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: Colors.grey,
    ),
  });

  final DateTime initialDate;
  final double height;
  final double width;
  final DateTime? initialSelectedDate;
  final Color? selectionColor;
  final Color selectedTextColor;
  final TextStyle dateTextStyle;

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  static const int _dayCount = 14;
  late DateTime _selectedDate;

  static const Color _selectedBackground = Color(0xFF6A5ACD);
  static const Color _unselectedBackground = Color(0xFFF5F5F5);
  static const Color _unselectedDayColor = Color(0xFFB0B0B0);
  static const Color _unselectedDateColor = Color(0xFF2D2D2D);
  static const Color _unselectedDotColor = Color(0xFFD0D0D0);

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialSelectedDate ?? widget.initialDate;
  }

  @override
  Widget build(BuildContext context) {
    final selectionColor = widget.selectionColor ?? _selectedBackground;
    return SizedBox(
      height: widget.height,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _dayCount,
        itemBuilder: (context, index) {
          final date = widget.initialDate.add(Duration(days: index));
          final isSelected = _isSameDay(_selectedDate, date);
          return GestureDetector(
            onTap: () => setState(() => _selectedDate = date),
            child: Container(
              width: widget.width,
              margin: const EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                color: isSelected ? selectionColor : _unselectedBackground,
                borderRadius: BorderRadius.circular(16),
              ),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _dayName(date),
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: isSelected
                          ? widget.selectedTextColor
                          : _unselectedDayColor,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    date.day.toString().padLeft(2, '0'),
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: isSelected
                          ? widget.selectedTextColor
                          : _unselectedDateColor,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    width: 4,
                    height: 4,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isSelected
                          ? widget.selectedTextColor
                          : _unselectedDotColor,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  String _dayName(DateTime date) {
    const names = ['PZT', 'SAL', 'ÇRŞ', 'PRŞ', 'CUM', 'CMT', 'PAZ'];
    return names[date.weekday - 1];
  }
}
