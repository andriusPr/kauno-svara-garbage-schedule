import 'dart:collection';
import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:home/constants/garbage_constants.dart';
import 'package:home/constants/request_constants.dart';
import 'package:home/model/garbage/contracts_model.dart';
import 'package:home/model/garbage/schedule_model.dart';
import 'package:home/utils/request_helper.dart';
import 'package:sprintf/sprintf.dart';
import 'package:table_calendar/table_calendar.dart';

class GarbageRepository {
  Future<List<GarbageContracts>> getContracts() async {
    final Response response = await DioApi.getInstance().get(
      garbageContractsApiPath,
      queryParameters: garbageContractsBody,
      options: buildCacheOptions(requestCacheTtl),
    );

    if (response.statusCode != 200) {
      throw const FormatException('Failed to load Contracts');
    }

    return GarbageContracts.fromJsonArray(response.data['data']);
  }

  Future<LinkedHashMap<DateTime, List<String>>> getScheduleByContracts(
      List<GarbageContracts> contracts,
      ) async {
    final kEvents = LinkedHashMap<DateTime, List<String>>(
      equals: isSameDay,
      hashCode: getHashCode,
    );

    final a = contracts.map((GarbageContracts contract) async {
      final Response response = await DioApi.getInstance().get(
        garbageScheduleApiPath,
        queryParameters: {
          'wasteObjectId': contract.id,
        },
        options: buildCacheOptions(requestCacheTtl),
      );

      if (response.statusCode != 200) {
        throw const FormatException('Failed to load Contracts Schedules');
      }

      GarbageSchedule.fromJsonArray(response.data).forEach((element) {
        if (kEvents[element.date] == null) {
          kEvents[element.date] = [];
        }

        kEvents[element.date]?.add(
            sprintf('%s (%s)', [contract.description, contract.container]));
      });
    });

    await Future.wait(a);

    return kEvents;
  }

  Future<LinkedHashMap<DateTime, List<String>>> getSchedule() async {
    return await getScheduleByContracts(await getContracts());
  }

  int getHashCode(DateTime key) {
    return key.day * 1000000 + key.month * 10000 + key.year;
  }
}
