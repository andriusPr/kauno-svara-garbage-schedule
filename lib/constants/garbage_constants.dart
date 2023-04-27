const garbageApiBaseUrl = 'https://grafikai.svara.lt/api';
const garbageContractsApiPath = '/contracts';
const garbageScheduleApiPath = '/schedule';
const garbageContractsBody = {
  'pageSize': 10,
  'pageIndex': 0,
  'address': '', // @TODO add street name.
  'region': 'Kauno m. sav.',
  'houseNumber': '', // @TODO add house number.
  'matchHouseNumber': true
};
const garbageNotificationTitle = 'Ryt išvežamos šiukšlės';