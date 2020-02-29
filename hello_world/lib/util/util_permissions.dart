import 'package:permission_handler/permission_handler.dart';

class PermissionsUtil {
  ///申请权限 并返回申请结果
  static Future<Map<PermissionGroup, PermissionStatus>> requestPermissions(
      List<PermissionGroup> permissions) async {
    return await PermissionHandler().requestPermissions(permissions);
  }

  ///检查权限 并返回申请结果
  static Future<PermissionStatus> checkPermission(
      PermissionGroup permission) async {
    return await PermissionHandler().checkPermissionStatus(permission);
  }

  ///手动打开系统设置权限界面
  static Future<bool> openAppSettings() async {
    return await PermissionHandler().openAppSettings();
  }
}
