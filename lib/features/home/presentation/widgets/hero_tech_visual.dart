import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

/// Abstract technology composition inspired by Java architecture, Flutter UI,
/// and AI workflows. Built entirely with Flutter widgets, CustomPainters, and
/// ambient glow effects without relying on remote images or fabricated portraits.
class HeroTechVisual extends StatefulWidget {
  const HeroTechVisual({super.key});

  @override
  State<HeroTechVisual> createState() => _HeroTechVisualState();
}

class _HeroTechVisualState extends State<HeroTechVisual>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animController;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animController,
      builder: (context, child) {
        final animValue = _animController.value;
        final floatOffset = math.sin(animValue * 2 * math.pi) * 8.0;

        return FittedBox(
          fit: BoxFit.scaleDown,
          child: SizedBox(
            width: 480,
            height: 480,
            child: Stack(
              alignment: Alignment.center,
              children: [
            // Ambient radial background glow
            Container(
              width: 480,
              height: 480,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.accentViolet.withValues(alpha: 0.18),
                    AppColors.accentBlue.withValues(alpha: 0.10),
                    Colors.transparent,
                  ],
                  stops: const [0.0, 0.5, 1.0],
                ),
              ),
            ),

            // Subtle rotating tech grid rings
            Transform.rotate(
              angle: animValue * 2 * math.pi * 0.05,
              child: CustomPaint(
                size: const Size(440, 440),
                painter: _TechOrbitPainter(),
              ),
            ),

            // Main Core Glass Terminal Card
            Transform.translate(
              offset: Offset(0, floatOffset),
              child: Container(
                width: 420,
                constraints: const BoxConstraints(maxWidth: 440),
                decoration: BoxDecoration(
                  color: AppColors.surfacePrimary.withValues(alpha: 0.92),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: AppColors.accentViolet.withValues(alpha: 0.4),
                    width: 1.2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.accentViolet.withValues(alpha: 0.2),
                      blurRadius: 30,
                      spreadRadius: -5,
                      offset: const Offset(0, 10),
                    ),
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.5),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Terminal header bar
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceSecondary,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                        ),
                        border: Border(
                          bottom: BorderSide(
                            color: AppColors.borderSubtle,
                            width: 1,
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          _buildDot(const Color(0xFFEF4444)),
                          const SizedBox(width: 8),
                          _buildDot(const Color(0xFFF59E0B)),
                          const SizedBox(width: 8),
                          _buildDot(const Color(0xFF10B981)),
                          const Spacer(),
                          Row(
                            children: [
                              const Icon(
                                Icons.auto_awesome_rounded,
                                size: 14,
                                color: AppColors.accentViolet,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                'Engine.java • AI Pipeline',
                                style: AppTypography.eyebrow(
                                  color: AppColors.textSecondary,
                                ).copyWith(fontSize: 11),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // Code Snippet Body
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildCodeLine('1', [
                            const _Token('@Service', AppColors.accentViolet),
                            const _Token(' public class ', AppColors.accentBlue),
                            const _Token('PortfolioEngine', AppColors.textPrimary),
                            const _Token(' {', AppColors.textSecondary),
                          ]),
                          const SizedBox(height: 6),
                          _buildCodeLine('2', [
                            const _Token('    @Autowired', AppColors.accentViolet),
                          ]),
                          const SizedBox(height: 6),
                          _buildCodeLine('3', [
                            const _Token('    private ', AppColors.accentBlue),
                            const _Token('AIWorkflow', AppColors.accentCyan),
                            const _Token(' aiPipeline;', AppColors.textPrimary),
                          ]),
                          const SizedBox(height: 6),
                          _buildCodeLine('4', [
                            const _Token('    public ', AppColors.accentBlue),
                            const _Token('Experience ', AppColors.accentCyan),
                            const _Token('build() {', AppColors.textSecondary),
                          ]),
                          const SizedBox(height: 6),
                          _buildCodeLine('5', [
                            const _Token('        return ', AppColors.accentBlue),
                            const _Token('new ', AppColors.accentViolet),
                            const _Token('FlutterWebUX(', AppColors.textPrimary),
                            const _Token('"Clean Architecture"', AppColors.accentEmerald),
                            const _Token(');', AppColors.textSecondary),
                          ]),
                          const SizedBox(height: 6),
                          _buildCodeLine('6', [
                            const _Token('    }', AppColors.textSecondary),
                          ]),
                          const SizedBox(height: 6),
                          _buildCodeLine('7', [
                            const _Token('}', AppColors.textSecondary),
                          ]),
                          const SizedBox(height: 16),

                          // Live execution status badge
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(
                              color: AppColors.surfaceSecondary,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: AppColors.accentEmerald.withValues(alpha: 0.3),
                                width: 1,
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 8,
                                  height: 8,
                                  decoration: const BoxDecoration(
                                    color: AppColors.accentEmerald,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Flexible(
                                  child: Text(
                                    'Status: Systems Operational • Ready to Build',
                                    overflow: TextOverflow.ellipsis,
                                    style: AppTypography.eyebrow(
                                      color: AppColors.accentEmerald,
                                    ).copyWith(fontSize: 11),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Floating Satellite Pill: Java Architecture
            Positioned(
              top: 15,
              left: 10,
              child: _FloatingPill(
                icon: Icons.coffee_rounded,
                label: 'Java 21 • Enterprise',
                accentColor: AppColors.accentCyan,
                offsetY: -floatOffset * 0.8,
              ),
            ),

            // Floating Satellite Pill: UI/UX & Flutter
            Positioned(
              bottom: 25,
              right: 10,
              child: _FloatingPill(
                icon: Icons.flutter_dash_rounded,
                label: 'Flutter Web • Modern UI/UX',
                accentColor: AppColors.accentBlue,
                offsetY: floatOffset * 0.9,
              ),
            ),

            // Floating Satellite Pill: AI Pipeline
            Positioned(
              bottom: 45,
              left: 15,
              child: _FloatingPill(
                icon: Icons.psychology_rounded,
                label: 'AI-Augmented Engineering',
                accentColor: AppColors.accentViolet,
                offsetY: -floatOffset * 0.6,
              ),
            ),
          ],
        ),
      ),
    );
      },
    );
  }

  Widget _buildDot(Color color) {
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _buildCodeLine(String lineNum, List<_Token> tokens) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 24,
          child: Text(
            lineNum,
            style: AppTypography.codeSnippet(color: AppColors.textMuted),
          ),
        ),
        Expanded(
          child: RichText(
            text: TextSpan(
              children: tokens
                  .map(
                    (t) => TextSpan(
                      text: t.text,
                      style: AppTypography.codeSnippet(color: t.color),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}

class _Token {
  final String text;
  final Color color;
  const _Token(this.text, this.color);
}

class _FloatingPill extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color accentColor;
  final double offsetY;

  const _FloatingPill({
    required this.icon,
    required this.label,
    required this.accentColor,
    required this.offsetY,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(0, offsetY),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.surfacePrimary.withValues(alpha: 0.95),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: accentColor.withValues(alpha: 0.5),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: accentColor.withValues(alpha: 0.25),
              blurRadius: 14,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 15, color: accentColor),
            const SizedBox(width: 8),
            Text(
              label,
              style: AppTypography.eyebrow(color: AppColors.textPrimary).copyWith(
                fontSize: 11,
                letterSpacing: 0.8,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TechOrbitPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final paintRing1 = Paint()
      ..color = AppColors.accentViolet.withValues(alpha: 0.15)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    final paintRing2 = Paint()
      ..color = AppColors.accentBlue.withValues(alpha: 0.10)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    canvas.drawCircle(center, size.width * 0.42, paintRing1);
    canvas.drawCircle(center, size.width * 0.48, paintRing2);

    // Decorative tick marks
    final tickPaint = Paint()
      ..color = AppColors.accentViolet.withValues(alpha: 0.25)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    for (int i = 0; i < 8; i++) {
      final angle = (i * math.pi / 4);
      final r1 = size.width * 0.40;
      final r2 = size.width * 0.44;
      final p1 = Offset(center.dx + r1 * math.cos(angle), center.dy + r1 * math.sin(angle));
      final p2 = Offset(center.dx + r2 * math.cos(angle), center.dy + r2 * math.sin(angle));
      canvas.drawLine(p1, p2, tickPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
