import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvVariable {
  final String clientCustomerHost =
      dotenv.env['CLIENT_CUSTOMER_HOST'] ?? 'http://localhost:8082';
  final String coreLocationHost =
      dotenv.env['CORE_LOCATION_HOST'] ?? 'http://localhost:8082';
  final String defaultCover = dotenv.env['DEFAULT_COVER'] ??
      'https://st5.depositphotos.com/12546280/63855/v/450/depositphotos_638556134-stock-illustration-landscape-nature-green-forest-mountain.jpg';
  final String defaultAvatar = dotenv.env['DEFAULT_AVATAR'] ??
      'https://images.vexels.com/media/users/3/125430/raw/a04274ad1a084b3ec5c20cb793dd1344-low-poly-fox-illustration.jpg';
}
