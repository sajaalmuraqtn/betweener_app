import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

 
class ProfileView extends StatelessWidget {
    static String id = '/profileView';

  const ProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(
            color: Color(0xFF2B2B4F),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildProfileCard(),
            const SizedBox(height: 20),
            
            // رابط عادي (غير قابل للتمرير)
            _buildSocialLinkContent(
              platform: 'INSTAGRAM',
              url: 'https://www.instagram.com/a7medhq/',
              color: Colors.pink[100]!,
            ),
            const SizedBox(height: 10),

             _buildSlidableSocialLink(
              platform: 'M',
              url: 'https://www.medium.com/a7medhq/',
              color: Colors.blue[100]!,
            ),
            const SizedBox(height: 10),
            
            // رابط آخر قابل للتمرير
            _buildSlidableSocialLink(
              platform: 'INSTAGRAM',
              url: 'https://www.instagram.com/another_handle/',
              color: Colors.pink[100]!,
            ),
            const SizedBox(height: 10),

            _buildSocialLinkContent(
              platform: 'INSTAGRAM',
              url: 'https://www.instagram.com/yet_another/',
              color: Colors.deepPurple[100]!,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // الانتقال إلى شاشة إضافة رابط
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddLinkScreen()),
          );
        },
        backgroundColor: const Color(0xFF2B2B4F),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  // بناء بطاقة الملف الشخصي
  Widget _buildProfileCard() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: const Color(0xFF2B2B4F),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CircleAvatar(
            radius: 40,
            backgroundImage: NetworkImage('https://i.ibb.co/L9H8FvX/profile-pic.png'), // صورة افتراضية
            backgroundColor: Colors.white,
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text(
                      'John Doe',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.white70),
                      onPressed: () {},
                    ),
                  ],
                ),
                const Text(
                  'example@gmail.com',
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
                const Text(
                  '+9700000000',
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    _buildFollowInfo('Followers', '200'),
                    const SizedBox(width: 10),
                    _buildFollowInfo('Following', '100'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // بناء معلومات المتابعة
  Widget _buildFollowInfo(String label, String count) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: const Color(0xFFFDD835), // اللون الأصفر
        borderRadius: BorderRadius.circular(15),
      ),
      child: Text(
        '$label $count',
        style: const TextStyle(
          color: Colors.black87,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
  
  // =======================================================
  // دوال الروابط القابلة للتمرير (Slidable)
  // =======================================================

  // المحتوى الأساسي لبطاقة الرابط (يستخدم داخل Slidable)
  Widget _buildSocialLinkContent({
    required String platform,
    required String url,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  platform,
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  url,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // بناء عنصر Slidable Wrapper
  Widget _buildSlidableSocialLink({
    required String platform,
    required String url,
    required Color color,
  }) {
    return Slidable(
      key: ValueKey(url), // مفتاح لكل عنصر Slidable
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        extentRatio: 0.35, // نسبة مساحة الأزرار الظاهرة
        children: [
          // 1. زر التعديل (الأصفر)
          SlidableAction(
            onPressed: (context) {
              print('Edit pressed for $platform');
            },
            backgroundColor: const Color(0xFFFDD835), // الأصفر
            foregroundColor: Colors.white,
            icon: Icons.edit,
            borderRadius: BorderRadius.circular(15),
          ),
          // 2. زر الحذف (الأحمر)
          SlidableAction(
            onPressed: (context) {
              print('Delete pressed for $platform');
            },
            backgroundColor: const Color(0xFFEF5350), // الأحمر
            foregroundColor: Colors.white,
            icon: Icons.delete,
            borderRadius: BorderRadius.circular(15),
          ),
        ],
      ),
      // المحتوى الذي يظهر أولاً
      child: _buildSocialLinkContent(
        platform: platform,
        url: url,
        color: color,
      ),
    );
  }
}

// =======================================================
// 2. شاشة إضافة رابط (AddLinkScreen)
// =======================================================

class AddLinkScreen extends StatelessWidget {
  final TextEditingController _titleController = TextEditingController(text: 'Snapchat');
  final TextEditingController _linkController = TextEditingController(text: 'http://www.Example.com');

  AddLinkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF2B2B4F)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Add Link',
          style: TextStyle(
            color: Color(0xFF2B2B4F),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // حقل العنوان
            const Text(
              'title',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2B2B4F),
              ),
            ),
            const SizedBox(height: 8),
            _buildInputField(_titleController),
            
            const SizedBox(height: 20),

            // حقل الرابط
            const Text(
              'link',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2B2B4F),
              ),
            ),
            const SizedBox(height: 8),
            _buildInputField(_linkController, keyboardType: TextInputType.url),

            const Spacer(),

            // زر الإضافة
            _buildAddButton(context),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // بناء حقل الإدخال
  Widget _buildInputField(TextEditingController controller, {TextInputType keyboardType = TextInputType.text}) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFF2B2B4F), width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFF2B2B4F), width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.deepPurple, width: 2.0),
        ),
      ),
    );
  }

  // بناء زر الإضافة
  Widget _buildAddButton(BuildContext context) {
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.7,
        height: 50,
        child: ElevatedButton(
          onPressed: () {
            print('Adding Link: ${_linkController.text}');
            // هنا يمكنك إضافة منطق حفظ البيانات والعودة
            Navigator.pop(context); 
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFFDD835), // اللون الأصفر
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 2,
          ),
          child: const Text(
            'ADD',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2B2B4F),
            ),
          ),
        ),
      ),
    );
  }
}