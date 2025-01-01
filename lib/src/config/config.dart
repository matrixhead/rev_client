import 'package:copy_with_extension/copy_with_extension.dart';
part 'config.g.dart';

@CopyWith()
class RevConfig {
  
  RevConfig({
    required this.baseUrl,
    required this.wsPort,
    required this.httpPort,
  });

  factory RevConfig.debug() {
    return RevConfig(
      baseUrl: '0.0.0.0',
      httpPort: 14702,
      wsPort: 14703,
    );
  }

  final String baseUrl;
  final int wsPort;
  final int httpPort;
}
