import 'package:flutter/material.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  final String? subtitle;
  final VoidCallback? onTap;
  final String? badge;
  final String? highlightWord; // الكلمة اللي تتلوّن بالبراند

  const SectionTitle({
    super.key,
    required this.title,
    this.subtitle,
    this.onTap,
    this.badge,
    this.highlightWord,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ─── Accent Bar ──────────────────────────────
          Container(
            width: 4,
            height: _barHeight(),
            margin: const EdgeInsetsDirectional.only(end: 12, top: 2),
            decoration: BoxDecoration(
              color: const Color(0xFF6B4FD4),
              borderRadius: BorderRadius.circular(4),
            ),
          ),

          // ─── Text Section ────────────────────────────
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Badge
                if (badge != null) ...[
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 2),
                    margin: const EdgeInsets.only(bottom: 6),
                    decoration: BoxDecoration(
                      color: const Color(0xFF6B4FD4).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      badge!,
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF6B4FD4),
                            letterSpacing: 0.3,
                          ),
                    ),
                  ),
                ],

                // Title with optional highlighted word
                _buildTitle(context),

                // Underline accent
                Container(
                  margin: const EdgeInsets.only(top: 5),
                  height: 3,
                  width: 120,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Colors.transparent,Color(0xFF6B4FD4)],
                    ),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),

                // Subtitle
                if (subtitle != null) ...[
                  const SizedBox(height: 5),
                  Text(
                    subtitle!,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: const Color(0xFF8A8A9A),
                          fontWeight: FontWeight.w500,
                          height: 1.4,
                        ),
                  ),
                ],
              ],
            ),
          ),

          // ─── View All Button ─────────────────────────
          if (onTap != null)
            Padding(
              padding: const EdgeInsets.only(top: 28),
              child: InkWell(
                onTap: onTap,
                borderRadius: BorderRadius.circular(8),
                splashColor: const Color(0xFF6B4FD4).withValues(alpha: 0.08),
                highlightColor: Colors.transparent,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 4, vertical: 4),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children:  [
                      Text(
                        'عرض الكل',
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF6B4FD4),
                            ),
                      ),
                      SizedBox(width: 2),
                      Icon(
                        Localizations.localeOf(context).languageCode == 'ar'
                            ? Icons.arrow_forward_ios_rounded
                            : Icons.arrow_back_ios_rounded,
                        size: 13,
                        color: Color(0xFF6B4FD4),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  double _barHeight() {
    double h = 26;
    if (badge != null) h += 22;
    if (subtitle != null) h += 22;
    return h;
  }

  Widget _buildTitle(BuildContext context) {
    if (highlightWord == null || !title.contains(highlightWord!)) {
      return Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontSize: 22,
              fontWeight: FontWeight.w900,
              color: const Color(0xFF0A0A18),
              height: 1.2,
              letterSpacing: -0.5,
            ),
      );
    }

    final parts = title.split(highlightWord!);
    return RichText(
      text: TextSpan(
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              // fontSize: 22,
              fontWeight: FontWeight.w900,
              color: const Color(0xFF0A0A18),
              height: 1.2,
              letterSpacing: -0.5,
            ),
        children: [
          TextSpan(text: parts[0]),
          TextSpan(
            text: highlightWord,
            style: const TextStyle(color: Color(0xFF6B4FD4)),
          ),
          TextSpan(text: parts[1]),
        ],
      ),
    );
  }
}
