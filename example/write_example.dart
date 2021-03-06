import 'package:influxdb_client/api.dart';

void main() async {
  var client = InfluxDBClient(
      url: 'http://localhost:8086',
      token: 'my-token',
      org: 'my-org',
      bucket: 'my-bucket',
      debug: true);

  var writeApi = client.getWriteService(WriteOptions().merge(
      precision: WritePrecision.s,
      batchSize: 100,
      flushInterval: 5000,
      gzip: true));

  var point = Point('h2o')
      .addTag('location', 'Prague')
      .addField('level', 1.12345)
      .time(DateTime.now().toUtc());

  await writeApi.write(point).then((value) {
    print('Write completed 1');
  }).catchError((exception) {
    // error block
    print('Handle write error here!');
    print(exception);
  });
}
