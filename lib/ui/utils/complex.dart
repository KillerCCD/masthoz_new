// Copyright 2019 Aleksander Woźniak
// SPDX-License-Identifier: Apache-2.0

import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:mashtoz_flutter/config/palette.dart';
import 'package:mashtoz_flutter/ui/utils/day_change_notifire.dart';

import 'package:mashtoz_flutter/ui/utils/utils_date.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class TableComplexExample extends StatefulWidget {
  @override
  _TableComplexExampleState createState() => _TableComplexExampleState();
}

class _TableComplexExampleState extends State<TableComplexExample> {
  late final ValueNotifier<List<Event>> _selectedEvents;
  final ValueNotifier<DateTime> _focusedDay = ValueNotifier(DateTime.now());
  final Set<DateTime> _selectedDays = LinkedHashSet<DateTime>(
    equals: isSameDay,
    hashCode: getHashCode,
  );

  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOff;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;

  @override
  void initState() {
    super.initState();

    _selectedDays.add(_focusedDay.value);
    _selectedEvents = ValueNotifier(_getEventsForDay(_focusedDay.value));
  }

  @override
  void dispose() {
    _focusedDay.dispose();
    _selectedEvents.dispose();

    super.dispose();
  }

  bool get canClearSelection =>
      _selectedDays.isNotEmpty || _rangeStart != null || _rangeEnd != null;

  List<Event> _getEventsForDay(DateTime day) {
    return kEvents[day] ?? [];
  }

  List<Event> _getEventsForDays(Iterable<DateTime> days) {
    return [
      for (final d in days) ..._getEventsForDay(d),
    ];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      if (_selectedDays.contains(selectedDay)) {
        _selectedDays.remove(selectedDay);
      } else {
        _selectedDays.add(selectedDay);
      }

      _focusedDay.value = focusedDay;

      context.read<FocuseDay>().setDays(_focusedDay.value.day.toInt());
      _rangeStart = null;
      _rangeEnd = null;
      _rangeSelectionMode = RangeSelectionMode.toggledOff;
    });

    _selectedEvents.value = _getEventsForDays(_selectedDays);
  }

  @override
  Widget build(BuildContext context) {
    print(_focusedDay.value.day);

    return Material(
      child: TableCalendar<Event>(
          locale: 'hy_AM',
          firstDay: kFirstDay,
          lastDay: kLastDay,
          focusedDay: _focusedDay.value,
          selectedDayPredicate: (day) => _selectedDays.contains(day),
          rangeStartDay: _rangeStart,
          rangeEndDay: _rangeEnd,
          rangeSelectionMode: _rangeSelectionMode,
          daysOfWeekVisible: false,
          onDaySelected: _onDaySelected,
          onPageChanged: (focusedDay) => _focusedDay.value = focusedDay,
          headerStyle: HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
              titleTextFormatter: (date, _locale) =>
                  DateFormat.yMMMMd(_locale).format(date),
              leftChevronMargin: EdgeInsets.only(left: 50.0),
              rightChevronMargin: EdgeInsets.only(right: 50.0)),
          calendarStyle: CalendarStyle(
            markerDecoration: BoxDecoration(color: Palette.whenTapedButton),
            selectedDecoration: BoxDecoration(color: Palette.whenTapedButton),
            todayDecoration: BoxDecoration(color: Palette.whenTapedButton),
          )),
    );
  }
}
