import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'dart:async';

class AppUsageTracker with WidgetsBindingObserver {
  static final AppUsageTracker _instance = AppUsageTracker._internal();
  factory AppUsageTracker() => _instance;
  AppUsageTracker._internal();

  static const String _boxName = 'app_usage';
  static const String _sessionBoxName = 'app_sessions';
  
  late Box<AppUsageSession> _sessionBox;
  late Box _usageBox;
  
  DateTime? _sessionStartTime;
  Timer? _updateTimer;
  AppUsageSession? _currentSession;
  
  // Track total usage time in seconds
  int _totalUsageSeconds = 0;
  int _dailyUsageSeconds = 0;
  int _weeklyUsageSeconds = 0;
  int _monthlyUsageSeconds = 0;
  
  Future<void> init() async {
    // Register Hive adapters
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(AppUsageSessionAdapter());
    }
    
    // Open boxes
    _sessionBox = await Hive.openBox<AppUsageSession>(_sessionBoxName);
    _usageBox = await Hive.openBox(_boxName);
    
    // Load existing data
    await _loadUsageData();
    
    // Add observer for app lifecycle
    WidgetsBinding.instance.addObserver(this);
    
    // Start session
    _startSession();
  }
  
  Future<void> _loadUsageData() async {
    _totalUsageSeconds = _usageBox.get('totalUsageSeconds', defaultValue: 0);
    _dailyUsageSeconds = _usageBox.get('dailyUsageSeconds', defaultValue: 0);
    _weeklyUsageSeconds = _usageBox.get('weeklyUsageSeconds', defaultValue: 0);
    _monthlyUsageSeconds = _usageBox.get('monthlyUsageSeconds', defaultValue: 0);
    
    // Check if we need to reset daily/weekly/monthly counters
    await _checkAndResetPeriodCounters();
  }
  
  Future<void> _checkAndResetPeriodCounters() async {
    final now = DateTime.now();
    final lastResetDateString = _usageBox.get('lastResetDate', defaultValue: '');
    
    if (lastResetDateString.isNotEmpty) {
      final lastResetDate = DateTime.parse(lastResetDateString);
      
      // Reset daily counter if it's a new day
      if (!_isSameDay(lastResetDate, now)) {
        _dailyUsageSeconds = 0;
        await _usageBox.put('dailyUsageSeconds', 0);
      }
      
      // Reset weekly counter if it's a new week
      if (!_isSameWeek(lastResetDate, now)) {
        _weeklyUsageSeconds = 0;
        await _usageBox.put('weeklyUsageSeconds', 0);
      }
      
      // Reset monthly counter if it's a new month
      if (!_isSameMonth(lastResetDate, now)) {
        _monthlyUsageSeconds = 0;
        await _usageBox.put('monthlyUsageSeconds', 0);
      }
    }
    
    await _usageBox.put('lastResetDate', now.toIso8601String());
  }
  
  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year && 
           date1.month == date2.month && 
           date1.day == date2.day;
  }
  
  bool _isSameWeek(DateTime date1, DateTime date2) {
    final week1 = _getWeekOfYear(date1);
    final week2 = _getWeekOfYear(date2);
    return date1.year == date2.year && week1 == week2;
  }
  
  bool _isSameMonth(DateTime date1, DateTime date2) {
    return date1.year == date2.year && date1.month == date2.month;
  }
  
  int _getWeekOfYear(DateTime date) {
    final firstDayOfYear = DateTime(date.year, 1, 1);
    final daysSinceFirstDay = date.difference(firstDayOfYear).inDays;
    return ((daysSinceFirstDay + firstDayOfYear.weekday - 1) / 7).ceil();
  }
  
  void _startSession() {
    _sessionStartTime = DateTime.now();
    _currentSession = AppUsageSession(
      startTime: _sessionStartTime!,
      endTime: null,
      durationSeconds: 0,
    );
    
    // Start periodic timer to update usage every 30 seconds
    _updateTimer = Timer.periodic(const Duration(seconds: 30), (timer) {
      _updateUsageTime();
    });
  }
  
  Future<void> _endSession() async {
    if (_sessionStartTime == null) return;
    
    final endTime = DateTime.now();
    final duration = endTime.difference(_sessionStartTime!).inSeconds;
    
    // Update current session
    if (_currentSession != null) {
      _currentSession = _currentSession!.copyWith(
        endTime: endTime,
        durationSeconds: duration,
      );
      
      // Save session
      await _sessionBox.add(_currentSession!);
    }
    
    // Update total usage time
    await _updateUsageTime(forceUpdate: true);
    
    // Cancel timer
    _updateTimer?.cancel();
    
    // Reset session
    _sessionStartTime = null;
    _currentSession = null;
  }
  
  Future<void> _updateUsageTime({bool forceUpdate = false}) async {
    if (_sessionStartTime == null) return;
    
    final now = DateTime.now();
    final sessionDuration = now.difference(_sessionStartTime!).inSeconds;
    
    // Only update if significant time has passed or forced
    if (sessionDuration > 0 || forceUpdate) {
      // Check for period resets
      await _checkAndResetPeriodCounters();
      
      // Calculate new usage time
      final previousSessionDuration = _currentSession?.durationSeconds ?? 0;
      final newSeconds = sessionDuration - previousSessionDuration;
      
      if (newSeconds > 0) {
        _totalUsageSeconds += newSeconds;
        _dailyUsageSeconds += newSeconds;
        _weeklyUsageSeconds += newSeconds;
        _monthlyUsageSeconds += newSeconds;
        
        // Save to Hive
        await _usageBox.put('totalUsageSeconds', _totalUsageSeconds);
        await _usageBox.put('dailyUsageSeconds', _dailyUsageSeconds);
        await _usageBox.put('weeklyUsageSeconds', _weeklyUsageSeconds);
        await _usageBox.put('monthlyUsageSeconds', _monthlyUsageSeconds);
        
        // Update current session
        _currentSession = _currentSession?.copyWith(
          durationSeconds: sessionDuration,
        );
      }
    }
  }
  
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        // App is in foreground
        _startSession();
        break;
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
      case AppLifecycleState.hidden:
      case AppLifecycleState.inactive:
        // App is in background or closing
        _endSession();
        break;
    }
  }
  
  // Public getters for usage data
  int get totalUsageSeconds => _totalUsageSeconds;
  int get dailyUsageSeconds => _dailyUsageSeconds;
  int get weeklyUsageSeconds => _weeklyUsageSeconds;
  int get monthlyUsageSeconds => _monthlyUsageSeconds;
  
  String get totalUsageFormatted => _formatDuration(_totalUsageSeconds);
  String get dailyUsageFormatted => _formatDuration(_dailyUsageSeconds);
  String get weeklyUsageFormatted => _formatDuration(_weeklyUsageSeconds);
  String get monthlyUsageFormatted => _formatDuration(_monthlyUsageSeconds);
  
  String _formatDuration(int seconds) {
    final hours = seconds ~/ 3600;
    final minutes = (seconds % 3600) ~/ 60;
    final secs = seconds % 60;
    
    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else if (minutes > 0) {
      return '${minutes}m ${secs}s';
    } else {
      return '${secs}s';
    }
  }
  
  // Get today's usage in minutes (for the circular progress)
  int getTodayUsageMinutes() {
    return _dailyUsageSeconds ~/ 60;
  }
  
  // Get all sessions for analytics
  Future<List<AppUsageSession>> getAllSessions() async {
    return _sessionBox.values.toList();
  }
  
  // Get sessions for a specific date range
  Future<List<AppUsageSession>> getSessionsInRange(DateTime start, DateTime end) async {
    return _sessionBox.values.where((session) {
      return session.startTime.isAfter(start) && 
             session.startTime.isBefore(end);
    }).toList();
  }
  
  // Clean up
  void dispose() {
    _updateTimer?.cancel();
    WidgetsBinding.instance.removeObserver(this);
  }
}

// Model for app usage session
class AppUsageSession {
  final DateTime startTime;
  final DateTime? endTime;
  final int durationSeconds;
  
  AppUsageSession({
    required this.startTime,
    this.endTime,
    required this.durationSeconds,
  });
  
  AppUsageSession copyWith({
    DateTime? startTime,
    DateTime? endTime,
    int? durationSeconds,
  }) {
    return AppUsageSession(
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      durationSeconds: durationSeconds ?? this.durationSeconds,
    );
  }
}

// Hive adapter for AppUsageSession
class AppUsageSessionAdapter extends TypeAdapter<AppUsageSession> {
  @override
  final int typeId = 0;
  
  @override
  AppUsageSession read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AppUsageSession(
      startTime: fields[0] as DateTime,
      endTime: fields[1] as DateTime?,
      durationSeconds: fields[2] as int,
    );
  }
  
  @override
  void write(BinaryWriter writer, AppUsageSession obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.startTime)
      ..writeByte(1)
      ..write(obj.endTime)
      ..writeByte(2)
      ..write(obj.durationSeconds);
  }
  
  @override
  int get hashCode => typeId.hashCode;
  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppUsageSessionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

