import 'package:flutter/material.dart';
import 'package:yosrixia/core/utils/styles.dart';
import 'package:yosrixia/features/child/tips/views/tips_title.dart';

class TipsViewBody extends StatelessWidget {
  const TipsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              spacing: 15,
              children: [
                const SizedBox(height: 20),
                const TipsTitle(),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    children: [
                      Text(
                        "• حاول ألا يتعدى استخدام الطفل للهاتف أكثر من ساعة فاليوم.",
                        style: Styles.textStyle32.copyWith(height: 1.2),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        "• التشجيع الإيجابي: ركز على التقدم بدلاً من الكمال. عندما يحقق الطفل إنجازًا صغيرًا، أشِد به وأظهر له أنك فخور.",
                        style: Styles.textStyle32.copyWith(height: 1.2),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        "• تحفيز الثقة بالنفس: قم بإشراك الطفل في أنشطة يجيدها بجانب القراءة والكتابة (مثل الرسم أو الرياضة)، لتعزيز ثقته بنفسه.",
                        style: Styles.textStyle32.copyWith(height: 1.2),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        "• التحدث مع الطفل: استمع إلى مشاعره ومخاوفه، وكن صبورًا. الشعور بالدعم العاطفي يساعدهم على التغلب على القلق المرتبط بالتعلم.",
                        style: Styles.textStyle32.copyWith(height: 1.2),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        "• تحدي الوقت: اطلب من الطفل قراءة أو كتابة عدد معين من الكلمات في وقت محدد لجعل النشاط أكثر إثارة.",
                        style: Styles.textStyle32.copyWith(height: 1.2),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        "• دمج القراءة في الروتين اليومي: اطلب من الطفل قراءة اللافتات، قائمة التسوق، أو أسماء المنتجات أثناء التسوق.",
                        style: Styles.textStyle32.copyWith(height: 1.2),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        "• احضري لطفلك صلصال أو أي نوع من أنواع العجائن لكي يشكل بيده الحرف.",
                        style: Styles.textStyle32.copyWith(height: 1.2),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        "• احضري لطفلك طبق به رمل وأطلبي منه أن يكتب الحرف بإصبعه على الرمل.",
                        style: Styles.textStyle32.copyWith(height: 1.2),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        "• أحضري ورق مقوى مختلف الألوان ومقص وساعديه في قص الحرف.",
                        style: Styles.textStyle32.copyWith(height: 1.2),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        "• اجعلي طفلك يتخيل ويكتب الحرف في الهواء بإصبعه.",
                        style: Styles.textStyle32.copyWith(height: 1.2),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        "• إملاء بسيط: أملي كلمات بسيطة تتكون من حروف وأصوات يعرفها الطفل.",
                        style: Styles.textStyle32.copyWith(height: 1.2),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        "• لعبة الأصوات: قم بنطق أصوات الحروف بشكل منفصل واطلب من الطفل تجميعها لتكوين كلمة.",
                        style: Styles.textStyle32.copyWith(height: 1.2),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        "• استخدم أغاني الأطفال التعليمية التي تركز على أصوات الحروف ومقاطع الكلمات.",
                        style: Styles.textStyle32.copyWith(height: 1.2),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        "• اللعب بالألعاب الحسية مثل المكعبات أو الألعاب المغناطيسية التي تحتوي على الحروف.",
                        style: Styles.textStyle32.copyWith(height: 1.2),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        "• صنع الكلمات باستخدام قطع البازل أو المكعبات الملونة التي تحتوي على حروف.",
                        style: Styles.textStyle32.copyWith(height: 1.2),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        "• لعبة القفز على الحروف: ضع الحروف على الأرض واطلب من الطفل القفز على الحرف الذي تسميه.",
                        style: Styles.textStyle32.copyWith(height: 1.2),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        "• اجعل الأنشطة قصيرة وممتعة لتجنب شعور الطفل بالإرهاق.",
                        style: Styles.textStyle32.copyWith(height: 1.2),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        "• اجعل النشاط مشوقًا بإضافة مكافآت عند الإجابة الصحيحة.",
                        style: Styles.textStyle32.copyWith(height: 1.2),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
