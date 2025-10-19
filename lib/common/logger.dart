import 'package:logger/logger.dart';
import '../core/config/env_config.dart';

Logger dLog = Logger(
  level: EnvConfig.instance.enableLogging ? Level.off : null,
);
