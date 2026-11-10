import 'package:ebv_ad_galaad_2026/screens/home_screen_spliter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'proyector_screen.dart'; // O el archivo donde esté ProyectorScreen
import 'reg_diario_page.dart';
import 'providers/supabase_provider.dart';

class LoginPinScreen extends StatefulWidget {
  const LoginPinScreen({super.key});

  @override
  State<LoginPinScreen> createState() => _LoginPinScreenState();
}

class _LoginPinScreenState extends State<LoginPinScreen> {
  final TextEditingController _pinController = TextEditingController();

  Future<void> _login() async {
    final provider = context.read<SupabaseProvider>();
    final pin = _pinController.text.trim();

    try {
      final exito = await provider.loginConPin(pin);

      if (exito) {
        if (!mounted) return;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => HomeScreenSpliterView(profesor: provider.profesorActual!),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('PIN incorrecto. Inténtalo de nuevo.')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al conectar: $e')),
      );
    }
  }

  @override
Widget build(BuildContext context) {
  final isLoading = context.watch<SupabaseProvider>().isLoading;

  return Scaffold(
    body: Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        gradient: RadialGradient(
          center: Alignment.center,
          radius: 0.8,
          colors: [
            Color(0xFFE0F2FE), // Azul muy claro (centro)
            Color(0xFF3B82F6), // Azul intermedio
            Color(0xFF1D4ED8), // Azul más oscuro (bordes)
          ],
          stops: [0.0, 0.6, 1.0],
        ),
      ),
      child: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight - 48, // Centra ocupando todo el alto disponible
                ),
                child: IntrinsicHeight(
                  child: Center(
                    child: Container(
                      constraints: const BoxConstraints(maxWidth: 450),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center, // AHORA SÍ CENTRA VERTICALMENTE
                        children: [
                          const Text(
                            'Asamblea de Dios GALAAD',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white,
                            fontWeight: FontWeight.bold,
                            
                            fontSize: 35
                            ),
                          ),
                          const Text(
                            'Sistema de Puntuación de la Escuela Bíblica de Vacaciones',
                            textAlign: TextAlign.center,
                            
                            style: TextStyle(color: Colors.white,
                            fontWeight: FontWeight.normal,
                            
                            fontSize: 18
                            ),
                          ),
                          const SizedBox(height: 32),
                          Image.asset(
                            'assets/img/LOGO.png',
                            width: MediaQuery.of(context).size.width * 0.3,
                          ),
                          const SizedBox(height: 80),
                          TextField(
                            controller: _pinController,
                            keyboardType: TextInputType.number,
                            obscureText: true,
                            maxLength: 6,
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 24, letterSpacing: 8, color: CupertinoColors.black),
                            decoration: InputDecoration(
                              labelText: 'Ingresa tu PIN',
                              labelStyle: TextStyle(
                                color: CupertinoColors.black
                              ),
                              

                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(35),
                                
                              ),
                              counterText: '',
                            ),
                          ),
                          const SizedBox(height: 20),
                          isLoading
                              ? const CircularProgressIndicator()
                              : ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.amber,
                                    minimumSize: const Size.fromHeight(50),
                                  ),
                                  onPressed: _login,
                                  child: const Text(
                                    'INGRESAR',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                          const SizedBox(height: 16),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const ProyectorScreen(),
                                ),
                              );
                            },
                            child: const Text(
                              'Abrir Modo Proyector / Tablero',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    ),
  );
}
}