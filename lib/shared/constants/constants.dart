import 'package:firebase_auth/firebase_auth.dart';

String? uId;

User? userConst;

String defaultDropDownListValue = "--Select--";

List<String> citiesList = [
  "--Select--",
  "Cairo",
  "Alexandria",
  "Gizeh",
  "Shubra El-Kheima",
  "Port Said",
  "Suez",
  "Luxor",
  "al-Mansura",
  "El-Mahalla El-Kubra",
  "Tanta",
  "Asyut",
  "Ismailia",
  "Fayyum",
  "Zagazig",
  "Aswan",
  "Damietta",
  "Damanhur",
  "al-Minya",
  "Beni Suef",
  "Qena",
  "Sohag",
  "Hurghada",
  "6th of October City",
  "Shibin El Kom",
  "Banha",
  "Kafr el-Sheikh",
  "Arish",
  "Mallawi",
  "10th of Ramadan City",
  "Bilbais",
  "Marsa Matruh",
  "Idfu",
  "Mit Ghamr",
  "Al-Hamidiyya",
  "Desouk",
  "Qalyub",
  "Abu Kabir",
  "Kafr el-Dawwar",
  "Girga",
  "Akhmim",
  "Matareya"
];
List<String> countriesList = [
  "--Select--",
  "United States",
  "Canada",
  "Afghanistan",
  "Albania",
  "Algeria",
  "American Samoa",
  "Andorra",
  "Angola",
  "Anguilla",
  "Antarctica",
  "Antigua and/or Barbuda",
  "Argentina",
  "Armenia",
  "Egypt"
];
List<String> jopTitlesList = [
  "--Select--",
  "IT",
  "front end web Developer",
  "Web Developer",
  "Integration",
  "IT Application Integration Technology Technical Manager",
  "full stack intern",
  "Embedded Software Engineer",
  "SaaS AI invoicing & estimate platform - Contractors",
  "Azure Synape Microsoft Arthitect/Engineer",
  "Core-java-tutor",
  "UI/UX designer",
  "Finance",
  "Business Systems Analyst",
  "Permanent Part-Time Sales Assistant",
  "Sales Assistant",
  "Finance Assistance",
  "Sales Consultant at Liberty",
  "accountant",
  "Internal Sales",
  "Client Services Store Co-ordinator",
  "Group Marketing Manager",
  "Medicine",
  "medical senior officer",
  "Quayside Superintendent",
  "patient safety specialist",
  "medical representative",
  "Other",
  "Recruitment Specialist"
      "Driver",
  "receptionist",
  "Head of Pre School in London UK",
  "Customer Service Consultant",
  "Vessel Manager x 2",
  "college management system",
  "social media moderator",
];
List<String> gradesList = ["--Select--", 'Excellent', 'Very Good', 'Good'];
List<String> nationalityList = [
  "--Select--",
  'Egyptian',
  'American',
  'Canadian',
  'Russian',
  'Australian',
  'Bahamaian',
  'Brazilian',
  'French',
  'Greek'
];
List<String> experienceLevel = ["--Select--", "0-1 years", "2-4 years", "5-10 years", "10+ years"];
List<String> jopType = ["--Select--", "Full-Time", 'Remote', "Part-Time", "Contract"];
List<String> genderList = ["--Select--", "Male", "Female"];
List<String> uniList = [
  "--Select--",
  "Cairo University",
  "Mansoura University",
  "Ain Shams University",
  "Alexandria University",
  "Kafrelsheikh University",
  "AAST",
  "Al Azhar University",
  "MTI",
  "MSA",
  "Modern Academy"
];
List<String> educationLevelsList = ["--Select--", "Masters", "PHD", 'Bachelors'];
List<String> facultiesList = [
  "--Select--",
  "computer science",
  "Engineering",
  'bussiness',
  'Medicine',
  'Law',
  'Art',
  'Mass Communication'
];
List<String> positionsList = [
  "--Select--",
  "Team leader",
  "Manager",
  'Administrative assistant',
  'Business analyst',
  'Sales representative',
  'Marketing manager',
  'Product manager',
  'Software engineer',
  'Project Manager',
  'Marketing Coordinator',
  'Supervisor',
  'Quality Control',
  'Accounting Staff',
];

List<String> skillsList = [
  'Java',
  'Python',
  'C++',
  'JavaScript',
  'Ruby',
  'HTML',
  'CSS',
  'React',
  'Angular',
  'Vue',
  'Android',
  'iOS',
  'Node.js',
  'Django',
  'Flask',
  'SQL',
  'MongoDB',
  'Git'
];
