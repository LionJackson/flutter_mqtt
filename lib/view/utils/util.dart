import 'dart:math';
import 'dart:ui';

class Util{
  static Color randomColor() {
    Random random = Random();
    int red = random.nextInt(256); // 生成0到255之间的随机数作为红色通道值
    int green = random.nextInt(256); // 生成0到255之间的随机数作为绿色通道值
    int blue = random.nextInt(256); // 生成0到255之间的随机数作为蓝色通道值

    // 将RGB颜色值转换为Color对象
    Color color = Color.fromRGBO(red, green, blue, 1.0);

    // 调整颜色亮度
    // 您可以根据需要自定义亮度调整的方式，这里是通过减少红、绿、蓝通道的值来生成淡色
    int delta = 50; // 亮度调整值
    int adjustedRed = (red - delta).clamp(0, 255); // 调整红色通道值
    int adjustedGreen = (green - delta).clamp(0, 255); // 调整绿色通道值
    int adjustedBlue = (blue - delta).clamp(0, 255); // 调整蓝色通道值

    // 将调整后的RGB颜色值转换为Color对象
    Color lightColor = Color.fromRGBO(adjustedRed, adjustedGreen, adjustedBlue, 1.0);

    return lightColor;
  }
  static String hidePhoneNumber(String phoneNumber) {
    if (phoneNumber.length != 11) {
      return phoneNumber;
    }
    String prefix = phoneNumber.substring(0, 3);
    String suffix = phoneNumber.substring(7);
    String hiddenNumber = '$prefix****$suffix';
    return hiddenNumber;
  }
}