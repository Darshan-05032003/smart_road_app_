import 'package:flutter/material.dart';
import 'package:smart_roadside/Login/GarageLoginScreen.dart';
import 'package:smart_roadside/Login/InsuranceLogin.dart';
import 'package:smart_roadside/Login/ToeProviderLogin.dart';
import 'package:smart_roadside/Login/VehicleOwneLogin.dart';
import 'package:smart_roadside/Login/adminLogin.dart';


class RoleSelectionScreen extends StatefulWidget {
  const RoleSelectionScreen({super.key});

  @override
  State<RoleSelectionScreen> createState() => _RoleSelectionScreenState();
}

class _RoleSelectionScreenState extends State<RoleSelectionScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> fadeAnimation;
  late Animation<double> slideAnimation;
  late Animation<double> scaleAnimation;
  late Animation<Color?> colorAnimation;
 
  

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.0, 0.6, curve: Curves.easeInOut),
      ),
    );

    slideAnimation = Tween<double>(begin: 80.0, end: 0.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.2, 0.8, curve: Curves.easeOutCubic),
      ),
    );

    scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.3, 1.0, curve: Curves.elasticOut),
      ),
    );

    colorAnimation = ColorTween(
      begin: const Color(0xFF6A11CB),
      end: const Color(0xFF2575FC),
    ).animate(CurvedAnimation(
      parent: controller,
      curve: Curves.easeInOut,
    ));

    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
// safe



    // Responsive helpers
    final size = MediaQuery.of(context).size;
    final isTablet = size.width > 600;
    final crossAxisCount = isTablet ? 3 : 2;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            double textScale = (constraints.maxWidth / 400).clamp(0.8, 1.4);

            return Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.white,
                    Colors.grey[50]!,
                    // ignore: deprecated_member_use
                    Colors.purple[50]!.withOpacity(0.3),
                  ],
                ),
              ), 
              child: Padding(
                padding: EdgeInsets.all(isTablet ? 32.0 : 20.0),
                child: AnimatedBuilder(
                  animation: controller,
                  builder: (context, child) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Transform.translate(
                          offset: Offset(0, slideAnimation.value),
                          child: FadeTransition(
                            opacity: fadeAnimation,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 4,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            const Color(0xFF8A2BE2),
                                            colorAnimation.value!,
                                          ],
                                        ),
                                        borderRadius: BorderRadius.circular(2),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Text(
                                        'Choose Your Role',
                                        style: TextStyle(
                                          fontSize: 28 * textScale,
                                          fontWeight: FontWeight.w800,
                                          color: Colors.purple[900],
                                          letterSpacing: -0.8,
                                          shadows: [
                                            Shadow(
                                              blurRadius: 10,
                                              color: Colors.purple
                                                  // ignore: deprecated_member_use
                                                  .withOpacity(0.1),
                                              offset: const Offset(2, 2),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                Padding(
                                  padding: const EdgeInsets.only(left: 16),
                                  child: Text(
                                    'Select how you want to use AutoConnect ecosystem',
                                    style: TextStyle(
                                      fontSize: 14 * textScale,
                                      color: Colors.grey[700],
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: isTablet ? 50 : 30),
                        Expanded(
                          child: FadeTransition(
                            opacity: fadeAnimation,
                            child: GridView.count(
                              crossAxisCount: crossAxisCount,
                              crossAxisSpacing: 20,
                              mainAxisSpacing: 20,
                              childAspectRatio: isTablet ? 1 : 0.85,
                              padding:
                                  const EdgeInsets.only(bottom: 20, top: 10),
                              children: [
                                _buildEnhancedRoleCard(
                                  icon: Icons.directions_car_rounded,
                                  title: 'Vehicle Owner',
                                  subtitle: 'Car owner or driver',
                                  color: const Color(0xFF6366F1),
                                  index: 0,
                                  textScale: textScale,
                                ),
                                _buildEnhancedRoleCard(
                                  icon: Icons.build_circle_rounded,
                                  title: 'Garage/Mechanic',
                                  subtitle: 'Auto repair shop',
                                  color: const Color(0xFFF59E0B),
                                  index: 1,
                                  textScale: textScale,
                                ),
                                _buildEnhancedRoleCard(
                                  icon: Icons.local_shipping_rounded,
                                  title: 'Tow Provider',
                                  subtitle: 'Towing services',
                                  color: const Color(0xFF10B981),
                                  index: 2,
                                  textScale: textScale,
                                ),
                                _buildEnhancedRoleCard(
                                  icon: Icons.security_rounded,
                                  title: 'Insurance Comp',
                                  subtitle: 'Insurance',
                                  color: const Color(0xFFEF4444),
                                  index: 3,
                                  textScale: textScale,
                                ),
                                _buildEnhancedRoleCard(
                                  icon: Icons.admin_panel_settings_rounded,
                                  title: 'Admin',
                                  subtitle: 'System administrator',
                                  color: const Color(0xFF8B5CF6),
                                  index: 4,
                                  textScale: textScale,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }

 Widget _buildEnhancedRoleCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required int index,
    required double textScale,
  }) {
   
   

    return ScaleTransition(
      scale: scaleAnimation,
      child: Transform.translate(
        offset: Offset(0, slideAnimation.value * (1 + index * 0.15)),
        child: InkWell(
          onTap: () => handleEnhancedRoleSelection(title, color),
          borderRadius: BorderRadius.circular(24),
          // ignore: deprecated_member_use
          splashColor: color.withOpacity(0.2),
          // ignore: deprecated_member_use
          highlightColor: color.withOpacity(0.1),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                
                
                  color: color.withOpacity(0.25),
                  blurRadius: 20,
                  spreadRadius: 1,
                  offset: const Offset(0, 8),
                ),
              ],
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [


                  // ignore: deprecated_member_use
                  color.withOpacity(0.08),
                  // ignore: deprecated_member_use
                  color.withOpacity(0.02),
                  Colors.white,
                ],
              ),
              border: Border.all(
                // ignore: deprecated_member_use
                color: color.withOpacity(0.1),
                width: 1,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [
                         
                          // ignore: deprecated_member_use
                          color.withOpacity(0.15),
                          // ignore: deprecated_member_use
                          color.withOpacity(0.05),
                        ], 
                      ),
                    ),
                    child: Icon(icon, size: 36, color: color),
                  ),
                  SizedBox(height: 18 * textScale),
                  ShaderMask(
                    shaderCallback: (bounds) => LinearGradient(
                      colors: [color, darkenColor(color, 0.3)],
                    ).createShader(bounds),
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 15 * textScale,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 6 * textScale),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12 * textScale,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                      height: 1.3,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void handleEnhancedRoleSelection(String role, Color color) {
    Future.delayed(const Duration(milliseconds: 400), () {
      switch (role) {
        case 'Vehicle Owner':
          Navigator.push(
              // ignore: use_build_context_synchronously
              context,
               MaterialPageRoute(builder: (context) => VehicleLoginPage()));
          break;
        case 'Garage/Mechanic':
          Navigator.push(
            // ignore: use_build_context_synchronously
              context, MaterialPageRoute(builder: (context) => GarageLoginPage()));
          break;
        case 'Tow Provider':
          Navigator.push(
            // ignore: use_build_context_synchronously
              context, MaterialPageRoute(builder: (context) => TowProviderLoginPage()));
          break;
        case 'Insurance Comp':
          Navigator.push(
            // ignore: use_build_context_synchronously
              context, MaterialPageRoute(builder: (context) => InsuranceLoginPage()));
          break;
        case 'Admin':
          Navigator.push(
            // ignore: use_build_context_synchronously
              context, MaterialPageRoute(builder: (context) => AdminLoginPage()));
          break;
      }
    });
  }

  Color darkenColor(Color color, [double amount = 0.1]) {
    final hsl = HSLColor.fromColor(color);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));
    return hslDark.toColor();
  }
}
