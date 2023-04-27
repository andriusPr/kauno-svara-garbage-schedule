import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home/bloc/garbage/garbage_bloc.dart';
import 'package:home/constants/request_constants.dart';
import 'package:home/widgets/calendar/calendar_widget.dart';
import 'package:home/widgets/common/loading_indicator_widget.dart';
import 'package:home/widgets/proxy/spacing/proxy_spacing_widget.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<GarbageBloc>(
          create: (BuildContext context) => GarbageBloc(),
        ),
      ],
      child: const AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: CalendarWrapperWidget(),
      ),
    );
  }
}

class CalendarWrapperWidget extends StatefulWidget {
  const CalendarWrapperWidget({super.key});

  @override
  State<CalendarWrapperWidget> createState() => _CalendarWrapperWidgetState();
}

class _CalendarWrapperWidgetState extends State<CalendarWrapperWidget> {
  @override
  void initState() {
    super.initState();
    refreshSchedules();
  }

  Widget _builder(BuildContext context, GarbageState state) {
    if (state.status != RequestStatus.success) {
      return _notSuccessStatusWidgets(state);
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 30.0),
      child: CalendarWidget(eventList: state.events!),
    );
  }

  Widget _notSuccessStatusWidgets(GarbageState state) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(state.status.message),
          const ProxySpacingVerticalWidget(),
          state.status == RequestStatus.failed
              ? FilledButton(
                  onPressed: refreshSchedules,
                  child: const Text('Refresh schedules'),
                )
              : const LoadingIndicatorWidget(),
        ],
      ),
    );
  }

  void refreshSchedules() {
    context.read<GarbageBloc>().add(const GarbageEventInit());
  }

  bool _buildWhen(GarbageState previousState, GarbageState state) =>
      previousState.status != state.status;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GarbageBloc, GarbageState>(
      builder: _builder,
      buildWhen: _buildWhen,
    );
  }
}
