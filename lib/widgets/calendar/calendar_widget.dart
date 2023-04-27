import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:home/constants/proxy.dart';
import 'package:home/widgets/proxy/spacing/proxy_spacing_widget.dart';
import 'package:table_calendar/table_calendar.dart';
import 'calendar_event_list_widget.dart';

class CalendarWidget extends StatefulWidget {
  final LinkedHashMap<DateTime, List<String>> eventList;

  const CalendarWidget({
    super.key,
    required this.eventList,
  });

  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  late DateTime _dateCurrent = DateTime.now();
  late DateTime _dateSelected = _dateCurrent;
  late final DateTime _dateStart = DateTime(_dateCurrent.year, _dateCurrent.month - 1, _dateCurrent.day);
  late final DateTime _dateEnd = DateTime(_dateCurrent.year, _dateCurrent.month + 5, _dateCurrent.day);

  List<String> _eventLoader(DateTime day) => widget.eventList[day] ?? [];

  bool _selectedDayPredicate(DateTime day) => isSameDay(_dateSelected, day);

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      _dateSelected = selectedDay;
      _dateCurrent = focusedDay;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<String> eventList = _eventLoader(_dateSelected);
    return Column(
      children: [
        TableCalendar(
          lastDay: _dateEnd,
          firstDay: _dateStart,
          focusedDay: _dateCurrent,
          eventLoader: _eventLoader,
          onDaySelected: _onDaySelected,
          calendarFormat: CalendarFormat.month,
          selectedDayPredicate: _selectedDayPredicate,
          headerStyle: const HeaderStyle(
            titleCentered: true,
            formatButtonVisible: false,
          ),
        ),
        const ProxySpacingVerticalWidget(
          size: ProxySpacing.small,
        ),
        eventList.isEmpty
            ? const SizedBox.shrink()
            : CalendarEventListWidget(
                eventList: eventList,
              ),
      ],
    );
  }
}
