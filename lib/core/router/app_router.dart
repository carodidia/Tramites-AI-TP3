import 'package:go_router/go_router.dart';
import 'package:proyecto_final/core/entities/solicitud.dart';
import 'package:proyecto_final/presentation/screens/addUser_screen.dart';
import 'package:proyecto_final/presentation/screens/formulario_screen.dart';
import 'package:proyecto_final/presentation/screens/historial_screen.dart';
import 'package:proyecto_final/presentation/screens/home_screen.dart';
import 'package:proyecto_final/presentation/screens/login_screen.dart';
import 'package:proyecto_final/presentation/screens/perfil_screen.dart';
import 'package:proyecto_final/presentation/screens/solicitud_screen.dart';
import 'package:proyecto_final/presentation/screens/solicitudes_screen.dart';

final AppRouter = GoRouter(initialLocation: '/', routes: [
  GoRoute(
  name: LogInScreen.name,
  path: '/',
  builder: (context, state)=> const LogInScreen()),

  GoRoute(
      name: AddUserScreen.name,
      path: '/addUser',
      builder: (context, state) => const AddUserScreen()),

  GoRoute(
      name: HomeScreen.name,
      path: '/home',
      builder: (context, state) => HomeScreen()),

  GoRoute(
      name: FormularioScreen.name,
      path: '/formulario',
      builder: (context, state) => const FormularioScreen()),

  GoRoute(
      name: HistorialScreen.name,
      path: '/historial',
      builder: (context, state) => HistorialScreen()),

  GoRoute(
      name: PerfilScreen.name,
      path: '/perfil',
      builder: (context, state) => const PerfilScreen()),

  GoRoute(
      name: SolicitudScreen.name,
      path: '/solicitud',
      builder: (context, state) => SolicitudScreen(
            solicitud: state.extra as Solicitud,
          )),

  GoRoute(
      name: SolicitudesScreen.name,
      path: '/solicitudes',
      builder: (context, state) => SolicitudesScreen()),
]);
