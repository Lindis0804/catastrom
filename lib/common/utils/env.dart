import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvVariable {
  final String clientCustomerHost =
      dotenv.env['CLIENT_CUSTOMER_HOST'] ?? 'http://localhost:8082';
  final String coreLocationHost =
      dotenv.env['CORE_LOCATION_HOST'] ?? 'http://localhost:8082';
}
