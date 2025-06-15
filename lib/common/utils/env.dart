import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class EnvVariable {
  static String clientCustomerHost =
      dotenv.env['CLIENT_CUSTOMER_HOST'] ?? 'http://localhost:8082';
  static String coreLocationHost =
      dotenv.env['CORE_LOCATION_HOST'] ?? 'http://localhost:8082';
  static String defaultCover = dotenv.env['DEFAULT_COVER'] ??
      'https://st5.depositphotos.com/12546280/63855/v/450/depositphotos_638556134-stock-illustration-landscape-nature-green-forest-mountain.jpg';
  static String defaultAvatar = dotenv.env['DEFAULT_AVATAR'] ??
      'https://images.vexels.com/media/users/3/125430/raw/a04274ad1a084b3ec5c20cb793dd1344-low-poly-fox-illustration.jpg';
}
