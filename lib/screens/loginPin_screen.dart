import 'package:ebv_ad_galaad_2026/screens/home_screen_spliter.dart';
import 'package:ebv_ad_galaad_2026/proyector_screen.dart';
import 'package:ebv_ad_galaad_2026/providers/supabase_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MobileLoginPinScreen extends StatefulWidget {
  const MobileLoginPinScreen({super.key});

  @override
  State<MobileLoginPinScreen> createState() => _MobileLoginPinScreenState();
}

class _MobileLoginPinScreenState extends State<MobileLoginPinScreen> {
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
            builder: (_) => HomeScreenSpliterView (profesor: provider.profesorActual!),
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
    final isLoading = context.watch<SupabaseProvider >().isLoading;

    final double fontSizeLarge = 24.0;
    final double fontSize = 14.0;
    final double fontSmall = 12.0;

    return Scaffold(
      
      body: Center(

        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: CustomScrollView(
            slivers: [
          
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  spacing: 16.0,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                
                    Text(
                              'Asamblea de Dios GALAAD',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white,
                              fontWeight: FontWeight.bold,
                              
                              fontSize: fontSizeLarge
                              ),
                            ),
                        Text(
                              'Sistema de Puntuación de la Escuela Bíblica de Vacaciones',
                              textAlign: TextAlign.center,
                              
                              style: TextStyle(color: Colors.white,
                              fontWeight: FontWeight.normal,
                              
                              fontSize: fontSize
                              ),
                            ),
                            const SizedBox(height: 32),
                            Image.asset(
                              'assets/img/LOGO.png',
                              width: MediaQuery.of(context).size.width * 0.8,
                            ),
                            const SizedBox(height: 40),
                            TextField(
                              controller: _pinController,
                              
                              keyboardType: TextInputType.number,
                              obscureText: true,
                              maxLength: 6,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: fontSize, 
                                letterSpacing: 8, color: CupertinoColors.white),
                              decoration: InputDecoration(
                                labelText: 'Ingresa tu PIN',
                                labelStyle: TextStyle(
                                  color: CupertinoColors.white,
                                  fontSize: fontSize
                                ),
                                
                
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(35),
                                  
                                ),
                                counterText: '',
                              ),
                            ),
                            //const SizedBox(height: 20),
                            isLoading
                                ? const CircularProgressIndicator()
                                : ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: CupertinoColors.activeBlue,
                                      minimumSize: const Size.fromHeight(50),
                                    ),
                                    onPressed: _login,
                                    child: Text(
                                      'INGRESAR',
                                      style: TextStyle(
                                        color: CupertinoColors.white,
                                        fontSize: fontSize,
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
                              child: Text(
                                'Abrir Modo Proyector / Tablero',
                                style: TextStyle(color: Colors.white,
                                fontSize: fontSize),
                              ),
                            ),
                
                  ],
                ),
              )
          
            ]
          ),
        ),
      ),
    );
  }
}