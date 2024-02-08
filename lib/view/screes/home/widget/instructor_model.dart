class InstructorItem {
  String instructorName,
      instructorPicture,
      instructorCategory,
      instructorStudents,
      instructorCourses,
      instructorRating;

  InstructorItem(
      {required this.instructorName,required this.instructorPicture, required this.instructorCategory, required
      this.instructorStudents, required this.instructorCourses, required this.instructorRating});

}

List<InstructorItem> instructors = [
  InstructorItem(
      instructorName: 'Albert Flores',
      instructorPicture: 'images/lms/instructor1.png',
      instructorCategory: 'Lifestyle',
      instructorStudents: '20k',
      instructorCourses: '17',
      instructorRating: '(4.5)'
  ),
  InstructorItem(
      instructorName: 'Annette Black',
      instructorPicture: 'images/lms/instructor2.png',
      instructorCategory: 'Graphic Design',
      instructorStudents: '80k',
      instructorCourses: '32',
      instructorRating: '(4.5)'
  ),
  InstructorItem(
      instructorName: 'Jerome Bell',
      instructorPicture: 'images/lms/instructor3.png',
      instructorCategory: 'Health',
      instructorStudents: '40k',
      instructorCourses: '27',
      instructorRating: '(4.5)'
  ),
  InstructorItem(
      instructorName: 'Eleanor Pena',
      instructorPicture: 'images/lms/instructor4.png',
      instructorCategory: 'Lifestyle',
      instructorStudents: '20k',
      instructorCourses: '17',
      instructorRating: '(4.5)'
  ),
  InstructorItem(
      instructorName: 'Eleanor Pena',
      instructorPicture: 'images/lms/instructor5.png',
      instructorCategory: 'Photography',
      instructorStudents: '20k',
      instructorCourses: '14',
      instructorRating: '(4.6)'
  ),
  InstructorItem(
      instructorName: 'Jenny Wilson',
      instructorPicture: 'images/lms/instructor6.png',
      instructorCategory: 'Programming',
      instructorStudents: '70k',
      instructorCourses: '23',
      instructorRating: '(4.3)'
  ),
  InstructorItem(
      instructorName: 'Wade Warren',
      instructorPicture: 'images/lms/instructor7.png',
      instructorCategory: 'Music',
      instructorStudents: '30k',
      instructorCourses: '19',
      instructorRating: '(4.9)'
  ),
  InstructorItem(
      instructorName: 'Arlene McCoy',
      instructorPicture: 'images/lms/instructor8.png',
      instructorCategory: 'Marketing',
      instructorStudents: '10k',
      instructorCourses: '12',
      instructorRating: '(4.8)'
  ),
];
