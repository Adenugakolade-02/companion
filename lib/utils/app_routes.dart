
import 'package:caution_companion/locator.dart';
import 'package:caution_companion/services/navigator_service.dart';

class AppRoute{
  static const String homeScreen = '/homeScreen';
  static const String login = '/login';
  static const String registerPage = '/registerPage';
  static const String resetPageone = '/resetPageone';
  static const String resetPageTwo = '/resetPageTwo';
  static const String otpPage = '/otpPage';
  static const String createReportPage = '/createReportPage';


  static Future go(String destination, { dynamic arguments, bool? pop, bool? popAll }) async {
    if (pop == true) {
      return await serviceLocator<NavigatorService>().popNavigateTo(destination, arguments: arguments);
    } else if (popAll == true) {
      return await serviceLocator<NavigatorService>().popAllNavigateTo(destination, arguments: arguments);
    } else {
      return await serviceLocator<NavigatorService>().navigateTo(destination, arguments: arguments);
    }
  }

  static pop<T extends Object>([T? result]) {
    return serviceLocator<NavigatorService>().pop(result);
  }

  static bool? canPop(){
    return serviceLocator<NavigatorService>().canPop();
  }
}