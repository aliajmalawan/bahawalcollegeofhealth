-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 22, 2026 at 06:30 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `bahalwalcollege`
--

-- --------------------------------------------------------

--
-- Table structure for table `accreditations`
--

CREATE TABLE `accreditations` (
  `id` int(11) NOT NULL,
  `organization_name` varchar(200) NOT NULL,
  `logo` varchar(255) DEFAULT NULL,
  `title` varchar(200) DEFAULT NULL,
  `program` varchar(150) DEFAULT NULL,
  `status` enum('accredited','provisional','pending','expired') NOT NULL DEFAULT 'pending',
  `description` text DEFAULT NULL,
  `valid_from` date DEFAULT NULL,
  `valid_until` date DEFAULT NULL,
  `website` varchar(255) DEFAULT NULL,
  `display_order` int(11) DEFAULT 0,
  `visibility` enum('active','inactive') DEFAULT 'active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `active_users`
--

CREATE TABLE `active_users` (
  `id` int(11) NOT NULL,
  `session_id` varchar(100) NOT NULL,
  `visitor_ip` varchar(45) NOT NULL,
  `current_page` varchar(255) DEFAULT NULL,
  `last_activity` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `active_users`
--

INSERT INTO `active_users` (`id`, `session_id`, `visitor_ip`, `current_page`, `last_activity`) VALUES
(1993, 'jjd0b1l50mrb44m57fd471q456', '::1', '/bahawalcollegeofhealth/index.php', '2026-09-17 09:48:13');

-- --------------------------------------------------------

--
-- Table structure for table `admin_users`
--

CREATE TABLE `admin_users` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `role` enum('super_admin','admin','moderator') DEFAULT 'admin',
  `status` enum('active','inactive') DEFAULT 'active',
  `last_login` datetime DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `failed_login_attempts` int(11) NOT NULL DEFAULT 0,
  `locked_until` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `admin_users`
--

INSERT INTO `admin_users` (`id`, `username`, `password`, `full_name`, `email`, `role`, `status`, `last_login`, `created_at`, `updated_at`, `failed_login_attempts`, `locked_until`) VALUES
(2, 'admin@bahawalcollege.com', '$2y$10$H0gwMCF9HH5VwSdt5yTqHOSB0ODBDuMlv8JFA3qgGXqgxZWKcuGeW', 'Administrator', 'sphs.pk.148@gmail.com', 'admin', 'active', '2026-09-17 11:27:12', '2025-12-26 07:04:40', '2026-09-17 06:27:12', 0, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `admissions`
--

CREATE TABLE `admissions` (
  `id` int(11) NOT NULL,
  `application_number` varchar(30) DEFAULT NULL,
  `student_name` varchar(100) NOT NULL,
  `father_name` varchar(100) NOT NULL,
  `cnic_bform` varchar(20) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `address` text NOT NULL,
  `course_id` varchar(100) NOT NULL,
  `medium` varchar(10) NOT NULL DEFAULT 'English',
  `previous_education` varchar(255) DEFAULT NULL,
  `qualification` varchar(150) DEFAULT NULL,
  `board_university` varchar(150) DEFAULT NULL,
  `passing_year` varchar(10) DEFAULT NULL,
  `marks_percentage` decimal(5,2) DEFAULT NULL,
  `documents` varchar(255) DEFAULT NULL,
  `message` text DEFAULT NULL,
  `status` enum('pending','approved','rejected') DEFAULT 'pending',
  `admin_notes` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `converted_student_id` int(11) DEFAULT NULL,
  `erp_sync_status` enum('not_configured','pending','synced','failed') NOT NULL DEFAULT 'not_configured',
  `erp_student_id` varchar(50) DEFAULT NULL,
  `erp_synced_at` timestamp NULL DEFAULT NULL,
  `erp_sync_error` varchar(500) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `admissions`
--

INSERT INTO `admissions` (`id`, `application_number`, `student_name`, `father_name`, `cnic_bform`, `phone`, `email`, `address`, `course_id`, `medium`, `previous_education`, `qualification`, `board_university`, `passing_year`, `marks_percentage`, `documents`, `message`, `status`, `admin_notes`, `created_at`, `updated_at`, `converted_student_id`, `erp_sync_status`, `erp_student_id`, `erp_synced_at`, `erp_sync_error`) VALUES
(2, NULL, 'Umar Ali', 'Arshad Ali', '45234523452452', '03159060190', '', 'adfasdfadfadsf', '8', 'English', '65%', NULL, NULL, NULL, NULL, '', '', 'approved', NULL, '2026-03-31 06:54:23', '2026-09-04 07:49:43', 7, 'not_configured', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `alumni`
--

CREATE TABLE `alumni` (
  `id` int(11) NOT NULL,
  `student_name` varchar(100) NOT NULL,
  `father_name` varchar(100) NOT NULL,
  `current_job` varchar(150) DEFAULT NULL,
  `job_department` varchar(150) DEFAULT NULL,
  `job_city` varchar(100) DEFAULT NULL,
  `course` varchar(100) NOT NULL,
  `passing_year` int(4) NOT NULL,
  `photo` varchar(255) DEFAULT NULL,
  `mobile_number` varchar(20) NOT NULL,
  `whatsapp_number` varchar(20) DEFAULT NULL,
  `review` text NOT NULL,
  `status` enum('pending','approved','rejected') DEFAULT 'pending',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `alumni_reviews`
--

CREATE TABLE `alumni_reviews` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `passing_year` int(4) DEFAULT NULL,
  `review` text NOT NULL,
  `rating` int(1) DEFAULT 5,
  `status` enum('pending','approved','rejected') DEFAULT 'pending',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `board_results`
--

CREATE TABLE `board_results` (
  `id` int(11) NOT NULL,
  `title` varchar(150) NOT NULL,
  `board_type` enum('Matric','Intermediate') NOT NULL,
  `year` int(4) NOT NULL,
  `image_path` varchar(255) NOT NULL,
  `display_order` int(11) DEFAULT 0,
  `status` enum('active','inactive') DEFAULT 'active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `campuses`
--

CREATE TABLE `campuses` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `area` varchar(150) NOT NULL COMMENT 'e.g. Green Town, Gujranwala',
  `phone` varchar(30) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `students` varchar(20) DEFAULT NULL COMMENT 'e.g. 800+',
  `programs` varchar(10) DEFAULT NULL COMMENT 'e.g. 12',
  `since_year` varchar(10) DEFAULT NULL COMMENT 'e.g. 2009',
  `icon` varchar(50) DEFAULT 'fa-building-columns' COMMENT 'Font Awesome class',
  `badge` varchar(50) DEFAULT NULL COMMENT 'e.g. Headquarters, Boys Campus',
  `badge_color` varchar(20) DEFAULT '#0B7275',
  `color_from` varchar(20) DEFAULT '#052E30' COMMENT 'Gradient start hex',
  `color_to` varchar(20) DEFAULT '#0B7275' COMMENT 'Gradient end hex',
  `map_query` varchar(200) DEFAULT NULL COMMENT 'Google Maps query, e.g. Green+Town+Gujranwala+Pakistan',
  `facilities` varchar(500) DEFAULT NULL COMMENT 'Comma separated list',
  `is_main` tinyint(1) DEFAULT 0 COMMENT 'Featured in the Location/Map section',
  `display_order` int(11) DEFAULT 0,
  `status` enum('active','inactive') DEFAULT 'active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `campuses`
--

INSERT INTO `campuses` (`id`, `name`, `area`, `phone`, `email`, `students`, `programs`, `since_year`, `icon`, `badge`, `badge_color`, `color_from`, `color_to`, `map_query`, `facilities`, `is_main`, `display_order`, `status`, `created_at`, `updated_at`) VALUES
(7, 'Bahawal College of Health Sciences Arif Wala', '3km Bahawalnagar Road, Arif Wala', '0325 0836600', NULL, NULL, NULL, NULL, 'fa-building-columns', 'Main Campus', '#17165B', '#0D1048', '#17165B', '3km+Bahawalnagar+Road+Arif+Wala+Pakistan', NULL, 1, 1, 'active', '2026-09-02 10:43:22', '2026-09-02 10:43:22'),
(8, 'Bahawal College of Health Sciences Vehari', 'Near Imtiaz Mall, Luddan Road, Vehari', '0304 0836600', NULL, NULL, NULL, NULL, 'fa-school', 'Vehari Campus', '#09A9D9', '#0D1048', '#09A9D9', 'Near+Imtiaz+Mall+Luddan+Road+Vehari+Pakistan', NULL, 0, 2, 'active', '2026-09-02 10:43:22', '2026-09-02 10:43:22'),
(9, 'Bahawal College of Health Sciences (University Campus) Arif Wala', '3km Bahawalnagar Road, Arif Wala', '0325 0836600', NULL, NULL, NULL, NULL, 'fa-graduation-cap', 'University Campus', '#18B9E8', '#17165B', '#18B9E8', '3km+Bahawalnagar+Road+Arif+Wala+Pakistan', NULL, 0, 3, 'active', '2026-09-02 10:43:22', '2026-09-02 10:43:22');

-- --------------------------------------------------------

--
-- Table structure for table `clinical_partners`
--

CREATE TABLE `clinical_partners` (
  `id` int(11) NOT NULL,
  `hospital_name` varchar(200) NOT NULL,
  `location` varchar(200) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `facilities` text DEFAULT NULL,
  `programs` text DEFAULT NULL,
  `logo` varchar(255) DEFAULT NULL,
  `website` varchar(255) DEFAULT NULL,
  `display_order` int(11) DEFAULT 0,
  `status` enum('active','inactive') DEFAULT 'active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `contacts`
--

CREATE TABLE `contacts` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `subject` varchar(200) NOT NULL,
  `message` text NOT NULL,
  `status` enum('unread','read','replied') DEFAULT 'unread',
  `admin_reply` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `contact_faqs`
--

CREATE TABLE `contact_faqs` (
  `id` int(11) NOT NULL,
  `question` varchar(255) NOT NULL,
  `answer` text NOT NULL,
  `display_order` int(11) DEFAULT 0,
  `status` enum('active','inactive') DEFAULT 'active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `contact_faqs`
--

INSERT INTO `contact_faqs` (`id`, `question`, `answer`, `display_order`, `status`, `created_at`, `updated_at`) VALUES
(1, 'What are the admission requirements?', 'Requirements vary by program. Generally needed: previous educational certificates, CNIC/B-Form, passport photos, and admission fee. Visit our Admission page for full details.', 1, 'active', '2026-08-18 10:43:52', '2026-08-18 10:43:52'),
(2, 'How can I apply for admission?', 'Apply online through our Admission page, or visit our campus in person. Fill the form, submit documents, and pay the admission fee.', 2, 'active', '2026-08-18 10:43:52', '2026-08-18 10:43:52'),
(3, 'What is the fee structure?', 'Fees range from Rs. 3,000/month (short courses) to Rs. 8,000/month (entry test prep). Matric: Rs. 5,000/mo. Intermediate: Rs. 6,000/mo. One-time admission fee: Rs. 2,000.', 3, 'active', '2026-08-18 10:43:52', '2026-08-18 10:43:52'),
(4, 'Do you offer scholarships?', 'Yes! We offer merit-based and need-based scholarships. Sibling discounts and installment plans are also available. Contact our admission office for details.', 4, 'active', '2026-08-18 10:43:52', '2026-08-18 10:43:52'),
(5, 'How can I contact a specific teacher?', 'Visit our campus during office hours or call us. We will connect you with the right faculty member or department directly.', 5, 'active', '2026-08-18 10:43:52', '2026-08-18 10:43:52');

-- --------------------------------------------------------

--
-- Table structure for table `core_values`
--

CREATE TABLE `core_values` (
  `id` int(11) NOT NULL,
  `title` varchar(100) NOT NULL,
  `description` text NOT NULL,
  `icon` varchar(50) DEFAULT 'fas fa-star' COMMENT 'Font Awesome class, e.g. fas fa-star',
  `color` varchar(20) DEFAULT '#0B7275' COMMENT 'Hex color for icon and accent',
  `display_order` int(11) DEFAULT 0,
  `status` enum('active','inactive') DEFAULT 'active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `core_values`
--

INSERT INTO `core_values` (`id`, `title`, `description`, `icon`, `color`, `display_order`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Excellence', 'We strive for the highest standards in teaching, learning, and all our educational programs.', 'fas fa-star', '#17165B', 1, 'active', '2026-07-27 09:28:39', '2026-09-16 11:45:26'),
(2, 'Integrity', 'We uphold honesty, transparency, and ethical conduct in all our interactions.', 'fas fa-handshake', '#09A9D9', 2, 'active', '2026-07-27 09:28:39', '2026-09-16 11:45:26'),
(3, 'Innovation', 'We embrace new ideas, modern teaching methods, and continuous improvement.', 'fas fa-lightbulb', '#0D1048', 3, 'active', '2026-07-27 09:28:39', '2026-09-16 11:45:26'),
(4, 'Respect', 'We value diversity, dignity, and mutual respect among all members.', 'fas fa-heart', '#18B9E8', 4, 'active', '2026-07-27 09:28:39', '2026-09-16 11:45:26'),
(5, 'Community', 'We foster a supportive learning environment and positive relationships.', 'fas fa-users', '#17165B', 5, 'active', '2026-07-27 09:28:39', '2026-09-16 11:45:26'),
(6, 'Social Responsibility', 'We prepare students to be responsible citizens who contribute positively.', 'fas fa-globe', '#09A9D9', 6, 'active', '2026-07-27 09:28:39', '2026-09-16 11:45:26');

-- --------------------------------------------------------

--
-- Table structure for table `courses`
--

CREATE TABLE `courses` (
  `id` int(11) NOT NULL,
  `name` varchar(200) NOT NULL,
  `description` text DEFAULT NULL,
  `duration` varchar(50) DEFAULT NULL,
  `fee` decimal(10,2) DEFAULT NULL,
  `admission_fee` decimal(10,2) DEFAULT NULL,
  `semester_fee` decimal(10,2) DEFAULT NULL,
  `fee_period` enum('Semester','Month') DEFAULT 'Semester',
  `initial_fee` decimal(10,2) DEFAULT NULL,
  `total_fee` decimal(10,2) DEFAULT NULL,
  `affiliation` varchar(150) DEFAULT NULL,
  `department` varchar(150) DEFAULT NULL,
  `eligibility` varchar(255) DEFAULT NULL,
  `category` varchar(20) DEFAULT 'regular' COMMENT 'regular, test, or short',
  `icon` varchar(50) DEFAULT NULL,
  `display_order` int(11) DEFAULT 0,
  `status` enum('active','inactive') DEFAULT 'active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `courses`
--

INSERT INTO `courses` (`id`, `name`, `description`, `duration`, `fee`, `admission_fee`, `semester_fee`, `fee_period`, `initial_fee`, `total_fee`, `affiliation`, `department`, `eligibility`, `category`, `icon`, `display_order`, `status`, `created_at`, `updated_at`) VALUES
(4, 'O Level – Part 1', 'The O Level – Part 1 program at Sir Syed Degree College Chowki AJK provides students with a strong academic foundation in core subjects and essential learning skills. This stage focuses on developing critical thinking, analytical abilities, and a deep understanding of fundamental concepts.\r\n\r\nStudents are guided by experienced teachers who help them build confidence in their studies while encouraging curiosity and independent learning. The curriculum is designed to prepare students for the advanced level of O Level studies and future academic challenges.', '1 year', 70000.00, NULL, NULL, 'Semester', NULL, NULL, NULL, NULL, NULL, 'regular', NULL, 0, 'inactive', '2026-03-16 03:09:25', '2026-09-04 03:39:39'),
(5, 'O Level – Part 2', 'The O Level – Part 2 program is the continuation of the O Level journey where students strengthen their subject knowledge and prepare for their final examinations. At this stage, greater emphasis is placed on problem-solving, practical learning, and exam preparation.\r\n\r\nThrough modern teaching methods and continuous assessment, students are supported in achieving academic excellence and developing the skills required for higher education and professional success.', '1 year', 70000.00, NULL, NULL, 'Semester', NULL, NULL, NULL, NULL, NULL, 'regular', NULL, 0, 'inactive', '2026-03-16 03:10:04', '2026-09-04 03:39:39'),
(6, 'A Level – Part 1', 'The A Level – Part 1 program focuses on advanced learning and subject specialization. Students are encouraged to explore their academic interests while developing strong analytical and research skills.\r\n\r\nAt Sir Syed Degree College Chowki AJK, our faculty provides personalized guidance to help students understand complex concepts and build a solid foundation for the final stage of A Level studies.', '1 year', 80000.00, NULL, NULL, 'Semester', NULL, NULL, NULL, NULL, NULL, 'regular', NULL, 0, 'inactive', '2026-03-16 03:10:40', '2026-09-04 03:39:39'),
(7, 'A Level – Part 2', 'The A Level – Part 2 program represents the final stage of advanced secondary education. Students refine their knowledge, improve their academic performance, and prepare for higher education opportunities.\r\n\r\nThis stage emphasizes independent thinking, problem-solving abilities, and academic excellence. Our goal is to equip students with the knowledge, confidence, and skills needed to succeed in universities and future careers.', '1 year', 80000.00, NULL, NULL, 'Semester', NULL, NULL, NULL, NULL, NULL, 'regular', NULL, 0, 'inactive', '2026-03-16 03:11:14', '2026-09-04 03:39:39'),
(8, 'ECAT Preparation', 'Intensive preparation course for Engineering College Admission Test. Covers all test patterns, practice questions, and proven strategies for success.', '6 Months', 40000.00, NULL, NULL, 'Semester', NULL, NULL, NULL, NULL, NULL, 'regular', NULL, 0, 'inactive', '2026-03-16 03:12:11', '2026-09-04 03:39:39'),
(9, 'MDCAT Preparation', 'Comprehensive Medical and Dental College Admission Test preparation. Expert faculty, extensive practice tests, and personalized guidance.', '6 Months', 50000.00, NULL, NULL, 'Semester', NULL, NULL, NULL, NULL, NULL, 'regular', NULL, 0, 'inactive', '2026-03-16 03:12:48', '2026-09-04 03:39:39'),
(11, 'Doctor of Pharmacy (Pharm-D)', 'A five-year professional degree preparing pharmacists for clinical practice, pharmaceutical care, and the pharmaceutical industry, affiliated with Government College University Faisalabad (GCUF).', '5 Years', NULL, 15000.00, 60000.00, 'Semester', 65000.00, 650000.00, 'Government College University Faisalabad (GCUF)', 'Department of Pharmacy', 'F.Sc Pre-Medical, 60% marks', 'regular', 'fa-capsules', 1, 'active', '2026-09-04 03:39:39', '2026-09-14 09:20:46'),
(12, 'Doctor of Physical Therapy (DPT)', 'A five-year professional degree training physical therapists in rehabilitation, musculoskeletal care, and patient movement therapy, affiliated with Government College University Faisalabad (GCUF).', '5 Years', NULL, NULL, NULL, 'Semester', NULL, NULL, NULL, NULL, NULL, 'regular', 'fa-dumbbell', 2, 'active', '2026-09-04 03:39:39', '2026-09-04 03:39:39'),
(13, 'BS Medical Laboratory Technology (BS MLT)', 'A four-year degree covering clinical laboratory science, diagnostics, pathology, and lab management, preparing graduates for careers as medical laboratory technologists.', '4 Years', NULL, NULL, NULL, 'Semester', NULL, NULL, NULL, NULL, NULL, 'regular', 'fa-microscope', 3, 'active', '2026-09-04 03:39:39', '2026-09-04 03:39:39'),
(14, 'BS Human Nutrition & Dietetics', 'A four-year degree in food science, clinical nutrition, and dietetics, preparing graduates to work as nutritionists and dietitians in hospitals, clinics, and community health.', '4 Years', NULL, NULL, NULL, 'Semester', NULL, NULL, NULL, NULL, NULL, 'regular', 'fa-apple-whole', 4, 'active', '2026-09-04 03:39:39', '2026-09-04 03:39:39'),
(15, 'Dispenser', 'A certificate program training students to dispense medicines accurately and assist pharmacists in hospital and retail pharmacy settings.', NULL, NULL, NULL, NULL, 'Semester', NULL, NULL, NULL, NULL, NULL, 'short', 'fa-prescription-bottle', 5, 'active', '2026-09-04 03:39:40', '2026-09-04 03:39:40'),
(16, 'Medical Laboratory Technician', 'A certificate program covering sample collection, lab testing procedures, and diagnostic support for hospital and clinical laboratories.', NULL, NULL, NULL, NULL, 'Semester', NULL, NULL, NULL, NULL, NULL, 'short', 'fa-vials', 6, 'active', '2026-09-04 03:39:40', '2026-09-04 03:39:40'),
(17, 'Operation Theater Technician', 'A certificate program preparing students to assist surgical teams with OT equipment, sterilization, and patient care during operations.', NULL, NULL, NULL, NULL, 'Semester', NULL, NULL, NULL, NULL, NULL, 'short', 'fa-syringe', 7, 'active', '2026-09-04 03:39:40', '2026-09-04 03:39:40'),
(18, 'Pharmacy Technician (Category B)', 'A certificate program training students in pharmacy operations, medicine handling, and pharmaceutical record-keeping under Category B guidelines.', NULL, NULL, NULL, NULL, 'Semester', NULL, NULL, NULL, NULL, NULL, 'short', 'fa-mortar-pestle', 8, 'active', '2026-09-04 03:39:40', '2026-09-04 03:39:40');

-- --------------------------------------------------------

--
-- Table structure for table `datesheet_details`
--

CREATE TABLE `datesheet_details` (
  `id` int(11) NOT NULL,
  `datesheet_id` int(11) NOT NULL,
  `exam_date` date NOT NULL,
  `day_name` varchar(20) NOT NULL,
  `class` varchar(20) NOT NULL,
  `subject` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dms_features`
--

CREATE TABLE `dms_features` (
  `id` int(11) NOT NULL,
  `title` varchar(100) NOT NULL,
  `description` varchar(255) NOT NULL,
  `icon` varchar(50) DEFAULT 'fas fa-star' COMMENT 'Font Awesome class, e.g. fas fa-star',
  `color` varchar(20) DEFAULT '#0B7275' COMMENT 'Hex color for icon and accent',
  `display_order` int(11) DEFAULT 0,
  `status` enum('active','inactive') DEFAULT 'active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `dms_features`
--

INSERT INTO `dms_features` (`id`, `title`, `description`, `icon`, `color`, `display_order`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Online Exam Results', 'Instant results & detailed analysis', 'fas fa-chart-line', '#0BBFC6', 1, 'active', '2026-08-18 09:27:10', '2026-08-18 09:27:10'),
(2, 'Digital Attendance', 'Real-time tracking & reports', 'fas fa-user-check', '#4CAF50', 2, 'active', '2026-08-18 09:27:10', '2026-08-18 09:27:10'),
(3, 'WhatsApp & SMS', 'Automated alerts to parents', 'fab fa-whatsapp', '#25D366', 3, 'active', '2026-08-18 09:27:10', '2026-08-18 09:27:10'),
(4, 'Parent Complaints', 'Quick resolution system', 'fas fa-comments', '#FF7043', 4, 'active', '2026-08-18 09:27:10', '2026-08-18 09:27:10'),
(5, 'Fee Management', 'Online fee history & tracking', 'fas fa-wallet', '#CE93D8', 5, 'active', '2026-08-18 09:27:10', '2026-08-18 09:27:10'),
(6, 'Digital Diaries', 'Homework & assignments online', 'fas fa-book-open', '#EF5350', 6, 'active', '2026-08-18 09:27:10', '2026-08-18 09:27:10'),
(7, 'Smart Timetable', 'Dynamic class schedules', 'fas fa-calendar-alt', '#26C6DA', 7, 'active', '2026-08-18 09:27:10', '2026-08-18 09:27:10'),
(8, 'PTM Notes', 'Parent-teacher meeting records', 'fas fa-clipboard-list', '#FFA726', 8, 'active', '2026-08-18 09:27:10', '2026-08-18 09:27:10');

-- --------------------------------------------------------

--
-- Table structure for table `downloads`
--

CREATE TABLE `downloads` (
  `id` int(11) NOT NULL,
  `date` date NOT NULL,
  `description` varchar(255) NOT NULL,
  `file_path` varchar(255) NOT NULL,
  `file_name` varchar(255) NOT NULL,
  `file_type` varchar(50) DEFAULT NULL,
  `display_order` int(11) DEFAULT 0,
  `status` enum('active','inactive') DEFAULT 'active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `eligibility_rules`
--

CREATE TABLE `eligibility_rules` (
  `id` int(11) NOT NULL,
  `course_id` int(11) NOT NULL,
  `qualification` varchar(150) NOT NULL,
  `min_percentage` decimal(5,2) NOT NULL,
  `notes` varchar(255) DEFAULT NULL,
  `display_order` int(11) DEFAULT 0,
  `status` enum('active','inactive') DEFAULT 'active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `eligibility_rules`
--

INSERT INTO `eligibility_rules` (`id`, `course_id`, `qualification`, `min_percentage`, `notes`, `display_order`, `status`, `created_at`, `updated_at`) VALUES
(1, 11, 'F.Sc Pre-Medical', 60.00, NULL, 1, 'active', '2026-09-14 10:36:17', '2026-09-14 10:36:17');

-- --------------------------------------------------------

--
-- Table structure for table `events`
--

CREATE TABLE `events` (
  `id` int(11) NOT NULL,
  `title` varchar(200) NOT NULL,
  `description` text DEFAULT NULL,
  `category` enum('general','sports','seminar','workshop','competition','cultural','community') NOT NULL DEFAULT 'general',
  `event_date` date NOT NULL,
  `time` varchar(50) DEFAULT NULL,
  `location` varchar(255) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `status` enum('active','inactive') DEFAULT 'active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `exams`
--

CREATE TABLE `exams` (
  `id` int(11) NOT NULL,
  `exam_title` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `status` enum('active','inactive') DEFAULT 'active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `exams`
--

INSERT INTO `exams` (`id`, `exam_title`, `description`, `status`, `created_at`, `updated_at`) VALUES
(2, 'Annual Examination 2025 9th-B', 'dummy data', 'active', '2026-01-27 09:19:54', '2026-01-27 09:54:14'),
(3, 'Mid Term Exam 2025 9th-B', '', 'active', '2026-01-27 10:39:55', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `exam_datesheets`
--

CREATE TABLE `exam_datesheets` (
  `id` int(11) NOT NULL,
  `exam_name` varchar(150) NOT NULL,
  `exam_year` int(4) NOT NULL,
  `status` enum('active','inactive') DEFAULT 'active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `faculty`
--

CREATE TABLE `faculty` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `designation` varchar(100) DEFAULT NULL,
  `department` varchar(150) DEFAULT NULL,
  `subjects` varchar(255) DEFAULT NULL,
  `qualification` varchar(255) DEFAULT NULL,
  `specialization` varchar(255) DEFAULT NULL,
  `experience` int(11) DEFAULT NULL,
  `photo` varchar(255) DEFAULT NULL,
  `icon` varchar(50) DEFAULT 'fa-chalkboard-teacher' COMMENT 'Font Awesome class fallback avatar icon',
  `bio` text DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `display_order` int(11) DEFAULT 0,
  `status` enum('active','inactive') DEFAULT 'active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `faculty`
--

INSERT INTO `faculty` (`id`, `name`, `designation`, `department`, `subjects`, `qualification`, `specialization`, `experience`, `photo`, `icon`, `bio`, `email`, `phone`, `display_order`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Ali Ajmal Awan', 'Developer', 'IT', 'Test', 'BBIT, Virtual University', '', 12, 'images/faculty/faculty_1788405944_8988.jpg', 'fa-chalkboard-teacher', '', NULL, NULL, 0, 'active', '2026-09-03 03:25:44', '2026-09-16 09:59:39');

-- --------------------------------------------------------

--
-- Table structure for table `fee_structure`
--

CREATE TABLE `fee_structure` (
  `id` int(11) NOT NULL,
  `title` varchar(100) NOT NULL,
  `subtitle` varchar(150) DEFAULT NULL,
  `price` varchar(50) NOT NULL COMMENT 'e.g. 5,000 or 7,000-8,000',
  `price_period` varchar(50) DEFAULT 'per month',
  `icon` varchar(50) DEFAULT 'fas fa-tag' COMMENT 'Font Awesome class',
  `color` varchar(20) DEFAULT '#0B7275' COMMENT 'Hex color for card gradient',
  `display_order` int(11) DEFAULT 0,
  `status` enum('active','inactive') DEFAULT 'active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `fee_structure`
--

INSERT INTO `fee_structure` (`id`, `title`, `subtitle`, `price`, `price_period`, `icon`, `color`, `display_order`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Matric Programs', '9th & 10th Grade', '5,000', 'per month', 'fas fa-graduation-cap', '#0B7275', 1, 'active', '2026-08-18 10:11:49', '2026-08-18 10:11:49'),
(2, 'Intermediate', 'FSc / ICS Programs', '6,000', 'per month', 'fas fa-university', '#1565c0', 2, 'active', '2026-08-18 10:11:49', '2026-08-18 10:11:49'),
(3, 'Entry Test Prep', 'ECAT / MDCAT / IELTS', '7,000-8,000', 'per month', 'fas fa-pencil-alt', '#e65100', 3, 'active', '2026-08-18 10:11:49', '2026-08-18 10:11:49'),
(4, 'Short Courses', 'IT / Languages / Math', '3,000-5,000', 'per month', 'fas fa-clock', '#7b1fa2', 4, 'active', '2026-08-18 10:11:49', '2026-08-18 10:11:49'),
(5, 'Admission Fee', 'One-time registration', '2,000', 'one time', 'fas fa-star', '#c62828', 5, 'active', '2026-08-18 10:11:49', '2026-08-18 10:11:49');

-- --------------------------------------------------------

--
-- Table structure for table `foundation_activities`
--

CREATE TABLE `foundation_activities` (
  `id` int(11) NOT NULL,
  `title` varchar(200) NOT NULL,
  `description` text DEFAULT NULL,
  `activity_date` date DEFAULT NULL,
  `icon` varchar(50) DEFAULT 'fa-hand-holding-heart',
  `display_order` int(11) DEFAULT 0,
  `status` enum('active','inactive') DEFAULT 'active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `gallery`
--

CREATE TABLE `gallery` (
  `id` int(11) NOT NULL,
  `title` varchar(200) DEFAULT NULL,
  `image_path` varchar(255) NOT NULL,
  `category` varchar(50) NOT NULL DEFAULT 'events',
  `display_order` int(11) DEFAULT 0,
  `status` enum('active','inactive') DEFAULT 'active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `gallery`
--

INSERT INTO `gallery` (`id`, `title`, `image_path`, `category`, `display_order`, `status`, `created_at`, `updated_at`) VALUES
(19, 'Examinations 01', 'uploads/gallery/1788343771_6a97f5db2f510.jpg', 'examination', 0, 'active', '2026-09-02 10:09:33', '2026-09-02 10:09:33'),
(20, 'Examinations 02', 'uploads/gallery/1788343773_6a97f5dd4185f.jpg', 'examination', 0, 'active', '2026-09-02 10:09:35', '2026-09-02 10:09:35'),
(21, 'Examinations 03', 'uploads/gallery/1788343775_6a97f5df7f903.jpg', 'examination', 0, 'active', '2026-09-02 10:09:36', '2026-09-02 10:09:36'),
(22, 'Examinations 04', 'uploads/gallery/1788343776_6a97f5e0d93f6.jpg', 'examination', 0, 'active', '2026-09-02 10:09:38', '2026-09-02 10:09:38'),
(23, 'Examinations 05', 'uploads/gallery/1788343778_6a97f5e218303.jpg', 'examination', 0, 'active', '2026-09-02 10:09:39', '2026-09-02 10:09:39'),
(24, 'Examinations 06', 'uploads/gallery/1788343779_6a97f5e3b87f1.jpg', 'examination', 0, 'active', '2026-09-02 10:09:41', '2026-09-02 10:09:41'),
(25, 'Examinations 07', 'uploads/gallery/1788343781_6a97f5e5233f0.jpg', 'examination', 0, 'active', '2026-09-02 10:09:42', '2026-09-02 10:09:42'),
(26, 'Examinations 08', 'uploads/gallery/1788343782_6a97f5e6a7654.jpg', 'examination', 0, 'active', '2026-09-02 10:09:44', '2026-09-02 10:09:44'),
(27, 'Examinations 09', 'uploads/gallery/1788343784_6a97f5e835264.jpg', 'examination', 0, 'active', '2026-09-02 10:09:45', '2026-09-02 10:09:45'),
(28, 'Faculty Tour 01', 'uploads/gallery/1788343810_6a97f60235bad.jpg', 'faculty_tour', 0, 'active', '2026-09-02 10:10:11', '2026-09-02 10:10:11'),
(29, 'Faculty Tour 02', 'uploads/gallery/1788343811_6a97f603a5571.jpg', 'faculty_tour', 0, 'active', '2026-09-02 10:10:12', '2026-09-02 10:10:12'),
(30, 'Faculty Tour 03', 'uploads/gallery/1788343812_6a97f604ec76a.jpg', 'faculty_tour', 0, 'active', '2026-09-02 10:10:14', '2026-09-02 10:10:14'),
(31, 'Faculty Tour 04', 'uploads/gallery/1788343814_6a97f60647ea7.jpg', 'faculty_tour', 0, 'active', '2026-09-02 10:10:16', '2026-09-02 10:10:16'),
(32, 'Faculty Tour 05', 'uploads/gallery/1788343816_6a97f60831a5b.jpg', 'faculty_tour', 0, 'active', '2026-09-02 10:10:17', '2026-09-02 10:10:17'),
(33, 'Faculty Tour 06', 'uploads/gallery/1788343817_6a97f6099d512.jpg', 'faculty_tour', 0, 'active', '2026-09-02 10:10:18', '2026-09-02 10:10:18'),
(34, 'Faculty Tour 07', 'uploads/gallery/1788343818_6a97f60ad8752.jpg', 'faculty_tour', 0, 'active', '2026-09-02 10:10:20', '2026-09-02 10:10:20'),
(35, 'Faculty Tour 08', 'uploads/gallery/1788343820_6a97f60c595d2.jpg', 'faculty_tour', 0, 'active', '2026-09-02 10:10:21', '2026-09-02 10:10:21'),
(36, 'Faculty Tour 09', 'uploads/gallery/1788343821_6a97f60ddf5bb.jpg', 'faculty_tour', 0, 'active', '2026-09-02 10:10:23', '2026-09-02 10:10:23'),
(37, 'Faculty Tour 10', 'uploads/gallery/1788343823_6a97f60ff2738.jpg', 'faculty_tour', 0, 'active', '2026-09-02 10:10:26', '2026-09-02 10:10:26'),
(38, 'First Aid Training 01', 'uploads/gallery/1788343847_6a97f6276a7e6.jpg', 'first_aid_training', 0, 'active', '2026-09-02 10:10:49', '2026-09-02 10:10:49'),
(39, 'First Aid Training 02', 'uploads/gallery/1788343849_6a97f6297abb1.jpg', 'first_aid_training', 0, 'active', '2026-09-02 10:10:51', '2026-09-02 10:10:51'),
(40, 'First Aid Training 03', 'uploads/gallery/1788343851_6a97f62b443dc.jpg', 'first_aid_training', 0, 'active', '2026-09-02 10:10:52', '2026-09-02 10:10:52'),
(41, 'First Aid Training 04', 'uploads/gallery/1788343853_6a97f62d007c9.jpg', 'first_aid_training', 0, 'active', '2026-09-02 10:10:55', '2026-09-02 10:10:55'),
(42, 'First Aid Training 05', 'uploads/gallery/1788343855_6a97f62f70824.jpg', 'first_aid_training', 0, 'active', '2026-09-02 10:10:55', '2026-09-02 10:10:55'),
(43, 'First Aid Training 06', 'uploads/gallery/1788343855_6a97f62fa3b14.jpg', 'first_aid_training', 0, 'active', '2026-09-02 10:10:55', '2026-09-02 10:10:55'),
(44, 'First Aid Training 07', 'uploads/gallery/1788343855_6a97f62fa9b54.jpg', 'first_aid_training', 0, 'active', '2026-09-02 10:10:57', '2026-09-02 10:10:57'),
(45, 'First Aid Training 08', 'uploads/gallery/1788343857_6a97f631a4858.jpg', 'first_aid_training', 0, 'active', '2026-09-02 10:10:59', '2026-09-02 10:10:59'),
(46, 'First Aid Training 09', 'uploads/gallery/1788343859_6a97f63372504.jpg', 'first_aid_training', 0, 'active', '2026-09-02 10:11:01', '2026-09-02 10:11:01'),
(47, 'Independence Day 01', 'uploads/gallery/1788343901_6a97f65d69d9c.jpg', 'independence_day', 0, 'active', '2026-09-02 10:11:43', '2026-09-02 10:11:43'),
(48, 'Independence Day 02', 'uploads/gallery/1788343903_6a97f65f09237.jpg', 'independence_day', 0, 'active', '2026-09-02 10:11:44', '2026-09-02 10:11:44'),
(49, 'Independence Day 03', 'uploads/gallery/1788343904_6a97f6606183e.jpg', 'independence_day', 0, 'active', '2026-09-02 10:11:45', '2026-09-02 10:11:45'),
(50, 'Independence Day 04', 'uploads/gallery/1788343905_6a97f661c10b9.jpg', 'independence_day', 0, 'active', '2026-09-02 10:11:47', '2026-09-02 10:11:47'),
(51, 'Independence Day 05', 'uploads/gallery/1788343907_6a97f663d9a03.jpg', 'independence_day', 0, 'active', '2026-09-02 10:11:49', '2026-09-02 10:11:49'),
(52, 'Independence Day 06', 'uploads/gallery/1788343909_6a97f665422bc.jpg', 'independence_day', 0, 'active', '2026-09-02 10:11:51', '2026-09-02 10:11:51'),
(53, 'Independence Day 07', 'uploads/gallery/1788343911_6a97f66798072.jpg', 'independence_day', 0, 'active', '2026-09-02 10:11:53', '2026-09-02 10:11:53'),
(54, 'Independence Day 08', 'uploads/gallery/1788343913_6a97f66957867.jpg', 'independence_day', 0, 'active', '2026-09-02 10:11:53', '2026-09-02 10:11:53'),
(55, 'Independence Day 09', 'uploads/gallery/1788343913_6a97f6695d093.jpg', 'independence_day', 0, 'active', '2026-09-02 10:11:54', '2026-09-02 10:11:54'),
(56, 'Independence Day 10', 'uploads/gallery/1788343914_6a97f66a78375.jpg', 'independence_day', 0, 'active', '2026-09-02 10:11:55', '2026-09-02 10:11:55'),
(57, 'Independence Day 11', 'uploads/gallery/1788343915_6a97f66bc365e.jpg', 'independence_day', 0, 'active', '2026-09-02 10:11:57', '2026-09-02 10:11:57'),
(58, 'Independence Day 12', 'uploads/gallery/1788343917_6a97f66d350e5.jpg', 'independence_day', 0, 'active', '2026-09-02 10:11:58', '2026-09-02 10:11:58'),
(59, 'Independence Day 13', 'uploads/gallery/1788343918_6a97f66e6f79a.jpg', 'independence_day', 0, 'active', '2026-09-02 10:11:59', '2026-09-02 10:11:59'),
(60, 'Mehfil E Milad 01', 'uploads/gallery/1788343948_6a97f68cea3d4.jpg', 'mehfil_e_milad', 0, 'active', '2026-09-02 10:12:31', '2026-09-02 10:12:31'),
(61, 'Mehfil E Milad 02', 'uploads/gallery/1788343951_6a97f68f2d3de.jpg', 'mehfil_e_milad', 0, 'active', '2026-09-02 10:12:33', '2026-09-02 10:12:33'),
(62, 'Mehfil E Milad 03', 'uploads/gallery/1788343953_6a97f69167a37.jpg', 'mehfil_e_milad', 0, 'active', '2026-09-02 10:12:34', '2026-09-02 10:12:34'),
(63, 'Mehfil E Milad 04', 'uploads/gallery/1788343955_6a97f693017e9.jpg', 'mehfil_e_milad', 0, 'active', '2026-09-02 10:12:37', '2026-09-02 10:12:37'),
(64, 'Mehfil E Milad 05', 'uploads/gallery/1788343957_6a97f6955f7f7.jpg', 'mehfil_e_milad', 0, 'active', '2026-09-02 10:12:39', '2026-09-02 10:12:39'),
(65, 'Mehfil E Milad 06', 'uploads/gallery/1788343959_6a97f69745b6a.jpg', 'mehfil_e_milad', 0, 'active', '2026-09-02 10:12:41', '2026-09-02 10:12:41'),
(66, 'Mehfil E Milad 07', 'uploads/gallery/1788343961_6a97f6991bc0d.jpg', 'mehfil_e_milad', 0, 'active', '2026-09-02 10:12:43', '2026-09-02 10:12:43'),
(67, 'Naat Competition 01', 'uploads/gallery/1788343993_6a97f6b910dfc.jpg', 'naat_competition', 0, 'active', '2026-09-02 10:13:14', '2026-09-02 10:13:14'),
(68, 'Naat Competition 02', 'uploads/gallery/1788343994_6a97f6ba595fc.jpg', 'naat_competition', 0, 'active', '2026-09-02 10:13:15', '2026-09-02 10:13:15'),
(69, 'Naat Competition 03', 'uploads/gallery/1788343995_6a97f6bb9a8b3.jpg', 'naat_competition', 0, 'active', '2026-09-02 10:13:16', '2026-09-02 10:13:16'),
(70, 'Naat Competition 04', 'uploads/gallery/1788343996_6a97f6bce6f91.jpg', 'naat_competition', 0, 'active', '2026-09-02 10:13:18', '2026-09-02 10:13:18'),
(71, 'Naat Competition 05', 'uploads/gallery/1788343998_6a97f6be354d6.jpg', 'naat_competition', 0, 'active', '2026-09-02 10:13:19', '2026-09-02 10:13:19'),
(72, 'Naat Competition 06', 'uploads/gallery/1788343999_6a97f6bfe3648.jpg', 'naat_competition', 0, 'active', '2026-09-02 10:13:21', '2026-09-02 10:13:21'),
(73, 'Naat Competition 07', 'uploads/gallery/1788344001_6a97f6c1635af.jpg', 'naat_competition', 0, 'active', '2026-09-02 10:13:22', '2026-09-02 10:13:22'),
(74, 'Naat Competition 08', 'uploads/gallery/1788344002_6a97f6c28dc84.jpg', 'naat_competition', 0, 'active', '2026-09-02 10:13:23', '2026-09-02 10:13:23'),
(75, 'Naat Competition 09', 'uploads/gallery/1788344003_6a97f6c3d6ecc.jpg', 'naat_competition', 0, 'active', '2026-09-02 10:13:25', '2026-09-02 10:13:25'),
(76, 'Naat Competition 10', 'uploads/gallery/1788344005_6a97f6c51c6ec.jpg', 'naat_competition', 0, 'active', '2026-09-02 10:13:26', '2026-09-02 10:13:26'),
(77, 'Orientation Class 01', 'uploads/gallery/1788344042_6a97f6ea23c32.jpg', 'orientation_class', 0, 'active', '2026-09-02 10:14:03', '2026-09-02 10:14:03'),
(78, 'Orientation Class 02', 'uploads/gallery/1788344043_6a97f6eb868bb.jpg', 'orientation_class', 0, 'active', '2026-09-02 10:14:04', '2026-09-02 10:14:04'),
(79, 'Orientation Class 03', 'uploads/gallery/1788344044_6a97f6ecdbf1e.jpg', 'orientation_class', 0, 'active', '2026-09-02 10:14:06', '2026-09-02 10:14:06'),
(80, 'Orientation Class 04', 'uploads/gallery/1788344046_6a97f6ee64e7c.jpg', 'orientation_class', 0, 'active', '2026-09-02 10:14:08', '2026-09-02 10:14:08'),
(81, 'Orientation Class 05', 'uploads/gallery/1788344048_6a97f6f008d3c.jpg', 'orientation_class', 0, 'active', '2026-09-02 10:14:09', '2026-09-02 10:14:09'),
(82, 'Orientation Class 06', 'uploads/gallery/1788344049_6a97f6f1d0064.jpg', 'orientation_class', 0, 'active', '2026-09-02 10:14:11', '2026-09-02 10:14:11');

-- --------------------------------------------------------

--
-- Table structure for table `gallery_categories`
--

CREATE TABLE `gallery_categories` (
  `id` int(11) NOT NULL,
  `slug` varchar(50) NOT NULL,
  `name` varchar(100) NOT NULL,
  `icon` varchar(50) DEFAULT 'fa-tag',
  `display_order` int(11) DEFAULT 0,
  `status` enum('active','inactive') DEFAULT 'active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `gallery_categories`
--

INSERT INTO `gallery_categories` (`id`, `slug`, `name`, `icon`, `display_order`, `status`, `created_at`, `updated_at`) VALUES
(6, 'examination', 'Examination', 'fa-clipboard-list', 5, 'active', '2026-09-02 10:02:34', '2026-09-02 10:02:34'),
(7, 'faculty_tour', 'Faculty Tour', 'fa-bus', 6, 'active', '2026-09-02 10:02:34', '2026-09-02 10:02:34'),
(8, 'first_aid_training', 'First Aid Training', 'fa-suitcase-medical', 7, 'active', '2026-09-02 10:02:34', '2026-09-02 10:02:34'),
(9, 'independence_day', 'Independence Day', 'fa-flag', 8, 'active', '2026-09-02 10:02:34', '2026-09-02 10:02:34'),
(10, 'mehfil_e_milad', 'Mehfil-e-Milad', 'fa-mosque', 9, 'active', '2026-09-02 10:02:34', '2026-09-02 10:02:34'),
(11, 'naat_competition', 'Naat Competition', 'fa-microphone', 10, 'active', '2026-09-02 10:02:34', '2026-09-02 10:02:34'),
(12, 'orientation_class', 'Orientation Class', 'fa-door-open', 11, 'active', '2026-09-02 10:02:34', '2026-09-02 10:02:34');

-- --------------------------------------------------------

--
-- Table structure for table `hero_carousel`
--

CREATE TABLE `hero_carousel` (
  `id` int(11) NOT NULL,
  `image_path` varchar(255) NOT NULL,
  `title` varchar(200) DEFAULT NULL,
  `subtitle` text DEFAULT NULL,
  `text_color` varchar(20) DEFAULT '#ffffff',
  `display_order` int(11) DEFAULT 0,
  `status` enum('active','inactive') DEFAULT 'active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `hero_carousel`
--

INSERT INTO `hero_carousel` (`id`, `image_path`, `title`, `subtitle`, `text_color`, `display_order`, `status`, `created_at`, `updated_at`) VALUES
(1, 'images/hero/slide_1788506933_1933.jpg', 'Bahawal College of Health Sciences', 'Empowering students with quality education', '#ffffff', 1, 'active', '2025-12-26 10:06:59', '2026-09-17 04:50:18'),
(2, 'images/hero/slide_1788507002_2032.jpg', 'Shape Your Future in Healthcare', 'Pharm-D, DPT, BS MLT & BS Human Nutrition - affiliated with GCUF', '#ffffff', 2, 'active', '2025-12-26 10:06:59', '2026-09-17 04:50:19');

-- --------------------------------------------------------

--
-- Table structure for table `leadership`
--

CREATE TABLE `leadership` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `designation` varchar(100) NOT NULL,
  `role_title` varchar(100) DEFAULT NULL COMMENT 'e.g., Founder Message, Director Message',
  `photo` varchar(255) DEFAULT NULL,
  `signature` varchar(255) DEFAULT NULL,
  `message` text NOT NULL,
  `display_order` int(11) DEFAULT 0,
  `status` enum('active','inactive') DEFAULT 'active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `leadership`
--

INSERT INTO `leadership` (`id`, `name`, `designation`, `role_title`, `photo`, `signature`, `message`, `display_order`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Tayyab Syed Khan', 'Chairman', 'Chairman', 'images/leadership/leader_1788505447_1759.jpg', '', 'At Bahawal College of Health Sciences, we are committed to preparing skilled, compassionate healthcare professionals for the medical field of tomorrow. Our focus goes beyond academics - we build discipline, clinical competence, and a genuine commitment to patient care in every student.\r\n\r\nGuided by experienced faculty and modern training facilities, our students graduate ready to serve with confidence and integrity. We warmly welcome you to be part of this journey toward excellence in health sciences education.', 1, 'active', '2025-12-26 07:56:01', '2026-09-17 04:50:19'),
(2, 'XYZ', 'Principal', 'Principal', 'images/leadership/leader_1773568876_7312.jpg', '', 'It is my pleasure to welcome you to Bahawal College of Health Sciences, where we nurture future healthcare professionals through quality education and hands-on clinical training.\r\n\r\nWe believe true success comes from combining knowledge with character - discipline, empathy, and a strong sense of responsibility toward the communities our students will serve. We look forward to supporting every student on their path to a rewarding career in health sciences.', 2, 'active', '2025-12-26 07:56:01', '2026-09-15 06:26:36');

-- --------------------------------------------------------

--
-- Table structure for table `menu_items`
--

CREATE TABLE `menu_items` (
  `id` int(11) NOT NULL,
  `label` varchar(100) NOT NULL,
  `icon` varchar(50) DEFAULT 'fa-circle',
  `url` varchar(255) NOT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `open_new_tab` tinyint(1) DEFAULT 0,
  `display_order` int(11) DEFAULT 0,
  `status` enum('active','inactive') DEFAULT 'active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `menu_items`
--

INSERT INTO `menu_items` (`id`, `label`, `icon`, `url`, `parent_id`, `open_new_tab`, `display_order`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Home', 'fa-house', 'index.php', NULL, 0, 1, 'active', '2026-09-02 10:52:27', '2026-09-02 10:52:27'),
(2, 'About', 'fa-circle-info', 'about.php', NULL, 0, 2, 'active', '2026-09-02 10:52:27', '2026-09-02 10:52:27'),
(3, 'Academics', 'fa-book-open', 'courses.php', NULL, 0, 3, 'active', '2026-09-02 10:52:27', '2026-09-02 11:14:29'),
(4, 'Admission', 'fa-file-pen', 'admission.php', NULL, 0, 5, 'active', '2026-09-02 10:52:27', '2026-09-15 04:31:00'),
(5, 'Campuses', 'fa-location-dot', 'campuses.php', NULL, 0, 6, 'active', '2026-09-02 10:52:27', '2026-09-15 04:31:00'),
(6, 'Student Life', 'fa-layer-group', 'events.php', NULL, 0, 7, 'active', '2026-09-02 10:52:27', '2026-09-15 04:31:00'),
(7, 'Gallery', 'fa-images', 'gallery.php', NULL, 0, 8, 'active', '2026-09-02 10:52:27', '2026-09-15 04:31:00'),
(8, 'Contact', 'fa-headset', 'contact.php', NULL, 0, 9, 'active', '2026-09-02 10:52:27', '2026-09-15 04:31:00'),
(9, 'About Us', 'fa-university', 'about.php', 2, 0, 1, 'active', '2026-09-02 10:52:27', '2026-09-02 10:52:27'),
(10, 'Mission & Vision', 'fa-compass', 'mission-vision.php', 2, 0, 2, 'active', '2026-09-02 10:52:27', '2026-09-02 10:52:27'),
(11, 'Core Values', 'fa-heart', 'core-values.php', 2, 0, 3, 'active', '2026-09-02 10:52:27', '2026-09-02 10:52:27'),
(12, 'Leadership', 'fa-users', 'leadership.php', 2, 0, 4, 'active', '2026-09-02 10:52:27', '2026-09-02 11:14:28'),
(13, 'Our Courses', 'fa-book-open', 'courses.php', 3, 0, 1, 'active', '2026-09-02 10:52:27', '2026-09-02 10:52:27'),
(14, 'Faculty Members', 'fa-chalkboard-user', 'faculty.php', 3, 0, 2, 'active', '2026-09-02 10:52:27', '2026-09-02 10:52:27'),
(15, 'Examination', 'fa-file-alt', 'examination.php', 3, 0, 3, 'active', '2026-09-02 10:52:27', '2026-09-02 10:52:27'),
(16, 'Admission Overview', 'fa-info-circle', 'admission.php', 4, 0, 1, 'active', '2026-09-02 10:52:27', '2026-09-02 10:52:27'),
(17, 'Downloads', 'fa-download', 'downloads.php', 4, 0, 2, 'active', '2026-09-02 10:52:27', '2026-09-02 10:52:27'),
(18, 'Notifications', 'fa-bullhorn', 'notifications.php', 4, 0, 3, 'active', '2026-09-02 10:52:27', '2026-09-02 10:52:27'),
(19, 'Our Campuses', 'fa-building-columns', 'campuses.php', 5, 0, 1, 'active', '2026-09-02 10:52:27', '2026-09-02 10:52:27'),
(20, 'Campus Portal', 'fa-sign-in-alt', 'campus-portal.php', 5, 0, 2, 'active', '2026-09-02 10:52:27', '2026-09-02 10:52:27'),
(21, 'Events', 'fa-calendar-alt', 'events.php', 6, 0, 1, 'active', '2026-09-02 10:52:27', '2026-09-02 10:52:27'),
(22, 'News', 'fa-newspaper', 'news.php', 6, 0, 2, 'active', '2026-09-02 10:52:27', '2026-09-02 10:52:27'),
(33, 'Clinical Training', 'fa-hospital', 'clinical-training.php', 44, 0, 1, 'active', '2026-09-14 09:26:25', '2026-09-15 04:31:46'),
(34, 'Fee Calculator', 'fa-calculator', 'fee-calculator.php', 4, 0, 4, 'active', '2026-09-14 09:31:33', '2026-09-14 09:31:33'),
(35, 'Scholarships', 'fa-award', 'scholarships.php', 4, 0, 5, 'active', '2026-09-14 09:43:18', '2026-09-14 09:43:18'),
(36, 'Our Networks', 'fa-circle', 'our-networks.php', 44, 0, 2, 'active', '2026-09-14 10:16:13', '2026-09-15 04:31:46'),
(37, 'Our Projects', 'fa-circle', 'our-projects.php', 44, 0, 3, 'active', '2026-09-14 10:25:33', '2026-09-15 04:31:46'),
(38, 'Affiliations & Accreditation', 'fa-circle', 'accreditation.php', 44, 0, 4, 'active', '2026-09-14 10:31:58', '2026-09-15 04:31:46'),
(39, 'Eligibility Checker', 'fa-circle', 'eligibility-checker.php', 4, 0, 6, 'active', '2026-09-14 10:42:43', '2026-09-14 10:42:43'),
(40, 'Extra-Curricular Activities', 'fa-circle', 'activities.php', 6, 0, 3, 'active', '2026-09-15 03:11:14', '2026-09-15 03:11:14'),
(41, 'Welfare Foundation', 'fa-circle', 'foundation.php', 44, 0, 5, 'active', '2026-09-15 03:29:38', '2026-09-15 04:31:46'),
(42, 'Chairman\'s Message', 'fa-circle', 'chairman-message.php', 2, 0, 5, 'active', '2026-09-15 04:16:13', '2026-09-15 04:33:28'),
(43, 'Principal\'s Message', 'fa-circle', 'principal-message.php', 2, 0, 6, 'active', '2026-09-15 04:24:45', '2026-09-15 04:33:28'),
(44, 'Our Institute', 'fa-building-columns', 'our-networks.php', NULL, 0, 4, 'active', '2026-09-15 04:31:00', '2026-09-15 04:37:46');

-- --------------------------------------------------------

--
-- Table structure for table `merit_scholarship_tiers`
--

CREATE TABLE `merit_scholarship_tiers` (
  `id` int(11) NOT NULL,
  `min_percentage` int(11) NOT NULL,
  `max_percentage` int(11) DEFAULT NULL,
  `discount_pct` int(11) NOT NULL,
  `display_order` int(11) DEFAULT 0,
  `status` enum('active','inactive') DEFAULT 'active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `merit_scholarship_tiers`
--

INSERT INTO `merit_scholarship_tiers` (`id`, `min_percentage`, `max_percentage`, `discount_pct`, `display_order`, `status`, `created_at`, `updated_at`) VALUES
(1, 90, NULL, 35, 1, 'active', '2026-09-17 05:36:16', '2026-09-17 05:39:46'),
(2, 85, 89, 30, 2, 'active', '2026-09-17 05:36:16', '2026-09-17 05:36:16'),
(3, 80, 84, 25, 3, 'active', '2026-09-17 05:36:16', '2026-09-17 05:36:16'),
(4, 75, 79, 20, 4, 'active', '2026-09-17 05:36:16', '2026-09-17 05:36:16'),
(5, 70, 74, 15, 5, 'active', '2026-09-17 05:36:16', '2026-09-17 05:36:16');

-- --------------------------------------------------------

--
-- Table structure for table `network_partners`
--

CREATE TABLE `network_partners` (
  `id` int(11) NOT NULL,
  `category` enum('academic','affiliated_institution','industry_professional') NOT NULL,
  `name` varchar(200) NOT NULL,
  `location` varchar(200) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `logo` varchar(255) DEFAULT NULL,
  `website` varchar(255) DEFAULT NULL,
  `display_order` int(11) DEFAULT 0,
  `status` enum('active','inactive') DEFAULT 'active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `news`
--

CREATE TABLE `news` (
  `id` int(11) NOT NULL,
  `title` varchar(200) NOT NULL,
  `content` text NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `author` varchar(100) DEFAULT NULL,
  `status` enum('active','inactive') DEFAULT 'active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `link` varchar(255) DEFAULT NULL,
  `display_order` int(11) DEFAULT 0,
  `status` enum('active','inactive') DEFAULT 'active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `projects`
--

CREATE TABLE `projects` (
  `id` int(11) NOT NULL,
  `title` varchar(200) NOT NULL,
  `category` varchar(100) DEFAULT NULL,
  `project_date` date DEFAULT NULL,
  `status` enum('ongoing','completed','upcoming') NOT NULL DEFAULT 'ongoing',
  `description` text DEFAULT NULL,
  `details` text DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `display_order` int(11) DEFAULT 0,
  `visibility` enum('active','inactive') DEFAULT 'active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `scholarships`
--

CREATE TABLE `scholarships` (
  `id` int(11) NOT NULL,
  `title` varchar(200) NOT NULL,
  `category` enum('merit','need_based','other') NOT NULL DEFAULT 'merit',
  `percentage` varchar(50) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `eligibility` text DEFAULT NULL,
  `application_procedure` text DEFAULT NULL,
  `terms_conditions` text DEFAULT NULL,
  `icon` varchar(50) DEFAULT 'fa-award',
  `display_order` int(11) DEFAULT 0,
  `status` enum('active','inactive') DEFAULT 'active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `settings`
--

CREATE TABLE `settings` (
  `id` int(11) NOT NULL,
  `setting_key` varchar(100) NOT NULL,
  `setting_value` text DEFAULT NULL,
  `setting_type` varchar(50) DEFAULT 'text',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `settings`
--

INSERT INTO `settings` (`id`, `setting_key`, `setting_value`, `setting_type`, `created_at`, `updated_at`) VALUES
(25, 'site_name', 'Bahawal College of Health Sciences', 'text', '2025-12-26 07:28:46', '2026-09-02 08:18:27'),
(26, 'site_email', 'tayyabdaha@gmail.com', 'text', '2025-12-26 07:28:46', '2026-09-02 09:03:03'),
(27, 'site_phone', '+92 302 0836600', 'text', '2025-12-26 07:28:46', '2026-09-02 09:03:03'),
(28, 'site_address', '43,44 Ameer town near khumharan wala chock, Arifwala, Pakistan', 'text', '2025-12-26 07:28:46', '2026-09-02 09:03:03'),
(29, 'hero_image', 'images/hero/hero_1766742714.jpeg', 'text', '2025-12-26 07:51:44', '2025-12-26 09:51:54'),
(30, 'office_hours', 'Mon - Sat: 8:00 AM - 5:00 PM', 'text', '2025-12-27 07:13:03', '2025-12-27 07:13:03'),
(31, 'facebook_url', 'https://www.facebook.com/p/Bahawal-College-Of-Health-Sciences-100064073435675/', 'text', '2025-12-27 07:13:03', '2026-09-02 09:03:03'),
(32, 'instagram_url', '', 'text', '2025-12-27 07:13:03', '2025-12-27 07:13:03'),
(33, 'youtube_url', '', 'text', '2025-12-27 07:13:03', '2025-12-27 07:13:03'),
(34, 'twitter_url', '', 'text', '2025-12-27 07:13:03', '2025-12-27 07:13:03'),
(35, 'hero_title', 'Lighting the Candle of Knowledge', 'text', '2025-12-27 07:13:03', '2026-08-18 09:37:37'),
(36, 'hero_description', 'Empowering students with quality education and nurturing their potential to become future leaders.', 'text', '2025-12-27 07:13:03', '2026-08-18 09:37:37'),
(37, 'hero_button_text', 'Apply Now', 'text', '2025-12-27 07:13:03', '2026-08-18 09:37:37'),
(38, 'hero_button_link', 'admission.php', 'text', '2025-12-27 07:13:03', '2025-12-27 07:13:03'),
(39, 'stats_students', '500', 'text', '2025-12-27 07:13:03', '2026-08-18 09:37:37'),
(40, 'stats_teachers', '50', 'text', '2025-12-27 07:13:03', '2026-08-18 09:37:37'),
(41, 'stats_courses', '8', 'text', '2025-12-27 07:13:03', '2026-09-04 04:24:46'),
(42, 'stats_years', '3', 'text', '2025-12-27 07:13:03', '2026-09-04 04:26:29'),
(43, 'about_description', 'Bahawal College of Health Sciences is a leading educational institution committed to excellence in education...', 'text', '2025-12-27 07:13:03', '2026-09-02 08:19:48'),
(44, 'mission_statement', 'The mission of Bahawal College of Health Sciences is to provide high-quality education in a supportive, disciplined environment that nurtures academic excellence, critical thinking, and personal growth. Through dedicated teaching and modern learning methods, we develop confident, capable, and ethical individuals ready to serve their community and nation.', 'text', '2025-12-27 07:13:03', '2026-09-15 09:20:30'),
(45, 'vision_statement', 'The vision of Bahawal College of Health Sciences is to become a leading educational institution recognized for academic excellence, character building, and innovation in learning. We aspire to create an environment where students are inspired to achieve their highest potential and develop into knowledgeable, confident, and responsible individuals.', 'text', '2025-12-27 07:13:03', '2026-09-02 08:19:48'),
(46, 'footer_about_text', 'Bahawal College of Health Sciences is dedicated to providing quality education focused on academic excellence, discipline, and ethical values. We strive to nurture confident, responsible, and well-rounded students in a supportive and inspiring learning environment.', 'text', '2025-12-27 07:13:03', '2026-09-02 08:19:48'),
(47, 'copyright_text', 'Bahawal College of Health Sciences. All rights reserved.', 'text', '2025-12-27 07:13:03', '2026-09-02 08:19:48'),
(48, 'google_maps_embed', '43,44 Ameer town near khumharan wala chock, Arifwala, Pakistan', 'text', '2025-12-27 07:13:03', '2026-09-02 09:03:03'),
(49, 'whatsapp_number', ' +92 302 0836600', 'text', '2025-12-27 07:13:03', '2026-09-02 09:03:03'),
(50, 'about_stat1_number', '98%', 'text', '2026-08-18 09:52:30', '2026-08-18 09:52:30'),
(51, 'about_stat1_label', 'Board Pass Rate', 'text', '2026-08-18 09:52:30', '2026-08-18 09:52:30'),
(52, 'about_stat2_number', '500+', 'text', '2026-08-18 09:52:30', '2026-08-18 09:52:30'),
(53, 'about_stat2_label', 'Students Enrolled', 'text', '2026-08-18 09:52:30', '2026-08-18 09:52:30'),
(54, 'about_stat3_number', '40+', 'text', '2026-08-18 09:52:30', '2026-08-18 09:52:30'),
(55, 'about_stat3_label', 'Expert Faculty', 'text', '2026-08-18 09:52:31', '2026-08-18 09:52:31'),
(56, 'about_stat4_number', '15+', 'text', '2026-08-18 09:52:31', '2026-08-18 09:52:31'),
(57, 'about_stat4_label', 'Years of Excellence', 'text', '2026-08-18 09:52:31', '2026-08-18 09:52:31'),
(58, 'contact_hours_weekday', '8:00 AM - 5:00 PM', 'text', '2026-08-18 10:51:15', '2026-08-18 10:51:15'),
(59, 'contact_hours_saturday', '9:00 AM - 3:00 PM', 'text', '2026-08-18 10:51:15', '2026-08-18 10:51:15'),
(60, 'contact_hours_sunday', 'Closed', 'text', '2026-08-18 10:51:15', '2026-08-18 10:51:15'),
(67, 'about_hero_badge', 'About B.C.H.S', 'text', '2026-09-03 03:12:52', '2026-09-03 03:12:52'),
(68, 'about_hero_subtitle', 'Learn about our mission, vision, and commitment to providing quality education that shapes futures and transforms lives.', 'text', '2026-09-03 03:12:52', '2026-09-03 03:12:52'),
(69, 'about_who_badge', 'Who We Are', 'text', '2026-09-03 03:12:52', '2026-09-03 03:12:52'),
(70, 'about_who_title', 'Shaping Futures Through Quality Education', 'text', '2026-09-03 03:12:52', '2026-09-03 03:12:52'),
(71, 'about_who_title_highlight', 'Quality Education', 'text', '2026-09-03 03:12:52', '2026-09-03 03:12:52'),
(72, 'about_who_paragraph2', 'With experienced faculty, modern facilities, and a student-centered approach, we create an environment where every student can thrive and reach their full potential.', 'text', '2026-09-03 03:12:52', '2026-09-03 03:12:52'),
(73, 'about_who_hl1', 'Board-Aligned Curriculum', 'text', '2026-09-03 03:12:52', '2026-09-03 03:12:52'),
(74, 'about_who_hl2', 'Expert Faculty', 'text', '2026-09-03 03:12:52', '2026-09-03 03:12:52'),
(75, 'about_who_hl3', 'Digital Campus', 'text', '2026-09-03 03:12:52', '2026-09-03 03:12:52'),
(76, 'about_who_hl4', 'Affordable Fees', 'text', '2026-09-03 03:12:52', '2026-09-03 03:12:52'),
(77, 'about_image_badge_num', '15+', 'text', '2026-09-03 03:12:52', '2026-09-03 03:12:52'),
(78, 'about_image_badge_label', 'Years of Excellence', 'text', '2026-09-03 03:12:52', '2026-09-03 03:12:52'),
(79, 'about_image', 'images/about_1788405172_1814.jpg', 'text', '2026-09-03 03:12:52', '2026-09-17 04:50:19'),
(80, 'courses_req1_head', 'Regular Programs', 'text', '2026-09-04 03:46:54', '2026-09-04 03:46:54'),
(81, 'courses_req1_items', 'F.Sc (Pre-Medical) certificate & result card\nCNIC or B-Form copy\n6 passport size photographs\nMigration certificate (if applicable)\nAdmission & registration fee', 'text', '2026-09-04 03:46:54', '2026-09-04 03:46:54'),
(82, 'courses_req2_head', 'Short Courses', 'text', '2026-09-04 03:46:54', '2026-09-04 03:46:54'),
(83, 'courses_req2_items', 'Educational certificates (as applicable)\nCNIC or B-Form copy\n2 passport size photographs\nCourse registration form\nCourse fee', 'text', '2026-09-04 03:46:54', '2026-09-04 03:46:54'),
(84, 'wcu_stat3_number', '3+', 'text', '2026-09-04 04:26:29', '2026-09-04 04:26:29'),
(85, 'erp_enabled', '0', 'text', '2026-09-14 11:04:52', '2026-09-14 11:04:52'),
(92, 'courses_hero_badge', 'Programs Offered', 'text', '2026-09-15 09:33:20', '2026-09-15 09:33:20'),
(93, 'courses_hero_subtitle', 'Browse every program we currently offer — with real duration, fees and eligibility — to find out what you can study here.', 'text', '2026-09-15 09:33:20', '2026-09-15 09:33:20'),
(94, 'dms_badge', 'Digital Innovation', 'text', '2026-09-16 07:18:41', '2026-09-16 07:18:41'),
(95, 'dms_title_line1', 'Complete Digital Campus', 'text', '2026-09-16 07:18:41', '2026-09-16 07:18:41'),
(96, 'dms_title_line2', 'Management System', 'text', '2026-09-16 07:18:41', '2026-09-16 07:18:41'),
(97, 'dms_subtitle', '{site_name} is fully digitized — experience modern education with cutting-edge technology at your fingertips.', 'text', '2026-09-16 07:18:41', '2026-09-16 07:18:41'),
(98, 'dms_cta_title', 'Download Our Mobile App', 'text', '2026-09-16 07:18:41', '2026-09-16 07:18:41'),
(99, 'dms_cta_desc', 'Access all school features on your smartphone. Stay connected with your child\'s education anytime, anywhere.', 'text', '2026-09-16 07:18:42', '2026-09-16 07:18:42'),
(100, 'dms_playstore_link', '#', 'text', '2026-09-16 07:18:42', '2026-09-16 07:18:42'),
(101, 'wcu_stat1_number', '98%', 'text', '2026-09-16 07:18:43', '2026-09-16 07:18:43'),
(102, 'wcu_stat1_label', 'Pass Rate', 'text', '2026-09-16 07:18:43', '2026-09-16 07:18:43'),
(103, 'wcu_stat2_number', '500+', 'text', '2026-09-16 07:18:43', '2026-09-16 07:18:43'),
(104, 'wcu_stat2_label', 'Students', 'text', '2026-09-16 07:18:43', '2026-09-16 07:18:43'),
(105, 'wcu_stat3_label', 'Years Exp.', 'text', '2026-09-16 07:18:43', '2026-09-16 07:18:43');

-- --------------------------------------------------------

--
-- Table structure for table `students`
--

CREATE TABLE `students` (
  `id` int(11) NOT NULL,
  `registration_no` varchar(30) NOT NULL,
  `full_name` varchar(150) NOT NULL,
  `father_name` varchar(150) NOT NULL,
  `cnic` varchar(20) DEFAULT NULL,
  `gender` enum('male','female') NOT NULL DEFAULT 'male',
  `date_of_birth` date DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `course_id` int(11) DEFAULT NULL,
  `semester` varchar(30) DEFAULT NULL,
  `admission_date` date DEFAULT NULL,
  `photo` varchar(255) DEFAULT NULL,
  `status` enum('active','graduated','left','suspended') NOT NULL DEFAULT 'active',
  `previous_education` varchar(255) DEFAULT NULL,
  `special_notes` text DEFAULT NULL,
  `converted_from_admission_id` int(11) DEFAULT NULL,
  `erp_sync_status` enum('not_configured','pending','synced','failed') NOT NULL DEFAULT 'not_configured',
  `erp_student_id` varchar(50) DEFAULT NULL,
  `erp_synced_at` timestamp NULL DEFAULT NULL,
  `erp_sync_error` varchar(500) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `students`
--

INSERT INTO `students` (`id`, `registration_no`, `full_name`, `father_name`, `cnic`, `gender`, `date_of_birth`, `phone`, `email`, `address`, `course_id`, `semester`, `admission_date`, `photo`, `status`, `previous_education`, `special_notes`, `converted_from_admission_id`, `erp_sync_status`, `erp_student_id`, `erp_synced_at`, `erp_sync_error`, `created_at`, `updated_at`) VALUES
(7, 'BCHS-2026-0001', 'Umar Ali', 'Arshad Ali', '45234523452452', 'male', NULL, '03159060190', '', 'adfasdfadfadsf', NULL, '', '2026-09-04', NULL, 'active', '65%', '', 2, 'not_configured', NULL, NULL, NULL, '2026-09-04 07:49:43', '2026-09-04 07:49:43');

-- --------------------------------------------------------

--
-- Table structure for table `student_exams`
--

CREATE TABLE `student_exams` (
  `id` int(11) NOT NULL,
  `exam_id` int(11) NOT NULL,
  `total_marks` decimal(10,2) NOT NULL,
  `student_name` varchar(255) NOT NULL,
  `father_name` varchar(255) DEFAULT NULL,
  `registration_no` varchar(100) NOT NULL,
  `obtain_marks` decimal(10,2) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `student_exams`
--

INSERT INTO `student_exams` (`id`, `exam_id`, `total_marks`, `student_name`, `father_name`, `registration_no`, `obtain_marks`, `created_at`, `updated_at`) VALUES
(1, 2, 75.00, 'Zaid', 'Ali', '258', 65.00, '2026-01-27 09:45:40', NULL),
(2, 2, 75.00, 'Subhan', 'Mukhtar', '260', 72.00, '2026-01-27 09:45:40', NULL),
(3, 2, 75.00, 'Hameed', 'Ahmad', '245', 55.00, '2026-01-27 09:45:40', NULL),
(4, 2, 75.00, 'Asghar', 'Ali', '261', 75.00, '2026-01-27 09:45:40', NULL),
(5, 2, 75.00, 'Aqib', 'Majeed', '290', 49.00, '2026-01-27 09:45:40', '2026-01-27 09:55:20'),
(6, 2, 75.00, 'Hamza', 'Babar', '300', 21.00, '2026-01-27 09:45:40', NULL),
(7, 3, 50.00, 'Zaid', NULL, '258', 11.00, '2026-01-27 10:45:58', NULL),
(8, 3, 100.00, 'Ali Ahmed', 'Hasan Ahmed', '2024-001', 85.00, '2026-03-02 08:07:22', NULL),
(9, 3, 100.00, 'Sara Khan', 'Imran Khan', '2024-002', 92.00, '2026-03-02 08:07:22', NULL),
(10, 3, 100.00, 'Zain Malik', 'Usman Malik', '2024-003', 78.00, '2026-03-02 08:07:22', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `student_societies`
--

CREATE TABLE `student_societies` (
  `id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL,
  `description` text DEFAULT NULL,
  `focus_area` varchar(150) DEFAULT NULL,
  `meeting_info` varchar(255) DEFAULT NULL,
  `icon` varchar(50) DEFAULT 'fa-people-group',
  `image` varchar(255) DEFAULT NULL,
  `display_order` int(11) DEFAULT 0,
  `status` enum('active','inactive') DEFAULT 'active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `themes`
--

CREATE TABLE `themes` (
  `id` int(11) NOT NULL,
  `theme_name` varchar(100) NOT NULL,
  `primary_color` varchar(7) NOT NULL DEFAULT '#0B4DA2',
  `secondary_color` varchar(7) NOT NULL DEFAULT '#FFFFFF',
  `accent_color` varchar(7) NOT NULL DEFAULT '#F9C900',
  `logo_path` varchar(255) DEFAULT 'images/logo.png',
  `is_active` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `themes`
--

INSERT INTO `themes` (`id`, `theme_name`, `primary_color`, `secondary_color`, `accent_color`, `logo_path`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'Default - Blue & Yellow', '#0B4DA2', '#FFFFFF', '#F9C900', 'images/logos/logo_1768371326.jpeg', 0, '2025-12-26 06:58:34', '2026-01-14 07:00:26'),
(2, 'Green Theme', '#1B5E20', '#FFFFFF', '#FDD835', 'images/logo.png', 0, '2025-12-26 06:58:34', '2026-01-14 06:59:57'),
(3, 'Purple Theme', '#4A148C', '#FFFFFF', '#FFD740', 'images/logo.png', 0, '2025-12-26 06:58:34', '2025-12-26 06:58:34'),
(4, 'Red Theme', '#B71C1C', '#FFFFFF', '#FFD700', 'images/logos/logo_1766733969.png', 0, '2025-12-26 06:58:34', '2025-12-26 09:38:48'),
(5, 'Teal Theme', '#00695C', '#FFFFFF', '#FFB300', 'images/logos/logo_1768385142.png', 0, '2025-12-26 06:58:34', '2026-03-14 11:08:46'),
(6, 'BCHS Navy & Cyan Theme', '#17165B', '#FFFFFF', '#09A9D9', 'images/logos/logo_1788339816.png', 1, '2025-12-26 06:58:34', '2026-09-02 09:03:36');

-- --------------------------------------------------------

--
-- Table structure for table `unique_visitors`
--

CREATE TABLE `unique_visitors` (
  `id` int(11) NOT NULL,
  `visitor_ip` varchar(45) NOT NULL,
  `session_id` varchar(100) NOT NULL,
  `first_visit` timestamp NOT NULL DEFAULT current_timestamp(),
  `last_visit` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `total_visits` int(11) DEFAULT 1,
  `user_agent` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `unique_visitors`
--

INSERT INTO `unique_visitors` (`id`, `visitor_ip`, `session_id`, `first_visit`, `last_visit`, `total_visits`, `user_agent`) VALUES
(1, '127.0.0.1', 'd5jspmud1b47s4ncofloekjgpr', '2025-12-27 09:51:30', '2025-12-27 10:43:42', 29, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:146.0) Gecko/20100101 Firefox/146.0'),
(2, '::1', 'kkbk6ki04deocaqg1c56a1h1hs', '2026-01-05 07:54:49', '2026-01-05 09:10:20', 4, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36'),
(3, '127.0.0.1', '1tkhaulgu9mobi38vhu99gj6cd', '2026-01-13 09:31:44', '2026-01-13 09:59:52', 8, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:146.0) Gecko/20100101 Firefox/146.0'),
(4, '::1', 'h8unkai0empu9dca4f89dpnetj', '2026-01-14 05:39:31', '2026-01-14 07:20:50', 31, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36'),
(5, '127.0.0.1', '05gcre9067e2v7pejjete1vgda', '2026-01-14 10:04:17', '2026-01-14 10:05:48', 3, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:146.0) Gecko/20100101 Firefox/146.0'),
(6, '::1', 'ffppbhsphl6k15okg0hvl2dsft', '2026-01-27 08:52:04', '2026-01-27 10:47:01', 26, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36'),
(7, '127.0.0.1', 'ga6dduep8slm4crmf4a8hloi57', '2026-01-28 11:25:00', '2026-01-28 11:25:00', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:147.0) Gecko/20100101 Firefox/147.0'),
(8, '127.0.0.1', 'n1b8e0mqhvi4muf7p90v7920vq', '2026-01-29 09:03:24', '2026-01-29 09:21:26', 11, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:147.0) Gecko/20100101 Firefox/147.0'),
(9, '127.0.0.1', 'r5aqkek0qd8mhki1ldm93p08pr', '2026-03-02 07:17:22', '2026-03-02 07:18:46', 4, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:148.0) Gecko/20100101 Firefox/148.0'),
(10, '::1', 'bqm074mnfg4qtcfor8sshokrl4', '2026-03-14 10:42:10', '2026-03-14 16:02:01', 29, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36'),
(23, '::1', 'idkf1resvep611610l7u01tl9v', '2026-03-31 06:38:37', '2026-03-31 06:54:25', 5, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36'),
(24, '127.0.0.1', 's4tf866c02r0tk62rsku2898v6', '2026-04-06 03:29:42', '2026-04-06 03:36:33', 3, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:149.0) Gecko/20100101 Firefox/149.0'),
(25, '::1', 'gndbq25omqgt8alesip48sibpi', '2026-05-19 07:16:19', '2026-05-19 11:07:06', 67, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(26, '127.0.0.1', '69sc1n07dkbeanuknm10htke8n', '2026-05-20 03:13:19', '2026-05-20 06:35:36', 27, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:150.0) Gecko/20100101 Firefox/150.0'),
(27, '::1', 'l105dtlmdm1avt98avorhahnqb', '2026-05-20 04:45:01', '2026-05-20 04:45:01', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(28, '::1', 'fsv002e0esc0pcp14407g6mgs0', '2026-05-21 07:20:25', '2026-05-21 07:20:25', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(29, '127.0.0.1', '0qgocbogaeqlkah9gsj1sun0tp', '2026-06-08 05:19:57', '2026-06-08 05:19:57', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(34, '::1', 'mb3ua4k1aiblfh1hf090ephqp5', '2026-06-08 06:10:12', '2026-06-08 06:22:31', 13, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(35, '::1', 'df3j0s14o91vci4sai9gld39s5', '2026-07-25 07:05:52', '2026-07-27 08:18:06', 6, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36'),
(37, '::1', 'hksg0k581jpm4hmg04mingfpgl', '2026-07-27 07:56:13', '2026-07-27 08:07:20', 33, 'curl/8.15.0'),
(38, '::1', 'hci3thoo938surrdal8b9o7f6g', '2026-07-27 08:17:16', '2026-07-27 08:17:16', 1, 'curl/8.15.0'),
(39, '::1', 'f9psieimke0bbohad8n2nt03bh', '2026-07-27 08:17:16', '2026-07-27 08:17:16', 1, 'curl/8.15.0'),
(40, '::1', 'd25jbpgk2njcu54tun0dhjq2q3', '2026-07-27 08:17:16', '2026-07-27 08:17:16', 1, 'curl/8.15.0'),
(41, '::1', 'ic3kh7p6vogp3nont9ibmvird1', '2026-07-27 08:17:16', '2026-07-27 08:17:16', 1, 'curl/8.15.0'),
(42, '::1', '6fpj1h7vko50atnqfvt372cuh7', '2026-07-27 08:17:16', '2026-07-27 08:17:16', 1, 'curl/8.15.0'),
(43, '::1', 'v3cit74gk23prsul4hvqu43jtk', '2026-07-27 08:17:17', '2026-07-27 08:17:17', 1, 'curl/8.15.0'),
(44, '::1', 'th2unoldhq41nf2b1h2m032mle', '2026-07-27 08:17:30', '2026-07-27 08:17:30', 1, 'curl/8.15.0'),
(45, '::1', 'rc63j3i25qc2rsm9nbr2olpa1a', '2026-07-27 08:17:30', '2026-07-27 08:17:30', 1, 'curl/8.15.0'),
(46, '::1', '7tineb0li7hpndpdifr8goac61', '2026-07-27 08:17:30', '2026-07-27 08:17:30', 1, 'curl/8.15.0'),
(47, '::1', 'ul9mv2gs2ao34ski7vfjc691ol', '2026-07-27 08:17:30', '2026-07-27 08:17:30', 1, 'curl/8.15.0'),
(48, '::1', 'vuha86i043ae26uet2govnnjis', '2026-07-27 08:17:30', '2026-07-27 08:17:30', 1, 'curl/8.15.0'),
(49, '::1', 'aci3df48lgpf40bdgm0c40ml4h', '2026-07-27 08:17:30', '2026-07-27 08:17:30', 1, 'curl/8.15.0'),
(50, '::1', 'ftknb15vuu8o2f7do2fun5c3sn', '2026-07-27 08:17:30', '2026-07-27 08:17:30', 1, 'curl/8.15.0'),
(51, '::1', 'phurh31dch51gfj5ihmf35dfu3', '2026-07-27 08:17:30', '2026-07-27 08:17:30', 1, 'curl/8.15.0'),
(52, '::1', 'gftaspkett7p4974dgngf5e5si', '2026-07-27 08:17:30', '2026-07-27 08:17:30', 1, 'curl/8.15.0'),
(53, '::1', '0nptaqqcvhdqsi69i9aofgaird', '2026-07-27 08:17:31', '2026-07-27 08:17:31', 1, 'curl/8.15.0'),
(54, '::1', 'ne9l9lt3miuej43is3mnc20mcp', '2026-07-27 08:17:31', '2026-07-27 08:17:31', 1, 'curl/8.15.0'),
(55, '::1', '50o40j47s2o9808mtfbiuo5l7i', '2026-07-27 08:17:31', '2026-07-27 08:17:31', 1, 'curl/8.15.0'),
(56, '::1', 'alf055cj1hv0i414g9cfvm4t4c', '2026-07-27 08:17:31', '2026-07-27 08:17:31', 1, 'curl/8.15.0'),
(57, '::1', 'rmkeb3kn3q5topm8e5f2gaut5v', '2026-07-27 08:17:31', '2026-07-27 08:17:31', 1, 'curl/8.15.0'),
(58, '::1', '9aek9s0e237hv06uah89nhbkl1', '2026-07-27 08:17:31', '2026-07-27 08:17:31', 1, 'curl/8.15.0'),
(59, '::1', 'gfjcpovmbvp5fqlv2rbmc3rqqh', '2026-07-27 08:17:31', '2026-07-27 08:17:31', 1, 'curl/8.15.0'),
(60, '::1', 'edmesdq9arcqii272qm55ddb9k', '2026-07-27 08:17:31', '2026-07-27 08:17:31', 1, 'curl/8.15.0'),
(63, '::1', '01slk03unf5k03krgfe0d2b01h', '2026-07-27 09:35:22', '2026-07-27 09:35:22', 1, 'curl/8.15.0'),
(64, '::1', '4s1oc4uhl3d92mc328n6sqeu93', '2026-07-27 09:35:23', '2026-07-27 09:35:23', 1, 'curl/8.15.0'),
(65, '::1', 'qd2bovg547fl4mapj32vaq47up', '2026-07-27 09:35:47', '2026-07-27 09:35:47', 1, 'curl/8.15.0'),
(66, '::1', 'dud8ivihnefdh56jollj4ol4m8', '2026-07-27 09:35:47', '2026-07-27 09:35:47', 1, 'curl/8.15.0'),
(67, '::1', 'pu3tu3me8fmcpvfp2jghdjugpt', '2026-08-18 09:12:11', '2026-08-18 10:42:26', 33, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36 Edg/151.0.0.0'),
(70, '::1', 'vs0td2jc8ekikj334jlmjdfh4s', '2026-08-18 09:29:42', '2026-08-18 09:29:42', 1, 'curl/8.15.0'),
(71, '::1', 'gvb4iqi86moaod09gjevpmmbnr', '2026-08-18 09:45:42', '2026-08-18 09:45:42', 1, 'curl/8.15.0'),
(76, '::1', '8pf0d813s9qu7cgfl6kraliq6o', '2026-08-18 09:52:03', '2026-08-18 09:52:03', 1, 'curl/8.15.0'),
(77, '::1', 'coeb9gqql4rt4muj9u8elehe3d', '2026-08-18 09:52:04', '2026-08-18 09:52:04', 1, 'curl/8.15.0'),
(78, '::1', '7rlds96bkv8qclo2vq25h6onq7', '2026-08-18 09:52:04', '2026-08-18 09:52:04', 1, 'curl/8.15.0'),
(79, '::1', 'qme6fu4pqi087v0466hg29b30h', '2026-08-18 09:52:04', '2026-08-18 09:52:04', 1, 'curl/8.15.0'),
(80, '::1', 'a34qvbpoq4nkkqiup51n8mkbo8', '2026-08-18 09:52:31', '2026-08-18 09:52:31', 1, 'curl/8.15.0'),
(86, '::1', 'ecc3c7fdcs0k8o97ve3v81bm9s', '2026-08-18 10:07:26', '2026-08-18 10:07:26', 1, 'curl/8.15.0'),
(87, '::1', '3eabfgansasfmscroe8r09svev', '2026-08-18 10:07:27', '2026-08-18 10:07:27', 1, 'curl/8.15.0'),
(88, '::1', 'sjhmuslralfpc77vfi82l1dtvk', '2026-08-18 10:07:27', '2026-08-18 10:07:27', 1, 'curl/8.15.0'),
(89, '::1', 'h79nnso9ku5akfug1simmm75c5', '2026-08-18 10:07:39', '2026-08-18 10:07:39', 1, 'curl/8.15.0'),
(90, '::1', '0ip4no1mhhjada1rnrtfbh437h', '2026-08-18 10:08:04', '2026-08-18 10:08:04', 1, 'curl/8.15.0'),
(97, '::1', 'm1o7bdcl11an619fh771487j82', '2026-08-18 10:17:34', '2026-08-18 10:17:34', 1, 'curl/8.15.0'),
(98, '::1', '372g97vspajmjjmtp2l868rj6g', '2026-08-18 10:17:34', '2026-08-18 10:17:34', 1, 'curl/8.15.0'),
(99, '::1', '28icri8ipidc5h9lr2p1qdrtko', '2026-08-18 10:17:34', '2026-08-18 10:17:34', 1, 'curl/8.15.0'),
(100, '::1', 'fbina1ednhd1vth0os9jurm894', '2026-08-18 10:17:52', '2026-08-18 10:17:52', 1, 'curl/8.15.0'),
(102, '::1', 'lpqqjota1si4mhvsm9pogvo0n4', '2026-08-18 10:24:26', '2026-08-18 10:24:26', 1, 'curl/8.15.0'),
(103, '::1', 'ngpvilu3en35fn6pcoie876r13', '2026-08-18 10:26:25', '2026-08-18 10:26:25', 1, 'curl/8.15.0'),
(107, '::1', 'guh1gfn70ehkvqoo163hf0c979', '2026-08-18 10:34:01', '2026-08-18 10:34:01', 1, 'curl/8.15.0'),
(108, '::1', 'sua54pkhpjubhsnk089g4utml7', '2026-08-18 10:34:01', '2026-08-18 10:34:01', 1, 'curl/8.15.0'),
(109, '::1', 'nqq7d3412a14ld7jt2n5i91dsg', '2026-08-18 10:34:01', '2026-08-18 10:34:01', 1, 'curl/8.15.0'),
(110, '::1', 'u14a51i44ncomk9uraeupqqpll', '2026-08-18 10:34:12', '2026-08-18 10:34:12', 1, 'curl/8.15.0'),
(120, '::1', 'psi3rvplrtu3dhl6dom80nrtk0', '2026-08-18 10:41:12', '2026-08-18 10:41:12', 1, 'curl/8.15.0'),
(121, '::1', 'ov64j6pk1o2u8akrsnu36gm5n9', '2026-08-18 10:41:12', '2026-08-18 10:41:12', 1, 'curl/8.15.0'),
(124, '::1', 'hdb0psteuukq8458d3pun2abvh', '2026-08-18 10:50:28', '2026-08-18 10:50:28', 1, 'curl/8.15.0'),
(125, '::1', '3bfd1upjsj5b0oi1ghl3337qa9', '2026-08-18 10:50:28', '2026-08-18 10:50:28', 1, 'curl/8.15.0'),
(126, '::1', 'tcatjrkoi3lvojmaiuuc2sd986', '2026-08-18 10:51:02', '2026-08-18 10:51:02', 1, 'curl/8.15.0'),
(127, '::1', 'c0ju1nfrasghvqp2v0qg0grqag', '2026-08-18 10:51:15', '2026-08-18 10:51:15', 1, 'curl/8.15.0'),
(128, '::1', 'rnttge7rlsg1gijce2ne831ivm', '2026-08-20 11:28:53', '2026-08-20 11:28:59', 2, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36'),
(130, '::1', 'rfsakn7efgvo9sftq9r2nbo1sn', '2026-08-20 11:44:20', '2026-08-20 11:44:20', 1, 'curl/8.15.0'),
(131, '::1', 'rkrfbpmnedvv3idfhjj8kff1mg', '2026-08-20 11:44:29', '2026-08-20 11:44:29', 1, 'curl/8.15.0'),
(132, '::1', 'v53iav7ot5g8li8j762404ejlq', '2026-08-20 11:44:42', '2026-08-20 11:44:42', 1, 'curl/8.15.0'),
(133, '::1', 'cijdrpnv2lg615mrp3fp7qola9', '2026-08-20 11:45:25', '2026-08-20 11:45:25', 1, 'curl/8.15.0'),
(134, '::1', 'l2h7k22gs2m1mmdamdf5me05ku', '2026-08-20 11:45:31', '2026-08-20 11:45:31', 1, 'curl/8.15.0'),
(135, '::1', 'aa3bpdinsgv6dqu05p317fhl0a', '2026-08-21 10:24:34', '2026-08-21 10:27:33', 2, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36'),
(137, '::1', 'us39m15vnt1mde3j3d3p51st2f', '2026-08-21 10:45:27', '2026-08-21 10:45:27', 1, 'curl/8.15.0'),
(138, '::1', 'dp9jktkksoj6cc9cinkeaer8ss', '2026-08-21 10:45:40', '2026-08-21 10:45:40', 1, 'curl/8.15.0'),
(139, '::1', 'l70jrro8h2hk71t4u3i74d4gao', '2026-08-21 10:45:40', '2026-08-21 10:45:40', 1, 'curl/8.15.0'),
(140, '::1', 'tfoftnjhq6l1ud1nhjka0lqdb4', '2026-08-21 11:11:10', '2026-08-21 11:11:10', 1, 'curl/8.15.0'),
(141, '::1', 'fccuc519ne7gm7t7cq09ebt2tc', '2026-08-21 11:11:17', '2026-08-21 11:11:17', 1, 'curl/8.15.0'),
(142, '::1', '8bot9pka0222tnj881405b52is', '2026-08-21 11:11:17', '2026-08-21 11:11:17', 1, 'curl/8.15.0'),
(143, '::1', '3k70vfs8p986j02n2sdfrep39p', '2026-08-21 11:24:20', '2026-08-21 11:24:20', 1, 'curl/8.15.0'),
(144, '::1', 'kccvevm92ldri54nkp92t8bnep', '2026-08-21 11:24:20', '2026-08-21 11:24:20', 1, 'curl/8.15.0'),
(145, '::1', '2jptcl78edjdtcm1u5hqou2erm', '2026-08-21 11:24:21', '2026-08-21 11:24:21', 1, 'curl/8.15.0'),
(146, '::1', 'q9ijae71on09irm183oelm5qt5', '2026-08-21 11:29:26', '2026-08-21 11:29:26', 1, 'curl/8.15.0'),
(147, '::1', 'qsjt0tr3g4vrapl8muh1bb4rje', '2026-08-21 11:29:26', '2026-08-21 11:29:26', 1, 'curl/8.15.0'),
(148, '::1', '0vsj4ht8ciru14jadk71hs0le1', '2026-08-21 11:29:27', '2026-08-21 11:29:27', 1, 'curl/8.15.0'),
(149, '::1', 'gu2tabnecjg2ksqo37evrhbi35', '2026-08-21 11:29:38', '2026-08-21 11:29:38', 1, 'curl/8.15.0'),
(150, '::1', 'bn8vsf27o48i19eb1vmufd20vc', '2026-08-21 11:29:38', '2026-08-21 11:29:38', 1, 'curl/8.15.0'),
(151, '::1', 'mjb5q61kjuhlsuqufle94ncp5h', '2026-08-21 11:29:39', '2026-08-21 11:29:39', 1, 'curl/8.15.0'),
(152, '::1', 'a1fdteb3aru95843gra0hg118u', '2026-08-21 11:29:45', '2026-08-21 11:29:45', 1, 'curl/8.15.0'),
(153, '::1', 'bgb39n3nviqk4m0ga0c5egpjl6', '2026-08-21 11:29:46', '2026-08-21 11:29:46', 1, 'curl/8.15.0'),
(154, '::1', 'a84dd3nhf1g6ikjt8dbju8gm58', '2026-08-21 11:29:48', '2026-08-21 11:29:48', 1, 'curl/8.15.0'),
(155, '::1', '03nbnf85sis9vmescqqmr6cum4', '2026-08-24 09:19:00', '2026-08-24 09:19:00', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36'),
(156, '::1', 'f9c9tfn35t60e7hiv64q7d0boa', '2026-09-02 07:47:52', '2026-09-04 08:02:03', 88, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36'),
(157, '::1', 'gkbti10s71t73v8v3ubscbi3l9', '2026-09-02 08:20:47', '2026-09-02 08:20:47', 1, 'curl/8.19.0'),
(158, '::1', 'rvtr3dniec9v2m8uh6tp4f10fb', '2026-09-02 08:23:57', '2026-09-02 08:23:57', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(159, '::1', 'pm0jvh52gfnl7p3hb8k7kchv7i', '2026-09-02 08:24:16', '2026-09-02 08:24:16', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(160, '::1', '0ua0uhmvo2frrv2egjkt6jv3vn', '2026-09-02 08:24:28', '2026-09-02 08:24:28', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(161, '::1', 'qa5tsfjf8s8mkjugk9ee0o6ejo', '2026-09-02 08:26:38', '2026-09-02 08:26:38', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(162, '::1', 'ovg82ul6sh8ncsc17f2782fs0k', '2026-09-02 08:27:06', '2026-09-02 08:27:06', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(163, '::1', 'f2gtjt3dseo4apor6ul0ne4578', '2026-09-02 08:27:27', '2026-09-02 08:27:27', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(164, '::1', 's1623givdm83cuiecqa7hnaa6g', '2026-09-02 08:30:08', '2026-09-02 08:30:08', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(165, '::1', 'lmnmdlf6qdng89qtfcsk2v4fmd', '2026-09-02 08:32:43', '2026-09-02 08:32:43', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(166, '::1', 'g2hlhsfpq0ernpcj2kj65e3a21', '2026-09-02 08:32:51', '2026-09-02 08:32:51', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(167, '::1', 'gmfnhomjc2e91vebe9u2n2lcg6', '2026-09-02 08:32:57', '2026-09-02 08:32:57', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(171, '::1', '8vl5d7940tv5k5n8uq8m25t1v2', '2026-09-02 08:42:50', '2026-09-02 08:42:50', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(173, '::1', '1qpitq650i4f1edvh7rb276igr', '2026-09-02 08:42:59', '2026-09-02 08:42:59', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(174, '::1', 'sc2s50bas67alhl7a6gf6109bm', '2026-09-02 08:43:08', '2026-09-02 08:43:08', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(175, '::1', 'sebknp7blroq8ibhhemvpfhe03', '2026-09-02 08:43:17', '2026-09-02 08:43:17', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(176, '::1', 'lp7g5nanlglmcki5sae0g5a9rh', '2026-09-02 08:43:20', '2026-09-02 08:43:20', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(177, '::1', '9fqrafm23dnp4gdi5ak7mqrpld', '2026-09-02 08:43:25', '2026-09-02 08:43:25', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(178, '::1', '1mb1auj4q4osfmoft3qbusg2p3', '2026-09-02 08:43:28', '2026-09-02 08:43:28', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(179, '::1', 'tlchblk46ccassfap9s9hqkdkp', '2026-09-02 08:43:31', '2026-09-02 08:43:31', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(180, '::1', 'u7oqibli1bf3i34mo8miskiq6i', '2026-09-02 08:43:33', '2026-09-02 08:43:33', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(181, '::1', 'un6hgt07nppbg7ua6pfinldhvf', '2026-09-02 08:43:38', '2026-09-02 08:43:38', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(182, '::1', '7krbtdubrd1ljcrfk1g2f1que1', '2026-09-02 08:43:47', '2026-09-02 08:43:47', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(183, '::1', 'nr8kh3hv0u8c78e6d2i696oeje', '2026-09-02 08:43:54', '2026-09-02 08:43:54', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(184, '::1', 'pm1mnmdv5d34rpap4024p4dvnn', '2026-09-02 08:43:59', '2026-09-02 08:43:59', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(185, '::1', 'f12k82d3sq2ggeeov5c1r5ht2p', '2026-09-02 08:44:05', '2026-09-02 08:44:05', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(186, '::1', '0qlh10qmrce330savvmna63146', '2026-09-02 08:44:13', '2026-09-02 08:44:13', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(187, '::1', '04b1b2dpp3g64v46cjcu157k2q', '2026-09-02 08:44:21', '2026-09-02 08:44:21', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(188, '::1', 'kbccas37kqohab4i9g58854dic', '2026-09-02 08:44:29', '2026-09-02 08:44:29', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(189, '::1', 'dg4pamfdpeef9rd7tc4sessjhf', '2026-09-02 08:44:38', '2026-09-02 08:44:38', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(192, '::1', 'iur80q7ujg7spqn3o2cg11kj6q', '2026-09-02 09:09:01', '2026-09-03 03:00:49', 28, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36'),
(193, '::1', 'tc4fkm50c821itbe43pn3gh2c1', '2026-09-02 09:32:04', '2026-09-02 09:32:04', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(194, '::1', 'vu69qc0rrfai46fj77k8eeso96', '2026-09-02 09:34:27', '2026-09-02 09:34:27', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(195, '::1', 'svkcg5qki66kdumm3nsnbantin', '2026-09-02 09:34:36', '2026-09-02 09:34:36', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(196, '::1', 'la6tq2qdndcj9e5b44vl4d67fb', '2026-09-02 09:34:41', '2026-09-02 09:34:41', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(197, '::1', 'csq2fb0h6qiuruhtq11m9l8mul', '2026-09-02 09:34:44', '2026-09-02 09:34:44', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(198, '::1', 'f8kighdsn9d4rf9k92qsuq1noe', '2026-09-02 09:34:47', '2026-09-02 09:34:47', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(199, '::1', '3o6g75tne6cuc7tptfrg4lirjt', '2026-09-02 09:34:54', '2026-09-02 09:34:54', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(200, '::1', 'iitiqdp0tke3o7uv7pfbdm568i', '2026-09-02 09:35:02', '2026-09-02 09:35:02', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(201, '::1', '202ne803j1h0ii33n2o02tabdr', '2026-09-02 09:35:07', '2026-09-02 09:35:07', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(202, '::1', '1r4sqjdvpra7amreetkdiehs06', '2026-09-02 09:35:10', '2026-09-02 09:35:10', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(203, '::1', 'l0rba3ld0hjhj5h9ssifimce3a', '2026-09-02 09:35:14', '2026-09-02 09:35:14', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(204, '::1', 'hecaqpc58ml23qblgdo48nb8g5', '2026-09-02 09:35:18', '2026-09-02 09:35:18', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(205, '::1', 'kfp7b1il8rh9hlp4gsce4dfvdk', '2026-09-02 09:35:25', '2026-09-02 09:35:25', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(206, '::1', '5nikf7nr89c4c3b15o1pud38r8', '2026-09-02 09:35:33', '2026-09-02 09:35:33', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(207, '::1', 'kapmc1r4qe1ftjdg8athbe04ag', '2026-09-02 09:35:39', '2026-09-02 09:35:39', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(208, '::1', 'rme9g0opbptkuejlh7bc2299tj', '2026-09-02 09:35:45', '2026-09-02 09:35:45', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(209, '::1', 'drootjmbkm49o8erk33j0csvkd', '2026-09-02 09:35:50', '2026-09-02 09:35:50', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(210, '::1', 'rb42gab736sesgmcth5ta9e8hr', '2026-09-02 09:35:54', '2026-09-02 09:35:54', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(211, '::1', 'celke0qm2ci5r5gian7j8s7odo', '2026-09-02 09:36:00', '2026-09-02 09:36:00', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(213, '::1', '4pqtr9q02lt75hjhf41po2qeb2', '2026-09-02 10:03:19', '2026-09-02 10:03:19', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(217, '::1', 'rlgkcdhhqherbn5gjjl81v4l1r', '2026-09-02 10:20:38', '2026-09-02 10:20:38', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(218, '::1', 'q4um6juduahjge7brqcr4lhvma', '2026-09-02 10:20:49', '2026-09-02 10:20:49', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(219, '::1', 'm0h0leuqgnvnkfa6jgmqun2klh', '2026-09-02 10:23:47', '2026-09-02 10:23:47', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(224, '::1', 'glqbjh1prnrgrfg0m1e0ica7v8', '2026-09-02 10:28:55', '2026-09-02 10:29:01', 2, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(227, '::1', 'djctvthfephdq34rk2j654ie4b', '2026-09-02 10:32:20', '2026-09-02 10:32:20', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(228, '::1', 'jdkdl5glqt6ipunbcblm94tdh0', '2026-09-02 10:32:28', '2026-09-02 10:32:28', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(230, '::1', '4qimhb8h3fgm396b06r0f52516', '2026-09-02 10:33:11', '2026-09-02 10:33:11', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(233, '::1', 'brq8ldqdi609qicd5balmb8dhu', '2026-09-02 10:36:43', '2026-09-02 10:36:43', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(244, '::1', 'tga56mc6toet3o10v64398hpi1', '2026-09-02 10:43:59', '2026-09-02 10:43:59', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(246, '::1', 'pf1durq8i6bvpt9vvi8hs3v8km', '2026-09-02 10:57:15', '2026-09-02 10:57:15', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(247, '::1', 'gtb1dhma00ffah2mukldkf4sdi', '2026-09-02 10:58:14', '2026-09-02 10:58:14', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(248, '::1', '6qletmriuk6hna61frepeqn9k1', '2026-09-02 10:58:21', '2026-09-02 10:58:21', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(249, '::1', '3u0lfhvsfcff4upq0eqosb5lb9', '2026-09-02 11:00:12', '2026-09-02 11:00:12', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(250, '::1', 't614b79fcadcj7gf970hdru9g1', '2026-09-02 11:00:20', '2026-09-02 11:00:20', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(251, '::1', 'nhi58j5m6vksob1n10e46o63kc', '2026-09-02 11:01:12', '2026-09-02 11:01:12', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(252, '::1', '82r9ev0pt1qq2ji7mr7pq8e62u', '2026-09-02 11:01:19', '2026-09-02 11:01:19', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(253, '::1', 'jb4fnm0qfoj114hl574g90i18i', '2026-09-02 11:01:22', '2026-09-02 11:01:22', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(254, '::1', 'dt63it090oocc44eu2emlrtthr', '2026-09-02 11:01:26', '2026-09-02 11:01:26', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(255, '::1', 'ib74djiqf21e7vrandnadchdfq', '2026-09-02 11:01:33', '2026-09-02 11:01:33', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(256, '::1', 'tis33egtj5dsst3e0lcd8kkl74', '2026-09-02 11:01:40', '2026-09-02 11:01:40', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(257, '::1', 'v6ef6mvlntj5pjkh3gmmguproq', '2026-09-02 11:01:47', '2026-09-02 11:01:47', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(258, '::1', 'uii2c11gqo84dl405s01k618g9', '2026-09-02 11:01:52', '2026-09-02 11:01:52', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(259, '::1', '29k88mencsk43jb2kmfkpurpou', '2026-09-02 11:01:55', '2026-09-02 11:01:55', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(260, '::1', '9qdqdcinbvs1ohg9g5efpsn42v', '2026-09-02 11:01:59', '2026-09-02 11:01:59', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(261, '::1', 'pib4cn41b04q98uof0jdkelacr', '2026-09-02 11:02:02', '2026-09-02 11:02:02', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(262, '::1', 'k94u3nt3pbfqrtomagk5lga7t5', '2026-09-02 11:02:06', '2026-09-02 11:02:06', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(263, '::1', '3jd65vdfooet1b0smpsohte0lb', '2026-09-02 11:02:11', '2026-09-02 11:02:11', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(264, '::1', '1j1ssfis34hd8uge4gj52qbtmk', '2026-09-02 11:02:15', '2026-09-02 11:02:15', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(265, '::1', '1ldpmvc46bnce1jhs149kgkok1', '2026-09-02 11:02:22', '2026-09-02 11:02:22', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(266, '::1', 'rs94qdv7c1sm2l98d6qjt4uhed', '2026-09-02 11:02:25', '2026-09-02 11:02:25', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(267, '::1', 'ig6m2po6l68o4cvbqsn8k8rp4d', '2026-09-02 11:02:30', '2026-09-02 11:02:30', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(268, '::1', 'cpdvll48610v3puca7gubo9tls', '2026-09-02 11:02:43', '2026-09-02 11:02:43', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(272, '::1', 'i3ultrmrbtngssbqvlqfg41if5', '2026-09-02 11:13:17', '2026-09-02 11:13:17', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(273, '::1', 'vh10utunfv2jqrpkf9ohbm99qk', '2026-09-02 11:14:24', '2026-09-02 11:14:24', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(274, '::1', 'gmn7q7dvubsb5se31uppr76hne', '2026-09-02 11:14:30', '2026-09-02 11:14:30', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(275, '::1', 'g3raoaa3e9mldjus3g2jj2tgf9', '2026-09-02 11:15:45', '2026-09-02 11:15:45', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(276, '::1', 'ihoiuujpn1ison02ouri28de22', '2026-09-02 11:15:50', '2026-09-02 11:15:50', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(277, '::1', 'gb3mttrknluuhs7c5smco8bi6l', '2026-09-02 11:15:53', '2026-09-02 11:15:53', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(278, '::1', 'c6edala4ah37gg2c8locqdv4b7', '2026-09-02 11:15:57', '2026-09-02 11:15:57', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(279, '::1', 'hk0la8oht4a731j862uidatopp', '2026-09-02 11:16:01', '2026-09-02 11:16:01', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(280, '::1', '1hligojhh9e1l7jmrmn1j5hfld', '2026-09-02 11:16:09', '2026-09-02 11:16:09', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(281, '::1', 'nvhqu3jd54eurn2ihcjset593p', '2026-09-02 11:16:29', '2026-09-02 11:16:29', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(282, '::1', 'ehkfek0los9duccn15kc13jp1s', '2026-09-02 11:16:32', '2026-09-02 11:16:32', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(283, '::1', 'lpn3jslbj19f3a896q3v129d58', '2026-09-02 11:16:37', '2026-09-02 11:16:37', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(284, '::1', 'i873flqnbd61ddv52fqeh272g7', '2026-09-02 11:16:40', '2026-09-02 11:16:40', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(285, '::1', 'aksshqcpmt51b69uo0bark3k5k', '2026-09-02 11:16:43', '2026-09-02 11:16:43', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(286, '::1', 'pva7lr5s2c0r6dqoh66c3kg97a', '2026-09-02 11:16:49', '2026-09-02 11:16:49', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(287, '::1', '4ns7u20jjv84in1mdd7clm4td4', '2026-09-02 11:16:58', '2026-09-02 11:16:58', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(288, '::1', 'lpmc5ku13l8nlgr0s0soicq4k8', '2026-09-02 11:17:06', '2026-09-02 11:17:06', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(289, '::1', '9efmc73f79gp9t0atb8late7ip', '2026-09-02 11:17:17', '2026-09-02 11:17:17', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(290, '::1', 'urelpu7cqm22jfedk3dn4vlnj5', '2026-09-02 11:17:21', '2026-09-02 11:17:21', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(291, '::1', 'bve0jbbuprcgj6tfqngd61v0mp', '2026-09-02 11:17:25', '2026-09-02 11:17:25', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(292, '::1', 'ahopk3ja9ftn5s73gc3k6l48k5', '2026-09-02 11:17:29', '2026-09-02 11:17:29', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(293, '::1', 'j5cq0394ss9gsc7u7dj8tlrdm1', '2026-09-02 11:18:00', '2026-09-02 11:18:00', 1, 'curl/8.19.0'),
(308, '::1', '8ljktshvujjbd3hsa3m65bc8vb', '2026-09-03 03:21:26', '2026-09-03 03:21:26', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(330, '::1', 'sshohav8bt7hfgbcp48bgrj6bl', '2026-09-03 04:16:26', '2026-09-03 04:16:26', 1, 'curl/8.19.0'),
(331, '::1', 'g06jkllm39gqrt2aojnhn1ulq7', '2026-09-03 04:16:26', '2026-09-03 04:16:26', 1, 'curl/8.19.0'),
(332, '::1', 'm74ffa904fav4ibt448cp8jl3k', '2026-09-03 04:16:57', '2026-09-03 04:16:57', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(333, '::1', 'uqeehdhtioel35et8dn2qr2378', '2026-09-03 04:17:05', '2026-09-03 04:17:05', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(334, '::1', 'ffjqtpb07kvici83gu0rblps0i', '2026-09-03 04:17:08', '2026-09-03 04:17:08', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(335, '::1', 'jqmv87lils5mcqeaats7d7m0j4', '2026-09-03 04:17:11', '2026-09-03 04:17:11', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(336, '::1', 'c2datdb329p8qnfb3c2c3dhepf', '2026-09-03 04:17:13', '2026-09-03 04:17:13', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(337, '::1', '3nm842d2ljh97jd4n52i7er855', '2026-09-03 04:17:20', '2026-09-03 04:17:20', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(338, '::1', 'dvjg79a6resja2kaoj0b3fo9gv', '2026-09-03 04:17:22', '2026-09-03 04:17:22', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(339, '::1', 'spvmqt0t9h301g2h6m0vvsfecl', '2026-09-03 04:17:24', '2026-09-03 04:17:24', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(340, '::1', '0rornt813k3g8js4pg76nsp0jp', '2026-09-03 04:17:26', '2026-09-03 04:17:26', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(341, '::1', 'tiemhoh00h1mq5kt8f31uskssn', '2026-09-03 04:17:30', '2026-09-03 04:17:30', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(342, '::1', 'jvsvu0h1uh276dq17dj5hmloe7', '2026-09-03 04:17:34', '2026-09-03 04:17:34', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(343, '::1', '1grbvignoiilb64lktl12nob7d', '2026-09-03 04:17:36', '2026-09-03 04:17:36', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(344, '::1', 'm73bvc4mnfnelognlr0gk99o83', '2026-09-03 04:17:38', '2026-09-03 04:17:38', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(345, '::1', '4kp8fc38rhn53hap4irg1fb2l4', '2026-09-03 04:17:42', '2026-09-03 04:17:42', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(346, '::1', 'gp957mk2ftr43hs6u205tm2mkj', '2026-09-03 04:17:46', '2026-09-03 04:17:46', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(347, '::1', 'be97pt1l9s6skt8a43uskote1d', '2026-09-03 04:17:48', '2026-09-03 04:17:48', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(348, '::1', 'n73s619e0n030nfvlud8kunmrh', '2026-09-03 04:17:50', '2026-09-03 04:17:50', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(349, '::1', '1l9ok4nsmc0jh06vqeqar0cm3r', '2026-09-03 04:17:53', '2026-09-03 04:17:53', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(361, '::1', '9d70hqeneo9ilh8i2omgs239a3', '2026-09-04 03:40:48', '2026-09-04 03:40:48', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(369, '::1', '5vrt7pr6lpgj2rd7ngqbguqe2u', '2026-09-04 03:49:02', '2026-09-04 03:49:02', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(381, '::1', 'hb2scub74orl1vopiufmcd374u', '2026-09-04 03:56:48', '2026-09-04 03:56:48', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(382, '::1', '63o0q5juj1t6hlif50hhjtjjcu', '2026-09-04 03:59:37', '2026-09-04 03:59:37', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(384, '::1', '0che42jtvvfn5tngg6e6sa87v8', '2026-09-04 04:10:29', '2026-09-04 04:10:29', 1, 'curl/8.19.0'),
(385, '::1', '668nilphahshstn6q9qi4l76g9', '2026-09-04 04:11:19', '2026-09-04 04:11:19', 1, 'curl/8.19.0'),
(386, '::1', 'q3fr849jl5k55f69lrsist4nph', '2026-09-04 04:12:06', '2026-09-04 04:12:06', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(387, '::1', 'mhd31lbveflt8c2apr2kqdb24h', '2026-09-04 04:12:13', '2026-09-04 04:12:13', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(388, '::1', 'notsaueglgp3iecv39hss0apf4', '2026-09-04 04:12:15', '2026-09-04 04:12:15', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(389, '::1', 'pp0gdf5vldignd99cbl5arjv5r', '2026-09-04 04:12:18', '2026-09-04 04:12:18', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(390, '::1', 'go2e44fo9d9l1c2i73ecui82mo', '2026-09-04 04:12:21', '2026-09-04 04:12:21', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(391, '::1', 'sl2vb6erlan2e24fir0l4il5qc', '2026-09-04 04:12:25', '2026-09-04 04:12:25', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(392, '::1', 'v9qf8h4unlj19880ulr0k2mkbs', '2026-09-04 04:12:28', '2026-09-04 04:12:28', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(393, '::1', 'mkgfs9b2th6o1g2uo5o96sfki0', '2026-09-04 04:12:31', '2026-09-04 04:12:31', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(394, '::1', 'pnisergqegptfib4ec3h8fsui2', '2026-09-04 04:12:33', '2026-09-04 04:12:33', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(395, '::1', '43sakjgs96krtrai0qjsjo9cjd', '2026-09-04 04:12:36', '2026-09-04 04:12:36', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(396, '::1', 'aabk8eab232f1q9ns4mavjoa2t', '2026-09-04 04:12:40', '2026-09-04 04:12:40', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(397, '::1', '73bgr3n4ff6s5crfqip8m9fd98', '2026-09-04 04:12:42', '2026-09-04 04:12:42', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(398, '::1', '7g4cql0rsuh6gjl9gmi8gcunan', '2026-09-04 04:12:44', '2026-09-04 04:12:44', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(399, '::1', '79t6at25ulpo82issvd7mi71bl', '2026-09-04 04:12:50', '2026-09-04 04:12:50', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(400, '::1', 'gsici04vgmgbt5b23osdd64j3v', '2026-09-04 04:12:56', '2026-09-04 04:12:56', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(401, '::1', 'il28asv5b72aldi774ide5pvnl', '2026-09-04 04:12:59', '2026-09-04 04:12:59', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(402, '::1', 'spvl0c4l2l5f8kt97k14b429f7', '2026-09-04 04:13:02', '2026-09-04 04:13:02', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(403, '::1', 'sv751ih07ct6qe42c668gc9kmc', '2026-09-04 04:13:05', '2026-09-04 04:13:05', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(405, '::1', 'hk72rtcbcq6nqubuhlneim7g42', '2026-09-04 04:17:17', '2026-09-04 04:17:17', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(407, '::1', '0rp8nfo97taf4o0j01p68o57jt', '2026-09-04 04:25:02', '2026-09-04 04:25:02', 1, 'curl/8.19.0'),
(408, '::1', 'j3ier0ei8rst2pemosjoq5qu32', '2026-09-04 04:27:11', '2026-09-04 04:27:11', 1, 'curl/8.19.0'),
(409, '::1', 'g41gql8kge4merkjbig1ug41rl', '2026-09-04 04:27:11', '2026-09-04 04:27:11', 1, 'curl/8.19.0'),
(410, '::1', 'a3chgkk73h3kdm5bfgn5o4ace7', '2026-09-04 04:27:29', '2026-09-04 04:27:29', 1, 'curl/8.19.0'),
(411, '::1', 'jj0jpb2rkjce5ap78krpd0do68', '2026-09-04 04:27:52', '2026-09-04 04:27:52', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(412, '::1', '7858da3elp31ns5bktjnq34psq', '2026-09-04 04:29:20', '2026-09-04 04:29:20', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(413, '::1', '0t3gbcsn6q1unatn4ev4i9ek25', '2026-09-04 04:29:23', '2026-09-04 04:29:23', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(414, '::1', 'nfh7q5kjpd85t67roh4vib60b2', '2026-09-04 04:29:27', '2026-09-04 04:29:27', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(415, '::1', '01mjm1pgjuo8dic70lg9ogak2i', '2026-09-04 04:29:30', '2026-09-04 04:29:30', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(416, '::1', 'k3j6ufj2u4b21r91jeohbponrl', '2026-09-04 04:29:37', '2026-09-04 04:29:37', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(417, '::1', '3gnc64flc0lebrtqjrnodfcv37', '2026-09-04 04:29:42', '2026-09-04 04:29:42', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(418, '::1', '880u5oo7tg81nrn8teajn47rr3', '2026-09-04 04:29:45', '2026-09-04 04:29:45', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(419, '::1', '22ffv13esl34d26g3tqfuqh5gv', '2026-09-04 04:29:47', '2026-09-04 04:29:47', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(420, '::1', '0oprrgqqfsh95qs6cbk603kk6m', '2026-09-04 04:29:49', '2026-09-04 04:29:49', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(421, '::1', 'rb6rfq0dfg3dtblpkn2k1kla91', '2026-09-04 04:29:52', '2026-09-04 04:29:52', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(422, '::1', 'el1uf9f7ofi6maaevu1e39gt7e', '2026-09-04 04:29:55', '2026-09-04 04:29:55', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(423, '::1', '9m889ehi780mnftgkkkp7fudeo', '2026-09-04 04:29:57', '2026-09-04 04:29:57', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(424, '::1', 'el22m3nu5od11kacps2t4gtdq4', '2026-09-04 04:30:00', '2026-09-04 04:30:00', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(425, '::1', 't86lv44sgggg0mj3mvv7cii34t', '2026-09-04 04:30:05', '2026-09-04 04:30:05', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(426, '::1', 't1ofug2957g5u4e748co7hr2rm', '2026-09-04 04:30:09', '2026-09-04 04:30:09', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(427, '::1', '8go19f5m33muvgc5rls77gcj0s', '2026-09-04 04:30:11', '2026-09-04 04:30:11', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(428, '::1', 'fjjiusprsidlc5a2dmm7bceabp', '2026-09-04 04:30:14', '2026-09-04 04:30:14', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(429, '::1', 'eot36pripum08a75c9chcpgrs9', '2026-09-04 04:30:18', '2026-09-04 04:30:18', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36');
INSERT INTO `unique_visitors` (`id`, `visitor_ip`, `session_id`, `first_visit`, `last_visit`, `total_visits`, `user_agent`) VALUES
(436, '::1', 'o92d021quemle22e91s9fc4jnp', '2026-09-04 07:35:02', '2026-09-04 07:35:02', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(437, '::1', 'tprtofq68cov5lassafk12b7f7', '2026-09-04 07:35:08', '2026-09-04 07:35:08', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(438, '::1', 'c5e730ekfpe1m1o4p3k48jtfhp', '2026-09-04 07:35:11', '2026-09-04 07:35:11', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(439, '::1', 'j30iumrlqv2m354dls92f68nj7', '2026-09-04 07:35:14', '2026-09-04 07:35:14', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(440, '::1', '8aq5gpar9tsd17mrue5bls2hfb', '2026-09-04 07:35:16', '2026-09-04 07:35:16', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(441, '::1', '0kv67aiorvk1uv4a19ue8c7b97', '2026-09-04 07:35:23', '2026-09-04 07:35:23', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(442, '::1', '7vq4fej6kg41nuf9ftg3s7ot94', '2026-09-04 07:35:29', '2026-09-04 07:35:29', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(443, '::1', 'ect525f2melmccdp7fn5uk6ci6', '2026-09-04 07:35:39', '2026-09-04 07:35:39', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(444, '::1', '4kvrc6gunmpmd95fevugghu1a1', '2026-09-04 07:35:42', '2026-09-04 07:35:42', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(445, '::1', 'k71qnfkrg7orbeqdaee0h71bo1', '2026-09-04 07:35:47', '2026-09-04 07:35:47', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(446, '::1', 'bpvnur1b588v50t1olmpufc96p', '2026-09-04 07:35:52', '2026-09-04 07:35:52', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(447, '::1', '4af3gohblgvs6h4g2p29qbcqgp', '2026-09-04 07:35:55', '2026-09-04 07:35:55', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(448, '::1', 'k2jjme8pg7o35gdk533ll3s8pa', '2026-09-04 07:36:01', '2026-09-04 07:36:01', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(449, '::1', 'o4jbspmuhn35832ngbgkvrdeec', '2026-09-04 07:36:07', '2026-09-04 07:36:07', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(450, '::1', 'oj5ghcis2fe6anamrv85iqooj5', '2026-09-04 07:36:14', '2026-09-04 07:36:14', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(451, '::1', 'lhlif7i2ctpivfp50dcbt3ek08', '2026-09-04 07:36:21', '2026-09-04 07:36:21', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(452, '::1', 'gj2qorhe9u6q1gea7pk1nioe4p', '2026-09-04 07:36:24', '2026-09-04 07:36:24', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(453, '::1', '3g0c6s66f9taq716p82lg4c9h0', '2026-09-04 07:36:32', '2026-09-04 07:36:32', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(460, '::1', 'oacbprkr50a46marackfhsdsl2', '2026-09-04 07:57:33', '2026-09-04 07:57:33', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(462, '::1', '7j5cdm1octiha1a82lbkntisbk', '2026-09-04 07:59:06', '2026-09-04 07:59:06', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(463, '::1', '0h13mh9iumfa20tebe3uimk26k', '2026-09-04 07:59:11', '2026-09-04 07:59:11', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(464, '::1', 'ma8vprpiemvbvg7r54b7jrbh3i', '2026-09-04 07:59:15', '2026-09-04 07:59:15', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(465, '::1', '3a2aopkma8qvmpc364s75aibvn', '2026-09-04 07:59:18', '2026-09-04 07:59:18', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(466, '::1', '9k690673noc7knkurc8u5rnb74', '2026-09-04 07:59:21', '2026-09-04 07:59:21', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(467, '::1', 'k053ogsj1cdv5ghsn9nmfbgenp', '2026-09-04 07:59:26', '2026-09-04 07:59:26', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(468, '::1', '2mjfcsck2mae6ae6n1u0mmapde', '2026-09-04 07:59:30', '2026-09-04 07:59:30', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(469, '::1', 't4rs15aacmluk9prd31a5ku0nb', '2026-09-04 07:59:38', '2026-09-04 07:59:38', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(470, '::1', 'miea6r0d6eruhf1crcd6a2rd1p', '2026-09-04 07:59:43', '2026-09-04 07:59:43', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(471, '::1', '51k4kt4gmjo4goflj58e2iln49', '2026-09-04 07:59:49', '2026-09-04 07:59:49', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(472, '::1', 'gf4f9b70p3akr91oa2itias3jr', '2026-09-04 07:59:54', '2026-09-04 07:59:54', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(473, '::1', 'jnbkistkogk43i56klhofpcar7', '2026-09-04 07:59:57', '2026-09-04 07:59:57', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(474, '::1', 's5d0is41a6da3kltopusscjqdi', '2026-09-04 08:00:05', '2026-09-04 08:00:05', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(476, '::1', 'jjdgpvl5krb4fi83uv8sdjh2io', '2026-09-04 08:00:23', '2026-09-04 08:00:23', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(477, '::1', '83acrl4k5ine7u11bp87ttojg7', '2026-09-04 08:00:41', '2026-09-04 08:00:41', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(478, '::1', 'rntrv845t2sed42qa18cc6k2d5', '2026-09-04 08:00:47', '2026-09-04 08:00:47', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(479, '::1', 'va6f8cdp6rvte1dacd47ts9ok8', '2026-09-04 08:01:06', '2026-09-04 08:01:06', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(480, '::1', '3okk38uekj6tdjqahanopp6roj', '2026-09-04 08:01:14', '2026-09-04 08:01:14', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(481, '::1', 'h82cvtef2nu5iml0lhqm5dglkc', '2026-09-04 08:01:31', '2026-09-04 08:01:31', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36'),
(483, '::1', '7ppcl12q2tm7i4f7ic12a374mu', '2026-09-04 08:02:34', '2026-09-04 09:56:04', 15, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36'),
(486, '::1', 'coaouklep6c8t4o0t14d6cdm73', '2026-09-04 08:32:09', '2026-09-04 08:32:09', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(487, '::1', 'l5rh9nd327e44skncq94ap8ovj', '2026-09-04 08:33:06', '2026-09-04 08:33:06', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(488, '::1', '5d7s15ue0rcv9qh1upo9lq9rma', '2026-09-04 08:33:10', '2026-09-04 08:33:10', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(489, '::1', '3hkaaoen63rrp3d3e3le9l8sa9', '2026-09-04 08:33:13', '2026-09-04 08:33:13', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(490, '::1', 'cpdngnb0hcdejfq40dn4omfonh', '2026-09-04 08:33:17', '2026-09-04 08:33:17', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(491, '::1', 'l5u7ofb5kuq9lde22e5rse6k7r', '2026-09-04 08:33:21', '2026-09-04 08:33:21', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(492, '::1', 'tqkkec5u8qebb4koc604su4app', '2026-09-04 08:33:25', '2026-09-04 08:33:25', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(493, '::1', 'i29ia7qmojqqom31hq0jbuptdl', '2026-09-04 08:33:27', '2026-09-04 08:33:27', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(494, '::1', 'vhbe9ag1p8tcapife7e6mllegi', '2026-09-04 08:33:30', '2026-09-04 08:33:30', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(495, '::1', '1gjfa1ea37ajeooj9ri37clm6j', '2026-09-04 08:33:32', '2026-09-04 08:33:32', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(496, '::1', 'vqh2ihc3q69evrrj19bg48q1vd', '2026-09-04 08:33:35', '2026-09-04 08:33:35', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(497, '::1', '35503lc04fc35rruutquihbv9b', '2026-09-04 08:33:38', '2026-09-04 08:33:38', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(498, '::1', 'dagp8vm7ir0unhqi09d9pgdgr0', '2026-09-04 08:33:40', '2026-09-04 08:33:40', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(499, '::1', '41smaafib6g5bsdnimh1jf6gtg', '2026-09-04 08:33:42', '2026-09-04 08:33:42', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(500, '::1', 'j5hjb9h9q0jbn5nsasil4fc103', '2026-09-04 08:33:46', '2026-09-04 08:33:46', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(501, '::1', '8tf0a30fkhc2g14f6q9hmgrjrg', '2026-09-04 08:33:50', '2026-09-04 08:33:50', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(502, '::1', 'urqn273h336977tgfhf20rklbj', '2026-09-04 08:33:53', '2026-09-04 08:33:53', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(503, '::1', 'fdmi884bq3k58qcibqf2ap48kk', '2026-09-04 08:33:57', '2026-09-04 08:33:57', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(504, '::1', '0e76cdv2jgvjlnco8k00q313nj', '2026-09-04 08:34:02', '2026-09-04 08:34:02', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(507, '::1', '6rtgo5uk58ps5q0to1agj2vt91', '2026-09-04 09:00:55', '2026-09-04 09:00:55', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(514, '::1', 'rp65gpfs4id319aogkq47nrptj', '2026-09-04 09:43:04', '2026-09-04 09:43:04', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(517, '::1', 'vpuco0rltvpkp83hfelv4dano7', '2026-09-04 09:46:37', '2026-09-04 10:22:18', 11, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36'),
(520, '::1', 'slj6dvbt5lv9ku6bl05ehhiuks', '2026-09-04 09:55:20', '2026-09-04 09:55:20', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(522, '::1', 'evi5vl5qtmikfshk1clue7o2qq', '2026-09-04 09:57:53', '2026-09-04 09:57:53', 1, 'curl/8.19.0'),
(523, '::1', 'vu7u4n39q6oc4kfid0clpqml7s', '2026-09-04 09:59:07', '2026-09-04 09:59:07', 1, 'curl/8.19.0'),
(526, '::1', '267suchufdmsqibtdirjqep20q', '2026-09-04 10:08:34', '2026-09-04 10:08:34', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(528, '::1', 'ujnt9243eko87kbf85jvhpihga', '2026-09-04 10:10:19', '2026-09-04 10:10:19', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(531, '::1', 'vgk522a9hdj21h1jpjtt4f3rrg', '2026-09-04 10:15:46', '2026-09-04 10:15:46', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(532, '::1', 'ku1mjipfk17r6ndfi3veu17f6f', '2026-09-04 10:15:52', '2026-09-04 10:15:52', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(533, '::1', '420198rk0vqh269f9u6rkasi2k', '2026-09-04 10:15:55', '2026-09-04 10:15:55', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(534, '::1', 'om05tml4cai4r56ltgdt2bup5c', '2026-09-04 10:16:00', '2026-09-04 10:16:00', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(535, '::1', 'qef559nbbtrnrf7goil3ontikf', '2026-09-04 10:16:04', '2026-09-04 10:16:04', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(536, '::1', 'a0hq00rqod44ia0e6hoc7n0stl', '2026-09-04 10:16:08', '2026-09-04 10:16:08', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(537, '::1', 'uhis8adh7f55n6gnkv2l49m313', '2026-09-04 10:16:11', '2026-09-04 10:16:11', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(538, '::1', 'd3j397bickrrl3u2c7f64ekm5k', '2026-09-04 10:16:14', '2026-09-04 10:16:14', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(539, '::1', 'ikvf25hnhuuf63j6h4qpqqr8fo', '2026-09-04 10:16:18', '2026-09-04 10:16:18', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(540, '::1', 'ethke6hkse7cs8v6pqqrarn8s4', '2026-09-04 10:16:21', '2026-09-04 10:16:21', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(541, '::1', 'v67dsoc39ji12uo7s7hhdtmdnt', '2026-09-04 10:16:24', '2026-09-04 10:16:24', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(542, '::1', '01n0j8j6o7sbj7bdvngv06m2jk', '2026-09-04 10:16:27', '2026-09-04 10:16:27', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(543, '::1', 'n3pc43gvdia9ke30p79lgrsn42', '2026-09-04 10:16:31', '2026-09-04 10:16:31', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(544, '::1', 'p7k2nj778fpnloqe804kl9ii3c', '2026-09-04 10:16:36', '2026-09-04 10:16:36', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(545, '::1', 'hjtml97vnaq7uvppusmgcmtrr7', '2026-09-04 10:16:41', '2026-09-04 10:16:41', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(546, '::1', 'opqelmofi6ll3doc6p83agab9c', '2026-09-04 10:16:45', '2026-09-04 10:16:45', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(547, '::1', 'jd96r0dv4svlm90p3krql03i6t', '2026-09-04 10:16:49', '2026-09-04 10:16:49', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(549, '::1', 'a1dklv1rurq1sanfmlcnn1sqi6', '2026-09-04 10:17:04', '2026-09-04 10:17:04', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36'),
(553, '::1', 'gsph9kh6osqelsgipsjfhr5e31', '2026-09-14 07:47:00', '2026-09-15 05:30:12', 10, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36'),
(555, '::1', 'pig835esdj9jdvbvtsfccf7f3h', '2026-09-14 09:21:12', '2026-09-14 09:21:12', 1, 'curl/8.19.0'),
(556, '::1', 'cq4u2euvrkpp3ji4ehss7shd9b', '2026-09-14 09:21:54', '2026-09-14 09:21:54', 1, 'curl/8.19.0'),
(557, '::1', '5ufc2mvo0ac9mc2mf5ndjr717c', '2026-09-14 09:21:54', '2026-09-14 09:21:54', 1, 'curl/8.19.0'),
(558, '::1', 't8523kudrci117mnhk83bps2cp', '2026-09-14 09:21:54', '2026-09-14 09:21:54', 1, 'curl/8.19.0'),
(559, '::1', 'c9jjadmheg5ga9ut16jhs32mtq', '2026-09-14 09:21:55', '2026-09-14 09:21:55', 1, 'curl/8.19.0'),
(560, '::1', 'apfauj0ca7b98h639ls7t3nvn7', '2026-09-14 09:21:55', '2026-09-14 09:21:55', 1, 'curl/8.19.0'),
(561, '::1', 'cllp7arit75g3ci7263eiocc7t', '2026-09-14 09:21:56', '2026-09-14 09:21:56', 1, 'curl/8.19.0'),
(562, '::1', '79jrrss6lhsgrqo0jodp3e9i9n', '2026-09-14 09:21:57', '2026-09-14 09:21:57', 1, 'curl/8.19.0'),
(563, '::1', 'ak8oe01qg0b2sgfv1bhvitvqan', '2026-09-14 09:21:57', '2026-09-14 09:21:57', 1, 'curl/8.19.0'),
(564, '::1', 'ifkeem09c2kvpva81b2iptgo68', '2026-09-14 09:21:57', '2026-09-14 09:21:57', 1, 'curl/8.19.0'),
(565, '::1', 'qs3qtjrgvp5h5hp82cmkuh0b1i', '2026-09-14 09:21:58', '2026-09-14 09:21:58', 1, 'curl/8.19.0'),
(566, '::1', 'r41ta9tugmt542hdj4r95ln78k', '2026-09-14 09:21:58', '2026-09-14 09:21:58', 1, 'curl/8.19.0'),
(567, '::1', '7rlfqcnpd85rt575ohst5qncmk', '2026-09-14 09:21:58', '2026-09-14 09:21:58', 1, 'curl/8.19.0'),
(568, '::1', 'nad6sggjq3qjmakd0cbddk8jmm', '2026-09-14 09:21:59', '2026-09-14 09:21:59', 1, 'curl/8.19.0'),
(569, '::1', '74hjamilp3mjp07cdppev32p9g', '2026-09-14 09:21:59', '2026-09-14 09:21:59', 1, 'curl/8.19.0'),
(570, '::1', 'ir33nbkdk8n0jqfonagv114dqp', '2026-09-14 09:21:59', '2026-09-14 09:21:59', 1, 'curl/8.19.0'),
(571, '::1', '65hrkquo0n47h1040r1f8eeu72', '2026-09-14 09:22:00', '2026-09-14 09:22:00', 1, 'curl/8.19.0'),
(572, '::1', '6bc3redmvmodl4gjn1f5ns1bb4', '2026-09-14 09:22:00', '2026-09-14 09:22:00', 1, 'curl/8.19.0'),
(573, '::1', '7s92016nvulim9ot1julumn1s4', '2026-09-14 09:22:01', '2026-09-14 09:22:01', 1, 'curl/8.19.0'),
(574, '::1', 'nf3g8uq2itt6r5mlmr1nm274sp', '2026-09-14 09:26:38', '2026-09-14 09:26:38', 1, 'curl/8.19.0'),
(575, '::1', 'd76hmchj6foo493f8r60304msm', '2026-09-14 09:26:39', '2026-09-14 09:26:39', 1, 'curl/8.19.0'),
(576, '::1', 'tp32ojbb208u8gmj7ganhfkmkd', '2026-09-14 09:27:29', '2026-09-14 09:27:29', 1, 'curl/8.19.0'),
(577, '::1', 'vpfebl9gl8tl8oum4tijac0p1a', '2026-09-14 09:27:53', '2026-09-14 09:27:53', 1, 'curl/8.19.0'),
(578, '::1', 'nr5sj1apf141gsa4l0jiqc06ls', '2026-09-14 09:27:54', '2026-09-14 09:27:54', 1, 'curl/8.19.0'),
(579, '::1', 'hkiqqgles2eib0es191fbvpr8r', '2026-09-14 09:27:55', '2026-09-14 09:27:55', 1, 'curl/8.19.0'),
(580, '::1', '85kld7atldf396toeb87ca79i3', '2026-09-14 09:27:57', '2026-09-14 09:27:57', 1, 'curl/8.19.0'),
(581, '::1', 'td8kdhafpaqpbbmenlipm823hf', '2026-09-14 09:27:59', '2026-09-14 09:27:59', 1, 'curl/8.19.0'),
(582, '::1', 'ppemt7hab17qrt8vui1r468uel', '2026-09-14 09:28:01', '2026-09-14 09:28:01', 1, 'curl/8.19.0'),
(583, '::1', '82g7t8khr104avrju2hcdgt7dc', '2026-09-14 09:28:03', '2026-09-14 09:28:03', 1, 'curl/8.19.0'),
(584, '::1', '8507cimmlf2qkkuej78t63drqm', '2026-09-14 09:28:05', '2026-09-14 09:28:05', 1, 'curl/8.19.0'),
(585, '::1', '3mdref42ndj2nqqi4d29hfla4u', '2026-09-14 09:28:06', '2026-09-14 09:28:06', 1, 'curl/8.19.0'),
(586, '::1', '2mp35792pa7fcpq1cjpe0gdm9d', '2026-09-14 09:28:07', '2026-09-14 09:28:07', 1, 'curl/8.19.0'),
(587, '::1', 'atilacl7mklv87p0t2j746datl', '2026-09-14 09:28:08', '2026-09-14 09:28:08', 1, 'curl/8.19.0'),
(588, '::1', 'i8ml04knuplo4jctkpikfumsah', '2026-09-14 09:28:13', '2026-09-14 09:28:13', 1, 'curl/8.19.0'),
(589, '::1', 'trolhvm7d42d7kh90btrv147rm', '2026-09-14 09:28:14', '2026-09-14 09:28:14', 1, 'curl/8.19.0'),
(590, '::1', 'qt4m4t7i4fdlek2uuqku527497', '2026-09-14 09:28:15', '2026-09-14 09:28:15', 1, 'curl/8.19.0'),
(591, '::1', 'm53bfe92novmnc2mnpst2lr1bj', '2026-09-14 09:28:15', '2026-09-14 09:28:15', 1, 'curl/8.19.0'),
(592, '::1', 'j9bkhmgt6mf6cispm1d5v17r4j', '2026-09-14 09:28:16', '2026-09-14 09:28:16', 1, 'curl/8.19.0'),
(593, '::1', '4it1rg36bkuvekuj5ebtgv8j6g', '2026-09-14 09:28:16', '2026-09-14 09:28:16', 1, 'curl/8.19.0'),
(594, '::1', 'hrfdgkd9gbpcg5qs3rch9euv8m', '2026-09-14 09:28:17', '2026-09-14 09:28:17', 1, 'curl/8.19.0'),
(595, '::1', 'ufokf1flm5plttponogauijet2', '2026-09-14 09:28:18', '2026-09-14 09:28:18', 1, 'curl/8.19.0'),
(596, '::1', 'jjd0b1l50mrb44m57fd471q456', '2026-09-14 09:31:13', '2026-09-17 09:48:13', 84, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36'),
(598, '::1', '7mrghi62m4louhs3c9bca0m812', '2026-09-14 09:32:28', '2026-09-14 09:32:28', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(599, '::1', 'e4f0qf148qul1nftksagqqs3ff', '2026-09-14 09:33:17', '2026-09-14 09:33:17', 1, 'curl/8.19.0'),
(600, '::1', '67n1e1rvjm74qklmtt08vrgu7d', '2026-09-14 09:35:43', '2026-09-14 09:35:43', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(601, '::1', 'kd88cuk2ipun9mk3urfuas5tej', '2026-09-14 09:36:53', '2026-09-14 09:36:53', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(602, '::1', 'tbij89cka54ajolq02io48qve7', '2026-09-14 09:37:01', '2026-09-14 09:37:01', 1, 'curl/8.19.0'),
(603, '::1', 'bgm21iqb3mter46i7qolas2tn5', '2026-09-14 09:37:02', '2026-09-14 09:37:02', 1, 'curl/8.19.0'),
(604, '::1', 'p97ta19f1k0crm381vtb8snl5k', '2026-09-14 09:37:02', '2026-09-14 09:37:02', 1, 'curl/8.19.0'),
(605, '::1', 'ab94smh4eut65f76lbjf0q8ir6', '2026-09-14 09:37:03', '2026-09-14 09:37:03', 1, 'curl/8.19.0'),
(606, '::1', 'qu98uh8qagm242p8uj45k8g0nd', '2026-09-14 09:37:04', '2026-09-14 09:37:04', 1, 'curl/8.19.0'),
(607, '::1', 'isvb23dd83ggd5erq1bpvlvl6f', '2026-09-14 09:37:07', '2026-09-14 09:37:07', 1, 'curl/8.19.0'),
(608, '::1', '59lj9jojpq6vdg4kp0m5t0v99i', '2026-09-14 09:37:07', '2026-09-14 09:37:07', 1, 'curl/8.19.0'),
(609, '::1', '8kj2ur66jpa3quglq238oevtc7', '2026-09-14 09:37:09', '2026-09-14 09:37:09', 1, 'curl/8.19.0'),
(610, '::1', 'kf4rkss22g44vngbvndla1t4fp', '2026-09-14 09:37:09', '2026-09-14 09:37:09', 1, 'curl/8.19.0'),
(611, '::1', 'sqft24fvrnh5o63q78dngcl8j2', '2026-09-14 09:37:10', '2026-09-14 09:37:10', 1, 'curl/8.19.0'),
(612, '::1', '73ps41q4gtap8d05a87g9mng43', '2026-09-14 09:37:10', '2026-09-14 09:37:10', 1, 'curl/8.19.0'),
(613, '::1', 'i86ets133b3uun0h77u8umacmi', '2026-09-14 09:37:11', '2026-09-14 09:37:11', 1, 'curl/8.19.0'),
(614, '::1', 'egcbq1951q5mdjc232o9b30oog', '2026-09-14 09:37:11', '2026-09-14 09:37:11', 1, 'curl/8.19.0'),
(615, '::1', 'n6579617b1ik6dtdn8slumkch9', '2026-09-14 09:37:12', '2026-09-14 09:37:12', 1, 'curl/8.19.0'),
(616, '::1', 'amdhkt8bjdalcclkl5s8uatru5', '2026-09-14 09:37:12', '2026-09-14 09:37:12', 1, 'curl/8.19.0'),
(617, '::1', 'gbk0bbsgnujfbera44b1n802lm', '2026-09-14 09:37:13', '2026-09-14 09:37:13', 1, 'curl/8.19.0'),
(618, '::1', 's0h79a5a1fa13s7d59b8vdi1dv', '2026-09-14 09:37:14', '2026-09-14 09:37:14', 1, 'curl/8.19.0'),
(619, '::1', 'taiue0h8iv5kinmsdcoma63nld', '2026-09-14 09:37:14', '2026-09-14 09:37:14', 1, 'curl/8.19.0'),
(620, '::1', '0okd2bv12mo2lh3k945vh3dedb', '2026-09-14 09:37:15', '2026-09-14 09:37:15', 1, 'curl/8.19.0'),
(621, '::1', 'ucqjefqvovkemj01dk4ms4kb2i', '2026-09-14 09:37:15', '2026-09-14 09:37:15', 1, 'curl/8.19.0'),
(623, '::1', 'hlsrf3abpd2qatlbogcsgubd46', '2026-09-14 09:43:30', '2026-09-14 09:43:30', 1, 'curl/8.19.0'),
(624, '::1', 'ah1cbjncdaekh85q5b60mim4lb', '2026-09-14 09:43:31', '2026-09-14 09:43:31', 1, 'curl/8.19.0'),
(625, '::1', 'qpsvid53ksmobv164bruvsdodc', '2026-09-14 09:44:13', '2026-09-14 09:44:13', 1, 'curl/8.19.0'),
(626, '::1', '1vclvt046l171s2fag308m80b7', '2026-09-14 09:44:58', '2026-09-14 09:45:18', 2, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(628, '::1', 'on9nkcoq4kgf8llq41l6f9biof', '2026-09-14 09:46:09', '2026-09-14 09:46:09', 1, 'curl/8.19.0'),
(629, '::1', 'ul5o0ef6mh1h0vj2dabmn8guvn', '2026-09-14 09:46:10', '2026-09-14 09:46:10', 1, 'curl/8.19.0'),
(630, '::1', 'uo8a9fqnl2dqefaf4h5dc4sm3k', '2026-09-14 09:46:11', '2026-09-14 09:46:11', 1, 'curl/8.19.0'),
(631, '::1', 'ekeneoa7153dsejkqa73cp6ghn', '2026-09-14 09:46:11', '2026-09-14 09:46:11', 1, 'curl/8.19.0'),
(632, '::1', '7tno2e48ljk0q977coqd5bqqel', '2026-09-14 09:46:11', '2026-09-14 09:46:11', 1, 'curl/8.19.0'),
(633, '::1', 'pq0ugd9p2rua37griubautk3q7', '2026-09-14 09:46:12', '2026-09-14 09:46:12', 1, 'curl/8.19.0'),
(634, '::1', 'e6g3bkg753ik0m394h9e9chbn0', '2026-09-14 09:46:12', '2026-09-14 09:46:12', 1, 'curl/8.19.0'),
(635, '::1', 'ipu4961rg7ean6t0fgk3qvhsca', '2026-09-14 09:46:13', '2026-09-14 09:46:13', 1, 'curl/8.19.0'),
(636, '::1', '3fv7kr8q98tn2mspb3bijp6s50', '2026-09-14 09:46:13', '2026-09-14 09:46:13', 1, 'curl/8.19.0'),
(637, '::1', '3f4lqdgknbujvasf21iib8gvfh', '2026-09-14 09:46:14', '2026-09-14 09:46:14', 1, 'curl/8.19.0'),
(638, '::1', '3irpifijhi49v4ninhat7vbv9k', '2026-09-14 09:46:14', '2026-09-14 09:46:14', 1, 'curl/8.19.0'),
(639, '::1', 'p26hosb4n791fmu3624feo49gv', '2026-09-14 09:46:15', '2026-09-14 09:46:15', 1, 'curl/8.19.0'),
(640, '::1', 'jtb98nblurl5hs3n04gjpkoi22', '2026-09-14 09:46:16', '2026-09-14 09:46:16', 1, 'curl/8.19.0'),
(641, '::1', 'ucansc62unp5nbljcq12mse3gk', '2026-09-14 09:46:16', '2026-09-14 09:46:16', 1, 'curl/8.19.0'),
(642, '::1', 'aits8eq4p6u5ngpv9553nu19dd', '2026-09-14 09:46:17', '2026-09-14 09:46:17', 1, 'curl/8.19.0'),
(643, '::1', 'oobl7770vhd8e4o1or61ajrmou', '2026-09-14 09:46:18', '2026-09-14 09:46:18', 1, 'curl/8.19.0'),
(644, '::1', 'jkt3li1e030sh86mg26p92pjlf', '2026-09-14 09:46:18', '2026-09-14 09:46:18', 1, 'curl/8.19.0'),
(645, '::1', 'suemhmr369470pr7039g145bo7', '2026-09-14 09:46:19', '2026-09-14 09:46:19', 1, 'curl/8.19.0'),
(646, '::1', 'qcln0ugf4f5k71f2i56i5v3tka', '2026-09-14 09:46:19', '2026-09-14 09:46:19', 1, 'curl/8.19.0'),
(647, '::1', 'n0kf4clpuv7fa4em0d1gfqunsc', '2026-09-14 09:46:20', '2026-09-14 09:46:20', 1, 'curl/8.19.0'),
(648, '::1', 'bu9tugm143p82qnuddkq1l2saj', '2026-09-14 09:46:23', '2026-09-14 09:46:23', 1, 'curl/8.19.0'),
(649, '::1', 'cu7nplv43l1lu1rqul0h1i2rm3', '2026-09-14 09:51:33', '2026-09-14 09:51:33', 1, 'curl/8.19.0'),
(650, '::1', 'atti0iko715n1r25lkq7o08r45', '2026-09-14 09:52:43', '2026-09-14 09:52:43', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(651, '::1', 'avmp9sra1esgt36qm1vg7ruic5', '2026-09-14 09:52:54', '2026-09-14 09:52:54', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(652, '::1', 'lnel30h8md4tr2n1c8oil7bk4i', '2026-09-14 09:54:12', '2026-09-14 09:54:12', 1, 'curl/8.19.0'),
(653, '::1', 'ru36ffobogj6r9qbo1o1prsmj1', '2026-09-14 09:54:13', '2026-09-14 09:54:13', 1, 'curl/8.19.0'),
(654, '::1', 'isltel66dic82tk8crielv9ru7', '2026-09-14 09:54:13', '2026-09-14 09:54:13', 1, 'curl/8.19.0'),
(655, '::1', 'uoe3pkl37hnhdfiiojb242guh0', '2026-09-14 09:54:14', '2026-09-14 09:54:14', 1, 'curl/8.19.0'),
(656, '::1', '2ee0694jmi8tvi9d5mimi96d3h', '2026-09-14 09:54:14', '2026-09-14 09:54:14', 1, 'curl/8.19.0'),
(657, '::1', 'ono0e8hu58301leke7fbg3qoga', '2026-09-14 09:54:15', '2026-09-14 09:54:15', 1, 'curl/8.19.0'),
(658, '::1', 'bs26shbic423i9oo1cimi71r2d', '2026-09-14 09:54:16', '2026-09-14 09:54:16', 1, 'curl/8.19.0'),
(659, '::1', '71j3uu6mfn5crtm1eg3r9hkpbd', '2026-09-14 09:54:16', '2026-09-14 09:54:16', 1, 'curl/8.19.0'),
(660, '::1', 'htv064pe0k7nq0afodvesgvns9', '2026-09-14 09:54:21', '2026-09-14 09:54:21', 1, 'curl/8.19.0'),
(661, '::1', 'hjqcope32lfpiq2gpefahtr6ri', '2026-09-14 09:54:23', '2026-09-14 09:54:23', 1, 'curl/8.19.0'),
(662, '::1', '2navs1f49dn4k2t987gg6go8um', '2026-09-14 09:54:24', '2026-09-14 09:54:24', 1, 'curl/8.19.0'),
(663, '::1', 'v7ji4bgnbnn5rpd2qstik1erie', '2026-09-14 09:54:24', '2026-09-14 09:54:24', 1, 'curl/8.19.0'),
(664, '::1', 'gbba4ludpk8ifiloav0ktl0u2t', '2026-09-14 09:54:25', '2026-09-14 09:54:25', 1, 'curl/8.19.0'),
(665, '::1', 'qisauv3lhhbmmpr7nqlo0ps9dt', '2026-09-14 09:54:25', '2026-09-14 09:54:25', 1, 'curl/8.19.0'),
(666, '::1', '0fum4eni3f06hgpq25bb6e8vde', '2026-09-14 09:54:25', '2026-09-14 09:54:25', 1, 'curl/8.19.0'),
(667, '::1', 'miti9g81aouatr1lsd38a45c8h', '2026-09-14 09:54:26', '2026-09-14 09:54:26', 1, 'curl/8.19.0'),
(668, '::1', 'p4e93dhgkenc1f9nt9dvce4q4u', '2026-09-14 09:54:26', '2026-09-14 09:54:26', 1, 'curl/8.19.0'),
(669, '::1', '68g090m0np3q5jrl8591cdtrk3', '2026-09-14 09:54:27', '2026-09-14 09:54:27', 1, 'curl/8.19.0'),
(670, '::1', 'q632cn11vuppdmeak3pr46cclj', '2026-09-14 09:54:28', '2026-09-14 09:54:28', 1, 'curl/8.19.0'),
(671, '::1', '22g1domo843cq9l87scqn4as84', '2026-09-14 09:54:29', '2026-09-14 09:54:29', 1, 'curl/8.19.0'),
(672, '::1', '6ts032169k1u4r6ed13pvijt40', '2026-09-14 09:54:29', '2026-09-14 09:54:29', 1, 'curl/8.19.0'),
(673, '::1', '5ill8sjb02uhcacmbpsn2uf4ep', '2026-09-14 10:02:12', '2026-09-14 10:02:12', 1, 'curl/8.19.0'),
(674, '::1', 'nik6md340utubvu6b71g2aacca', '2026-09-14 10:02:13', '2026-09-14 10:02:13', 1, 'curl/8.19.0'),
(675, '::1', 'qad2vt1up9g4kqdlmlcff505nj', '2026-09-14 10:02:13', '2026-09-14 10:02:13', 1, 'curl/8.19.0'),
(676, '::1', 'cv8v617pqc3fie7ala1fkl6r36', '2026-09-14 10:02:20', '2026-09-14 10:02:20', 1, 'curl/8.19.0'),
(677, '::1', 'qm8ljgcajao27g1apvmjg3atvi', '2026-09-14 10:02:20', '2026-09-14 10:02:20', 1, 'curl/8.19.0'),
(678, '::1', 'g37gvq2q4475npn86ukqksat3b', '2026-09-14 10:03:02', '2026-09-14 10:03:02', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(679, '::1', '38jdcqse9i1febf6hmblr1b0qs', '2026-09-14 10:03:49', '2026-09-14 10:03:49', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(680, '::1', 'nks1i2iobtlcojhjjl93jqs3u3', '2026-09-14 10:04:12', '2026-09-14 10:04:12', 1, 'curl/8.19.0'),
(681, '::1', 'ep5mi7p842hvgunhjaj1rbs1tp', '2026-09-14 10:04:13', '2026-09-14 10:04:13', 1, 'curl/8.19.0'),
(682, '::1', 'so22rlntl4fljjvs1lv0m9crfs', '2026-09-14 10:04:13', '2026-09-14 10:04:13', 1, 'curl/8.19.0'),
(683, '::1', '774h60ap58drpdao4vijvq3v64', '2026-09-14 10:04:14', '2026-09-14 10:04:14', 1, 'curl/8.19.0'),
(684, '::1', '6412o92q1hoe2bd4gmtigrti64', '2026-09-14 10:04:14', '2026-09-14 10:04:14', 1, 'curl/8.19.0'),
(685, '::1', 'n82b0iirl4e151jlbp224rmjdd', '2026-09-14 10:04:15', '2026-09-14 10:04:15', 1, 'curl/8.19.0'),
(686, '::1', '3c4gkuq2uvm9rg1vdrp4nk6dui', '2026-09-14 10:04:15', '2026-09-14 10:04:15', 1, 'curl/8.19.0'),
(687, '::1', '80lqvejfp9vcoh60329ao4u931', '2026-09-14 10:04:16', '2026-09-14 10:04:16', 1, 'curl/8.19.0'),
(688, '::1', 'sqpkaetv4nn20nddekonq5p0qh', '2026-09-14 10:16:23', '2026-09-14 10:16:23', 1, 'curl/8.19.0'),
(689, '::1', 'jjnrh3a1sjl1blcc15ogk1sffr', '2026-09-14 10:16:24', '2026-09-14 10:16:24', 1, 'curl/8.19.0'),
(690, '::1', '7b6tmjej83po83rlcdk790aubt', '2026-09-14 10:17:37', '2026-09-14 10:17:37', 1, 'curl/8.19.0'),
(691, '::1', 'opng8alk6rnslpf133780jc8st', '2026-09-14 10:18:03', '2026-09-14 10:18:03', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(692, '::1', '8kinc7m4jes72030segk33lkdu', '2026-09-14 10:18:34', '2026-09-14 10:18:34', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(693, '::1', 'jt10jrrm1r2hb9intdhlrr2jhb', '2026-09-14 10:19:35', '2026-09-14 10:19:35', 1, 'curl/8.19.0'),
(694, '::1', 'm8u54bcuvvnpbqe959amvq6ca8', '2026-09-14 10:19:36', '2026-09-14 10:19:36', 1, 'curl/8.19.0'),
(695, '::1', 'qcvq136fnpdmuq7h0hovuolfdk', '2026-09-14 10:19:36', '2026-09-14 10:19:36', 1, 'curl/8.19.0'),
(696, '::1', 'uj9h1d3mr57p049023p36sdi6r', '2026-09-14 10:19:37', '2026-09-14 10:19:37', 1, 'curl/8.19.0'),
(697, '::1', '5cnr17mub76815duksh0a0shkv', '2026-09-14 10:19:38', '2026-09-14 10:19:38', 1, 'curl/8.19.0'),
(698, '::1', 'hv8basgsp5l5j7o2dbqsks1unn', '2026-09-14 10:19:38', '2026-09-14 10:19:38', 1, 'curl/8.19.0'),
(699, '::1', '035bi6883049j681jaf71bja1l', '2026-09-14 10:19:39', '2026-09-14 10:19:39', 1, 'curl/8.19.0'),
(700, '::1', 'lfm2s08bh5nknojp7ua1qvmdj5', '2026-09-14 10:19:39', '2026-09-14 10:19:39', 1, 'curl/8.19.0'),
(701, '::1', 'us9j4ogurl3a77g2an2dblnfhd', '2026-09-14 10:19:40', '2026-09-14 10:19:40', 1, 'curl/8.19.0'),
(702, '::1', 'q4nhua36lsd7shu8c1a3d7kvil', '2026-09-14 10:19:41', '2026-09-14 10:19:41', 1, 'curl/8.19.0'),
(703, '::1', '668tm1tqtc4cpugp7ks2ean6ct', '2026-09-14 10:25:49', '2026-09-14 10:25:49', 1, 'curl/8.19.0'),
(705, '::1', 'eoibh95iud4m2acjh4btlkhlm8', '2026-09-14 10:26:51', '2026-09-14 10:26:51', 1, 'curl/8.19.0'),
(707, '::1', 'sg5q3ipkjnq7cb8flpqanqtc4q', '2026-09-14 10:27:22', '2026-09-14 10:27:22', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(708, '::1', '2iqs0j5e8bsnrhpu11ls774kj4', '2026-09-14 10:27:37', '2026-09-14 10:27:37', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(709, '::1', 't8dus0can1d5mcj9gpvaja59e6', '2026-09-14 10:28:34', '2026-09-14 10:28:34', 1, 'curl/8.19.0'),
(710, '::1', 'd1g6ujbe8upoi4g4ikki1dntqu', '2026-09-14 10:28:36', '2026-09-14 10:28:36', 1, 'curl/8.19.0'),
(711, '::1', 'uadu5pu8vb0p4v0fuiav93u8uq', '2026-09-14 10:28:37', '2026-09-14 10:28:37', 1, 'curl/8.19.0'),
(712, '::1', 'plfcgug2fvelvml21efreq3bgl', '2026-09-14 10:28:38', '2026-09-14 10:28:38', 1, 'curl/8.19.0'),
(713, '::1', 'ivn8n2jp9l2sht0at2vqbv6lgv', '2026-09-14 10:28:40', '2026-09-14 10:28:40', 1, 'curl/8.19.0'),
(714, '::1', '1v6tjimvn2o0bfmjqjovd6tspc', '2026-09-14 10:28:41', '2026-09-14 10:28:41', 1, 'curl/8.19.0'),
(715, '::1', 'caeodj73q6okskkq7sptlqkea5', '2026-09-14 10:28:42', '2026-09-14 10:28:42', 1, 'curl/8.19.0'),
(716, '::1', '46jpjc4j7s1p1864q136cuj0as', '2026-09-14 10:28:42', '2026-09-14 10:28:42', 1, 'curl/8.19.0'),
(717, '::1', 'd51kbk4nvia9l3qd5hslrfaccq', '2026-09-14 10:28:43', '2026-09-14 10:28:43', 1, 'curl/8.19.0'),
(718, '::1', 's27a577tvtqs6n39d3uo5lqpal', '2026-09-14 10:28:44', '2026-09-14 10:28:44', 1, 'curl/8.19.0'),
(719, '::1', 'e85p7qkguv0s50lc8jlfsi05vs', '2026-09-14 10:28:45', '2026-09-14 10:28:45', 1, 'curl/8.19.0'),
(720, '::1', '9seq0m8okhtm2eijt72fd4g6nd', '2026-09-14 10:32:07', '2026-09-14 10:32:07', 1, 'curl/8.19.0'),
(721, '::1', 'kt4d5jkmnna4goup10cks0c0e4', '2026-09-14 10:32:41', '2026-09-14 10:32:41', 1, 'curl/8.19.0'),
(722, '::1', 'cn3v1g526r0a5pccjff1vsf13o', '2026-09-14 10:33:15', '2026-09-14 10:33:15', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(723, '::1', 'dl5cfbba9nk635nm7psh104anl', '2026-09-14 10:33:28', '2026-09-14 10:33:28', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(724, '::1', 'uroevudb5i8tpsmrqk7qa5chn6', '2026-09-14 10:34:35', '2026-09-14 10:34:35', 1, 'curl/8.19.0'),
(725, '::1', '5qq9l52jcqrc570q6clk621ue6', '2026-09-14 10:34:36', '2026-09-14 10:34:36', 1, 'curl/8.19.0'),
(726, '::1', '0uj3t1joe0vceabnu6v7ae20kv', '2026-09-14 10:34:36', '2026-09-14 10:34:36', 1, 'curl/8.19.0'),
(727, '::1', '0lkmaho799bc7b38u6npqerqi1', '2026-09-14 10:34:37', '2026-09-14 10:34:37', 1, 'curl/8.19.0'),
(728, '::1', 'fv3lf8h3dgajkdd16rrme9fuhk', '2026-09-14 10:34:37', '2026-09-14 10:34:37', 1, 'curl/8.19.0'),
(729, '::1', 'chpbv9mcrchqr110k5mgfdveuq', '2026-09-14 10:34:38', '2026-09-14 10:34:38', 1, 'curl/8.19.0'),
(730, '::1', '09qu2ol2i367md5fe3r2gpbmn0', '2026-09-14 10:34:38', '2026-09-14 10:34:38', 1, 'curl/8.19.0'),
(731, '::1', 'ch3b82ll33p7flqt74hu6qj6s0', '2026-09-14 10:34:39', '2026-09-14 10:34:39', 1, 'curl/8.19.0'),
(732, '::1', 'p7noqr3tnov8f7g593grjaktt4', '2026-09-14 10:34:40', '2026-09-14 10:34:40', 1, 'curl/8.19.0'),
(733, '::1', '2uro45ru6fhn1355rtfmjslf4v', '2026-09-14 10:34:40', '2026-09-14 10:34:40', 1, 'curl/8.19.0'),
(734, '::1', 'q1f0v07jpbvkt26s246d0aabad', '2026-09-14 10:34:41', '2026-09-14 10:34:41', 1, 'curl/8.19.0'),
(735, '::1', '90lue8ldd79uerqg129emsbafd', '2026-09-14 10:34:42', '2026-09-14 10:34:42', 1, 'curl/8.19.0'),
(736, '::1', 'iuqphmrr9le1mv0hb48ge2fopk', '2026-09-14 10:42:50', '2026-09-14 10:42:50', 1, 'curl/8.19.0'),
(737, '::1', 'lp25amdtk19glquf7fotvhck4a', '2026-09-14 10:43:19', '2026-09-14 10:43:19', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(738, '::1', 'tnn1ar21d6a33k0sdhrpnqhqil', '2026-09-14 10:43:29', '2026-09-14 10:43:29', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(739, '::1', '6hfh2qckiutb6iso8kju6rd45m', '2026-09-14 10:44:10', '2026-09-14 10:44:10', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(740, '::1', '8jjpadkt1db9icgsu8aqa29hd5', '2026-09-14 10:44:39', '2026-09-14 10:44:39', 1, 'curl/8.19.0'),
(741, '::1', 'aeifpmuvc1f8s9fhioemlpk1hr', '2026-09-14 10:44:40', '2026-09-14 10:44:40', 1, 'curl/8.19.0'),
(742, '::1', '7r79dagk2efc4fous1aeobqdpr', '2026-09-14 10:44:41', '2026-09-14 10:44:41', 1, 'curl/8.19.0'),
(743, '::1', 'l7fnm8cghejahhpemi52tcnuqe', '2026-09-14 10:44:42', '2026-09-14 10:44:42', 1, 'curl/8.19.0'),
(744, '::1', '38dt2boop86iddocofv4bkabo9', '2026-09-14 10:44:42', '2026-09-14 10:44:42', 1, 'curl/8.19.0'),
(745, '::1', '98hno5dv1inumq2tb3u4p0vnso', '2026-09-14 10:44:43', '2026-09-14 10:44:43', 1, 'curl/8.19.0'),
(746, '::1', 'dratj3h56e8f8el8gmkfvebhbk', '2026-09-14 10:44:43', '2026-09-14 10:44:43', 1, 'curl/8.19.0'),
(747, '::1', '39g8sujuskbgubq43junm08mse', '2026-09-14 10:44:44', '2026-09-14 10:44:44', 1, 'curl/8.19.0'),
(748, '::1', 'reekf3ku0m0b4436htal2th1t1', '2026-09-14 10:44:44', '2026-09-14 10:44:44', 1, 'curl/8.19.0'),
(749, '::1', 'tl7i66eq5gdt3tu0tuf5skmunv', '2026-09-14 10:44:45', '2026-09-14 10:44:45', 1, 'curl/8.19.0'),
(750, '::1', '0rae5co74c92vrjvi9gdh7871a', '2026-09-14 10:44:45', '2026-09-14 10:44:45', 1, 'curl/8.19.0'),
(751, '::1', 'p6c2jespb5rpi6murjk05sn7vt', '2026-09-14 10:44:46', '2026-09-14 10:44:46', 1, 'curl/8.19.0'),
(752, '::1', 'tnnogemf99l8ht8h5u21pko7bq', '2026-09-14 10:51:01', '2026-09-14 10:51:01', 1, 'curl/8.19.0'),
(753, '::1', '99210rh7asf3qbvj7ksh02hqn4', '2026-09-14 10:51:34', '2026-09-14 10:51:34', 1, 'curl/8.19.0'),
(754, '::1', 'ojrhn0nio6qncoscgs91igt091', '2026-09-14 10:51:35', '2026-09-14 10:51:35', 1, 'curl/8.19.0'),
(755, '::1', 'ssn81od9rvd19vir3vp4c6mu04', '2026-09-14 10:52:06', '2026-09-14 10:52:06', 1, 'curl/8.19.0'),
(756, '::1', 'epusb5h8ju6m7na0uefb2dlndl', '2026-09-14 10:52:06', '2026-09-14 10:52:06', 1, 'curl/8.19.0'),
(757, '::1', '5ehekcuui7tkt76k6gib5u61cp', '2026-09-14 10:53:08', '2026-09-14 10:53:08', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(758, '::1', 'ulnlnvmgvg3tl522fa421uejpo', '2026-09-14 10:53:25', '2026-09-14 10:53:25', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(759, '::1', 'o786fcglapnk5o04krivfvo6lo', '2026-09-14 10:53:51', '2026-09-14 10:53:51', 1, 'curl/8.19.0'),
(760, '::1', 'duuo71mcbptep1439stb2krfum', '2026-09-14 10:53:51', '2026-09-14 10:53:51', 1, 'curl/8.19.0'),
(761, '::1', 'dhkempjulhadbat4cq4ise4hin', '2026-09-14 10:53:52', '2026-09-14 10:53:52', 1, 'curl/8.19.0'),
(762, '::1', 'r1ekut0hvsj17ubdc2abt5b99b', '2026-09-14 10:53:52', '2026-09-14 10:53:52', 1, 'curl/8.19.0'),
(763, '::1', 'c2if3ci99i9nutt52m5965l6mc', '2026-09-14 10:53:53', '2026-09-14 10:53:53', 1, 'curl/8.19.0'),
(764, '::1', '3vkc3iuvg93296l4k9vnckj60b', '2026-09-14 10:53:53', '2026-09-14 10:53:53', 1, 'curl/8.19.0'),
(765, '::1', '88h283jltsrk7rhnif942dr6t7', '2026-09-14 10:53:54', '2026-09-14 10:53:54', 1, 'curl/8.19.0'),
(766, '::1', 'edq11s1bi4d8t9m1afpqucdh8p', '2026-09-14 10:53:54', '2026-09-14 10:53:54', 1, 'curl/8.19.0'),
(767, '::1', 'dvm1rqaknsl0i6fmmag5bo9hjq', '2026-09-14 10:53:55', '2026-09-14 10:53:55', 1, 'curl/8.19.0'),
(768, '::1', 'imm4s39hlp6487vkm0p0smkmg5', '2026-09-14 10:53:55', '2026-09-14 10:53:55', 1, 'curl/8.19.0'),
(769, '::1', 'c134vov6q1vt39k11585hpv3i4', '2026-09-14 10:53:55', '2026-09-14 10:53:55', 1, 'curl/8.19.0'),
(770, '::1', 'hqeurscjlp7suj5l9cp2hls81u', '2026-09-14 10:53:56', '2026-09-14 10:53:56', 1, 'curl/8.19.0'),
(771, '::1', 'hroh570qeadmagru2tigjr07p5', '2026-09-14 10:53:57', '2026-09-14 10:53:57', 1, 'curl/8.19.0'),
(772, '::1', 'ldq1thdde7mkf7t1clbmpb62cv', '2026-09-14 11:03:42', '2026-09-14 11:03:42', 1, 'curl/8.19.0'),
(773, '::1', 'qnf1albibppo12jsrqae2tpem3', '2026-09-14 11:03:44', '2026-09-14 11:03:44', 1, 'curl/8.19.0'),
(774, '::1', 'r55b52pn6smub3ti80dj4bicgu', '2026-09-14 11:03:45', '2026-09-14 11:03:45', 1, 'curl/8.19.0'),
(775, '::1', '9m06755cu22ev4r0jq4mrfij03', '2026-09-14 11:03:46', '2026-09-14 11:03:46', 1, 'curl/8.19.0'),
(776, '::1', '7p1m2r0v2dnhav6pcrdlokja8m', '2026-09-14 11:03:47', '2026-09-14 11:03:47', 1, 'curl/8.19.0'),
(777, '::1', 't2ro5n6ri782mjmb62r4f8cbr3', '2026-09-14 11:03:48', '2026-09-14 11:03:48', 1, 'curl/8.19.0'),
(778, '::1', 'dljjt64u26rd78cmj0frmsu02n', '2026-09-14 11:03:49', '2026-09-14 11:03:49', 1, 'curl/8.19.0'),
(779, '::1', 'dd3nncu3pe6vn3q2rjg84l15ur', '2026-09-14 11:03:49', '2026-09-14 11:03:49', 1, 'curl/8.19.0'),
(780, '::1', 'ch86h634qpiu421b1dcltta2mp', '2026-09-14 11:03:50', '2026-09-14 11:03:50', 1, 'curl/8.19.0'),
(781, '::1', 'o43sciuu1717n31lsd4qt4vrkq', '2026-09-14 11:03:50', '2026-09-14 11:03:50', 1, 'curl/8.19.0'),
(782, '::1', '46r71eia7fnihqkfrs72dcebpr', '2026-09-14 11:03:51', '2026-09-14 11:03:51', 1, 'curl/8.19.0'),
(783, '::1', 'vlvj6q01igp1e2afjdjjnakjm5', '2026-09-14 11:03:52', '2026-09-14 11:03:52', 1, 'curl/8.19.0'),
(784, '::1', 'agp6fuvi17gj6v34pgks7i1bet', '2026-09-14 11:03:53', '2026-09-14 11:03:53', 1, 'curl/8.19.0'),
(785, '::1', '3lnt4c869futbr9s3nbgr5tu9u', '2026-09-14 11:03:54', '2026-09-14 11:03:54', 1, 'curl/8.19.0'),
(786, '::1', 'ro6kpca8utvp02qv3kg12e8bpg', '2026-09-14 11:03:55', '2026-09-14 11:03:55', 1, 'curl/8.19.0'),
(787, '::1', '8ooc7vf8h80d5lcqmlao2ikmro', '2026-09-14 11:03:55', '2026-09-14 11:03:55', 1, 'curl/8.19.0'),
(788, '::1', 'dr3pgsvjrr7vkksoelaagcu55f', '2026-09-14 11:03:56', '2026-09-14 11:03:56', 1, 'curl/8.19.0'),
(789, '::1', '63ol5jp4l3cdl6rda6o2atcdbf', '2026-09-14 11:03:56', '2026-09-14 11:03:56', 1, 'curl/8.19.0'),
(790, '::1', 'tcbo71fmi7toear0mbmbn1qnnc', '2026-09-14 11:03:57', '2026-09-14 11:03:57', 1, 'curl/8.19.0'),
(791, '::1', '5hfm763v6g0fsj045552r9mtq5', '2026-09-14 11:03:58', '2026-09-14 11:03:58', 1, 'curl/8.19.0'),
(792, '::1', 'qvknmc03q2sh6pv5rbos4vufcu', '2026-09-14 11:04:09', '2026-09-14 11:04:09', 1, 'curl/8.19.0'),
(793, '::1', 'gp769lvcg2jtkmr2fgvvfaqect', '2026-09-14 11:05:17', '2026-09-14 11:05:17', 1, 'curl/8.19.0'),
(794, '::1', 'ttbeab3spl2afbre4m3pc8ut19', '2026-09-14 11:05:17', '2026-09-14 11:05:17', 1, 'curl/8.19.0'),
(795, '::1', 't1pnbrmhb79r8kgvff6hmkl16t', '2026-09-14 11:05:18', '2026-09-14 11:05:18', 1, 'curl/8.19.0'),
(796, '::1', 'ef69jiv5qif309iq7gaoog2o1b', '2026-09-14 11:05:18', '2026-09-14 11:05:18', 1, 'curl/8.19.0'),
(802, '::1', 'fe5286ubk4h2dqu0si9i9e2gjn', '2026-09-15 03:11:30', '2026-09-15 03:11:30', 1, 'curl/8.19.0'),
(803, '::1', 'm4bmk53i82j0c9m9u459np4i8c', '2026-09-15 03:15:04', '2026-09-15 03:15:04', 1, 'curl/8.19.0'),
(804, '::1', 'hjrbuc5bqj2ov75negcp86d4e7', '2026-09-15 03:16:18', '2026-09-15 03:16:18', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(805, '::1', 'sdpeqhpf81rdh9f6vml8vrn53u', '2026-09-15 03:16:43', '2026-09-15 03:16:43', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(806, '::1', 'snr2aielr918guur50dpb6rqg0', '2026-09-15 03:20:41', '2026-09-15 03:20:41', 1, 'curl/8.19.0'),
(807, '::1', 'dpjm2pgn0a1rmn2n4ajur9bhp8', '2026-09-15 03:20:43', '2026-09-15 03:20:43', 1, 'curl/8.19.0'),
(808, '::1', '49i74b5rf52qf1pidgce7og0ha', '2026-09-15 03:20:44', '2026-09-15 03:20:44', 1, 'curl/8.19.0'),
(809, '::1', 'o632ft2ciu6kp8d7u5abvisasa', '2026-09-15 03:20:45', '2026-09-15 03:20:45', 1, 'curl/8.19.0'),
(810, '::1', '4bfg5h40gv9kpr767mti3rag78', '2026-09-15 03:20:46', '2026-09-15 03:20:46', 1, 'curl/8.19.0'),
(811, '::1', 'faffrq7bd75vmmg7sh6dqtpo09', '2026-09-15 03:20:47', '2026-09-15 03:20:47', 1, 'curl/8.19.0'),
(812, '::1', 'somg77gbob1hiqknah8hqeggk7', '2026-09-15 03:20:47', '2026-09-15 03:20:47', 1, 'curl/8.19.0'),
(813, '::1', '23iu2g4v1d71h0evari0r7994u', '2026-09-15 03:20:48', '2026-09-15 03:20:48', 1, 'curl/8.19.0'),
(814, '::1', 'r6itluqdkve6576ofhtmr388vp', '2026-09-15 03:20:49', '2026-09-15 03:20:49', 1, 'curl/8.19.0'),
(815, '::1', '1skm4l15shnlkn2h9imdh5i6n4', '2026-09-15 03:20:50', '2026-09-15 03:20:50', 1, 'curl/8.19.0'),
(816, '::1', 'ed9kp4uf3b5i1f9c6hfegojk9i', '2026-09-15 03:20:51', '2026-09-15 03:20:51', 1, 'curl/8.19.0'),
(817, '::1', 'hbkdjid0c6td5vb7284me09f9o', '2026-09-15 03:20:51', '2026-09-15 03:20:51', 1, 'curl/8.19.0'),
(818, '::1', '3odlh2mkrbqu1r7o66ojn3gv5j', '2026-09-15 03:20:52', '2026-09-15 03:20:52', 1, 'curl/8.19.0'),
(819, '::1', '2bi344rtn0aae5fgnntnmrvqqh', '2026-09-15 03:20:53', '2026-09-15 03:20:53', 1, 'curl/8.19.0'),
(820, '::1', '5cgn54kslsc0lbg0aepscf3u2j', '2026-09-15 03:20:54', '2026-09-15 03:20:54', 1, 'curl/8.19.0'),
(821, '::1', 'm8fgat3tbdg6d2uiicet9ct2fh', '2026-09-15 03:20:55', '2026-09-15 03:20:55', 1, 'curl/8.19.0'),
(822, '::1', 'kvo74c5q3n54k5e6ceq6hrb1pj', '2026-09-15 03:30:34', '2026-09-15 03:30:34', 1, 'curl/8.19.0'),
(823, '::1', 'q1jv7ql7ti3278q72815qk3via', '2026-09-15 03:31:35', '2026-09-15 03:31:35', 1, 'curl/8.19.0'),
(824, '::1', 'q1m01u4fb8a9hcj59dne5itkd6', '2026-09-15 03:32:16', '2026-09-15 03:32:16', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(825, '::1', 'boogot2tgsb7r9tfsrf8ipbs74', '2026-09-15 03:32:27', '2026-09-15 03:32:27', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(827, '::1', 'k56sfon8ou9lk6ej0qsld17s2c', '2026-09-15 03:38:34', '2026-09-15 03:38:34', 1, 'curl/8.19.0'),
(828, '::1', 'b7artn8q6qnhkn6e78td7o4g9n', '2026-09-15 03:38:42', '2026-09-15 03:38:42', 1, 'curl/8.19.0'),
(829, '::1', '7c8cmguk1anhdbm57cs8hlhl6l', '2026-09-15 03:38:46', '2026-09-15 03:38:46', 1, 'curl/8.19.0'),
(830, '::1', 'o0ibhlilc8u5cqkpl6pcjeabod', '2026-09-15 03:38:48', '2026-09-15 03:38:48', 1, 'curl/8.19.0'),
(831, '::1', 'kkim3c0h19l6f46vc0lrnh3ha7', '2026-09-15 03:38:49', '2026-09-15 03:38:49', 1, 'curl/8.19.0'),
(832, '::1', 'g6t8tce92p2dinqdohk1tqvk4t', '2026-09-15 03:38:50', '2026-09-15 03:38:50', 1, 'curl/8.19.0'),
(833, '::1', 'vmca49u6f79ktgkvr4d2ism8rm', '2026-09-15 03:38:52', '2026-09-15 03:38:52', 1, 'curl/8.19.0'),
(834, '::1', 'tdj6tm60uasg8c44dubpu987ai', '2026-09-15 03:38:54', '2026-09-15 03:38:54', 1, 'curl/8.19.0'),
(835, '::1', 'aj9nkgb17smsflr7jfq7o5oikf', '2026-09-15 03:38:56', '2026-09-15 03:38:56', 1, 'curl/8.19.0'),
(836, '::1', 'b7aq5qv79jgs3slotle9m82u8q', '2026-09-15 03:38:57', '2026-09-15 03:38:57', 1, 'curl/8.19.0'),
(837, '::1', 'qu69aj5dgglt6ba4fa3le3os49', '2026-09-15 03:38:58', '2026-09-15 03:38:58', 1, 'curl/8.19.0');
INSERT INTO `unique_visitors` (`id`, `visitor_ip`, `session_id`, `first_visit`, `last_visit`, `total_visits`, `user_agent`) VALUES
(838, '::1', 'dt8fvu1ig275agguhgepmtvpea', '2026-09-15 03:38:59', '2026-09-15 03:38:59', 1, 'curl/8.19.0'),
(839, '::1', 'h1vvbhlju02ds6cj654uhcgmpp', '2026-09-15 03:39:00', '2026-09-15 03:39:00', 1, 'curl/8.19.0'),
(840, '::1', 'fe08pq5tu66gjd68edobmcjpr9', '2026-09-15 03:39:01', '2026-09-15 03:39:01', 1, 'curl/8.19.0'),
(841, '::1', '6faeu0eb38kunk56lfuom24dal', '2026-09-15 03:39:02', '2026-09-15 03:39:02', 1, 'curl/8.19.0'),
(842, '::1', 'bqukqasa6r6vucndjofv2df1g7', '2026-09-15 03:39:04', '2026-09-15 03:39:04', 1, 'curl/8.19.0'),
(843, '::1', 'osuuin30e25rl48mea2ghrq8bn', '2026-09-15 03:39:05', '2026-09-15 03:39:05', 1, 'curl/8.19.0'),
(844, '::1', '5161c8gc50re4fshf9hcfkva5q', '2026-09-15 03:39:07', '2026-09-15 03:39:07', 1, 'curl/8.19.0'),
(845, '::1', 'q8pidg6r4j8qtatbu4pacc72ud', '2026-09-15 03:39:08', '2026-09-15 03:39:08', 1, 'curl/8.19.0'),
(846, '::1', '57nib4a463rlvn4ks3dp907tgd', '2026-09-15 03:55:45', '2026-09-15 03:55:45', 1, 'curl/8.19.0'),
(847, '::1', 'ib08p6o4fr3g2gof631ahgj18s', '2026-09-15 03:57:20', '2026-09-15 03:57:20', 1, 'curl/8.19.0'),
(848, '::1', '68g8f8461eouk1ro497c6h7rdd', '2026-09-15 03:59:26', '2026-09-15 03:59:26', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(849, '::1', 'hs1s17c04dnni25klflj6408lr', '2026-09-15 04:00:08', '2026-09-15 04:00:08', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(850, '::1', 'baprhle8alru9hksbuc4kqogr0', '2026-09-15 04:04:27', '2026-09-15 04:04:27', 1, 'curl/8.19.0'),
(851, '::1', 'up371okv09fpgebg1geu2ae153', '2026-09-15 04:04:56', '2026-09-15 04:04:56', 1, 'curl/8.19.0'),
(852, '::1', '7j97jl5532m0sk26lgp9bhd2kj', '2026-09-15 04:05:46', '2026-09-15 04:05:46', 1, 'curl/8.19.0'),
(853, '::1', 'pmk231jp8o0b17gugh7j81haqm', '2026-09-15 04:05:58', '2026-09-15 04:05:58', 1, 'curl/8.19.0'),
(854, '::1', 'u6aj4vijq5cqcuec38rsnpah3v', '2026-09-15 04:06:13', '2026-09-15 04:06:13', 1, 'curl/8.19.0'),
(855, '::1', 'ti5v6m500uhoa7hga1ppbkrnta', '2026-09-15 04:06:31', '2026-09-15 04:06:31', 1, 'curl/8.19.0'),
(856, '::1', 'b4uf509j1uk76b6sa2ktoe7hj2', '2026-09-15 04:06:51', '2026-09-15 04:06:51', 1, 'curl/8.19.0'),
(857, '::1', 'jcr4ja08dm5rjvr63vp2hkuijs', '2026-09-15 04:06:56', '2026-09-15 04:06:56', 1, 'curl/8.19.0'),
(858, '::1', '38fq87fdith59bc4ku09rmlgpg', '2026-09-15 04:07:02', '2026-09-15 04:07:02', 1, 'curl/8.19.0'),
(859, '::1', '2rvei2c12gf8ko76qaf430dlf2', '2026-09-15 04:07:04', '2026-09-15 04:07:04', 1, 'curl/8.19.0'),
(860, '::1', 'gh4vsr08av077jbg8upi9c5239', '2026-09-15 04:07:08', '2026-09-15 04:07:08', 1, 'curl/8.19.0'),
(861, '::1', '4dc37ioo8n0v148fivdcrk8k6l', '2026-09-15 04:07:13', '2026-09-15 04:07:13', 1, 'curl/8.19.0'),
(862, '::1', 'qce0r0tbhehq9irbu0pr7lejpc', '2026-09-15 04:07:17', '2026-09-15 04:07:17', 1, 'curl/8.19.0'),
(863, '::1', 'l3vj90946o6vhqv7q8r712ostq', '2026-09-15 04:07:26', '2026-09-15 04:07:26', 1, 'curl/8.19.0'),
(864, '::1', 'pbv7mgdqh7197aq59ehgdf3hm2', '2026-09-15 04:07:33', '2026-09-15 04:07:33', 1, 'curl/8.19.0'),
(865, '::1', 'int8vtg02buqf2ckrd80qf7ggb', '2026-09-15 04:07:39', '2026-09-15 04:07:39', 1, 'curl/8.19.0'),
(866, '::1', '4o6uqajedov85tlst6nbfcoesq', '2026-09-15 04:07:55', '2026-09-15 04:07:55', 1, 'curl/8.19.0'),
(867, '::1', 'c1a72bfjig6oh5apvigj4fs89h', '2026-09-15 04:08:14', '2026-09-15 04:08:14', 1, 'curl/8.19.0'),
(868, '::1', '2c7ida0crftd1gdeti62cmp0iq', '2026-09-15 04:08:27', '2026-09-15 04:08:27', 1, 'curl/8.19.0'),
(869, '::1', '9ppnb43qoavvp16s499c5fhlt9', '2026-09-15 04:16:26', '2026-09-15 04:16:26', 1, 'curl/8.19.0'),
(870, '::1', 'iqehjmng11gonvfvea29s586ms', '2026-09-15 04:17:24', '2026-09-15 04:17:24', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(871, '::1', 'nvib3g5pmg0qjvkpg177mspueo', '2026-09-15 04:17:37', '2026-09-15 04:17:37', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(872, '::1', '53a8mupnthtvkrtnbaf4gec989', '2026-09-15 04:19:04', '2026-09-15 04:19:04', 1, 'curl/8.19.0'),
(873, '::1', 'mfiigurgir3mk900m7u4acptg1', '2026-09-15 04:20:11', '2026-09-15 04:20:11', 1, 'curl/8.19.0'),
(874, '::1', 'bk4s81rj5lv2aa90chep3qrc3d', '2026-09-15 04:20:12', '2026-09-15 04:20:12', 1, 'curl/8.19.0'),
(875, '::1', 'kp02iine7ovn4i1albkeeprgve', '2026-09-15 04:20:14', '2026-09-15 04:20:14', 1, 'curl/8.19.0'),
(876, '::1', '76l59lmi84r19ckuea5voholph', '2026-09-15 04:20:15', '2026-09-15 04:20:15', 1, 'curl/8.19.0'),
(877, '::1', '795sp22kekd910bde5cdb65oji', '2026-09-15 04:20:15', '2026-09-15 04:20:15', 1, 'curl/8.19.0'),
(878, '::1', 'begmuco5lo72kp16c4ousc6m0n', '2026-09-15 04:20:16', '2026-09-15 04:20:16', 1, 'curl/8.19.0'),
(879, '::1', 'itaokqb1v8k6dt67ak8soop2o0', '2026-09-15 04:20:17', '2026-09-15 04:20:17', 1, 'curl/8.19.0'),
(880, '::1', '5t416bh05fqdf6nve5os07coeg', '2026-09-15 04:20:17', '2026-09-15 04:20:17', 1, 'curl/8.19.0'),
(881, '::1', 'sn20auq0budklhim7g98cd7kc0', '2026-09-15 04:20:18', '2026-09-15 04:20:18', 1, 'curl/8.19.0'),
(882, '::1', '0jj1c4bqcvmc34dqbriujsvg2n', '2026-09-15 04:20:24', '2026-09-15 04:20:24', 1, 'curl/8.19.0'),
(883, '::1', '45eu83knv9i4qoru3ftfvhpf87', '2026-09-15 04:24:59', '2026-09-15 04:24:59', 1, 'curl/8.19.0'),
(884, '::1', 'jds16fnshd72diqeu4e9624koi', '2026-09-15 04:25:52', '2026-09-15 04:25:52', 1, 'curl/8.19.0'),
(885, '::1', 'g1gl72doknlp5jumb5l1q74512', '2026-09-15 04:26:33', '2026-09-15 04:26:33', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(886, '::1', 'vl5gc7n2drrsoip1afvg2g7nbs', '2026-09-15 04:26:40', '2026-09-15 04:26:40', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(887, '::1', '32kf1q30ek48rcvrv8mubnove6', '2026-09-15 04:27:34', '2026-09-15 04:27:34', 1, 'curl/8.19.0'),
(888, '::1', 'dltpelq01e244kj4cd6hbji038', '2026-09-15 04:27:35', '2026-09-15 04:27:35', 1, 'curl/8.19.0'),
(889, '::1', '66ln2r28q9i5fr4j57cs246gh3', '2026-09-15 04:27:36', '2026-09-15 04:27:36', 1, 'curl/8.19.0'),
(890, '::1', 'c5et9fag3rnogoscqhdjv8juo6', '2026-09-15 04:27:37', '2026-09-15 04:27:37', 1, 'curl/8.19.0'),
(891, '::1', '5d6gu76c95qp4ptq9rlhfd57ri', '2026-09-15 04:27:37', '2026-09-15 04:27:37', 1, 'curl/8.19.0'),
(892, '::1', 'nl5n9dpvsgqe2n18ua218sbk6f', '2026-09-15 04:27:38', '2026-09-15 04:27:38', 1, 'curl/8.19.0'),
(893, '::1', 'hrv25htgq8d4ncv377fgkshkns', '2026-09-15 04:27:39', '2026-09-15 04:27:39', 1, 'curl/8.19.0'),
(894, '::1', '46l0pmcvk704t0ddeocu9fpbqc', '2026-09-15 04:27:39', '2026-09-15 04:27:39', 1, 'curl/8.19.0'),
(895, '::1', '11icdajom0u91cblh44u333vnh', '2026-09-15 04:27:40', '2026-09-15 04:27:40', 1, 'curl/8.19.0'),
(896, '::1', 'tpn9arekm95qhq9dqfk8kltns0', '2026-09-15 04:27:41', '2026-09-15 04:27:41', 1, 'curl/8.19.0'),
(897, '::1', 'o42d9ljfirjag95ddag2vtm3b9', '2026-09-15 04:27:42', '2026-09-15 04:27:42', 1, 'curl/8.19.0'),
(901, '::1', '2f5tkg1ltsqahtp25q12khth7v', '2026-09-15 04:34:50', '2026-09-15 04:34:50', 1, 'curl/8.19.0'),
(902, '::1', 'r0c1staftkn8ei6a9ulup8u1ls', '2026-09-15 04:35:38', '2026-09-15 04:35:38', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(903, '::1', 'bp5hc6a3pcq69l4ms2d1kvjmhs', '2026-09-15 04:36:23', '2026-09-15 04:36:23', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(904, '::1', 'i4qlfjjijhun5jv72h1tji7dtt', '2026-09-15 04:38:02', '2026-09-15 04:38:02', 1, 'curl/8.19.0'),
(905, '::1', 't2raulspvt6c7e5vakcq8dtmv2', '2026-09-15 04:38:03', '2026-09-15 04:38:03', 1, 'curl/8.19.0'),
(906, '::1', '4j8lcf22lc3304i0r3fqtnikre', '2026-09-15 04:38:05', '2026-09-15 04:38:05', 1, 'curl/8.19.0'),
(907, '::1', '1lf490mmgod9tgpj88n367u6is', '2026-09-15 04:38:09', '2026-09-15 04:38:09', 1, 'curl/8.19.0'),
(908, '::1', '8g9kmog0gtl116cdndokvmdqhe', '2026-09-15 04:38:10', '2026-09-15 04:38:10', 1, 'curl/8.19.0'),
(909, '::1', 'vd8bn9hfodb8mnbk0hssv9fm9h', '2026-09-15 04:38:12', '2026-09-15 04:38:12', 1, 'curl/8.19.0'),
(910, '::1', '0u5idos0hsc05qqgjoqul7nndr', '2026-09-15 04:38:14', '2026-09-15 04:38:14', 1, 'curl/8.19.0'),
(911, '::1', 'q61bb1qsnr4tqkhm4dpnjum30u', '2026-09-15 04:38:16', '2026-09-15 04:38:16', 1, 'curl/8.19.0'),
(912, '::1', 'r28o804dcnjgt0e62rftkinl6p', '2026-09-15 04:38:17', '2026-09-15 04:38:17', 1, 'curl/8.19.0'),
(913, '::1', '2jjp8ho0jq44vv04acreici0tn', '2026-09-15 04:38:18', '2026-09-15 04:38:18', 1, 'curl/8.19.0'),
(914, '::1', 'k0i29hmnt5vk0uvqu7uomebbit', '2026-09-15 04:38:20', '2026-09-15 04:38:20', 1, 'curl/8.19.0'),
(915, '::1', 'ft299i32ro1vseftep4qipjmj8', '2026-09-15 04:38:21', '2026-09-15 04:38:21', 1, 'curl/8.19.0'),
(916, '::1', 't8un44qrslh010oucc312ndj43', '2026-09-15 04:38:22', '2026-09-15 04:38:22', 1, 'curl/8.19.0'),
(917, '::1', 'q20hsn34q5kf866ts3bdeu18pn', '2026-09-15 04:38:24', '2026-09-15 04:38:24', 1, 'curl/8.19.0'),
(918, '::1', 'fvfjb9j3f6er7qg7g1e3arspjc', '2026-09-15 04:38:25', '2026-09-15 04:38:25', 1, 'curl/8.19.0'),
(919, '::1', 'mh5rm99dbaloc43tn443aklldk', '2026-09-15 04:38:28', '2026-09-15 04:38:28', 1, 'curl/8.19.0'),
(920, '::1', '5f9rfqgj930qs0osqoot0ljekb', '2026-09-15 04:38:29', '2026-09-15 04:38:29', 1, 'curl/8.19.0'),
(921, '::1', 'gbak2v4ofrhq5l9lh5o0kgusac', '2026-09-15 04:38:31', '2026-09-15 04:38:31', 1, 'curl/8.19.0'),
(922, '::1', 'bsopea1jhb89du9an1jndfr6fk', '2026-09-15 04:38:32', '2026-09-15 04:38:32', 1, 'curl/8.19.0'),
(923, '::1', 'ikmlkkv4jvdvmg45f0mvomiom8', '2026-09-15 04:38:33', '2026-09-15 04:38:33', 1, 'curl/8.19.0'),
(924, '::1', 'aj4tioqkvujemdp63qt6s6as3c', '2026-09-15 04:38:36', '2026-09-15 04:38:36', 1, 'curl/8.19.0'),
(925, '::1', 'q57lnui25hrp5f9n1t9rfok9e0', '2026-09-15 04:38:37', '2026-09-15 04:38:37', 1, 'curl/8.19.0'),
(928, '::1', '3sn4hokfokma8moodk19jsmhcj', '2026-09-15 04:45:14', '2026-09-15 04:45:14', 1, 'curl/8.19.0'),
(929, '::1', 'pu16pmus7at09t1nbq70m92o71', '2026-09-15 04:46:15', '2026-09-15 04:46:15', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(930, '::1', 'dkltjiahteseld2o0pp0f0dotr', '2026-09-15 04:46:43', '2026-09-15 04:46:43', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(931, '127.0.0.1', '9tgtmqaqb2b7u19uibeckutpec', '2026-09-15 04:48:42', '2026-09-15 04:48:42', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(932, '::1', 'gt182a6ivu08a3il8nqvvhfve8', '2026-09-15 04:52:07', '2026-09-15 04:52:07', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(933, '::1', 'kt95pt2s81csociosj2uu4bqlc', '2026-09-15 04:53:46', '2026-09-15 04:53:46', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(934, '::1', 'tjct48c61gmfel8ha6j3kdcacq', '2026-09-15 04:54:22', '2026-09-15 04:54:22', 1, 'curl/8.19.0'),
(935, '::1', 'vgi83t6gpcu6ldka55i5a01hpi', '2026-09-15 04:54:24', '2026-09-15 04:54:24', 1, 'curl/8.19.0'),
(936, '::1', 'rbghr7vse63fi08nv8hbr820mb', '2026-09-15 04:54:25', '2026-09-15 04:54:25', 1, 'curl/8.19.0'),
(937, '::1', 'poh60su1qu1ssrqr2jjbu7mlr4', '2026-09-15 04:54:25', '2026-09-15 04:54:25', 1, 'curl/8.19.0'),
(938, '::1', 'ce5tp0maq33brervjsrsja9u76', '2026-09-15 04:54:26', '2026-09-15 04:54:26', 1, 'curl/8.19.0'),
(939, '::1', '3mghp7ef7udhbp6e23u3cftue7', '2026-09-15 04:54:26', '2026-09-15 04:54:26', 1, 'curl/8.19.0'),
(940, '::1', 'fgffvc15a0e6p6g289hnqq6i43', '2026-09-15 04:54:27', '2026-09-15 04:54:27', 1, 'curl/8.19.0'),
(941, '::1', 'n3cd2j963cmqkouaa3altqh77h', '2026-09-15 04:54:27', '2026-09-15 04:54:27', 1, 'curl/8.19.0'),
(942, '::1', 'g7erct584u13t0kf0l7o788mj8', '2026-09-15 04:54:28', '2026-09-15 04:54:28', 1, 'curl/8.19.0'),
(943, '::1', 'k7ch5khrsdt42fqc1vcm091jgp', '2026-09-15 04:54:29', '2026-09-15 04:54:29', 1, 'curl/8.19.0'),
(944, '::1', 'eoeen9dpgdedheljhh0ve1goiu', '2026-09-15 04:54:30', '2026-09-15 04:54:30', 1, 'curl/8.19.0'),
(945, '::1', 'rfcak2epuvcl81iatmtvbg1cdd', '2026-09-15 04:54:31', '2026-09-15 04:54:31', 1, 'curl/8.19.0'),
(946, '::1', 'jek4rnc77d0ukfnu06o5l0e01q', '2026-09-15 04:54:32', '2026-09-15 04:54:32', 1, 'curl/8.19.0'),
(947, '::1', 'ad2fe0jifci6t3e9genvd17i4n', '2026-09-15 04:54:32', '2026-09-15 04:54:32', 1, 'curl/8.19.0'),
(948, '::1', 'j0kfrce9tva39ceb3sp9f49rvv', '2026-09-15 04:54:33', '2026-09-15 04:54:33', 1, 'curl/8.19.0'),
(949, '::1', 'iasstvha7eo632bkggl61df8pk', '2026-09-15 04:54:34', '2026-09-15 04:54:34', 1, 'curl/8.19.0'),
(950, '::1', 'mdchmlgcg7r276fblvu7jp9o15', '2026-09-15 04:54:34', '2026-09-15 04:54:34', 1, 'curl/8.19.0'),
(951, '::1', 'snuo63gbes1aa6agpvdsmdjbg1', '2026-09-15 04:54:35', '2026-09-15 04:54:35', 1, 'curl/8.19.0'),
(953, '::1', '7jpsc9l7dfnd91mpgf1c98nkab', '2026-09-15 05:32:40', '2026-09-15 05:32:40', 1, 'curl/8.19.0'),
(954, '::1', 'mrjrd0v6jsh0to4mf36bbf4lmj', '2026-09-15 05:32:41', '2026-09-15 05:32:41', 1, 'curl/8.19.0'),
(955, '::1', 'sgdv0g7hnrhjnkvkmq0hm8thds', '2026-09-15 05:33:27', '2026-09-15 05:33:37', 2, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(957, '::1', 'actkur22164p5pr6bf6gkj2ara', '2026-09-15 05:34:10', '2026-09-15 05:34:10', 1, 'curl/8.19.0'),
(958, '::1', 'ifo13nhvd19og9fsjgadav7n8d', '2026-09-15 05:34:11', '2026-09-15 05:34:11', 1, 'curl/8.19.0'),
(959, '::1', '016knhas1j8gsi1k5chs848ho0', '2026-09-15 05:34:12', '2026-09-15 05:34:12', 1, 'curl/8.19.0'),
(960, '::1', '60n16n0pok278c3mvhecbj582l', '2026-09-15 05:34:13', '2026-09-15 05:34:13', 1, 'curl/8.19.0'),
(961, '::1', 't427corua89a268ri9lgumu77n', '2026-09-15 05:34:14', '2026-09-15 05:34:14', 1, 'curl/8.19.0'),
(962, '::1', 'bj4bu23k15s537493uk5sbi9a8', '2026-09-15 05:34:15', '2026-09-15 05:34:15', 1, 'curl/8.19.0'),
(963, '::1', 'omheol67m85abeiv20uk36ibmg', '2026-09-15 05:34:17', '2026-09-15 05:34:17', 1, 'curl/8.19.0'),
(964, '::1', 'f4fnamd4u8h80pa4ndvnpbk4hm', '2026-09-15 05:34:19', '2026-09-15 05:34:19', 1, 'curl/8.19.0'),
(965, '::1', 'kautjnsfsuu98pe0pt7qqphq33', '2026-09-15 05:34:19', '2026-09-15 05:34:19', 1, 'curl/8.19.0'),
(966, '::1', '0m17qhnojk6tk3a9if8l4au0nn', '2026-09-15 05:34:20', '2026-09-15 05:34:20', 1, 'curl/8.19.0'),
(967, '::1', 'mrra5b2pj100du8ubpsie909j3', '2026-09-15 05:34:21', '2026-09-15 05:34:21', 1, 'curl/8.19.0'),
(968, '::1', 'r9merfgsed2afgsrpf3leeilui', '2026-09-15 05:34:22', '2026-09-15 05:34:22', 1, 'curl/8.19.0'),
(969, '::1', 'u767u7hmqriffmmraafidcdkej', '2026-09-15 05:34:22', '2026-09-15 05:34:22', 1, 'curl/8.19.0'),
(970, '::1', '65vale5r7d1c6e0qgb77vpq1kc', '2026-09-15 05:34:23', '2026-09-15 05:34:23', 1, 'curl/8.19.0'),
(971, '::1', '69pvf8au3qpue3ng7kv6ep8he4', '2026-09-15 05:34:24', '2026-09-15 05:34:24', 1, 'curl/8.19.0'),
(972, '::1', 'avspafika15npa5s21925fevks', '2026-09-15 05:34:24', '2026-09-15 05:34:24', 1, 'curl/8.19.0'),
(973, '::1', 'c5b53jk3njnmfb1s0nagv10urh', '2026-09-15 05:34:25', '2026-09-15 05:34:25', 1, 'curl/8.19.0'),
(974, '::1', 'ittprokikf7qqepu97vgbml02k', '2026-09-15 05:43:54', '2026-09-15 05:43:54', 1, 'curl/8.19.0'),
(975, '::1', '7ruqmaakbni6l347qagvodopuh', '2026-09-15 05:43:55', '2026-09-15 05:43:55', 1, 'curl/8.19.0'),
(976, '::1', '3h3t7a7iunvagqhiumfvfh4n8g', '2026-09-15 05:44:13', '2026-09-15 05:44:13', 1, 'curl/8.19.0'),
(977, '::1', '3evohi57gdu6le27n6h6d8ago5', '2026-09-15 05:44:17', '2026-09-15 05:44:17', 1, 'curl/8.19.0'),
(978, '::1', 'pbi3k72m6fanhkorupu4msc5ii', '2026-09-15 05:44:17', '2026-09-15 05:44:17', 1, 'curl/8.19.0'),
(979, '::1', '1cmtj312ir35i3s5e1nslobc6j', '2026-09-15 05:44:20', '2026-09-15 05:44:20', 1, 'curl/8.19.0'),
(980, '::1', 'us1e2v8gvifqnml1b117iobe1j', '2026-09-15 05:44:21', '2026-09-15 05:44:21', 1, 'curl/8.19.0'),
(981, '::1', 'scsoe29k458li130938t22h2ur', '2026-09-15 05:44:22', '2026-09-15 05:44:22', 1, 'curl/8.19.0'),
(982, '::1', '2i7m041blhuo4t311crb8crkct', '2026-09-15 05:44:22', '2026-09-15 05:44:22', 1, 'curl/8.19.0'),
(983, '::1', 'vlvv7cibncljcq6p5tcaj9cfcp', '2026-09-15 05:44:23', '2026-09-15 05:44:23', 1, 'curl/8.19.0'),
(984, '::1', 'issov9hbpi04sv73o3t1j56kq7', '2026-09-15 05:44:25', '2026-09-15 05:44:25', 1, 'curl/8.19.0'),
(985, '::1', 'gebcs1n0uj9608qvqs2clqkt9s', '2026-09-15 05:44:27', '2026-09-15 05:44:27', 1, 'curl/8.19.0'),
(986, '::1', '0munoslrus14163e6tl0rado9v', '2026-09-15 05:44:29', '2026-09-15 05:44:29', 1, 'curl/8.19.0'),
(987, '::1', 'fnvklcp9rgo66o7emcb84pnrmn', '2026-09-15 05:44:34', '2026-09-15 05:44:34', 1, 'curl/8.19.0'),
(988, '::1', 'a92av14qffpvh7i4am5hhff1ma', '2026-09-15 05:44:37', '2026-09-15 05:44:37', 1, 'curl/8.19.0'),
(989, '::1', 'v8gdc1k9mt534arkpiq3sg4tt2', '2026-09-15 05:44:37', '2026-09-15 05:44:37', 1, 'curl/8.19.0'),
(990, '::1', 'elp7f3o5gjssru5e0b06me4i2j', '2026-09-15 05:44:38', '2026-09-15 05:44:38', 1, 'curl/8.19.0'),
(991, '::1', '6br37247756mnfgtv50mtr88r3', '2026-09-15 05:48:29', '2026-09-15 05:48:29', 1, 'curl/8.19.0'),
(992, '::1', 'g6cjn4ptpgh2eq5g887htlmqcv', '2026-09-15 05:48:31', '2026-09-15 05:48:31', 1, 'curl/8.19.0'),
(993, '::1', 'su89ohrp1s1871nr143vcp14ec', '2026-09-15 05:48:32', '2026-09-15 05:48:32', 1, 'curl/8.19.0'),
(994, '::1', 'm6lpqgmdjiokhu1dngpfjh36em', '2026-09-15 05:48:33', '2026-09-15 05:48:33', 1, 'curl/8.19.0'),
(995, '::1', 'kch4vvj1npfu68jlrqogucd94f', '2026-09-15 05:48:34', '2026-09-15 05:48:34', 1, 'curl/8.19.0'),
(996, '::1', 'kuhbg5hjdrm6ipbam2vlemssjt', '2026-09-15 05:48:34', '2026-09-15 05:48:34', 1, 'curl/8.19.0'),
(997, '::1', 'bjr2emcpt9svj1ogjniuerlv72', '2026-09-15 05:48:35', '2026-09-15 05:48:35', 1, 'curl/8.19.0'),
(998, '::1', 'okmstj1ocnd3kfu8dhigin45pm', '2026-09-15 05:48:35', '2026-09-15 05:48:35', 1, 'curl/8.19.0'),
(999, '::1', 'dorkoi9c5rte4md0bv7ac4p0cd', '2026-09-15 05:48:36', '2026-09-15 05:48:36', 1, 'curl/8.19.0'),
(1000, '::1', '2cip235g0fbma6kib34qvf08ae', '2026-09-15 05:48:36', '2026-09-15 05:48:36', 1, 'curl/8.19.0'),
(1001, '::1', 'kngg7a8i6rv3k68oncd67mdbu4', '2026-09-15 05:48:37', '2026-09-15 05:48:37', 1, 'curl/8.19.0'),
(1002, '::1', '4d1ajrherq5325i2knfdfi57aa', '2026-09-15 05:48:38', '2026-09-15 05:48:38', 1, 'curl/8.19.0'),
(1003, '::1', 'vksk2nqrhs15bs5sadelo70ab8', '2026-09-15 05:48:39', '2026-09-15 05:48:39', 1, 'curl/8.19.0'),
(1004, '::1', 'mjs2ti5pi8g4v0ql9bjout35uq', '2026-09-15 05:48:39', '2026-09-15 05:48:39', 1, 'curl/8.19.0'),
(1005, '::1', 'vooars2jst2tt17f19e02smvu4', '2026-09-15 05:48:40', '2026-09-15 05:48:40', 1, 'curl/8.19.0'),
(1006, '::1', 'n45r04p8gdrm6r0kntcs8gpkk6', '2026-09-15 05:48:40', '2026-09-15 05:48:40', 1, 'curl/8.19.0'),
(1007, '::1', '06u7vtchv32uh152s9uodm7o83', '2026-09-15 05:48:41', '2026-09-15 05:48:41', 1, 'curl/8.19.0'),
(1008, '::1', 'qd2kklhoivfavulu922esd9p0f', '2026-09-15 05:48:42', '2026-09-15 05:48:42', 1, 'curl/8.19.0'),
(1009, '::1', '46mc1nscdhf3o7tfd5ttfkqm0m', '2026-09-15 05:48:43', '2026-09-15 05:48:43', 1, 'curl/8.19.0'),
(1010, '::1', 'jitjafb8vh151s6mhuu0241jgn', '2026-09-15 05:48:43', '2026-09-15 05:48:43', 1, 'curl/8.19.0'),
(1011, '::1', '6c0nio07puj8mc871b3ia9s3u5', '2026-09-15 05:48:44', '2026-09-15 05:48:44', 1, 'curl/8.19.0'),
(1012, '::1', '1jibgo57dvqviq7qthn293ue6g', '2026-09-15 05:48:44', '2026-09-15 05:48:44', 1, 'curl/8.19.0'),
(1013, '::1', 'fnpu522cd0i4ueeimc9h9rsq0h', '2026-09-15 05:48:45', '2026-09-15 05:48:45', 1, 'curl/8.19.0'),
(1014, '::1', '73uqnnqbsm0bk6v11uip9ucgq3', '2026-09-15 05:48:46', '2026-09-15 05:48:46', 1, 'curl/8.19.0'),
(1015, '::1', '0ie2lllme428daktttjjasag7p', '2026-09-15 05:48:46', '2026-09-15 05:48:46', 1, 'curl/8.19.0'),
(1016, '::1', 'tbk1occ8ul07n39ps40er0r3vi', '2026-09-15 05:48:47', '2026-09-15 05:48:47', 1, 'curl/8.19.0'),
(1017, '::1', 'jjrt3mkodt0pk1j0n854ofa88e', '2026-09-15 05:48:48', '2026-09-15 05:48:48', 1, 'curl/8.19.0'),
(1018, '::1', 'hvthfdnhij0j6mk9u1na2u2tqc', '2026-09-15 05:48:48', '2026-09-15 05:48:48', 1, 'curl/8.19.0'),
(1019, '::1', 'cj7ca818pv94fstqr73gfjknug', '2026-09-15 05:51:33', '2026-09-15 05:51:33', 1, 'curl/8.19.0'),
(1020, '::1', 'm7o2us3t5comila45m1f6ahlvc', '2026-09-15 05:51:33', '2026-09-15 05:51:33', 1, 'curl/8.19.0'),
(1021, '::1', 'ingj276267m6804o2ab5413p2s', '2026-09-15 05:51:34', '2026-09-15 05:51:34', 1, 'curl/8.19.0'),
(1022, '::1', 'fon9okctn27gb3v5p02dgabj9b', '2026-09-15 05:51:34', '2026-09-15 05:51:34', 1, 'curl/8.19.0'),
(1023, '::1', 'irg9bvo0kmgpeu47pi3vdj2a8q', '2026-09-15 05:51:35', '2026-09-15 05:51:35', 1, 'curl/8.19.0'),
(1024, '::1', '9oo23gj5f50s1k6msfeou1tv8m', '2026-09-15 05:51:36', '2026-09-15 05:51:36', 1, 'curl/8.19.0'),
(1025, '::1', 'el7e6tnvd10vhc0s6nlm3u3qqa', '2026-09-15 05:51:36', '2026-09-15 05:51:36', 1, 'curl/8.19.0'),
(1026, '::1', '69sau23klu589va34t7e0hopij', '2026-09-15 05:51:37', '2026-09-15 05:51:37', 1, 'curl/8.19.0'),
(1027, '::1', '2ud2hf0mt8k8pur675pmuf6rs2', '2026-09-15 05:51:38', '2026-09-15 05:51:38', 1, 'curl/8.19.0'),
(1028, '::1', 'ke9n3agd7g01ebmoi4h4ddj3tt', '2026-09-15 05:51:38', '2026-09-15 05:51:38', 1, 'curl/8.19.0'),
(1029, '::1', '9f3psrqbf1n2g674apph16q2ei', '2026-09-15 05:51:39', '2026-09-15 05:51:39', 1, 'curl/8.19.0'),
(1030, '::1', '3ghcg61cg77mv9vv0kmma0pvi9', '2026-09-15 05:51:39', '2026-09-15 05:51:39', 1, 'curl/8.19.0'),
(1031, '::1', 'afn9987cvhjdilp8slpsk724l6', '2026-09-15 05:51:40', '2026-09-15 05:51:40', 1, 'curl/8.19.0'),
(1032, '::1', 'pd4nmfi4tt1irbd6q11hc84up5', '2026-09-15 05:51:41', '2026-09-15 05:51:41', 1, 'curl/8.19.0'),
(1033, '::1', 'v5tf4u0r2b3v7pr6e958fvcbvt', '2026-09-15 05:51:41', '2026-09-15 05:51:41', 1, 'curl/8.19.0'),
(1034, '::1', 'ct0kdb973sv7sa2i9skgrpug27', '2026-09-15 05:51:42', '2026-09-15 05:51:42', 1, 'curl/8.19.0'),
(1035, '::1', '1uuk3pf23ica5rr7j19jlvd65b', '2026-09-15 05:51:42', '2026-09-15 05:51:42', 1, 'curl/8.19.0'),
(1036, '::1', '34anjlkgpp1j783tcd5i6sstj5', '2026-09-15 05:51:43', '2026-09-15 05:51:43', 1, 'curl/8.19.0'),
(1037, '::1', 'ub9dl06mmmih4v9tbhvk1uocvr', '2026-09-15 05:51:43', '2026-09-15 05:51:43', 1, 'curl/8.19.0'),
(1038, '::1', '04a950p7kavdun8b6ml89uo7be', '2026-09-15 05:51:44', '2026-09-15 05:51:44', 1, 'curl/8.19.0'),
(1039, '::1', 'hlhvkd0j4dsnjldeh7jc6cvrat', '2026-09-15 05:51:44', '2026-09-15 05:51:44', 1, 'curl/8.19.0'),
(1040, '::1', 'hadjd9tgapni9pber6vb9d7bbp', '2026-09-15 05:51:45', '2026-09-15 05:51:45', 1, 'curl/8.19.0'),
(1041, '::1', 'd8mcpmurdfverh1qnb6q2rvg3i', '2026-09-15 05:51:46', '2026-09-15 05:51:46', 1, 'curl/8.19.0'),
(1042, '::1', '1cnaa58boc59ro6qcu8s07lagh', '2026-09-15 05:51:46', '2026-09-15 05:51:46', 1, 'curl/8.19.0'),
(1043, '::1', '0q6hr2vo8rsaa09pg7ssu6iir1', '2026-09-15 05:51:47', '2026-09-15 05:51:47', 1, 'curl/8.19.0'),
(1044, '::1', 'fd8ss15bam7bgj3ve56mpfiaqm', '2026-09-15 05:51:48', '2026-09-15 05:51:48', 1, 'curl/8.19.0'),
(1045, '::1', 'fbfr7j330jbal7mbgkcrpnbsng', '2026-09-15 05:51:48', '2026-09-15 05:51:48', 1, 'curl/8.19.0'),
(1046, '::1', 'lae4o8cj67shglg1ukea1urtf3', '2026-09-15 05:51:49', '2026-09-15 05:51:49', 1, 'curl/8.19.0'),
(1047, '::1', '1efuf0n3gh9cnccljvsbhubb2v', '2026-09-15 05:52:00', '2026-09-15 05:52:00', 1, 'curl/8.19.0'),
(1048, '::1', '1htala61l1dbddls3hnh0jhr2d', '2026-09-15 05:52:01', '2026-09-15 05:52:01', 1, 'curl/8.19.0'),
(1049, '::1', 'cdsj18rc88lgttp8ke3rg9v7ac', '2026-09-15 05:52:01', '2026-09-15 05:52:01', 1, 'curl/8.19.0'),
(1050, '::1', 'bmu5san1c283486po2d5gn69ka', '2026-09-15 05:52:01', '2026-09-15 05:52:01', 1, 'curl/8.19.0'),
(1051, '::1', 'cs9gia7tdl0tgshftjeojsnjio', '2026-09-15 05:52:02', '2026-09-15 05:52:02', 1, 'curl/8.19.0'),
(1052, '::1', '49ir6k2v5a1v3itir8c9t15eh7', '2026-09-15 05:52:02', '2026-09-15 05:52:02', 1, 'curl/8.19.0'),
(1053, '::1', 'u4jjiudtpkuuvo1oo4jqg067ek', '2026-09-15 05:52:03', '2026-09-15 05:52:03', 1, 'curl/8.19.0'),
(1054, '::1', 'lnlgis9j83bqo7arpv0mrlkrea', '2026-09-15 05:52:04', '2026-09-15 05:52:04', 1, 'curl/8.19.0'),
(1055, '::1', 'h0pbev80hj08tpamejcm59pt57', '2026-09-15 05:52:04', '2026-09-15 05:52:04', 1, 'curl/8.19.0'),
(1056, '::1', '8rfcrv846ig69d5u8586i6ri7g', '2026-09-15 05:52:04', '2026-09-15 05:52:04', 1, 'curl/8.19.0'),
(1057, '::1', 'kj9rsde37amgatig6e35d5cnno', '2026-09-15 05:52:05', '2026-09-15 05:52:05', 1, 'curl/8.19.0'),
(1058, '::1', '5ivid2g74q4pdtijiqvfpe7513', '2026-09-15 05:52:05', '2026-09-15 05:52:05', 1, 'curl/8.19.0'),
(1059, '::1', 'bgc0pp2umm0jcgamk4khdrf173', '2026-09-15 05:52:06', '2026-09-15 05:52:06', 1, 'curl/8.19.0'),
(1060, '::1', 'qj1n0fqe6s9ps1t4ohtv7lkr83', '2026-09-15 05:52:06', '2026-09-15 05:52:06', 1, 'curl/8.19.0'),
(1061, '::1', 'fq61iqpoiatm635k6db529fcc8', '2026-09-15 05:52:06', '2026-09-15 05:52:06', 1, 'curl/8.19.0'),
(1062, '::1', 'qpsgbqpe5clrri01ml0ahguhr4', '2026-09-15 05:52:07', '2026-09-15 05:52:07', 1, 'curl/8.19.0'),
(1063, '::1', 'kb5pj6ua972m7kbqsitqo7t19a', '2026-09-15 05:52:07', '2026-09-15 05:52:07', 1, 'curl/8.19.0'),
(1064, '::1', 'i6svq465ci5jidvukhbo61n4ae', '2026-09-15 05:52:07', '2026-09-15 05:52:07', 1, 'curl/8.19.0'),
(1065, '::1', 'j5p5cfo0u9l1piebel81n54cls', '2026-09-15 05:52:08', '2026-09-15 05:52:08', 1, 'curl/8.19.0'),
(1066, '::1', '29fpv1p1925dhnbm91m6hr7eul', '2026-09-15 05:52:08', '2026-09-15 05:52:08', 1, 'curl/8.19.0'),
(1067, '::1', '8r1r8a2tgk31dbi5prm10bca9t', '2026-09-15 05:52:08', '2026-09-15 05:52:08', 1, 'curl/8.19.0'),
(1068, '::1', '7tv3g0slftdpug0dnnd4gueppg', '2026-09-15 05:52:09', '2026-09-15 05:52:09', 1, 'curl/8.19.0'),
(1069, '::1', 'jn38spj69rq0jspqqpfoigd85k', '2026-09-15 05:52:09', '2026-09-15 05:52:09', 1, 'curl/8.19.0'),
(1070, '::1', '8mk2m0g8sj1bcn6bpjg6rtvbtb', '2026-09-15 05:52:09', '2026-09-15 05:52:09', 1, 'curl/8.19.0'),
(1071, '::1', 'ipce85ilo9b32tjeghfke286e2', '2026-09-15 05:52:10', '2026-09-15 05:52:10', 1, 'curl/8.19.0'),
(1072, '::1', 'dhtvn5d6h18p74t9gc8vubbot8', '2026-09-15 05:52:10', '2026-09-15 05:52:10', 1, 'curl/8.19.0'),
(1073, '::1', 'usruhrf7n0sa67sq8pufjgvhk1', '2026-09-15 05:52:11', '2026-09-15 05:52:11', 1, 'curl/8.19.0'),
(1074, '::1', 'ea7gpiucob4rsfb5a9qv45vko3', '2026-09-15 05:52:11', '2026-09-15 05:52:11', 1, 'curl/8.19.0'),
(1075, '::1', '3t63o6d899eq6u84m4r5jg3qoe', '2026-09-15 05:52:22', '2026-09-15 05:52:22', 1, 'curl/8.19.0'),
(1076, '::1', 'spjd52ds6jeoc8ea3sm4tc09th', '2026-09-15 05:52:22', '2026-09-15 05:52:22', 1, 'curl/8.19.0'),
(1077, '::1', 't1hbe8aomtj1f7n6hfcipqkdh0', '2026-09-15 05:52:23', '2026-09-15 05:52:23', 1, 'curl/8.19.0'),
(1078, '::1', 'up8fj67dje0v9q1ft0rtu5oad7', '2026-09-15 05:52:23', '2026-09-15 05:52:23', 1, 'curl/8.19.0'),
(1079, '::1', '7mcl9sr1o65lfa3ru383mfj368', '2026-09-15 05:52:24', '2026-09-15 05:52:24', 1, 'curl/8.19.0'),
(1080, '::1', 'lf54a7d2fr387975a8elf4ffor', '2026-09-15 05:52:24', '2026-09-15 05:52:24', 1, 'curl/8.19.0'),
(1081, '::1', 'mnjmn3pu68s7qphiapq6qd5vvl', '2026-09-15 05:52:25', '2026-09-15 05:52:25', 1, 'curl/8.19.0'),
(1082, '::1', '3bk5gfkkuar3u75vlu9g4p4bud', '2026-09-15 05:52:26', '2026-09-15 05:52:26', 1, 'curl/8.19.0'),
(1083, '::1', '18hpe3al9oe0k3rge2lbpb6i5i', '2026-09-15 05:52:26', '2026-09-15 05:52:26', 1, 'curl/8.19.0'),
(1084, '::1', 'scd097l6fs3651p0hs3pi7vtem', '2026-09-15 05:52:27', '2026-09-15 05:52:27', 1, 'curl/8.19.0'),
(1085, '::1', '02b9v1h7ruulmbbqg129an4rps', '2026-09-15 05:52:27', '2026-09-15 05:52:27', 1, 'curl/8.19.0'),
(1086, '::1', 'mn2spvo3dor28e3eaak2cfu5c8', '2026-09-15 05:52:28', '2026-09-15 05:52:28', 1, 'curl/8.19.0'),
(1087, '::1', 'lem9qacghjtcfm5pvdd3mktntb', '2026-09-15 05:52:29', '2026-09-15 05:52:29', 1, 'curl/8.19.0'),
(1088, '::1', '5d09v106ccvquqthibojefoqpj', '2026-09-15 05:52:30', '2026-09-15 05:52:30', 1, 'curl/8.19.0'),
(1089, '::1', 'a63qplkun7ca7t0oac3md81uuc', '2026-09-15 05:52:30', '2026-09-15 05:52:30', 1, 'curl/8.19.0'),
(1090, '::1', 'qml62grqb9r2b21r259j12vmjf', '2026-09-15 05:52:31', '2026-09-15 05:52:31', 1, 'curl/8.19.0'),
(1091, '::1', 'augcildpturcm3ur5c7q207alg', '2026-09-15 05:52:31', '2026-09-15 05:52:31', 1, 'curl/8.19.0'),
(1092, '::1', '9csrfnm7nkomofq95p22772oe5', '2026-09-15 05:52:32', '2026-09-15 05:52:32', 1, 'curl/8.19.0'),
(1093, '::1', 's0eima7i0pd3ors70q0ii70sq6', '2026-09-15 05:52:32', '2026-09-15 05:52:32', 1, 'curl/8.19.0'),
(1094, '::1', '6qlg34hrrro1ef3i1joeo3gkft', '2026-09-15 05:52:33', '2026-09-15 05:52:33', 1, 'curl/8.19.0'),
(1095, '::1', 'rsife0cu2igusalktkelevlrog', '2026-09-15 05:52:34', '2026-09-15 05:52:34', 1, 'curl/8.19.0'),
(1096, '::1', 'adfi71bq81dendr4lf13h9lcir', '2026-09-15 05:52:34', '2026-09-15 05:52:34', 1, 'curl/8.19.0'),
(1097, '::1', 'vgcsromke4rn0idoge5hftfpcv', '2026-09-15 05:52:35', '2026-09-15 05:52:35', 1, 'curl/8.19.0'),
(1098, '::1', 'bqo7o5v1nj55u4licd2he0e8t3', '2026-09-15 05:52:35', '2026-09-15 05:52:35', 1, 'curl/8.19.0'),
(1101, '::1', 'fm0nm0td1n4cfj7pkn922uf24o', '2026-09-15 05:53:53', '2026-09-15 05:53:53', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1102, '::1', '1uul5rsk3d2bi83gcjv2tivqkq', '2026-09-15 05:54:03', '2026-09-15 05:54:03', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1104, '::1', '46r3re1dmct4fieu29i04d66qa', '2026-09-15 05:54:11', '2026-09-15 05:54:11', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1105, '::1', 'lrqqgtci5jc98ar2f5rhebld2i', '2026-09-15 05:54:16', '2026-09-15 05:54:16', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1107, '::1', '84ja3vh11gpssugg0rail39v7a', '2026-09-15 05:54:20', '2026-09-15 05:54:20', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1108, '::1', 'gk3ah891li7pqsnmbivnnahi21', '2026-09-15 05:54:23', '2026-09-15 05:54:23', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1110, '::1', 'opegtnngng6alv7ar9gvns54tk', '2026-09-15 05:54:26', '2026-09-15 05:54:26', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1111, '::1', 'bhb1bfo66q5fdiafl4aboqu2p9', '2026-09-15 05:54:30', '2026-09-15 05:54:30', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1112, '::1', 'kajoh6l0s9pjncqeg6d50b8bde', '2026-09-15 05:54:33', '2026-09-15 05:54:33', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1114, '::1', '21u6unvl8h8s83ph2jt6m96260', '2026-09-15 05:54:44', '2026-09-15 05:54:44', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1115, '::1', '6bq60uv24k312p1pobb7ktjf7d', '2026-09-15 05:54:48', '2026-09-15 05:54:48', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1116, '::1', 'fnk6o694jq8dogrk4so1hma5m1', '2026-09-15 05:55:08', '2026-09-15 05:55:08', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1117, '::1', 'gd6tpmgchbdupmla73drf6qjv0', '2026-09-15 05:55:22', '2026-09-15 05:55:22', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1118, '::1', 'cc4690o8c90if300fv12sd5o8b', '2026-09-15 05:55:30', '2026-09-15 05:55:30', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1119, '::1', 'cpu8vgj9koe40hnnpnbakpn7bf', '2026-09-15 05:55:40', '2026-09-15 05:55:40', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1120, '::1', 'kshqpk80t7f9817vm76hpshqq2', '2026-09-15 05:56:03', '2026-09-15 05:56:03', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1121, '::1', 'bjcd3as9pi2mdit2k2a3rq4co8', '2026-09-15 05:56:24', '2026-09-15 05:56:24', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1122, '::1', 'o0srn1dbrtivvjdnsvel1nu2tm', '2026-09-15 05:56:44', '2026-09-15 05:56:44', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1123, '::1', 'e6qvhrvflnvsgqlsn9l0behmga', '2026-09-15 05:56:53', '2026-09-15 05:57:15', 3, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1124, '::1', 'lll1hqrqsc4olsdbiq35mm7l25', '2026-09-15 05:56:54', '2026-09-15 05:56:54', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1126, '::1', 'ouee1vb8073mi30p81skljbhrc', '2026-09-15 05:56:58', '2026-09-15 05:56:58', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1127, '::1', 'mdsk0ge5fq9dg0ogfmddc7i3ok', '2026-09-15 05:57:06', '2026-09-15 05:57:06', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1129, '::1', 'g4m0afsi63de3ld5ulk8kp78pk', '2026-09-15 05:57:16', '2026-09-15 05:57:16', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1130, '::1', 'm67dqlbfr00j210fut5nrmliin', '2026-09-15 05:57:25', '2026-09-15 05:57:25', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1131, '::1', '875gfpeurmvph976qmdmeot1ml', '2026-09-15 05:57:35', '2026-09-15 05:57:35', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1132, '::1', 'b0u2u8bhm3gg1fbuod4nrbfdu1', '2026-09-15 05:57:38', '2026-09-15 05:57:38', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1133, '::1', 'tt9m7f550sm3pdd2j0nmb8g0h5', '2026-09-15 05:57:44', '2026-09-15 05:57:44', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1134, '::1', 'in35bdco3o5n7o411nj4l8hirl', '2026-09-15 05:57:50', '2026-09-15 05:57:50', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1135, '::1', '4vd19ospsgbs6b5btsq72glg46', '2026-09-15 05:57:59', '2026-09-15 05:57:59', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1136, '::1', 'h3p59nobaq8tcvmeuppf1gqq82', '2026-09-15 05:58:30', '2026-09-15 05:58:30', 1, 'curl/8.19.0'),
(1137, '::1', 'ampeifa2pvum3v0afutc6jk6ji', '2026-09-15 05:59:04', '2026-09-15 05:59:04', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1138, '::1', 'aa5im6l9iu02qdmbqu6qmk6o3n', '2026-09-15 05:59:20', '2026-09-15 05:59:20', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1139, '::1', 'h3patsnb1887feuqd9r0q6hc49', '2026-09-15 05:59:30', '2026-09-15 05:59:30', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1140, '::1', 'f4klvf6ko2koc1p5rloa4v3nbc', '2026-09-15 05:59:43', '2026-09-15 05:59:43', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1141, '::1', 'e0c31k0l94gnlvn0o5u9uclp64', '2026-09-15 06:00:03', '2026-09-15 06:00:03', 1, 'curl/8.19.0'),
(1142, '::1', 'aejp3018dl78miimedsi1vm3tj', '2026-09-15 06:00:38', '2026-09-15 06:00:38', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1143, '::1', 'qjtid9uqvoukhkei9nar9g3ugo', '2026-09-15 06:00:45', '2026-09-15 06:00:45', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1144, '::1', 'f6o4499ds2h1u41ko5j3cgt9tg', '2026-09-15 06:00:51', '2026-09-15 06:00:51', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1145, '::1', 'al080qrane4c8i8bogn2sbdpo4', '2026-09-15 06:01:35', '2026-09-15 06:01:35', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1146, '::1', 'helgqcj4ul2p69354b3kpbanic', '2026-09-15 06:05:54', '2026-09-15 06:05:54', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1147, '::1', 'h5391pe4bgfc8igm2e16bo5dsu', '2026-09-15 06:06:03', '2026-09-15 06:06:03', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1148, '::1', 'ka6ulf5shdh866bvr88g96a0sl', '2026-09-15 06:06:10', '2026-09-15 06:06:10', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1150, '::1', 'be3bc80d03ojdop1i8na90e1j6', '2026-09-15 06:07:36', '2026-09-15 06:07:36', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1151, '::1', '6vdjj8g69c6ish58k1c8fv14k9', '2026-09-15 06:10:12', '2026-09-15 06:10:12', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1152, '::1', '87nthfdh95aqcah0017p3644r2', '2026-09-15 06:10:21', '2026-09-15 06:10:21', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1153, '::1', '5p6euus9s4l2k4pefutag9pva5', '2026-09-15 06:10:26', '2026-09-15 06:10:26', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1154, '::1', '8g8i8p5gc6433q13cuudd33i4u', '2026-09-15 06:10:32', '2026-09-15 06:10:32', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1155, '::1', '0oa12s9cqnqmvkdvlbjvt8k3lr', '2026-09-15 06:10:56', '2026-09-15 06:10:56', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1156, '::1', 'o57atqdl2ugmh6mjnn7tav7hu8', '2026-09-15 06:11:05', '2026-09-15 06:11:05', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1157, '::1', '1ob7e0sbsdjvhrh6lik0ijrrjl', '2026-09-15 06:11:10', '2026-09-15 06:11:10', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1158, '::1', 'tiomc5ng7qt96tgb38rqoij5g7', '2026-09-15 06:11:13', '2026-09-15 06:11:13', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1159, '::1', '20nuo93r2grt5ab2htk4a3sa2k', '2026-09-15 06:11:21', '2026-09-15 06:11:21', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1160, '::1', '0616rfvsvamk010e1pubnabs1t', '2026-09-15 06:11:26', '2026-09-15 06:11:26', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1161, '::1', 'jdkplnttikggod3carh4pga3uc', '2026-09-15 06:11:29', '2026-09-15 06:11:29', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1162, '::1', 'p7vklvltk8gqp2pbiuqkqqbsdl', '2026-09-15 06:11:33', '2026-09-15 06:11:33', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1163, '::1', 'a0t0h1q6e0jtp71681j96jvtjm', '2026-09-15 06:11:39', '2026-09-15 06:11:39', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1164, '::1', '1a37nqfsc14kfqjqndlq20rhgm', '2026-09-15 06:11:43', '2026-09-15 06:11:43', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1165, '::1', 'u5v1hos772fpv6bleb7ic24tqt', '2026-09-15 06:11:51', '2026-09-15 06:11:51', 1, 'curl/8.19.0'),
(1166, '::1', 'ckil2658hs5si3hka7sb3kfu6i', '2026-09-15 06:11:52', '2026-09-15 06:11:52', 1, 'curl/8.19.0'),
(1167, '::1', '0bqfktk7r1fodi2mjlbur6daso', '2026-09-15 06:11:53', '2026-09-15 06:11:53', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1168, '::1', 'kc7tvfet4bid6fl7njo6ki9fnu', '2026-09-15 06:11:54', '2026-09-15 06:11:54', 1, 'curl/8.19.0'),
(1169, '::1', '7vm2fh67eno7epntq4j2h2opl6', '2026-09-15 06:11:54', '2026-09-15 06:11:54', 1, 'curl/8.19.0'),
(1170, '::1', '02k2locb4558kefca9vsi3u2d6', '2026-09-15 06:11:56', '2026-09-15 06:11:56', 1, 'curl/8.19.0'),
(1171, '::1', '7esabhr78ofht763ij3abdrqur', '2026-09-15 06:11:56', '2026-09-15 06:11:56', 1, 'curl/8.19.0'),
(1172, '::1', '1akgh46flvj8hf8uf045apvuqk', '2026-09-15 06:12:01', '2026-09-15 06:12:01', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1173, '::1', 'r4sjdp0c8cud803q9c3cm2ihnp', '2026-09-15 06:12:06', '2026-09-15 06:12:06', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1174, '::1', '8upummt61mmlamq8rce1943bfk', '2026-09-15 06:12:14', '2026-09-15 06:12:14', 1, 'curl/8.19.0'),
(1175, '::1', 'msh5f35e4d5mbd5aseo8nvacqn', '2026-09-15 06:12:19', '2026-09-15 06:12:19', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1176, '::1', 'h0rt7qiuq0d79piic3egddshn4', '2026-09-15 06:12:25', '2026-09-15 06:12:25', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1177, '::1', '6258g5k10sh4ov8dtpkig37cf7', '2026-09-15 06:12:32', '2026-09-15 06:12:32', 1, 'curl/8.19.0'),
(1178, '::1', 'guvp6cd89ddskq3tocjoni9a3g', '2026-09-15 06:12:33', '2026-09-15 06:12:33', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1179, '::1', 'cdbe5rqvubi59befh7egvn5is7', '2026-09-15 06:12:50', '2026-09-15 06:12:50', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1182, '::1', 'lft3c3is8ekcnjrt8bgch6jaen', '2026-09-15 06:19:24', '2026-09-15 06:19:24', 1, 'curl/8.19.0'),
(1183, '::1', 'n5jhat43unf8pu3i327vqpgbsg', '2026-09-15 06:21:26', '2026-09-15 06:21:26', 1, 'curl/8.19.0'),
(1184, '::1', 'hm8sphfb3lf157gpor6ukhq46j', '2026-09-15 06:21:28', '2026-09-15 06:21:28', 1, 'curl/8.19.0'),
(1185, '::1', 'upisf9ulf96pbitauel3id5vod', '2026-09-15 06:21:30', '2026-09-15 06:21:30', 1, 'curl/8.19.0'),
(1186, '::1', '50f70s1naj15tb94qiap9i5v8v', '2026-09-15 06:21:31', '2026-09-15 06:21:31', 1, 'curl/8.19.0'),
(1187, '::1', '7d9ebvdrtb7rsfgtc8em4u4695', '2026-09-15 06:21:32', '2026-09-15 06:21:32', 1, 'curl/8.19.0'),
(1188, '::1', '36t548m95bkflgktm05dv9eo70', '2026-09-15 06:22:37', '2026-09-15 06:22:48', 2, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1190, '::1', 'mf7mlq845qjdjr9sqooe7msmkj', '2026-09-15 06:23:13', '2026-09-15 06:23:13', 1, 'curl/8.19.0'),
(1191, '::1', '813jfmbjcqgi2lf27ptruldedv', '2026-09-15 06:23:14', '2026-09-15 06:23:14', 1, 'curl/8.19.0'),
(1192, '::1', 'ueupnmmv0pjadasdpomrnhas3r', '2026-09-15 06:23:14', '2026-09-15 06:23:14', 1, 'curl/8.19.0'),
(1193, '::1', 'lphpvtskae3vhup5leeerenkdo', '2026-09-15 06:23:15', '2026-09-15 06:23:15', 1, 'curl/8.19.0'),
(1194, '::1', '6j4akn78uglcig0h687m8vl46h', '2026-09-15 06:23:15', '2026-09-15 06:23:15', 1, 'curl/8.19.0'),
(1195, '::1', '3atomltdfnp5ai5ao7ru0u1qu5', '2026-09-15 06:23:16', '2026-09-15 06:23:16', 1, 'curl/8.19.0'),
(1196, '::1', 'dajqqkb7h8o2saqk8marrfo3j9', '2026-09-15 06:23:16', '2026-09-15 06:23:16', 1, 'curl/8.19.0'),
(1197, '::1', 'jjhpn8iq3a3uaanj6dcsjp3skh', '2026-09-15 06:23:17', '2026-09-15 06:23:17', 1, 'curl/8.19.0'),
(1198, '::1', 'gucb6r5ed7glfc0eoead7fl021', '2026-09-15 06:23:17', '2026-09-15 06:23:17', 1, 'curl/8.19.0'),
(1199, '::1', 'eb1gqmbqucr76675c881ilh8rj', '2026-09-15 06:23:18', '2026-09-15 06:23:18', 1, 'curl/8.19.0'),
(1200, '::1', 'feivh3njuu8ac00q6l9btg7t6v', '2026-09-15 06:23:18', '2026-09-15 06:23:18', 1, 'curl/8.19.0'),
(1201, '::1', 'vndvatqeb111onakba3el4n55f', '2026-09-15 06:23:19', '2026-09-15 06:23:19', 1, 'curl/8.19.0'),
(1202, '::1', 'idbt50hrl2a1q8gv53kuos2bm9', '2026-09-15 06:23:19', '2026-09-15 06:23:19', 1, 'curl/8.19.0'),
(1203, '::1', 't7fss0jcmgt5bgn1rsdohchktp', '2026-09-15 06:23:20', '2026-09-15 06:23:20', 1, 'curl/8.19.0'),
(1204, '::1', '9v091lmg4s4hdbshnm8bcheogu', '2026-09-15 06:23:21', '2026-09-15 06:23:21', 1, 'curl/8.19.0'),
(1205, '::1', 'g589vi4c3lvnd64am7548bv10r', '2026-09-15 06:23:22', '2026-09-15 06:23:22', 1, 'curl/8.19.0'),
(1206, '::1', 'pidc97001hqgb9o9afha1fd5ie', '2026-09-15 06:23:23', '2026-09-15 06:23:23', 1, 'curl/8.19.0'),
(1207, '::1', 'ijpsljp0jutlgsga1anjhjeq3g', '2026-09-15 06:23:24', '2026-09-15 06:23:24', 1, 'curl/8.19.0'),
(1208, '::1', '1lsusrtlgthq978gaghsn57e89', '2026-09-15 06:23:25', '2026-09-15 06:23:25', 1, 'curl/8.19.0'),
(1209, '::1', 'gkkvs3qo8oqlp2cosrlo4if67e', '2026-09-15 06:23:25', '2026-09-15 06:23:25', 1, 'curl/8.19.0'),
(1210, '::1', 'pulo8i71js9a5c7mtsdob24sjl', '2026-09-15 06:23:26', '2026-09-15 06:23:26', 1, 'curl/8.19.0'),
(1211, '::1', '5doqgmeli41oad3m0bmnkv4n0j', '2026-09-15 06:23:26', '2026-09-15 06:23:26', 1, 'curl/8.19.0'),
(1212, '::1', '4soqp7fk77l4erthq0g88pspli', '2026-09-15 06:23:27', '2026-09-15 06:23:27', 1, 'curl/8.19.0'),
(1213, '::1', '3an7gnms1k13vh5kgc5nbtc692', '2026-09-15 06:23:27', '2026-09-15 06:23:27', 1, 'curl/8.19.0'),
(1214, '::1', 'qm2gvimuihlsabl9qbb0daqbe3', '2026-09-15 06:23:28', '2026-09-15 06:23:28', 1, 'curl/8.19.0'),
(1215, '::1', '22rg5rjgigs84qbj55sgi3dga0', '2026-09-15 06:23:28', '2026-09-15 06:23:28', 1, 'curl/8.19.0'),
(1216, '::1', 'p9q3ncu3p7uv24kuv57ekr4keq', '2026-09-15 06:23:29', '2026-09-15 06:23:29', 1, 'curl/8.19.0'),
(1217, '::1', 'jsod9d07bh2meclj0jukebugv6', '2026-09-15 06:23:29', '2026-09-15 06:23:29', 1, 'curl/8.19.0'),
(1218, '::1', 'ng4pfacs3aq7vph82u53arje57', '2026-09-15 06:23:30', '2026-09-15 06:23:30', 1, 'curl/8.19.0'),
(1235, '::1', 'bqjar5g56q4g591fln55k2s6p9', '2026-09-15 09:14:44', '2026-09-15 09:14:44', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1236, '::1', '9ibt1o9rf3r81trhnnhq1ml88k', '2026-09-15 09:14:55', '2026-09-15 09:14:55', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1237, '::1', 'npc4nt07gkl2vos1vdv674t54b', '2026-09-15 09:15:12', '2026-09-15 09:15:12', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1238, '::1', 'u87nm4cb8k06uv3teqtpvgg0qv', '2026-09-15 09:17:14', '2026-09-15 09:17:14', 1, 'curl/8.19.0'),
(1239, '::1', 'a4eir489bmvh4s65gd72jjf14b', '2026-09-15 09:17:27', '2026-09-15 09:17:27', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1241, '::1', 'isllogph628k8ah806spapk500', '2026-09-15 09:17:36', '2026-09-15 09:17:36', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1242, '::1', 'qvfr8ev4v492i0ek3nt013k766', '2026-09-15 09:17:48', '2026-09-15 09:17:48', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1243, '::1', 'hqv7k3r8ush7t9opq43hrvrfk7', '2026-09-15 09:18:27', '2026-09-15 09:18:27', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1245, '::1', 'e3fpdl5gi0i3k7afl41jm2vs5t', '2026-09-15 09:20:38', '2026-09-15 09:20:38', 1, 'curl/8.19.0'),
(1246, '::1', 'rmhq6qpsmnh6k5om0vnmmate2e', '2026-09-15 09:20:40', '2026-09-15 09:20:40', 1, 'curl/8.19.0'),
(1247, '::1', 'nbmkn2pigbimg7auo5qv6sa6ho', '2026-09-15 09:20:59', '2026-09-15 09:20:59', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1251, '::1', '1mcbrgf65cvojliubrmmm5qcrv', '2026-09-15 09:34:37', '2026-09-15 09:34:37', 1, 'curl/8.19.0'),
(1252, '::1', 'bc5cdd0roc68ci3um63n7irhgp', '2026-09-15 09:34:38', '2026-09-15 09:34:38', 1, 'curl/8.19.0'),
(1253, '::1', 'l0m0kbhvpvav0h7d0hhsp9ecqd', '2026-09-15 10:19:53', '2026-09-15 10:19:53', 1, 'curl/8.19.0'),
(1256, '::1', 'dsg8ji3v51ufb5ehgs3269bv6q', '2026-09-16 07:19:25', '2026-09-16 07:19:25', 1, 'curl/8.19.0');
INSERT INTO `unique_visitors` (`id`, `visitor_ip`, `session_id`, `first_visit`, `last_visit`, `total_visits`, `user_agent`) VALUES
(1261, '::1', 'ltlmrthrt71k0a4ma3mhbiio49', '2026-09-16 07:50:28', '2026-09-16 07:50:28', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1263, '::1', 'cnmem2ehkgg3h73ubnm7dgmbp2', '2026-09-16 08:16:17', '2026-09-16 08:16:27', 2, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1271, '::1', 'glvo8bs1o97djptnau3s1eul55', '2026-09-16 08:48:52', '2026-09-16 08:48:52', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1272, '::1', 'liuuj7dr22u9ojch5j87ljp2e4', '2026-09-16 08:50:56', '2026-09-16 08:50:56', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1279, '::1', 'govde5ngcu303pkvnh2sp2pj61', '2026-09-16 09:05:20', '2026-09-16 09:05:20', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1282, '::1', 'p6mnqulbnjcph09ghauo7ak1m9', '2026-09-16 09:22:53', '2026-09-16 09:22:53', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1284, '::1', 'fuamral9eu34ouc6bgirp4nisu', '2026-09-16 09:24:47', '2026-09-16 09:24:47', 1, 'curl/8.19.0'),
(1285, '::1', 'dkqe0cf5rsed7a2ff3qtee88kl', '2026-09-16 09:26:08', '2026-09-16 09:26:08', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36'),
(1286, '::1', 'ihjk3si0lq2m0a0aq4r6gni0qr', '2026-09-16 09:28:27', '2026-09-16 10:05:26', 11, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36 Edg/153.0.0.0'),
(1294, '::1', 'a543dq3eoa61u1cksqkkgiltju', '2026-09-16 09:43:39', '2026-09-16 09:43:39', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36'),
(1295, '::1', '7em8k2601r1l7cl6qrrb33qhc5', '2026-09-16 09:44:39', '2026-09-16 09:44:39', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1296, '::1', '688h0ui10atto936mlhea6vii2', '2026-09-16 09:45:58', '2026-09-17 09:30:25', 8, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36'),
(1307, '::1', '97r2e2chv4cuvp0ibqhknj1up0', '2026-09-16 09:54:29', '2026-09-16 09:54:47', 2, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1310, '::1', '1ups4cmjv84nbgurvhetnrrf2q', '2026-09-16 09:56:39', '2026-09-16 09:56:39', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1322, '::1', 'fr2utu986i74hslt84f20ol4h2', '2026-09-16 10:14:00', '2026-09-16 10:14:00', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1323, '::1', 'beihu258f6nrjtntk9st4srdp8', '2026-09-16 10:14:10', '2026-09-16 10:14:10', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1324, '::1', '44mg7jf85df5e14eb7lq00sufj', '2026-09-16 10:14:20', '2026-09-16 10:14:20', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1325, '::1', 't9gifmn60v3s1n55r8d1mm4383', '2026-09-16 10:14:24', '2026-09-16 10:14:24', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1326, '::1', 'i4nv6jm6a1qbkq19icvgdcus77', '2026-09-16 10:14:29', '2026-09-16 10:14:29', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1327, '::1', 'l1nl96nr853sjrt26mb2i5ofmo', '2026-09-16 10:14:33', '2026-09-16 10:14:33', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1328, '::1', 'coau71t1uk366h5i3bhn26muab', '2026-09-16 10:14:43', '2026-09-16 10:14:43', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1329, '::1', '689itk6juop37fc763ruts8tnb', '2026-09-16 10:14:47', '2026-09-16 10:14:47', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1330, '::1', 'fvgib04a19chcuh6scju52hq8o', '2026-09-16 10:14:54', '2026-09-16 10:14:54', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1331, '::1', 'otttd7lhdodb6d4jh6ptcjk4ba', '2026-09-16 10:14:57', '2026-09-16 10:14:57', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1332, '::1', '35osj8vua6g6dmbpnfki5u4o7m', '2026-09-16 10:15:03', '2026-09-16 10:15:03', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1333, '::1', 'mvjddflji3it9tmo3rkllgca10', '2026-09-16 10:15:12', '2026-09-16 10:15:12', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1334, '::1', 'ej9u21iciai2mqd9eojo8lk4t9', '2026-09-16 10:16:04', '2026-09-16 10:16:04', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1335, '::1', '24qjv99u1oecilag68eq2aet8m', '2026-09-16 10:16:55', '2026-09-16 10:16:55', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1336, '::1', 'bck6liq5rmckjqt02tlf01kg2i', '2026-09-16 10:18:59', '2026-09-16 10:18:59', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1337, '::1', 'dah0c12khlthjnsjee384vg9ni', '2026-09-16 10:19:04', '2026-09-16 10:19:04', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1338, '::1', '3moargt2l71iq1jecuc2gvjs0a', '2026-09-16 10:19:45', '2026-09-16 10:19:45', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1339, '::1', 'qi76h579hi3gmqadphetng7f5a', '2026-09-16 10:19:54', '2026-09-16 10:19:54', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1340, '::1', 'ngtd886inn8lkt888uuj4aj4os', '2026-09-16 10:20:01', '2026-09-16 10:20:01', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1341, '::1', 'qjegqrhp98cvst056j3tpg30p4', '2026-09-16 10:20:08', '2026-09-16 10:20:08', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1342, '::1', 'hbeilek0r2r19u329gdpt9etfg', '2026-09-16 10:20:37', '2026-09-16 10:20:37', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1343, '::1', '2c86p5quigp32cjfshlmmbf039', '2026-09-16 10:20:45', '2026-09-16 10:20:45', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1344, '::1', 'ujm5kf7jt2ue72jdr5ur3menp7', '2026-09-16 10:21:10', '2026-09-16 10:21:10', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1345, '::1', 'mbermrie8l7bdthi5nmavqte70', '2026-09-16 10:21:14', '2026-09-16 10:21:14', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1346, '::1', 'qjsl16hd1q35qu2uc4dkdbujd6', '2026-09-16 10:21:19', '2026-09-16 10:21:19', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1347, '::1', '43vmig524hqsp1fcbqgbaof094', '2026-09-16 10:21:32', '2026-09-16 10:21:32', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1348, '::1', 'gadho3rtsc9acpnffffkm4iqf8', '2026-09-16 10:23:25', '2026-09-16 10:23:25', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1349, '::1', 'f7rthr9otves1ksttmifdvh8tv', '2026-09-16 10:23:33', '2026-09-16 10:23:33', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1353, '::1', '8e7p62v8c6tug52gt3fofdc85l', '2026-09-16 10:52:46', '2026-09-16 10:52:46', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1354, '::1', '22o893abrf7rmagmj244512rka', '2026-09-16 10:52:53', '2026-09-16 10:52:53', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1355, '::1', 'ksbpmd806am01eqlo3ol6n7352', '2026-09-16 10:53:15', '2026-09-16 10:53:15', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1356, '::1', 'pc57gke27mu6smnjhgql53d28v', '2026-09-16 10:53:20', '2026-09-16 10:53:20', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1357, '::1', 'r6uvj0g1ufce1iifaemu0a6f6c', '2026-09-16 10:53:26', '2026-09-16 10:53:26', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1358, '::1', '2mshcv7bsth4064vpilcbo56jb', '2026-09-16 10:53:35', '2026-09-16 10:53:35', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1359, '::1', 'qu36callon0lduin9n90vmabdk', '2026-09-16 10:53:49', '2026-09-16 10:53:49', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1360, '::1', '6j35v9er1g43bg0heml258gd3e', '2026-09-16 10:57:19', '2026-09-16 10:57:19', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1361, '::1', 'lb7p6q1i7v8d411prqde3ccb72', '2026-09-16 10:57:26', '2026-09-16 10:57:26', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1362, '::1', 've7u96pvqkih4p47lpttcefarp', '2026-09-16 10:57:37', '2026-09-16 10:57:37', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1363, '::1', 'pq4j4mrv7pje8ilenfjulqurfp', '2026-09-16 10:57:51', '2026-09-16 10:57:51', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1364, '::1', 'mp1ssj2jmmjurrt2ros5tomppm', '2026-09-16 10:58:21', '2026-09-16 10:58:21', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1365, '::1', '7iqvcq06eq8j7h5gndnr8vstsv', '2026-09-16 10:58:25', '2026-09-16 10:58:25', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1366, '::1', '12h706mm4tr35tk41fqspi60qk', '2026-09-16 10:58:46', '2026-09-16 10:58:46', 1, 'curl/8.19.0'),
(1367, '::1', '80vm4ddh693kpg61nmrv021gjr', '2026-09-16 11:02:20', '2026-09-16 11:02:20', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1368, '::1', '49nkep5uui4uiv5o5fg837niif', '2026-09-16 11:02:26', '2026-09-16 11:02:26', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1369, '::1', 'g68sc3v5ksj6da3mv7hr4pvfel', '2026-09-16 11:02:30', '2026-09-16 11:02:30', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1370, '::1', 'phl4opsb0biiqse930bp6bu4du', '2026-09-16 11:02:36', '2026-09-16 11:02:36', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1371, '::1', 'bkn32uv4f5c5b92jdn3asrhklo', '2026-09-16 11:02:45', '2026-09-16 11:02:45', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1372, '::1', 'l12derebc44msrd4hkir7tqqt0', '2026-09-16 11:02:55', '2026-09-16 11:02:55', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1373, '::1', 'd1vvqe0nlsk7nnudghr0d12amc', '2026-09-16 11:03:02', '2026-09-16 11:03:02', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1374, '::1', '40qjv5ooo9dj5e0qu4ud64u3q8', '2026-09-16 11:03:06', '2026-09-16 11:03:06', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1375, '::1', 'uk3ihoeldv3krad322i9brghft', '2026-09-16 11:03:12', '2026-09-16 11:03:12', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1376, '::1', 'ut46vj4s9mar6f60g57j6nt9bl', '2026-09-16 11:03:15', '2026-09-16 11:03:15', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1377, '::1', 'mrn0atuk41adt407t9igls2p54', '2026-09-16 11:03:19', '2026-09-16 11:03:19', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1378, '::1', '8n672lks2cri837v66p5q49d24', '2026-09-16 11:03:22', '2026-09-16 11:03:22', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1379, '::1', '1g5r2r1lbkcapgg256c3luf9ua', '2026-09-16 11:03:34', '2026-09-16 11:03:34', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1380, '::1', 'maouva04jcrvhktsnl8ch9mufk', '2026-09-16 11:03:45', '2026-09-16 11:03:45', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1381, '::1', '7nn6jhbclmgm91oj1kfomo5a7v', '2026-09-16 11:08:14', '2026-09-16 11:08:14', 1, 'curl/8.19.0'),
(1382, '::1', 'bri77hjnuf97vqvibr2resvppg', '2026-09-16 11:11:26', '2026-09-16 11:11:26', 1, 'curl/8.19.0'),
(1383, '::1', 'p4euvs6ltmuv1var54fbeok8cr', '2026-09-16 11:11:28', '2026-09-16 11:11:28', 1, 'curl/8.19.0'),
(1384, '::1', 'tek24ims3nonicl2aj29id791f', '2026-09-16 11:11:29', '2026-09-16 11:11:29', 1, 'curl/8.19.0'),
(1385, '::1', 'cvivmmlsnquodmoruh2n3h0ohm', '2026-09-16 11:11:32', '2026-09-16 11:11:32', 1, 'curl/8.19.0'),
(1386, '::1', '4vrq64dr332afuor3php3dkr18', '2026-09-16 11:11:33', '2026-09-16 11:11:33', 1, 'curl/8.19.0'),
(1387, '::1', 'nvi099fuf2o1q0gi3t90pb84is', '2026-09-16 11:11:34', '2026-09-16 11:11:34', 1, 'curl/8.19.0'),
(1388, '::1', 'v1e5pv2f72com1op5414j2h1u7', '2026-09-16 11:11:35', '2026-09-16 11:11:35', 1, 'curl/8.19.0'),
(1389, '::1', 'vpfmmejhjajd42d3vrq6hk5rlc', '2026-09-16 11:11:36', '2026-09-16 11:11:36', 1, 'curl/8.19.0'),
(1390, '::1', 'n010lpktmtutavqht7nrj56ld6', '2026-09-16 11:11:37', '2026-09-16 11:11:37', 1, 'curl/8.19.0'),
(1391, '::1', '49cgk7b3bh7juk2jh0r943pdmg', '2026-09-16 11:11:38', '2026-09-16 11:11:38', 1, 'curl/8.19.0'),
(1392, '::1', '33226j3h0lgn8darrhmt0c37fk', '2026-09-16 11:11:39', '2026-09-16 11:11:39', 1, 'curl/8.19.0'),
(1393, '::1', 'o8cek4t8o8a0gmde4l174reln5', '2026-09-16 11:11:40', '2026-09-16 11:11:40', 1, 'curl/8.19.0'),
(1394, '::1', 'tfr07sgqg5po6vhsr7kufe2o4o', '2026-09-16 11:11:41', '2026-09-16 11:11:41', 1, 'curl/8.19.0'),
(1395, '::1', '9a7ukcokuvhv63ti94o42g66h5', '2026-09-16 11:11:42', '2026-09-16 11:11:42', 1, 'curl/8.19.0'),
(1396, '::1', 'spndi9u975aaujc6l1krtk183j', '2026-09-16 11:11:42', '2026-09-16 11:11:42', 1, 'curl/8.19.0'),
(1397, '::1', 'anll3ail3t925nmunuactkqnv4', '2026-09-16 11:11:43', '2026-09-16 11:11:43', 1, 'curl/8.19.0'),
(1398, '::1', '6lbp6puq3sonfqfc2vt4n30cm9', '2026-09-16 11:11:44', '2026-09-16 11:11:44', 1, 'curl/8.19.0'),
(1399, '::1', 'pkqgiou7el1iph6hhcbhgb1h5v', '2026-09-16 11:11:45', '2026-09-16 11:11:45', 1, 'curl/8.19.0'),
(1400, '::1', 'ev8ju4ue10ie5f1atro2jdr3ht', '2026-09-16 11:11:46', '2026-09-16 11:11:46', 1, 'curl/8.19.0'),
(1401, '::1', 'qk6bakfiht04kbpgidofs2tncu', '2026-09-16 11:11:47', '2026-09-16 11:11:47', 1, 'curl/8.19.0'),
(1402, '::1', 'si4m8rem4lbukfeg5o1f6gk8gn', '2026-09-16 11:11:48', '2026-09-16 11:11:48', 1, 'curl/8.19.0'),
(1403, '::1', 'egl42a7c6fidrst7mh5rki1dkb', '2026-09-16 11:11:49', '2026-09-16 11:11:49', 1, 'curl/8.19.0'),
(1404, '::1', 'ijfjpajald0nhvhaljor5gsgqp', '2026-09-16 11:11:50', '2026-09-16 11:11:50', 1, 'curl/8.19.0'),
(1405, '::1', '83bpb80o0kqv5s0803p0tfm355', '2026-09-16 11:11:50', '2026-09-16 11:11:50', 1, 'curl/8.19.0'),
(1406, '::1', 'u552vtcmfljq7nl8c429l19bhd', '2026-09-16 11:11:51', '2026-09-16 11:11:51', 1, 'curl/8.19.0'),
(1407, '::1', 'n1vsn73tqqissgh4cmrdpsfqti', '2026-09-16 11:11:52', '2026-09-16 11:11:52', 1, 'curl/8.19.0'),
(1408, '::1', '5eghq9kbpu2vch17cifrgm57vr', '2026-09-16 11:12:50', '2026-09-16 11:15:10', 26, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1434, '::1', 'gcvnpp7lohejci75nbatuosfh2', '2026-09-16 11:15:17', '2026-09-16 11:15:48', 26, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1460, '::1', '7r5ulprl2829l8os1pjok2q599', '2026-09-16 11:15:50', '2026-09-16 11:16:17', 26, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1486, '::1', '7rhr1d0am15e0s6fn2nmtb5c06', '2026-09-16 11:16:18', '2026-09-16 11:16:55', 26, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1513, '::1', 'evvbibcqjf7aqu3ik2ni0g2jg0', '2026-09-16 11:18:57', '2026-09-16 11:18:57', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1514, '::1', '6hrf8dbfns57etqghoq77gm7ie', '2026-09-16 11:21:13', '2026-09-16 11:25:07', 26, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1541, '::1', '7b8fcgj0ue5o8bi3n57ps5solv', '2026-09-16 11:30:15', '2026-09-16 11:30:15', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1542, '::1', 'sv91ie0hfhn4vcngpaleibkmb3', '2026-09-16 11:31:04', '2026-09-16 11:31:04', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1543, '::1', 'p3md7262tl156gqka3lt7gto7m', '2026-09-16 11:35:30', '2026-09-16 11:35:39', 2, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1545, '::1', '89nirokgb643ff7hu504pn3vjt', '2026-09-16 11:36:08', '2026-09-16 11:36:08', 1, 'curl/8.19.0'),
(1546, '::1', 'pi5oijkoqjnv07er5i5k95tlo2', '2026-09-16 11:36:40', '2026-09-16 11:36:40', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1547, '::1', 'c39a5bmohblfaoip50qf1q3eb8', '2026-09-16 11:37:48', '2026-09-16 11:37:48', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1548, '::1', 'ffjl7mmn1cvacnd9j3hl3k9e5j', '2026-09-16 11:40:41', '2026-09-16 11:40:51', 2, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1550, '::1', 'jo482r0r7n238gle69k6m2pp8j', '2026-09-16 11:43:47', '2026-09-16 11:43:47', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1551, '::1', 'qha1l9j8q2mhjcnvstg53qiorn', '2026-09-16 14:47:01', '2026-09-16 14:47:01', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1552, '::1', 'nj4fie8emiblhoq58d86t5jl1u', '2026-09-16 14:50:15', '2026-09-16 14:50:15', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1553, '::1', '86unht2ok8eqnoj8d7t6gf5dmq', '2026-09-16 14:51:18', '2026-09-16 14:51:18', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1554, '::1', 'b2qd9uheiq3eqt35pf3603kf3t', '2026-09-16 14:52:07', '2026-09-16 14:52:07', 1, 'curl/8.19.0'),
(1555, '::1', 'rfqke3hh0j1rs4sggjfm8sgcma', '2026-09-16 14:52:45', '2026-09-16 14:52:45', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1556, '::1', 'ejivbdvjs05ccl3dtk3plchgtn', '2026-09-16 14:53:42', '2026-09-16 14:53:42', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1557, '::1', '2qitp1tclb7trsvvqkvs9c2afp', '2026-09-16 14:54:57', '2026-09-16 14:54:57', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1558, '::1', 'r0ss0ncj2o83stfdshtimmr3ip', '2026-09-16 14:58:38', '2026-09-16 14:58:44', 2, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1560, '::1', 'lho446oq5eadj3im744hd309q6', '2026-09-16 15:00:34', '2026-09-16 15:00:34', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1561, '::1', 'rnnhn77avh79ro2fdcpb85r4u8', '2026-09-17 04:11:06', '2026-09-17 04:12:16', 6, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1567, '::1', 'ho02knc0ujoae7l5msnj38urtp', '2026-09-17 04:54:06', '2026-09-17 04:54:06', 1, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456'),
(1568, '::1', '9104phmvt66cr99vto1jk19vjc', '2026-09-17 04:54:07', '2026-09-17 04:54:07', 1, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456'),
(1569, '::1', '4jebv4gk6mmqdndma93nloa1bi', '2026-09-17 04:54:07', '2026-09-17 04:54:07', 1, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456'),
(1570, '::1', '4m1rr3d9j4hli2g5797gbq8eem', '2026-09-17 05:00:57', '2026-09-17 05:00:57', 1, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456'),
(1571, '::1', 'sfi98fjadn802484udd3slv3al', '2026-09-17 05:00:59', '2026-09-17 05:00:59', 1, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456'),
(1572, '::1', 'mh2okudjjj8hdbovh17f7nujk9', '2026-09-17 05:00:59', '2026-09-17 05:00:59', 1, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456'),
(1573, '::1', 'cp1vbr5bb2263ivve5h13nlhh0', '2026-09-17 05:01:00', '2026-09-17 05:01:00', 1, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456'),
(1574, '::1', 'tcajiuin6it8mj4hurf6pq0lvi', '2026-09-17 05:01:00', '2026-09-17 05:01:00', 1, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456'),
(1575, '::1', '3b3tcunuf4dds2j2sbbf6dgv3i', '2026-09-17 05:01:00', '2026-09-17 05:01:00', 1, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456'),
(1576, '::1', 'h0lr4ris4hn4fvssjurn1e4ssj', '2026-09-17 05:01:01', '2026-09-17 05:01:01', 1, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456'),
(1577, '::1', '92tme9ftnl1hu5unlp00j6gqvg', '2026-09-17 05:01:03', '2026-09-17 05:01:03', 1, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456'),
(1578, '::1', 'beehu7bcitf592hhci854ah99r', '2026-09-17 05:01:04', '2026-09-17 05:01:04', 1, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456'),
(1579, '::1', 'dtfmtt4i7v654ag7c3urge99l2', '2026-09-17 05:01:04', '2026-09-17 05:01:04', 1, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456'),
(1580, '::1', 'p9pgbk45a85pk44gpinplc4i7i', '2026-09-17 05:01:05', '2026-09-17 05:01:05', 1, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456'),
(1581, '::1', 'j4taqg53mskqg9plvvom3e2qim', '2026-09-17 05:01:05', '2026-09-17 05:01:05', 1, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456'),
(1582, '::1', 'la5khlnh9ev7le689brv37pif5', '2026-09-17 05:01:06', '2026-09-17 05:01:06', 1, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456'),
(1583, '::1', '64scqhognblrbboeraradn158o', '2026-09-17 05:01:06', '2026-09-17 05:01:06', 1, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456'),
(1584, '::1', '3acht7j52upg0dtss04qjs9fi0', '2026-09-17 05:01:06', '2026-09-17 05:01:06', 1, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456'),
(1585, '::1', '0d5tknm8meliqu4o79n0o0e6ph', '2026-09-17 05:01:07', '2026-09-17 05:01:07', 1, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456'),
(1586, '::1', '8b82652u34gcbiqssjo35njvlm', '2026-09-17 05:01:41', '2026-09-17 05:01:41', 1, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456'),
(1587, '::1', 'geg7ljm9o8a64qbk0duvc9snav', '2026-09-17 05:01:42', '2026-09-17 05:01:42', 1, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456'),
(1588, '::1', 'kn93jgg5bu1idsmva94tg6ldva', '2026-09-17 05:02:20', '2026-09-17 05:02:20', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1589, '::1', 'g5ojp5hkv1ph0a3jmse1qv75pg', '2026-09-17 05:07:39', '2026-09-17 05:07:39', 1, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456'),
(1590, '::1', '2ktluphmt7dnmccof3j4fkc35l', '2026-09-17 05:08:11', '2026-09-17 05:08:11', 1, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456'),
(1591, '::1', 'a28u7tn0efrb9582nvn6v2aq70', '2026-09-17 05:08:11', '2026-09-17 05:08:11', 1, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456'),
(1592, '::1', 'or098inucrjenduo0d5auf0vlk', '2026-09-17 05:10:34', '2026-09-17 05:10:34', 1, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456'),
(1593, '::1', 'jagic82tt9agcqhnko062t1cj2', '2026-09-17 05:10:35', '2026-09-17 05:10:35', 1, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456'),
(1594, '::1', 'j0kinif9mrbi3ecb5fed41hf7q', '2026-09-17 05:10:35', '2026-09-17 05:10:35', 1, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456'),
(1595, '::1', 'u2mrda1la4bti56pbgk8dg00i9', '2026-09-17 05:10:35', '2026-09-17 05:10:35', 1, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456'),
(1596, '::1', 'laavnhjm7sk58l93tmfjr9a0tt', '2026-09-17 05:10:36', '2026-09-17 05:10:36', 1, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456'),
(1597, '::1', 'f824qqjuj35iop3urrclldq77q', '2026-09-17 05:10:36', '2026-09-17 05:10:36', 1, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456'),
(1598, '::1', 't9j6uu7undb3m0iji1o6a97ts4', '2026-09-17 05:10:36', '2026-09-17 05:10:36', 1, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456'),
(1600, '::1', 'f2iqqq2l5enmv7nb9rfool9h4l', '2026-09-17 05:15:19', '2026-09-17 05:15:19', 1, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456'),
(1601, '::1', 'jukgi0e9gfdflc7cnqduuhld1k', '2026-09-17 05:22:26', '2026-09-17 05:22:26', 1, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456'),
(1602, '::1', 'uihii3ub114tigv8nr75da5fsb', '2026-09-17 05:22:50', '2026-09-17 05:22:50', 1, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456'),
(1603, '::1', '3cr88cfkricfgmimg5gnv76kvv', '2026-09-17 05:23:27', '2026-09-17 05:23:27', 1, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456'),
(1604, '::1', 'emfttkqsjh92elfqnu11hj05qu', '2026-09-17 05:23:50', '2026-09-17 05:23:50', 1, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456'),
(1605, '::1', 'a4d3lq0np490k89tnlc2e8jdhi', '2026-09-17 05:25:13', '2026-09-17 05:25:13', 1, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456'),
(1606, '::1', 'g26bk2smuhplf9l21tbr57rarv', '2026-09-17 05:25:40', '2026-09-17 05:25:40', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1607, '::1', 't0bfce05u8p3fr9maico40388n', '2026-09-17 05:26:09', '2026-09-17 05:26:09', 1, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456'),
(1608, '::1', 'n6of767er9guf0n6q9l6qnaglk', '2026-09-17 05:26:10', '2026-09-17 05:26:10', 1, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456'),
(1609, '::1', '3vu1sgem9letne7rsn4kka493d', '2026-09-17 05:26:10', '2026-09-17 05:26:10', 1, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456'),
(1610, '::1', 'q64t7hldc5rdmab635e64hu0q9', '2026-09-17 05:26:11', '2026-09-17 05:26:11', 1, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456'),
(1611, '::1', 'ile38gq75egkc4iv1mpnaeorq7', '2026-09-17 05:26:11', '2026-09-17 05:26:11', 1, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456'),
(1612, '::1', 'ls4o9h6fbsa9sor5d8g04se8ml', '2026-09-17 05:26:11', '2026-09-17 05:26:11', 1, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456'),
(1613, '::1', '1muvon45t36t4v8nkluk6aokkd', '2026-09-17 05:26:12', '2026-09-17 05:26:12', 1, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456'),
(1614, '::1', '13372ljrkpsk70i1r2dmp136j0', '2026-09-17 05:26:12', '2026-09-17 05:26:12', 1, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456'),
(1615, '::1', 'k2qig1f8t2b91u3c40sr601f5d', '2026-09-17 05:26:13', '2026-09-17 05:26:13', 1, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456'),
(1616, '::1', 'i18vtj8boabbdh5oucs58lu15r', '2026-09-17 05:26:13', '2026-09-17 05:26:13', 1, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456'),
(1617, '::1', 'l0afs1foem8hconb7rdv47g07l', '2026-09-17 05:26:13', '2026-09-17 05:26:13', 1, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456'),
(1618, '::1', 'oijlfla2g3acbg62r5hvmivvj6', '2026-09-17 05:26:13', '2026-09-17 05:26:13', 1, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456'),
(1619, '::1', 'oh8aeufp8gbbqph1id6m75mo5s', '2026-09-17 05:26:14', '2026-09-17 05:26:14', 1, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456'),
(1620, '::1', 'm2qaqbhgdleddohg9pev5bjm6c', '2026-09-17 05:26:14', '2026-09-17 05:26:14', 1, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456'),
(1621, '::1', 'bbgl2kpianbgb27rid603gqr7f', '2026-09-17 05:26:14', '2026-09-17 05:26:14', 1, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456'),
(1622, '::1', '4qi0117h7lffprs89akvcpge08', '2026-09-17 05:26:14', '2026-09-17 05:26:14', 1, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456'),
(1623, '::1', 'grlufqhhqsqv81ft4oohfrab9t', '2026-09-17 05:26:15', '2026-09-17 05:26:15', 1, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456'),
(1624, '::1', '2ssl0nd4uis9ghesoha68m9ha2', '2026-09-17 05:26:15', '2026-09-17 05:26:15', 1, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456'),
(1625, '::1', '47nsnfkrin05knke5pc5623nsc', '2026-09-17 05:26:16', '2026-09-17 05:26:16', 1, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456'),
(1626, '::1', 's9d28bpct1vkdrn060vnu21ipj', '2026-09-17 05:26:16', '2026-09-17 05:26:16', 1, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456'),
(1627, '::1', '8b6tscfsr7g2mjkgrhv87tl6eq', '2026-09-17 05:26:16', '2026-09-17 05:26:16', 1, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456'),
(1628, '::1', 'e6lmp9i11kovj4g7o6eotj6jmq', '2026-09-17 05:26:16', '2026-09-17 05:26:16', 1, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456'),
(1629, '::1', '2u82akvrpua5sup4catna44tm1', '2026-09-17 05:26:16', '2026-09-17 05:26:16', 1, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456'),
(1630, '::1', 'vuch9dc5dmn86av72p62pu4dqt', '2026-09-17 05:26:17', '2026-09-17 05:26:17', 1, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456'),
(1631, '::1', 'ljr12qvlto37p81bvfk8a5s2bq', '2026-09-17 05:26:17', '2026-09-17 05:26:17', 1, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456'),
(1632, '::1', '7121srto84c0uc2kb73mhelc3t', '2026-09-17 05:26:17', '2026-09-17 05:26:17', 1, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456'),
(1633, '::1', 'qm3tc2cckc6k6e2ngv2r08pagv', '2026-09-17 05:26:17', '2026-09-17 05:26:17', 1, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456'),
(1634, '::1', 'g1vu650a40n6sa5hp8gtsvh3rg', '2026-09-17 05:26:18', '2026-09-17 05:26:18', 1, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456'),
(1635, '::1', 'bvptdbkv1qba0hjonu5pggdh9c', '2026-09-17 05:26:18', '2026-09-17 05:26:18', 1, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456'),
(1636, '::1', 'rcr03bai3apj9nsjje8kd0k38q', '2026-09-17 05:36:56', '2026-09-17 05:36:56', 1, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456'),
(1637, '::1', 'glbb23vbo67242bkdganqrqv8o', '2026-09-17 05:36:57', '2026-09-17 05:36:57', 1, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456'),
(1638, '::1', '3nqruhivoottn9jpe48ogs2n3r', '2026-09-17 05:36:57', '2026-09-17 05:36:57', 1, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456'),
(1639, '::1', 'knge2nuidd38q1bb8jdrei96tg', '2026-09-17 05:39:36', '2026-09-17 05:39:36', 1, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456'),
(1640, '::1', 'dmdashs6pl9aop8qkgletfdvhl', '2026-09-17 05:39:36', '2026-09-17 05:39:36', 1, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456'),
(1641, '::1', 'd5megqcsfv7k166sn3n9nt7s3g', '2026-09-17 05:40:06', '2026-09-17 05:40:06', 1, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456'),
(1642, '::1', 'msi4tohe2mha4re5ouvqm0r2pa', '2026-09-17 05:40:07', '2026-09-17 05:40:07', 1, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456'),
(1643, '::1', 'hdcuhq296o3tv3c8ffd9pv4er3', '2026-09-17 05:40:07', '2026-09-17 05:40:07', 1, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456'),
(1644, '::1', 'n18ucodvpmekt9do3h76e9126m', '2026-09-17 05:52:18', '2026-09-17 05:52:18', 1, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456'),
(1645, '::1', 'hutmebgv1gj90ugpmp4403pe9e', '2026-09-17 05:52:19', '2026-09-17 05:52:19', 1, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456'),
(1646, '::1', 'gk2rv5nnntmdj7lf9e4dieungq', '2026-09-17 05:55:23', '2026-09-17 05:55:32', 2, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1648, '::1', '2vtcv029813k0ec1sbog2qck73', '2026-09-17 06:00:42', '2026-09-17 06:00:42', 1, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456'),
(1649, '::1', 'h0qqg31ed3r4c3f4n0tsdi9lto', '2026-09-17 06:00:43', '2026-09-17 06:00:43', 1, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456'),
(1650, '::1', '6ug70ibe35s5r14ng55ghuig9e', '2026-09-17 06:00:43', '2026-09-17 06:00:43', 1, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456'),
(1651, '::1', '55pq5rhaung7rd2mj0du3ijk4l', '2026-09-17 06:00:44', '2026-09-17 06:00:44', 1, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456'),
(1652, '::1', 'tjoj6ndmeu1so90mum2k8vf6rh', '2026-09-17 06:00:44', '2026-09-17 06:00:44', 1, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456'),
(1653, '::1', 'l6hag28i55aug3823qaussu9t3', '2026-09-17 06:00:44', '2026-09-17 06:00:44', 1, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456'),
(1654, '::1', '09lmuu7bv3h4bpd9if3f6g3v4h', '2026-09-17 06:00:45', '2026-09-17 06:00:45', 1, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456'),
(1655, '::1', 'p3gsd6ho9c9nu5fpqgb29l9d9n', '2026-09-17 06:00:45', '2026-09-17 06:00:45', 1, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456'),
(1656, '::1', '1284g7c40vtr29hoe436u6rdgd', '2026-09-17 06:28:32', '2026-09-17 06:28:32', 1, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456'),
(1657, '::1', '9e9gte2qgdf7ovv40c3hlut1ve', '2026-09-17 06:28:48', '2026-09-17 06:28:48', 1, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456'),
(1658, '::1', 'scipcuguur8eni5dg03ocbt8uk', '2026-09-17 06:28:49', '2026-09-17 06:28:49', 1, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456'),
(1659, '::1', 's8juohencg9ssbgecb94jh9j4c', '2026-09-17 06:29:32', '2026-09-17 06:29:32', 1, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456'),
(1660, '::1', '72qblc7298sb9duae14tkhcbo5', '2026-09-17 06:29:37', '2026-09-17 06:29:37', 1, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456'),
(1661, '::1', 'u82p0rtoa3iebi1j84h5q0h9pd', '2026-09-17 06:29:37', '2026-09-17 06:29:37', 1, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456'),
(1662, '::1', 'r2mnmu9399kqc9ojqgfq58foj3', '2026-09-17 06:29:39', '2026-09-17 06:29:39', 1, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456'),
(1663, '::1', 'mabrv2vj6gr8vatspfvsutlluq', '2026-09-17 06:29:40', '2026-09-17 06:29:40', 1, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456'),
(1664, '::1', 'ojcoh2qf6lbohs1540nvp3c5ih', '2026-09-17 06:29:46', '2026-09-17 06:29:46', 1, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456'),
(1665, '::1', '2hsjp4a98empvp0pq26rf8nn49', '2026-09-17 06:30:22', '2026-09-17 06:30:22', 1, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456'),
(1666, '::1', 't4drb27c2v5ef384ddmb1mj1k5', '2026-09-17 06:36:36', '2026-09-17 06:38:25', 66, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1732, '::1', 's0vdneeci9qjbahci632d08tln', '2026-09-17 06:39:37', '2026-09-17 06:39:37', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1733, '::1', '0nf6d3p0c6dpgsmv2bsjbg7tk8', '2026-09-17 06:39:46', '2026-09-17 06:39:46', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1734, '::1', '2q3a6q81u89k2t7p1aar65g8fj', '2026-09-17 06:40:47', '2026-09-17 06:41:02', 2, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1736, '::1', '932es6tq3vjfbq2tabtvh5t6ku', '2026-09-17 06:41:38', '2026-09-17 06:41:54', 2, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1738, '::1', 'abbq2krajv280id0qns4i4u2au', '2026-09-17 06:44:17', '2026-09-17 06:49:02', 116, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1800, '::1', 'ienvolk7l2pibo2l6mpqbdr5sl', '2026-09-17 06:46:57', '2026-09-17 06:46:57', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1855, '::1', 'ktv9s8km9ak51jh4j03aekocah', '2026-09-17 06:49:24', '2026-09-17 06:49:24', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1856, '::1', '32mstiaikvtl6imu5tuehrj3c6', '2026-09-17 06:51:04', '2026-09-17 06:51:04', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1857, '::1', 'a0lf1f38cgtrnhfpgs7796squi', '2026-09-17 06:51:37', '2026-09-17 06:51:37', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1858, '::1', 'n4k8ho39n0koujoee4o936ndld', '2026-09-17 06:52:12', '2026-09-17 06:53:01', 17, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1874, '::1', '6g67n24ncpck0o9eubgnvcn7b9', '2026-09-17 06:52:56', '2026-09-17 06:53:13', 5, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1880, '::1', 'e81u6p8cpof2ik3k84uckkhem6', '2026-09-17 08:01:52', '2026-09-17 08:06:48', 116, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(1997, '::1', 'me2t6n282rbihopo875t0v667e', '2026-09-17 08:37:59', '2026-09-17 08:37:59', 1, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456'),
(1998, '::1', 'lo4bo4q2gqo8ccbheo6h844vah', '2026-09-17 08:43:58', '2026-09-17 08:44:13', 2, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36'),
(2000, '::1', '3kbekit2dnivnl40sgr4cn63uu', '2026-09-17 08:45:13', '2026-09-17 08:45:13', 1, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456'),
(2001, '::1', '3i4r8ipt4ltehamc86gioqpucc', '2026-09-17 08:45:14', '2026-09-17 08:45:14', 1, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456'),
(2002, '::1', 'ao5ov9o5ncbvomd2nbj3ag27bm', '2026-09-17 08:45:14', '2026-09-17 08:45:14', 1, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456'),
(2003, '::1', 'rfqtd73v6rijh0hgihql5pn18d', '2026-09-17 08:45:14', '2026-09-17 08:45:14', 1, 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456');

-- --------------------------------------------------------

--
-- Table structure for table `website_analytics`
--

CREATE TABLE `website_analytics` (
  `id` int(11) NOT NULL,
  `visitor_ip` varchar(45) NOT NULL,
  `page_url` varchar(255) NOT NULL,
  `page_title` varchar(255) DEFAULT NULL,
  `referrer` varchar(255) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `device_type` enum('Mobile','Tablet','Desktop','Unknown') DEFAULT 'Unknown',
  `browser` varchar(100) DEFAULT NULL,
  `operating_system` varchar(100) DEFAULT NULL,
  `country` varchar(100) DEFAULT NULL,
  `city` varchar(100) DEFAULT NULL,
  `session_id` varchar(100) NOT NULL,
  `visit_date` date NOT NULL,
  `visit_time` time NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `website_analytics`
--

INSERT INTO `website_analytics` (`id`, `visitor_ip`, `page_url`, `page_title`, `referrer`, `user_agent`, `device_type`, `browser`, `operating_system`, `country`, `city`, `session_id`, `visit_date`, `visit_time`, `created_at`) VALUES
(1, '127.0.0.1', '/SHAHEENPUBLICHIGHSCHOOL/index.php', '', 'http://localhost/SHAHEENPUBLICHIGHSCHOOL/contact.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:146.0) Gecko/20100101 Firefox/146.0', 'Desktop', 'Firefox', 'Windows 10', NULL, NULL, 'd5jspmud1b47s4ncofloekjgpr', '2025-12-27', '10:51:30', '2025-12-27 09:51:30'),
(2, '127.0.0.1', '/SHAHEENPUBLICHIGHSCHOOL/index.php', '', 'http://localhost/SHAHEENPUBLICHIGHSCHOOL/contact.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:146.0) Gecko/20100101 Firefox/146.0', 'Desktop', 'Firefox', 'Windows 10', NULL, NULL, 'd5jspmud1b47s4ncofloekjgpr', '2025-12-27', '10:53:16', '2025-12-27 09:53:16'),
(3, '127.0.0.1', '/SHAHEENPUBLICHIGHSCHOOL/index.php', '', 'http://localhost/SHAHEENPUBLICHIGHSCHOOL/contact.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:146.0) Gecko/20100101 Firefox/146.0', 'Desktop', 'Firefox', 'Windows 10', NULL, NULL, 'd5jspmud1b47s4ncofloekjgpr', '2025-12-27', '10:57:59', '2025-12-27 09:57:59'),
(4, '127.0.0.1', '/SHAHEENPUBLICHIGHSCHOOL/index.php', '', 'http://localhost/SHAHEENPUBLICHIGHSCHOOL/contact.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:146.0) Gecko/20100101 Firefox/146.0', 'Desktop', 'Firefox', 'Windows 10', NULL, NULL, 'd5jspmud1b47s4ncofloekjgpr', '2025-12-27', '10:59:52', '2025-12-27 09:59:52'),
(5, '127.0.0.1', '/SHAHEENPUBLICHIGHSCHOOL/index.php', '', 'http://localhost/SHAHEENPUBLICHIGHSCHOOL/contact.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:146.0) Gecko/20100101 Firefox/146.0', 'Desktop', 'Firefox', 'Windows 10', NULL, NULL, 'd5jspmud1b47s4ncofloekjgpr', '2025-12-27', '11:04:42', '2025-12-27 10:04:42'),
(6, '127.0.0.1', '/SHAHEENPUBLICHIGHSCHOOL/about.php', '', 'http://localhost/SHAHEENPUBLICHIGHSCHOOL/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:146.0) Gecko/20100101 Firefox/146.0', 'Desktop', 'Firefox', 'Windows 10', NULL, NULL, 'd5jspmud1b47s4ncofloekjgpr', '2025-12-27', '11:04:56', '2025-12-27 10:04:56'),
(7, '127.0.0.1', '/SHAHEENPUBLICHIGHSCHOOL/index.php', '', 'http://localhost/SHAHEENPUBLICHIGHSCHOOL/about.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:146.0) Gecko/20100101 Firefox/146.0', 'Desktop', 'Firefox', 'Windows 10', NULL, NULL, 'd5jspmud1b47s4ncofloekjgpr', '2025-12-27', '11:05:52', '2025-12-27 10:05:52'),
(8, '127.0.0.1', '/SHAHEENPUBLICHIGHSCHOOL/index.php', '', 'http://localhost/SHAHEENPUBLICHIGHSCHOOL/about.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:146.0) Gecko/20100101 Firefox/146.0', 'Desktop', 'Firefox', 'Windows 10', NULL, NULL, 'd5jspmud1b47s4ncofloekjgpr', '2025-12-27', '11:06:28', '2025-12-27 10:06:28'),
(9, '127.0.0.1', '/SHAHEENPUBLICHIGHSCHOOL/index.php', '', 'http://localhost/SHAHEENPUBLICHIGHSCHOOL/about.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:146.0) Gecko/20100101 Firefox/146.0', 'Desktop', 'Firefox', 'Windows 10', NULL, NULL, 'd5jspmud1b47s4ncofloekjgpr', '2025-12-27', '11:10:04', '2025-12-27 10:10:04'),
(10, '127.0.0.1', '/SHAHEENPUBLICHIGHSCHOOL/index.php', '', 'http://localhost/SHAHEENPUBLICHIGHSCHOOL/about.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:146.0) Gecko/20100101 Firefox/146.0', 'Desktop', 'Firefox', 'Windows 10', NULL, NULL, 'd5jspmud1b47s4ncofloekjgpr', '2025-12-27', '11:11:02', '2025-12-27 10:11:02'),
(11, '127.0.0.1', '/SHAHEENPUBLICHIGHSCHOOL/index.php', '', 'http://localhost/SHAHEENPUBLICHIGHSCHOOL/about.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:146.0) Gecko/20100101 Firefox/146.0', 'Desktop', 'Firefox', 'Windows 10', NULL, NULL, 'd5jspmud1b47s4ncofloekjgpr', '2025-12-27', '11:16:21', '2025-12-27 10:16:21'),
(12, '127.0.0.1', '/SHAHEENPUBLICHIGHSCHOOL/index.php', '', 'http://localhost/SHAHEENPUBLICHIGHSCHOOL/about.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:146.0) Gecko/20100101 Firefox/146.0', 'Desktop', 'Firefox', 'Windows 10', NULL, NULL, 'd5jspmud1b47s4ncofloekjgpr', '2025-12-27', '11:19:18', '2025-12-27 10:19:18'),
(13, '127.0.0.1', '/SHAHEENPUBLICHIGHSCHOOL/about.php', '', 'http://localhost/SHAHEENPUBLICHIGHSCHOOL/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:146.0) Gecko/20100101 Firefox/146.0', 'Desktop', 'Firefox', 'Windows 10', NULL, NULL, 'd5jspmud1b47s4ncofloekjgpr', '2025-12-27', '11:19:37', '2025-12-27 10:19:37'),
(14, '127.0.0.1', '/SHAHEENPUBLICHIGHSCHOOL/about.php', '', 'http://localhost/SHAHEENPUBLICHIGHSCHOOL/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:146.0) Gecko/20100101 Firefox/146.0', 'Desktop', 'Firefox', 'Windows 10', NULL, NULL, 'd5jspmud1b47s4ncofloekjgpr', '2025-12-27', '11:27:11', '2025-12-27 10:27:11'),
(15, '127.0.0.1', '/SHAHEENPUBLICHIGHSCHOOL/about.php', '', 'http://localhost/SHAHEENPUBLICHIGHSCHOOL/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:146.0) Gecko/20100101 Firefox/146.0', 'Desktop', 'Firefox', 'Windows 10', NULL, NULL, 'd5jspmud1b47s4ncofloekjgpr', '2025-12-27', '11:27:13', '2025-12-27 10:27:13'),
(16, '127.0.0.1', '/SHAHEENPUBLICHIGHSCHOOL/courses.php', '', 'http://localhost/SHAHEENPUBLICHIGHSCHOOL/about.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:146.0) Gecko/20100101 Firefox/146.0', 'Desktop', 'Firefox', 'Windows 10', NULL, NULL, 'd5jspmud1b47s4ncofloekjgpr', '2025-12-27', '11:27:35', '2025-12-27 10:27:35'),
(17, '127.0.0.1', '/SHAHEENPUBLICHIGHSCHOOL/admission.php', '', 'http://localhost/SHAHEENPUBLICHIGHSCHOOL/courses.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:146.0) Gecko/20100101 Firefox/146.0', 'Desktop', 'Firefox', 'Windows 10', NULL, NULL, 'd5jspmud1b47s4ncofloekjgpr', '2025-12-27', '11:27:49', '2025-12-27 10:27:49'),
(18, '127.0.0.1', '/SHAHEENPUBLICHIGHSCHOOL/faculty.php', '', 'http://localhost/SHAHEENPUBLICHIGHSCHOOL/admission.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:146.0) Gecko/20100101 Firefox/146.0', 'Desktop', 'Firefox', 'Windows 10', NULL, NULL, 'd5jspmud1b47s4ncofloekjgpr', '2025-12-27', '11:28:07', '2025-12-27 10:28:07'),
(19, '127.0.0.1', '/SHAHEENPUBLICHIGHSCHOOL/contact.php', '', 'http://localhost/SHAHEENPUBLICHIGHSCHOOL/faculty.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:146.0) Gecko/20100101 Firefox/146.0', 'Desktop', 'Firefox', 'Windows 10', NULL, NULL, 'd5jspmud1b47s4ncofloekjgpr', '2025-12-27', '11:28:16', '2025-12-27 10:28:16'),
(20, '127.0.0.1', '/SHAHEENPUBLICHIGHSCHOOL/contact.php', '', 'http://localhost/SHAHEENPUBLICHIGHSCHOOL/faculty.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:146.0) Gecko/20100101 Firefox/146.0', 'Desktop', 'Firefox', 'Windows 10', NULL, NULL, 'd5jspmud1b47s4ncofloekjgpr', '2025-12-27', '11:30:24', '2025-12-27 10:30:24'),
(21, '127.0.0.1', '/SHAHEENPUBLICHIGHSCHOOL/contact.php', '', 'http://localhost/SHAHEENPUBLICHIGHSCHOOL/faculty.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:146.0) Gecko/20100101 Firefox/146.0', 'Desktop', 'Firefox', 'Windows 10', NULL, NULL, 'd5jspmud1b47s4ncofloekjgpr', '2025-12-27', '11:31:46', '2025-12-27 10:31:46'),
(22, '127.0.0.1', '/SHAHEENPUBLICHIGHSCHOOL/contact.php', '', 'http://localhost/SHAHEENPUBLICHIGHSCHOOL/faculty.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:146.0) Gecko/20100101 Firefox/146.0', 'Desktop', 'Firefox', 'Windows 10', NULL, NULL, 'd5jspmud1b47s4ncofloekjgpr', '2025-12-27', '11:32:38', '2025-12-27 10:32:38'),
(23, '127.0.0.1', '/SHAHEENPUBLICHIGHSCHOOL/contact.php', '', 'http://localhost/SHAHEENPUBLICHIGHSCHOOL/faculty.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:146.0) Gecko/20100101 Firefox/146.0', 'Desktop', 'Firefox', 'Windows 10', NULL, NULL, 'd5jspmud1b47s4ncofloekjgpr', '2025-12-27', '11:34:08', '2025-12-27 10:34:08'),
(24, '127.0.0.1', '/SHAHEENPUBLICHIGHSCHOOL/contact.php', '', 'http://localhost/SHAHEENPUBLICHIGHSCHOOL/faculty.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:146.0) Gecko/20100101 Firefox/146.0', 'Desktop', 'Firefox', 'Windows 10', NULL, NULL, 'd5jspmud1b47s4ncofloekjgpr', '2025-12-27', '11:35:42', '2025-12-27 10:35:42'),
(25, '127.0.0.1', '/SHAHEENPUBLICHIGHSCHOOL/index.php', '', 'http://localhost/SHAHEENPUBLICHIGHSCHOOL/contact.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:146.0) Gecko/20100101 Firefox/146.0', 'Desktop', 'Firefox', 'Windows 10', NULL, NULL, 'd5jspmud1b47s4ncofloekjgpr', '2025-12-27', '11:41:15', '2025-12-27 10:41:15'),
(26, '127.0.0.1', '/SHAHEENPUBLICHIGHSCHOOL/index.php', '', 'http://localhost/SHAHEENPUBLICHIGHSCHOOL/contact.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:146.0) Gecko/20100101 Firefox/146.0', 'Desktop', 'Firefox', 'Windows 10', NULL, NULL, 'd5jspmud1b47s4ncofloekjgpr', '2025-12-27', '11:43:35', '2025-12-27 10:43:35'),
(27, '127.0.0.1', '/SHAHEENPUBLICHIGHSCHOOL/index.php', '', 'http://localhost/SHAHEENPUBLICHIGHSCHOOL/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:146.0) Gecko/20100101 Firefox/146.0', 'Desktop', 'Firefox', 'Windows 10', NULL, NULL, 'd5jspmud1b47s4ncofloekjgpr', '2025-12-27', '11:43:37', '2025-12-27 10:43:37'),
(28, '127.0.0.1', '/SHAHEENPUBLICHIGHSCHOOL/about.php', '', 'http://localhost/SHAHEENPUBLICHIGHSCHOOL/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:146.0) Gecko/20100101 Firefox/146.0', 'Desktop', 'Firefox', 'Windows 10', NULL, NULL, 'd5jspmud1b47s4ncofloekjgpr', '2025-12-27', '11:43:39', '2025-12-27 10:43:39'),
(29, '127.0.0.1', '/SHAHEENPUBLICHIGHSCHOOL/index.php', '', 'http://localhost/SHAHEENPUBLICHIGHSCHOOL/about.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:146.0) Gecko/20100101 Firefox/146.0', 'Desktop', 'Firefox', 'Windows 10', NULL, NULL, 'd5jspmud1b47s4ncofloekjgpr', '2025-12-27', '11:43:42', '2025-12-27 10:43:42'),
(30, '::1', '/SHAHEENPUBLICHIGHSCHOOL/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'kkbk6ki04deocaqg1c56a1h1hs', '2026-01-05', '08:54:44', '2026-01-05 07:54:44'),
(31, '::1', '/shaheen/shaheen/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'kkbk6ki04deocaqg1c56a1h1hs', '2026-01-05', '09:51:55', '2026-01-05 08:51:55'),
(32, '::1', '/shaheen/shaheen/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'kkbk6ki04deocaqg1c56a1h1hs', '2026-01-05', '10:09:43', '2026-01-05 09:09:43'),
(33, '::1', '/shaheen/shaheen/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'kkbk6ki04deocaqg1c56a1h1hs', '2026-01-05', '10:10:20', '2026-01-05 09:10:20'),
(34, '127.0.0.1', '/SHAHEENPUBLICHIGHSCHOOL/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:146.0) Gecko/20100101 Firefox/146.0', 'Desktop', 'Firefox', 'Windows 10', NULL, NULL, '1tkhaulgu9mobi38vhu99gj6cd', '2026-01-13', '10:31:44', '2026-01-13 09:31:44'),
(35, '127.0.0.1', '/SHAHEENPUBLICHIGHSCHOOL/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:146.0) Gecko/20100101 Firefox/146.0', 'Desktop', 'Firefox', 'Windows 10', NULL, NULL, '1tkhaulgu9mobi38vhu99gj6cd', '2026-01-13', '10:45:27', '2026-01-13 09:45:27'),
(36, '127.0.0.1', '/SHAHEENPUBLICHIGHSCHOOL/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:146.0) Gecko/20100101 Firefox/146.0', 'Desktop', 'Firefox', 'Windows 10', NULL, NULL, '1tkhaulgu9mobi38vhu99gj6cd', '2026-01-13', '10:45:34', '2026-01-13 09:45:34'),
(37, '127.0.0.1', '/SHAHEENPUBLICHIGHSCHOOL/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:146.0) Gecko/20100101 Firefox/146.0', 'Desktop', 'Firefox', 'Windows 10', NULL, NULL, '1tkhaulgu9mobi38vhu99gj6cd', '2026-01-13', '10:53:27', '2026-01-13 09:53:27'),
(38, '127.0.0.1', '/SHAHEENPUBLICHIGHSCHOOL/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:146.0) Gecko/20100101 Firefox/146.0', 'Desktop', 'Firefox', 'Windows 10', NULL, NULL, '1tkhaulgu9mobi38vhu99gj6cd', '2026-01-13', '10:57:01', '2026-01-13 09:57:01'),
(39, '127.0.0.1', '/SHAHEENPUBLICHIGHSCHOOL/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:146.0) Gecko/20100101 Firefox/146.0', 'Desktop', 'Firefox', 'Windows 10', NULL, NULL, '1tkhaulgu9mobi38vhu99gj6cd', '2026-01-13', '10:58:41', '2026-01-13 09:58:41'),
(40, '127.0.0.1', '/SHAHEENPUBLICHIGHSCHOOL/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:146.0) Gecko/20100101 Firefox/146.0', 'Desktop', 'Firefox', 'Windows 10', NULL, NULL, '1tkhaulgu9mobi38vhu99gj6cd', '2026-01-13', '10:59:19', '2026-01-13 09:59:19'),
(41, '127.0.0.1', '/SHAHEENPUBLICHIGHSCHOOL/about.php', '', 'http://localhost/SHAHEENPUBLICHIGHSCHOOL/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:146.0) Gecko/20100101 Firefox/146.0', 'Desktop', 'Firefox', 'Windows 10', NULL, NULL, '1tkhaulgu9mobi38vhu99gj6cd', '2026-01-13', '10:59:52', '2026-01-13 09:59:52'),
(42, '::1', '/SHAHEENPUBLICHIGHSCHOOL/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'h8unkai0empu9dca4f89dpnetj', '2026-01-14', '06:39:31', '2026-01-14 05:39:31'),
(43, '::1', '/SHAHEENPUBLICHIGHSCHOOL/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'h8unkai0empu9dca4f89dpnetj', '2026-01-14', '06:39:41', '2026-01-14 05:39:41'),
(44, '::1', '/SHAHEENPUBLICHIGHSCHOOL/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'h8unkai0empu9dca4f89dpnetj', '2026-01-14', '06:43:21', '2026-01-14 05:43:21'),
(45, '::1', '/SHAHEENPUBLICHIGHSCHOOL/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'h8unkai0empu9dca4f89dpnetj', '2026-01-14', '06:55:39', '2026-01-14 05:55:39'),
(46, '::1', '/SHAHEENPUBLICHIGHSCHOOL/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'h8unkai0empu9dca4f89dpnetj', '2026-01-14', '07:15:29', '2026-01-14 06:15:29'),
(47, '::1', '/SHAHEENPUBLICHIGHSCHOOL/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'h8unkai0empu9dca4f89dpnetj', '2026-01-14', '07:20:02', '2026-01-14 06:20:02'),
(48, '::1', '/SHAHEENPUBLICHIGHSCHOOL/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'h8unkai0empu9dca4f89dpnetj', '2026-01-14', '07:28:51', '2026-01-14 06:28:51'),
(49, '::1', '/SHAHEENPUBLICHIGHSCHOOL/index.php', '', 'http://localhost/SHAHEENPUBLICHIGHSCHOOL/', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'h8unkai0empu9dca4f89dpnetj', '2026-01-14', '07:30:09', '2026-01-14 06:30:09'),
(50, '::1', '/SHAHEENPUBLICHIGHSCHOOL/index.php', '', 'http://localhost/SHAHEENPUBLICHIGHSCHOOL/', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'h8unkai0empu9dca4f89dpnetj', '2026-01-14', '07:33:00', '2026-01-14 06:33:00'),
(51, '::1', '/SHAHEENPUBLICHIGHSCHOOL/about.php', '', 'http://localhost/SHAHEENPUBLICHIGHSCHOOL/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'h8unkai0empu9dca4f89dpnetj', '2026-01-14', '07:33:58', '2026-01-14 06:33:58'),
(52, '::1', '/SHAHEENPUBLICHIGHSCHOOL/about.php', '', 'http://localhost/SHAHEENPUBLICHIGHSCHOOL/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'h8unkai0empu9dca4f89dpnetj', '2026-01-14', '07:36:06', '2026-01-14 06:36:06'),
(53, '::1', '/SHAHEENPUBLICHIGHSCHOOL/about.php', '', 'http://localhost/SHAHEENPUBLICHIGHSCHOOL/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'h8unkai0empu9dca4f89dpnetj', '2026-01-14', '07:38:34', '2026-01-14 06:38:34'),
(54, '::1', '/SHAHEENPUBLICHIGHSCHOOL/about.php', '', 'http://localhost/SHAHEENPUBLICHIGHSCHOOL/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'h8unkai0empu9dca4f89dpnetj', '2026-01-14', '07:38:37', '2026-01-14 06:38:37'),
(55, '::1', '/SHAHEENPUBLICHIGHSCHOOL/courses.php', '', 'http://localhost/SHAHEENPUBLICHIGHSCHOOL/about.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'h8unkai0empu9dca4f89dpnetj', '2026-01-14', '07:39:20', '2026-01-14 06:39:20'),
(56, '::1', '/SHAHEENPUBLICHIGHSCHOOL/courses.php', '', 'http://localhost/SHAHEENPUBLICHIGHSCHOOL/about.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'h8unkai0empu9dca4f89dpnetj', '2026-01-14', '07:39:35', '2026-01-14 06:39:35'),
(57, '::1', '/SHAHEENPUBLICHIGHSCHOOL/admission.php', '', 'http://localhost/SHAHEENPUBLICHIGHSCHOOL/courses.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'h8unkai0empu9dca4f89dpnetj', '2026-01-14', '07:39:39', '2026-01-14 06:39:39'),
(58, '::1', '/SHAHEENPUBLICHIGHSCHOOL/faculty.php', '', 'http://localhost/SHAHEENPUBLICHIGHSCHOOL/admission.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'h8unkai0empu9dca4f89dpnetj', '2026-01-14', '07:39:58', '2026-01-14 06:39:58'),
(59, '::1', '/SHAHEENPUBLICHIGHSCHOOL/gallery.php', '', 'http://localhost/SHAHEENPUBLICHIGHSCHOOL/faculty.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'h8unkai0empu9dca4f89dpnetj', '2026-01-14', '07:40:08', '2026-01-14 06:40:08'),
(60, '::1', '/SHAHEENPUBLICHIGHSCHOOL/contact.php', '', 'http://localhost/SHAHEENPUBLICHIGHSCHOOL/gallery.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'h8unkai0empu9dca4f89dpnetj', '2026-01-14', '07:40:12', '2026-01-14 06:40:12'),
(61, '::1', '/SHAHEENPUBLICHIGHSCHOOL/contact.php', '', 'http://localhost/SHAHEENPUBLICHIGHSCHOOL/gallery.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'h8unkai0empu9dca4f89dpnetj', '2026-01-14', '07:56:53', '2026-01-14 06:56:53'),
(62, '::1', '/SHAHEENPUBLICHIGHSCHOOL/index.php', '', 'http://localhost/SHAHEENPUBLICHIGHSCHOOL/contact.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'h8unkai0empu9dca4f89dpnetj', '2026-01-14', '07:57:12', '2026-01-14 06:57:12'),
(63, '::1', '/SHAHEENPUBLICHIGHSCHOOL/index.php', '', 'http://localhost/SHAHEENPUBLICHIGHSCHOOL/AdminCP/dashboard.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'h8unkai0empu9dca4f89dpnetj', '2026-01-14', '07:57:46', '2026-01-14 06:57:46'),
(64, '::1', '/SHAHEENPUBLICHIGHSCHOOL/index.php', '', 'http://localhost/SHAHEENPUBLICHIGHSCHOOL/contact.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'h8unkai0empu9dca4f89dpnetj', '2026-01-14', '07:58:23', '2026-01-14 06:58:23'),
(65, '::1', '/SHAHEENPUBLICHIGHSCHOOL/index.php', '', 'http://localhost/SHAHEENPUBLICHIGHSCHOOL/contact.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'h8unkai0empu9dca4f89dpnetj', '2026-01-14', '07:58:54', '2026-01-14 06:58:54'),
(66, '::1', '/SHAHEENPUBLICHIGHSCHOOL/index.php', '', 'http://localhost/SHAHEENPUBLICHIGHSCHOOL/contact.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'h8unkai0empu9dca4f89dpnetj', '2026-01-14', '07:59:46', '2026-01-14 06:59:46'),
(67, '::1', '/SHAHEENPUBLICHIGHSCHOOL/index.php', '', 'http://localhost/SHAHEENPUBLICHIGHSCHOOL/contact.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'h8unkai0empu9dca4f89dpnetj', '2026-01-14', '07:59:59', '2026-01-14 06:59:59'),
(68, '::1', '/SHAHEENPUBLICHIGHSCHOOL/index.php', '', 'http://localhost/SHAHEENPUBLICHIGHSCHOOL/contact.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'h8unkai0empu9dca4f89dpnetj', '2026-01-14', '08:00:29', '2026-01-14 07:00:29'),
(69, '::1', '/SHAHEENPUBLICHIGHSCHOOL/admission.php', '', 'http://localhost/SHAHEENPUBLICHIGHSCHOOL/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'h8unkai0empu9dca4f89dpnetj', '2026-01-14', '08:01:47', '2026-01-14 07:01:47'),
(70, '::1', '/SHAHEENPUBLICHIGHSCHOOL/contact.php', '', 'http://localhost/SHAHEENPUBLICHIGHSCHOOL/admission.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'h8unkai0empu9dca4f89dpnetj', '2026-01-14', '08:02:24', '2026-01-14 07:02:24'),
(71, '::1', '/SHAHEENPUBLICHIGHSCHOOL/contact.php', '', 'http://localhost/SHAHEENPUBLICHIGHSCHOOL/admission.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'h8unkai0empu9dca4f89dpnetj', '2026-01-14', '08:20:42', '2026-01-14 07:20:42'),
(72, '::1', '/SHAHEENPUBLICHIGHSCHOOL/index.php', '', 'http://localhost/SHAHEENPUBLICHIGHSCHOOL/contact.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'h8unkai0empu9dca4f89dpnetj', '2026-01-14', '08:20:50', '2026-01-14 07:20:50'),
(73, '127.0.0.1', '/SHAHEENPUBLICHIGHSCHOOL/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:146.0) Gecko/20100101 Firefox/146.0', 'Desktop', 'Firefox', 'Windows 10', NULL, NULL, '05gcre9067e2v7pejjete1vgda', '2026-01-14', '11:04:17', '2026-01-14 10:04:17'),
(74, '127.0.0.1', '/SHAHEENPUBLICHIGHSCHOOL/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:146.0) Gecko/20100101 Firefox/146.0', 'Desktop', 'Firefox', 'Windows 10', NULL, NULL, '05gcre9067e2v7pejjete1vgda', '2026-01-14', '11:04:22', '2026-01-14 10:04:22'),
(75, '127.0.0.1', '/SHAHEENPUBLICHIGHSCHOOL/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:146.0) Gecko/20100101 Firefox/146.0', 'Desktop', 'Firefox', 'Windows 10', NULL, NULL, '05gcre9067e2v7pejjete1vgda', '2026-01-14', '11:05:47', '2026-01-14 10:05:47'),
(76, '::1', '/SHAHEENPUBLICHIGHSCHOOL/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'ffppbhsphl6k15okg0hvl2dsft', '2026-01-27', '09:52:04', '2026-01-27 08:52:04'),
(77, '::1', '/SHAHEENPUBLICHIGHSCHOOL/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'ffppbhsphl6k15okg0hvl2dsft', '2026-01-27', '10:00:23', '2026-01-27 09:00:23'),
(78, '::1', '/SHAHEENPUBLICHIGHSCHOOL/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'ffppbhsphl6k15okg0hvl2dsft', '2026-01-27', '10:04:38', '2026-01-27 09:04:38'),
(79, '::1', '/SHAHEENPUBLICHIGHSCHOOL/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'ffppbhsphl6k15okg0hvl2dsft', '2026-01-27', '10:04:40', '2026-01-27 09:04:40'),
(80, '::1', '/ghzaliSwari/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'ffppbhsphl6k15okg0hvl2dsft', '2026-01-27', '10:07:15', '2026-01-27 09:07:15'),
(81, '::1', '/ghzaliSwari/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'ffppbhsphl6k15okg0hvl2dsft', '2026-01-27', '10:07:30', '2026-01-27 09:07:30'),
(82, '::1', '/ghzaliSwari/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'ffppbhsphl6k15okg0hvl2dsft', '2026-01-27', '10:07:37', '2026-01-27 09:07:37'),
(83, '::1', '/ghzaliSwari/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'ffppbhsphl6k15okg0hvl2dsft', '2026-01-27', '11:29:13', '2026-01-27 10:29:13'),
(84, '::1', '/ghzaliSwari/result.php', '', 'http://localhost/ghzaliSwari/', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'ffppbhsphl6k15okg0hvl2dsft', '2026-01-27', '11:29:18', '2026-01-27 10:29:18'),
(85, '::1', '/ghzaliSwari/result.php', '', 'http://localhost/ghzaliSwari/result.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'ffppbhsphl6k15okg0hvl2dsft', '2026-01-27', '11:29:32', '2026-01-27 10:29:32'),
(86, '::1', '/ghzaliSwari/result.php', '', 'http://localhost/ghzaliSwari/result.php?exam_id=2&registration_no=258', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'ffppbhsphl6k15okg0hvl2dsft', '2026-01-27', '11:29:51', '2026-01-27 10:29:51'),
(87, '::1', '/ghzaliSwari/result.php', '', 'http://localhost/ghzaliSwari/result.php?exam_id=&registration_no=258', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'ffppbhsphl6k15okg0hvl2dsft', '2026-01-27', '11:30:07', '2026-01-27 10:30:07'),
(88, '::1', '/ghzaliSwari/result.php', '', 'http://localhost/ghzaliSwari/result.php?exam_id=&registration_no=258', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'ffppbhsphl6k15okg0hvl2dsft', '2026-01-27', '11:33:24', '2026-01-27 10:33:24'),
(89, '::1', '/ghzaliSwari/result.php', '', 'http://localhost/ghzaliSwari/result.php?exam_id=&registration_no=258', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'ffppbhsphl6k15okg0hvl2dsft', '2026-01-27', '11:35:47', '2026-01-27 10:35:47'),
(90, '::1', '/ghzaliSwari/result.php', '', 'http://localhost/ghzaliSwari/result.php?exam_id=&registration_no=258', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'ffppbhsphl6k15okg0hvl2dsft', '2026-01-27', '11:37:18', '2026-01-27 10:37:18'),
(91, '::1', '/ghzaliSwari/result.php', '', 'http://localhost/ghzaliSwari/result.php?exam_id=&registration_no=258', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'ffppbhsphl6k15okg0hvl2dsft', '2026-01-27', '11:37:28', '2026-01-27 10:37:28'),
(92, '::1', '/ghzaliSwari/result.php', '', 'http://localhost/ghzaliSwari/result.php?exam_id=&registration_no=259', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'ffppbhsphl6k15okg0hvl2dsft', '2026-01-27', '11:38:11', '2026-01-27 10:38:11'),
(93, '::1', '/ghzaliSwari/index.php', '', 'http://localhost/ghzaliSwari/result.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'ffppbhsphl6k15okg0hvl2dsft', '2026-01-27', '11:38:29', '2026-01-27 10:38:29'),
(94, '::1', '/ghzaliSwari/result.php', '', 'http://localhost/ghzaliSwari/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'ffppbhsphl6k15okg0hvl2dsft', '2026-01-27', '11:38:50', '2026-01-27 10:38:50'),
(95, '::1', '/ghzaliSwari/result.php', '', 'http://localhost/ghzaliSwari/result.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'ffppbhsphl6k15okg0hvl2dsft', '2026-01-27', '11:43:53', '2026-01-27 10:43:53'),
(96, '::1', '/ghzaliSwari/result.php', '', 'http://localhost/ghzaliSwari/result.php?exam_id=&registration_no=258', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'ffppbhsphl6k15okg0hvl2dsft', '2026-01-27', '11:44:03', '2026-01-27 10:44:03'),
(97, '::1', '/ghzaliSwari/result.php', '', 'http://localhost/ghzaliSwari/result.php?exam_id=3&registration_no=258', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'ffppbhsphl6k15okg0hvl2dsft', '2026-01-27', '11:45:38', '2026-01-27 10:45:38'),
(98, '::1', '/ghzaliSwari/result.php', '', 'http://localhost/ghzaliSwari/result.php?exam_id=2&registration_no=258', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'ffppbhsphl6k15okg0hvl2dsft', '2026-01-27', '11:46:04', '2026-01-27 10:46:04'),
(99, '::1', '/ghzaliSwari/result.php', '', 'http://localhost/ghzaliSwari/result.php?exam_id=&registration_no=258', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'ffppbhsphl6k15okg0hvl2dsft', '2026-01-27', '11:46:14', '2026-01-27 10:46:14'),
(100, '::1', '/ghzaliSwari/result.php', '', 'http://localhost/ghzaliSwari/result.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'ffppbhsphl6k15okg0hvl2dsft', '2026-01-27', '11:46:41', '2026-01-27 10:46:41'),
(101, '::1', '/ghzaliSwari/result.php', '', 'http://localhost/ghzaliSwari/result.php?exam_id=2&registration_no=258', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'ffppbhsphl6k15okg0hvl2dsft', '2026-01-27', '11:47:01', '2026-01-27 10:47:01'),
(102, '127.0.0.1', '/ghzaliSwari/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:147.0) Gecko/20100101 Firefox/147.0', 'Desktop', 'Firefox', 'Windows 10', NULL, NULL, 'ga6dduep8slm4crmf4a8hloi57', '2026-01-28', '12:25:00', '2026-01-28 11:25:00'),
(103, '127.0.0.1', '/ghzaliSwari/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:147.0) Gecko/20100101 Firefox/147.0', 'Desktop', 'Firefox', 'Windows 10', NULL, NULL, 'n1b8e0mqhvi4muf7p90v7920vq', '2026-01-29', '10:03:24', '2026-01-29 09:03:24'),
(104, '127.0.0.1', '/ghzaliSwari/result.php', '', 'http://localhost/ghzaliSwari/', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:147.0) Gecko/20100101 Firefox/147.0', 'Desktop', 'Firefox', 'Windows 10', NULL, NULL, 'n1b8e0mqhvi4muf7p90v7920vq', '2026-01-29', '10:03:28', '2026-01-29 09:03:28'),
(105, '127.0.0.1', '/ghzaliSwari/result.php', '', 'http://localhost/ghzaliSwari/', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:147.0) Gecko/20100101 Firefox/147.0', 'Desktop', 'Firefox', 'Windows 10', NULL, NULL, 'n1b8e0mqhvi4muf7p90v7920vq', '2026-01-29', '10:10:36', '2026-01-29 09:10:36'),
(106, '127.0.0.1', '/ghzaliSwari/result.php', '', 'http://localhost/ghzaliSwari/', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:147.0) Gecko/20100101 Firefox/147.0', 'Desktop', 'Firefox', 'Windows 10', NULL, NULL, 'n1b8e0mqhvi4muf7p90v7920vq', '2026-01-29', '10:13:39', '2026-01-29 09:13:39'),
(107, '127.0.0.1', '/ghzaliSwari/result.php', '', 'http://localhost/ghzaliSwari/', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:147.0) Gecko/20100101 Firefox/147.0', 'Desktop', 'Firefox', 'Windows 10', NULL, NULL, 'n1b8e0mqhvi4muf7p90v7920vq', '2026-01-29', '10:15:00', '2026-01-29 09:15:00'),
(108, '127.0.0.1', '/ghzaliSwari/result.php', '', 'http://localhost/ghzaliSwari/', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:147.0) Gecko/20100101 Firefox/147.0', 'Desktop', 'Firefox', 'Windows 10', NULL, NULL, 'n1b8e0mqhvi4muf7p90v7920vq', '2026-01-29', '10:16:39', '2026-01-29 09:16:39'),
(109, '127.0.0.1', '/ghzaliSwari/result.php', '', 'http://localhost/ghzaliSwari/', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:147.0) Gecko/20100101 Firefox/147.0', 'Desktop', 'Firefox', 'Windows 10', NULL, NULL, 'n1b8e0mqhvi4muf7p90v7920vq', '2026-01-29', '10:20:44', '2026-01-29 09:20:44'),
(110, '127.0.0.1', '/ghzaliSwari/result.php', '', 'http://localhost/ghzaliSwari/', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:147.0) Gecko/20100101 Firefox/147.0', 'Desktop', 'Firefox', 'Windows 10', NULL, NULL, 'n1b8e0mqhvi4muf7p90v7920vq', '2026-01-29', '10:20:52', '2026-01-29 09:20:52'),
(111, '127.0.0.1', '/ghzaliSwari/result.php', '', 'http://localhost/ghzaliSwari/result.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:147.0) Gecko/20100101 Firefox/147.0', 'Desktop', 'Firefox', 'Windows 10', NULL, NULL, 'n1b8e0mqhvi4muf7p90v7920vq', '2026-01-29', '10:21:07', '2026-01-29 09:21:07'),
(112, '127.0.0.1', '/ghzaliSwari/result.php', '', 'http://localhost/ghzaliSwari/result.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:147.0) Gecko/20100101 Firefox/147.0', 'Desktop', 'Firefox', 'Windows 10', NULL, NULL, 'n1b8e0mqhvi4muf7p90v7920vq', '2026-01-29', '10:21:18', '2026-01-29 09:21:18'),
(113, '127.0.0.1', '/ghzaliSwari/result.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:147.0) Gecko/20100101 Firefox/147.0', 'Desktop', 'Firefox', 'Windows 10', NULL, NULL, 'n1b8e0mqhvi4muf7p90v7920vq', '2026-01-29', '10:21:26', '2026-01-29 09:21:26'),
(114, '127.0.0.1', '/SHAHEENPUBLICHIGHSCHOOL/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:148.0) Gecko/20100101 Firefox/148.0', 'Desktop', 'Firefox', 'Windows 10', NULL, NULL, 'r5aqkek0qd8mhki1ldm93p08pr', '2026-03-02', '08:17:22', '2026-03-02 07:17:22'),
(115, '127.0.0.1', '/SHAHEENPUBLICHIGHSCHOOL/examination.php', '', 'https://localhost/SHAHEENPUBLICHIGHSCHOOL/', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:148.0) Gecko/20100101 Firefox/148.0', 'Desktop', 'Firefox', 'Windows 10', NULL, NULL, 'r5aqkek0qd8mhki1ldm93p08pr', '2026-03-02', '08:17:33', '2026-03-02 07:17:33'),
(116, '127.0.0.1', '/ghzaliSwari/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:148.0) Gecko/20100101 Firefox/148.0', 'Desktop', 'Firefox', 'Windows 10', NULL, NULL, 'r5aqkek0qd8mhki1ldm93p08pr', '2026-03-02', '08:18:41', '2026-03-02 07:18:41'),
(117, '127.0.0.1', '/ghzaliSwari/result.php', '', 'https://localhost/ghzaliSwari/', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:148.0) Gecko/20100101 Firefox/148.0', 'Desktop', 'Firefox', 'Windows 10', NULL, NULL, 'r5aqkek0qd8mhki1ldm93p08pr', '2026-03-02', '08:18:46', '2026-03-02 07:18:46'),
(118, '::1', '/SHAHEENPUBLICHIGHSCHOOL/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'bqm074mnfg4qtcfor8sshokrl4', '2026-03-14', '11:42:10', '2026-03-14 10:42:10'),
(119, '::1', '/SHAHEENPUBLICHIGHSCHOOL/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'bqm074mnfg4qtcfor8sshokrl4', '2026-03-14', '11:42:31', '2026-03-14 10:42:31'),
(120, '::1', '/SHAHEENPUBLICHIGHSCHOOL/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'bqm074mnfg4qtcfor8sshokrl4', '2026-03-14', '11:50:25', '2026-03-14 10:50:25'),
(121, '::1', '/SHAHEENPUBLICHIGHSCHOOL/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'bqm074mnfg4qtcfor8sshokrl4', '2026-03-14', '11:50:50', '2026-03-14 10:50:50'),
(122, '::1', '/SHAHEENPUBLICHIGHSCHOOL/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'bqm074mnfg4qtcfor8sshokrl4', '2026-03-14', '12:07:09', '2026-03-14 11:07:09'),
(123, '::1', '/SHAHEENPUBLICHIGHSCHOOL/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'bqm074mnfg4qtcfor8sshokrl4', '2026-03-14', '12:08:50', '2026-03-14 11:08:50'),
(124, '::1', '/SHAHEENPUBLICHIGHSCHOOL/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'bqm074mnfg4qtcfor8sshokrl4', '2026-03-14', '12:17:16', '2026-03-14 11:17:16'),
(125, '::1', '/SHAHEENPUBLICHIGHSCHOOL/contact.php', '', 'http://localhost/SHAHEENPUBLICHIGHSCHOOL/', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'bqm074mnfg4qtcfor8sshokrl4', '2026-03-14', '12:17:22', '2026-03-14 11:17:22'),
(126, '::1', '/SHAHEENPUBLICHIGHSCHOOL/admission.php', '', 'http://localhost/SHAHEENPUBLICHIGHSCHOOL/contact.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'bqm074mnfg4qtcfor8sshokrl4', '2026-03-14', '12:17:58', '2026-03-14 11:17:58'),
(127, '::1', '/SHAHEENPUBLICHIGHSCHOOL/contact.php', '', 'http://localhost/SHAHEENPUBLICHIGHSCHOOL/admission.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'bqm074mnfg4qtcfor8sshokrl4', '2026-03-14', '12:18:42', '2026-03-14 11:18:42'),
(128, '::1', '/SHAHEENPUBLICHIGHSCHOOL/contact.php', '', 'http://localhost/SHAHEENPUBLICHIGHSCHOOL/admission.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'bqm074mnfg4qtcfor8sshokrl4', '2026-03-14', '12:23:17', '2026-03-14 11:23:17'),
(129, '::1', '/SHAHEENPUBLICHIGHSCHOOL/contact.php', '', 'http://localhost/SHAHEENPUBLICHIGHSCHOOL/admission.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'bqm074mnfg4qtcfor8sshokrl4', '2026-03-14', '12:25:22', '2026-03-14 11:25:22'),
(130, '::1', '/SHAHEENPUBLICHIGHSCHOOL/index.php', '', 'http://localhost/SHAHEENPUBLICHIGHSCHOOL/contact.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'bqm074mnfg4qtcfor8sshokrl4', '2026-03-14', '12:25:41', '2026-03-14 11:25:41'),
(131, '::1', '/SHAHEENPUBLICHIGHSCHOOL/index.php', '', 'http://localhost/SHAHEENPUBLICHIGHSCHOOL/contact.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'bqm074mnfg4qtcfor8sshokrl4', '2026-03-14', '16:53:46', '2026-03-14 15:53:46'),
(132, '::1', '/SHAHEENPUBLICHIGHSCHOOL/index.php', '', 'http://localhost/SHAHEENPUBLICHIGHSCHOOL/contact.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'bqm074mnfg4qtcfor8sshokrl4', '2026-03-14', '16:57:09', '2026-03-14 15:57:09'),
(133, '::1', '/SHAHEENPUBLICHIGHSCHOOL/about.php', '', 'http://localhost/SHAHEENPUBLICHIGHSCHOOL/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'bqm074mnfg4qtcfor8sshokrl4', '2026-03-14', '16:58:29', '2026-03-14 15:58:29'),
(134, '::1', '/SHAHEENPUBLICHIGHSCHOOL/about.php', '', 'http://localhost/SHAHEENPUBLICHIGHSCHOOL/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'bqm074mnfg4qtcfor8sshokrl4', '2026-03-14', '17:00:44', '2026-03-14 16:00:45'),
(135, '::1', '/SHAHEENPUBLICHIGHSCHOOL/about.php', '', 'http://localhost/SHAHEENPUBLICHIGHSCHOOL/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'bqm074mnfg4qtcfor8sshokrl4', '2026-03-14', '17:00:47', '2026-03-14 16:00:47'),
(136, '::1', '/SHAHEENPUBLICHIGHSCHOOL/about.php', '', 'http://localhost/SHAHEENPUBLICHIGHSCHOOL/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'bqm074mnfg4qtcfor8sshokrl4', '2026-03-14', '17:00:49', '2026-03-14 16:00:49'),
(137, '::1', '/SHAHEENPUBLICHIGHSCHOOL/courses.php', '', 'http://localhost/SHAHEENPUBLICHIGHSCHOOL/about.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'bqm074mnfg4qtcfor8sshokrl4', '2026-03-14', '17:00:58', '2026-03-14 16:00:58'),
(138, '::1', '/SHAHEENPUBLICHIGHSCHOOL/admission.php', '', 'http://localhost/SHAHEENPUBLICHIGHSCHOOL/courses.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'bqm074mnfg4qtcfor8sshokrl4', '2026-03-14', '17:01:10', '2026-03-14 16:01:10'),
(139, '::1', '/SHAHEENPUBLICHIGHSCHOOL/faculty.php', '', 'http://localhost/SHAHEENPUBLICHIGHSCHOOL/admission.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'bqm074mnfg4qtcfor8sshokrl4', '2026-03-14', '17:01:19', '2026-03-14 16:01:19'),
(140, '::1', '/SHAHEENPUBLICHIGHSCHOOL/downloads.php', '', 'http://localhost/SHAHEENPUBLICHIGHSCHOOL/faculty.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'bqm074mnfg4qtcfor8sshokrl4', '2026-03-14', '17:01:30', '2026-03-14 16:01:30'),
(141, '::1', '/SHAHEENPUBLICHIGHSCHOOL/alumni.php', '', 'http://localhost/SHAHEENPUBLICHIGHSCHOOL/downloads.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'bqm074mnfg4qtcfor8sshokrl4', '2026-03-14', '17:01:36', '2026-03-14 16:01:36'),
(142, '::1', '/SHAHEENPUBLICHIGHSCHOOL/examination.php', '', 'http://localhost/SHAHEENPUBLICHIGHSCHOOL/alumni.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'bqm074mnfg4qtcfor8sshokrl4', '2026-03-14', '17:01:43', '2026-03-14 16:01:43'),
(143, '::1', '/SHAHEENPUBLICHIGHSCHOOL/events.php', '', 'http://localhost/SHAHEENPUBLICHIGHSCHOOL/examination.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'bqm074mnfg4qtcfor8sshokrl4', '2026-03-14', '17:01:49', '2026-03-14 16:01:49'),
(144, '::1', '/SHAHEENPUBLICHIGHSCHOOL/gallery.php', '', 'http://localhost/SHAHEENPUBLICHIGHSCHOOL/events.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'bqm074mnfg4qtcfor8sshokrl4', '2026-03-14', '17:01:54', '2026-03-14 16:01:54'),
(145, '::1', '/SHAHEENPUBLICHIGHSCHOOL/contact.php', '', 'http://localhost/SHAHEENPUBLICHIGHSCHOOL/gallery.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'bqm074mnfg4qtcfor8sshokrl4', '2026-03-14', '17:01:58', '2026-03-14 16:01:58'),
(146, '::1', '/SHAHEENPUBLICHIGHSCHOOL/index.php', '', 'http://localhost/SHAHEENPUBLICHIGHSCHOOL/contact.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'bqm074mnfg4qtcfor8sshokrl4', '2026-03-14', '17:02:01', '2026-03-14 16:02:01'),
(147, '::1', '/SHAHEENPUBLICHIGHSCHOOL/index.php', '', 'http://localhost/SHAHEENPUBLICHIGHSCHOOL/contact.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'bqm074mnfg4qtcfor8sshokrl4', '2026-03-15', '11:01:22', '2026-03-15 10:01:22'),
(148, '::1', '/SHAHEENPUBLICHIGHSCHOOL/index.php', '', 'http://localhost/SHAHEENPUBLICHIGHSCHOOL/contact.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'bqm074mnfg4qtcfor8sshokrl4', '2026-03-15', '11:01:45', '2026-03-15 10:01:45'),
(149, '::1', '/SHAHEENPUBLICHIGHSCHOOL/index.php', '', 'http://localhost/SHAHEENPUBLICHIGHSCHOOL/contact.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'bqm074mnfg4qtcfor8sshokrl4', '2026-03-15', '11:03:05', '2026-03-15 10:03:05'),
(150, '::1', '/SHAHEENPUBLICHIGHSCHOOL/courses.php', '', 'http://localhost/SHAHEENPUBLICHIGHSCHOOL/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'bqm074mnfg4qtcfor8sshokrl4', '2026-03-16', '04:06:23', '2026-03-16 03:06:23'),
(151, '::1', '/SHAHEENPUBLICHIGHSCHOOL/courses.php', '', 'http://localhost/SHAHEENPUBLICHIGHSCHOOL/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'bqm074mnfg4qtcfor8sshokrl4', '2026-03-16', '04:12:53', '2026-03-16 03:12:53'),
(152, '::1', '/SHAHEENPUBLICHIGHSCHOOL/gallery.php', '', 'http://localhost/SHAHEENPUBLICHIGHSCHOOL/courses.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'bqm074mnfg4qtcfor8sshokrl4', '2026-03-16', '04:13:34', '2026-03-16 03:13:34');
INSERT INTO `website_analytics` (`id`, `visitor_ip`, `page_url`, `page_title`, `referrer`, `user_agent`, `device_type`, `browser`, `operating_system`, `country`, `city`, `session_id`, `visit_date`, `visit_time`, `created_at`) VALUES
(153, '::1', '/SHAHEENPUBLICHIGHSCHOOL/gallery.php', '', 'http://localhost/SHAHEENPUBLICHIGHSCHOOL/courses.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'bqm074mnfg4qtcfor8sshokrl4', '2026-03-16', '04:20:28', '2026-03-16 03:20:28'),
(154, '::1', '/SHAHEENPUBLICHIGHSCHOOL/gallery.php', '', 'http://localhost/SHAHEENPUBLICHIGHSCHOOL/courses.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'bqm074mnfg4qtcfor8sshokrl4', '2026-03-16', '04:21:14', '2026-03-16 03:21:14'),
(155, '::1', '/SHAHEENPUBLICHIGHSCHOOL/gallery.php', '', 'http://localhost/SHAHEENPUBLICHIGHSCHOOL/courses.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'bqm074mnfg4qtcfor8sshokrl4', '2026-03-16', '04:23:42', '2026-03-16 03:23:42'),
(156, '::1', '/SHAHEENPUBLICHIGHSCHOOL/courses.php', '', 'http://localhost/SHAHEENPUBLICHIGHSCHOOL/gallery.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'bqm074mnfg4qtcfor8sshokrl4', '2026-03-16', '04:24:14', '2026-03-16 03:24:14'),
(157, '::1', '/SHAHEENPUBLICHIGHSCHOOL/index.php', '', 'http://localhost/SHAHEENPUBLICHIGHSCHOOL/courses.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'bqm074mnfg4qtcfor8sshokrl4', '2026-03-16', '04:24:22', '2026-03-16 03:24:22'),
(158, '::1', '/SHAHEENPUBLICHIGHSCHOOL/courses.php', '', 'http://localhost/SHAHEENPUBLICHIGHSCHOOL/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'bqm074mnfg4qtcfor8sshokrl4', '2026-03-16', '04:25:26', '2026-03-16 03:25:26'),
(159, '::1', '/SHAHEENPUBLICHIGHSCHOOL/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'idkf1resvep611610l7u01tl9v', '2026-03-31', '08:38:37', '2026-03-31 06:38:37'),
(160, '::1', '/SHAHEENPUBLICHIGHSCHOOL/downloads.php', '', 'http://localhost/SHAHEENPUBLICHIGHSCHOOL/', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'idkf1resvep611610l7u01tl9v', '2026-03-31', '08:38:41', '2026-03-31 06:38:41'),
(161, '::1', '/SHAHEENPUBLICHIGHSCHOOL/downloads.php', '', 'http://localhost/SHAHEENPUBLICHIGHSCHOOL/', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'idkf1resvep611610l7u01tl9v', '2026-03-31', '08:51:49', '2026-03-31 06:51:49'),
(162, '::1', '/SHAHEENPUBLICHIGHSCHOOL/admission.php', '', 'http://localhost/SHAHEENPUBLICHIGHSCHOOL/downloads.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'idkf1resvep611610l7u01tl9v', '2026-03-31', '08:53:30', '2026-03-31 06:53:30'),
(163, '::1', '/SHAHEENPUBLICHIGHSCHOOL/admission.php', '', 'http://localhost/SHAHEENPUBLICHIGHSCHOOL/admission.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'idkf1resvep611610l7u01tl9v', '2026-03-31', '08:54:25', '2026-03-31 06:54:25'),
(164, '127.0.0.1', '/SHAHEENPUBLICHIGHSCHOOL/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:149.0) Gecko/20100101 Firefox/149.0', 'Desktop', 'Firefox', 'Windows 10', NULL, NULL, 's4tf866c02r0tk62rsku2898v6', '2026-04-06', '05:29:39', '2026-04-06 03:29:39'),
(165, '127.0.0.1', '/SHAHEENPUBLICHIGHSCHOOL/admission.php', '', 'http://localhost/SHAHEENPUBLICHIGHSCHOOL/', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:149.0) Gecko/20100101 Firefox/149.0', 'Desktop', 'Firefox', 'Windows 10', NULL, NULL, 's4tf866c02r0tk62rsku2898v6', '2026-04-06', '05:29:46', '2026-04-06 03:29:46'),
(166, '127.0.0.1', '/SHAHEENPUBLICHIGHSCHOOL/admission.php', '', 'http://localhost/SHAHEENPUBLICHIGHSCHOOL/', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:149.0) Gecko/20100101 Firefox/149.0', 'Desktop', 'Firefox', 'Windows 10', NULL, NULL, 's4tf866c02r0tk62rsku2898v6', '2026-04-06', '05:36:33', '2026-04-06 03:36:33'),
(167, '::1', '/ghzaliSwari/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'gndbq25omqgt8alesip48sibpi', '2026-05-19', '09:16:19', '2026-05-19 07:16:19'),
(168, '::1', '/SHAHEENPUBLICHIGHSCHOOL/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'gndbq25omqgt8alesip48sibpi', '2026-05-19', '09:16:44', '2026-05-19 07:16:44'),
(169, '::1', '/AimsGroupOfColleges/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'gndbq25omqgt8alesip48sibpi', '2026-05-19', '09:18:34', '2026-05-19 07:18:34'),
(170, '::1', '/AimsGroupOfColleges/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'gndbq25omqgt8alesip48sibpi', '2026-05-19', '11:01:48', '2026-05-19 09:01:48'),
(171, '::1', '/AimsGroupOfColleges/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'gndbq25omqgt8alesip48sibpi', '2026-05-19', '11:08:16', '2026-05-19 09:08:16'),
(172, '::1', '/AimsGroupOfColleges/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'gndbq25omqgt8alesip48sibpi', '2026-05-19', '11:10:07', '2026-05-19 09:10:07'),
(173, '::1', '/AimsGroupOfColleges/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'gndbq25omqgt8alesip48sibpi', '2026-05-19', '11:17:33', '2026-05-19 09:17:33'),
(174, '::1', '/AimsGroupOfColleges/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'gndbq25omqgt8alesip48sibpi', '2026-05-19', '11:22:25', '2026-05-19 09:22:25'),
(175, '::1', '/AimsGroupOfColleges/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'gndbq25omqgt8alesip48sibpi', '2026-05-19', '11:25:37', '2026-05-19 09:25:37'),
(176, '::1', '/AimsGroupOfColleges/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'gndbq25omqgt8alesip48sibpi', '2026-05-19', '11:25:48', '2026-05-19 09:25:48'),
(177, '::1', '/AimsGroupOfColleges/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'gndbq25omqgt8alesip48sibpi', '2026-05-19', '11:26:06', '2026-05-19 09:26:06'),
(178, '::1', '/AimsGroupOfColleges/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'gndbq25omqgt8alesip48sibpi', '2026-05-19', '11:26:30', '2026-05-19 09:26:30'),
(179, '::1', '/AimsGroupOfColleges/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'gndbq25omqgt8alesip48sibpi', '2026-05-19', '11:30:17', '2026-05-19 09:30:17'),
(180, '::1', '/AimsGroupOfColleges/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'gndbq25omqgt8alesip48sibpi', '2026-05-19', '11:35:45', '2026-05-19 09:35:45'),
(181, '::1', '/AimsGroupOfColleges/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'gndbq25omqgt8alesip48sibpi', '2026-05-19', '11:40:31', '2026-05-19 09:40:31'),
(182, '::1', '/AimsGroupOfColleges/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'gndbq25omqgt8alesip48sibpi', '2026-05-19', '11:47:02', '2026-05-19 09:47:02'),
(183, '::1', '/AimsGroupOfColleges/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'gndbq25omqgt8alesip48sibpi', '2026-05-19', '11:52:43', '2026-05-19 09:52:43'),
(184, '::1', '/AimsGroupOfColleges/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'gndbq25omqgt8alesip48sibpi', '2026-05-19', '12:01:02', '2026-05-19 10:01:02'),
(185, '::1', '/AimsGroupOfColleges/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'gndbq25omqgt8alesip48sibpi', '2026-05-19', '12:01:13', '2026-05-19 10:01:13'),
(186, '::1', '/AimsGroupOfColleges/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'gndbq25omqgt8alesip48sibpi', '2026-05-19', '12:09:09', '2026-05-19 10:09:09'),
(187, '::1', '/AimsGroupOfColleges/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'gndbq25omqgt8alesip48sibpi', '2026-05-19', '12:09:16', '2026-05-19 10:09:16'),
(188, '::1', '/AimsGroupOfColleges/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'gndbq25omqgt8alesip48sibpi', '2026-05-19', '12:19:26', '2026-05-19 10:19:26'),
(189, '::1', '/AimsGroupOfColleges/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'gndbq25omqgt8alesip48sibpi', '2026-05-19', '12:22:39', '2026-05-19 10:22:39'),
(190, '::1', '/AimsGroupOfColleges/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'gndbq25omqgt8alesip48sibpi', '2026-05-19', '12:25:58', '2026-05-19 10:25:58'),
(191, '::1', '/AimsGroupOfColleges/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'gndbq25omqgt8alesip48sibpi', '2026-05-19', '12:28:31', '2026-05-19 10:28:31'),
(192, '::1', '/AimsGroupOfColleges/about.php', '', 'http://localhost/AimsGroupOfColleges/', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'gndbq25omqgt8alesip48sibpi', '2026-05-19', '12:28:56', '2026-05-19 10:28:56'),
(193, '::1', '/AimsGroupOfColleges/courses.php', '', 'http://localhost/AimsGroupOfColleges/about.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'gndbq25omqgt8alesip48sibpi', '2026-05-19', '12:31:27', '2026-05-19 10:31:27'),
(194, '::1', '/AimsGroupOfColleges/admission.php', '', 'http://localhost/AimsGroupOfColleges/courses.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'gndbq25omqgt8alesip48sibpi', '2026-05-19', '12:31:42', '2026-05-19 10:31:42'),
(195, '::1', '/AimsGroupOfColleges/faculty.php', '', 'http://localhost/AimsGroupOfColleges/admission.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'gndbq25omqgt8alesip48sibpi', '2026-05-19', '12:31:52', '2026-05-19 10:31:52'),
(196, '::1', '/AimsGroupOfColleges/gallery.php', '', 'http://localhost/AimsGroupOfColleges/faculty.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'gndbq25omqgt8alesip48sibpi', '2026-05-19', '12:32:01', '2026-05-19 10:32:01'),
(197, '::1', '/AimsGroupOfColleges/contact.php', '', 'http://localhost/AimsGroupOfColleges/gallery.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'gndbq25omqgt8alesip48sibpi', '2026-05-19', '12:32:19', '2026-05-19 10:32:19'),
(198, '::1', '/AimsGroupOfColleges/about.php', '', 'http://localhost/AimsGroupOfColleges/contact.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'gndbq25omqgt8alesip48sibpi', '2026-05-19', '12:32:56', '2026-05-19 10:32:56'),
(199, '::1', '/AimsGroupOfColleges/courses.php', '', 'http://localhost/AimsGroupOfColleges/about.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'gndbq25omqgt8alesip48sibpi', '2026-05-19', '12:33:13', '2026-05-19 10:33:13'),
(200, '::1', '/AimsGroupOfColleges/admission.php', '', 'http://localhost/AimsGroupOfColleges/courses.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'gndbq25omqgt8alesip48sibpi', '2026-05-19', '12:34:02', '2026-05-19 10:34:02'),
(201, '::1', '/AimsGroupOfColleges/faculty.php', '', 'http://localhost/AimsGroupOfColleges/admission.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'gndbq25omqgt8alesip48sibpi', '2026-05-19', '12:34:17', '2026-05-19 10:34:17'),
(202, '::1', '/AimsGroupOfColleges/courses.php', '', 'http://localhost/AimsGroupOfColleges/faculty.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'gndbq25omqgt8alesip48sibpi', '2026-05-19', '12:34:27', '2026-05-19 10:34:27'),
(203, '::1', '/AimsGroupOfColleges/about.php', '', 'http://localhost/AimsGroupOfColleges/courses.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'gndbq25omqgt8alesip48sibpi', '2026-05-19', '12:38:50', '2026-05-19 10:38:50'),
(204, '::1', '/AimsGroupOfColleges/courses.php', '', 'http://localhost/AimsGroupOfColleges/about.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'gndbq25omqgt8alesip48sibpi', '2026-05-19', '12:38:58', '2026-05-19 10:38:58'),
(205, '::1', '/AimsGroupOfColleges/admission.php', '', 'http://localhost/AimsGroupOfColleges/courses.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'gndbq25omqgt8alesip48sibpi', '2026-05-19', '12:39:12', '2026-05-19 10:39:12'),
(206, '::1', '/AimsGroupOfColleges/faculty.php', '', 'http://localhost/AimsGroupOfColleges/admission.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'gndbq25omqgt8alesip48sibpi', '2026-05-19', '12:40:00', '2026-05-19 10:40:00'),
(207, '::1', '/AimsGroupOfColleges/admission.php', '', 'http://localhost/AimsGroupOfColleges/faculty.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'gndbq25omqgt8alesip48sibpi', '2026-05-19', '12:40:20', '2026-05-19 10:40:20'),
(208, '::1', '/AimsGroupOfColleges/admission.php', '', 'http://localhost/AimsGroupOfColleges/faculty.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'gndbq25omqgt8alesip48sibpi', '2026-05-19', '12:42:53', '2026-05-19 10:42:53'),
(209, '::1', '/AimsGroupOfColleges/faculty.php', '', 'http://localhost/AimsGroupOfColleges/admission.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'gndbq25omqgt8alesip48sibpi', '2026-05-19', '12:43:24', '2026-05-19 10:43:24'),
(210, '::1', '/AimsGroupOfColleges/admission.php', '', 'http://localhost/AimsGroupOfColleges/faculty.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'gndbq25omqgt8alesip48sibpi', '2026-05-19', '12:46:29', '2026-05-19 10:46:29'),
(211, '::1', '/AimsGroupOfColleges/faculty.php', '', 'http://localhost/AimsGroupOfColleges/admission.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'gndbq25omqgt8alesip48sibpi', '2026-05-19', '12:46:34', '2026-05-19 10:46:34'),
(212, '::1', '/AimsGroupOfColleges/gallery.php', '', 'http://localhost/AimsGroupOfColleges/faculty.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'gndbq25omqgt8alesip48sibpi', '2026-05-19', '12:46:56', '2026-05-19 10:46:56'),
(213, '::1', '/AimsGroupOfColleges/contact.php', '', 'http://localhost/AimsGroupOfColleges/gallery.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'gndbq25omqgt8alesip48sibpi', '2026-05-19', '12:47:02', '2026-05-19 10:47:02'),
(214, '::1', '/AimsGroupOfColleges/faculty.php', '', 'http://localhost/AimsGroupOfColleges/contact.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'gndbq25omqgt8alesip48sibpi', '2026-05-19', '12:49:22', '2026-05-19 10:49:22'),
(215, '::1', '/AimsGroupOfColleges/downloads.php', '', 'http://localhost/AimsGroupOfColleges/faculty.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'gndbq25omqgt8alesip48sibpi', '2026-05-19', '12:49:26', '2026-05-19 10:49:26'),
(216, '::1', '/AimsGroupOfColleges/alumni.php', '', 'http://localhost/AimsGroupOfColleges/downloads.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'gndbq25omqgt8alesip48sibpi', '2026-05-19', '12:49:30', '2026-05-19 10:49:30'),
(217, '::1', '/AimsGroupOfColleges/examination.php', '', 'http://localhost/AimsGroupOfColleges/alumni.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'gndbq25omqgt8alesip48sibpi', '2026-05-19', '12:49:39', '2026-05-19 10:49:39'),
(218, '::1', '/AimsGroupOfColleges/events.php', '', 'http://localhost/AimsGroupOfColleges/examination.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'gndbq25omqgt8alesip48sibpi', '2026-05-19', '12:49:43', '2026-05-19 10:49:43'),
(219, '::1', '/AimsGroupOfColleges/about.php', '', 'http://localhost/AimsGroupOfColleges/events.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'gndbq25omqgt8alesip48sibpi', '2026-05-19', '12:49:48', '2026-05-19 10:49:48'),
(220, '::1', '/AimsGroupOfColleges/contact.php', '', 'http://localhost/AimsGroupOfColleges/about.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'gndbq25omqgt8alesip48sibpi', '2026-05-19', '12:54:35', '2026-05-19 10:54:35'),
(221, '::1', '/AimsGroupOfColleges/gallery.php', '', 'http://localhost/AimsGroupOfColleges/contact.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'gndbq25omqgt8alesip48sibpi', '2026-05-19', '12:54:54', '2026-05-19 10:54:54'),
(222, '::1', '/AimsGroupOfColleges/index.php', '', 'http://localhost/AimsGroupOfColleges/gallery.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'gndbq25omqgt8alesip48sibpi', '2026-05-19', '12:56:58', '2026-05-19 10:56:58'),
(223, '::1', '/AimsGroupOfColleges/about.php', '', 'http://localhost/AimsGroupOfColleges/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'gndbq25omqgt8alesip48sibpi', '2026-05-19', '12:57:32', '2026-05-19 10:57:32'),
(224, '::1', '/AimsGroupOfColleges/courses.php', '', 'http://localhost/AimsGroupOfColleges/about.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'gndbq25omqgt8alesip48sibpi', '2026-05-19', '12:57:54', '2026-05-19 10:57:54'),
(225, '::1', '/AimsGroupOfColleges/admission.php', '', 'http://localhost/AimsGroupOfColleges/courses.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'gndbq25omqgt8alesip48sibpi', '2026-05-19', '12:58:01', '2026-05-19 10:58:01'),
(226, '::1', '/AimsGroupOfColleges/faculty.php', '', 'http://localhost/AimsGroupOfColleges/admission.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'gndbq25omqgt8alesip48sibpi', '2026-05-19', '12:58:08', '2026-05-19 10:58:08'),
(227, '::1', '/AimsGroupOfColleges/gallery.php', '', 'http://localhost/AimsGroupOfColleges/faculty.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'gndbq25omqgt8alesip48sibpi', '2026-05-19', '12:58:17', '2026-05-19 10:58:17'),
(228, '::1', '/AimsGroupOfColleges/gallery.php', '', 'http://localhost/AimsGroupOfColleges/faculty.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'gndbq25omqgt8alesip48sibpi', '2026-05-19', '12:58:54', '2026-05-19 10:58:54'),
(229, '::1', '/AimsGroupOfColleges/index.php', '', 'http://localhost/AimsGroupOfColleges/gallery.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'gndbq25omqgt8alesip48sibpi', '2026-05-19', '13:05:36', '2026-05-19 11:05:36'),
(230, '::1', '/AimsGroupOfColleges/index.php', '', 'http://localhost/AimsGroupOfColleges/gallery.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'gndbq25omqgt8alesip48sibpi', '2026-05-19', '13:06:54', '2026-05-19 11:06:54'),
(231, '::1', '/AimsGroupOfColleges/index.php', '', 'http://localhost/AimsGroupOfColleges/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'gndbq25omqgt8alesip48sibpi', '2026-05-19', '13:07:01', '2026-05-19 11:07:01'),
(232, '::1', '/AimsGroupOfColleges/index.php', '', 'http://localhost/AimsGroupOfColleges/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'gndbq25omqgt8alesip48sibpi', '2026-05-19', '13:07:02', '2026-05-19 11:07:02'),
(233, '::1', '/AimsGroupOfColleges/index.php', '', 'http://localhost/AimsGroupOfColleges/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'gndbq25omqgt8alesip48sibpi', '2026-05-19', '13:07:04', '2026-05-19 11:07:04'),
(234, '127.0.0.1', '/AimsGroupOfColleges/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:150.0) Gecko/20100101 Firefox/150.0', 'Desktop', 'Firefox', 'Windows 10', NULL, NULL, '9ojthgg0mevrc3p7ceu7n6eopu', '2026-05-20', '05:13:19', '2026-05-20 03:13:19'),
(235, '127.0.0.1', '/AimsGroupOfColleges/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:150.0) Gecko/20100101 Firefox/150.0', 'Desktop', 'Firefox', 'Windows 10', NULL, NULL, '9ojthgg0mevrc3p7ceu7n6eopu', '2026-05-20', '06:35:16', '2026-05-20 04:35:16'),
(236, '127.0.0.1', '/AimsGroupOfColleges/campuses.php', '', 'http://localhost/AimsGroupOfColleges/', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:150.0) Gecko/20100101 Firefox/150.0', 'Desktop', 'Firefox', 'Windows 10', NULL, NULL, '9ojthgg0mevrc3p7ceu7n6eopu', '2026-05-20', '06:35:41', '2026-05-20 04:35:41'),
(237, '127.0.0.1', '/AimsGroupOfColleges/index.php', '', 'http://localhost/AimsGroupOfColleges/campuses.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:150.0) Gecko/20100101 Firefox/150.0', 'Desktop', 'Firefox', 'Windows 10', NULL, NULL, '9ojthgg0mevrc3p7ceu7n6eopu', '2026-05-20', '06:35:48', '2026-05-20 04:35:48'),
(238, '127.0.0.1', '/AimsGroupOfColleges/index.php', '', 'http://localhost/AimsGroupOfColleges/campuses.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:150.0) Gecko/20100101 Firefox/150.0', 'Desktop', 'Firefox', 'Windows 10', NULL, NULL, '9ojthgg0mevrc3p7ceu7n6eopu', '2026-05-20', '06:41:33', '2026-05-20 04:41:33'),
(239, '127.0.0.1', '/AimsGroupOfColleges/campuses.php', '', 'http://localhost/AimsGroupOfColleges/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:150.0) Gecko/20100101 Firefox/150.0', 'Desktop', 'Firefox', 'Windows 10', NULL, NULL, '9ojthgg0mevrc3p7ceu7n6eopu', '2026-05-20', '06:41:39', '2026-05-20 04:41:39'),
(240, '127.0.0.1', '/AimsGroupOfColleges/index.php', '', 'http://localhost/AimsGroupOfColleges/campuses.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:150.0) Gecko/20100101 Firefox/150.0', 'Desktop', 'Firefox', 'Windows 10', NULL, NULL, '9ojthgg0mevrc3p7ceu7n6eopu', '2026-05-20', '06:41:44', '2026-05-20 04:41:44'),
(241, '::1', '/AimsGroupOfColleges/index.php', '', 'http://localhost/AimsGroupOfColleges/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'l105dtlmdm1avt98avorhahnqb', '2026-05-20', '06:45:01', '2026-05-20 04:45:01'),
(242, '127.0.0.1', '/AimsGroupOfColleges/index.php', '', 'http://localhost/AimsGroupOfColleges/campuses.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:150.0) Gecko/20100101 Firefox/150.0', 'Desktop', 'Firefox', 'Windows 10', NULL, NULL, '9ojthgg0mevrc3p7ceu7n6eopu', '2026-05-20', '07:22:32', '2026-05-20 05:22:32'),
(243, '127.0.0.1', '/AimsGroupOfColleges/index.php', '', 'http://localhost/AimsGroupOfColleges/campuses.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:150.0) Gecko/20100101 Firefox/150.0', 'Desktop', 'Firefox', 'Windows 10', NULL, NULL, '9ojthgg0mevrc3p7ceu7n6eopu', '2026-05-20', '07:32:24', '2026-05-20 05:32:24'),
(244, '127.0.0.1', '/AimsGroupOfColleges/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:150.0) Gecko/20100101 Firefox/150.0', 'Desktop', 'Firefox', 'Windows 10', NULL, NULL, 'k4ot68ir5rsd10kqb02k6jmvbb', '2026-05-20', '07:39:12', '2026-05-20 05:39:12'),
(245, '127.0.0.1', '/AimsGroupOfColleges/index.php', '', 'http://localhost/AimsGroupOfColleges/campuses.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:150.0) Gecko/20100101 Firefox/150.0', 'Desktop', 'Firefox', 'Windows 10', NULL, NULL, '9ojthgg0mevrc3p7ceu7n6eopu', '2026-05-20', '07:39:25', '2026-05-20 05:39:25'),
(246, '127.0.0.1', '/AimsGroupOfColleges/index.php', '', 'http://localhost/AimsGroupOfColleges/campuses.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:150.0) Gecko/20100101 Firefox/150.0', 'Desktop', 'Firefox', 'Windows 10', NULL, NULL, '9ojthgg0mevrc3p7ceu7n6eopu', '2026-05-20', '07:41:02', '2026-05-20 05:41:02'),
(247, '127.0.0.1', '/AimsGroupOfColleges/campus-portal.php', '', 'http://localhost/AimsGroupOfColleges/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:150.0) Gecko/20100101 Firefox/150.0', 'Desktop', 'Firefox', 'Windows 10', NULL, NULL, '9ojthgg0mevrc3p7ceu7n6eopu', '2026-05-20', '07:41:21', '2026-05-20 05:41:21'),
(248, '127.0.0.1', '/AimsGroupOfColleges/index.php', '', 'http://localhost/AimsGroupOfColleges/campus-portal.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:150.0) Gecko/20100101 Firefox/150.0', 'Desktop', 'Firefox', 'Windows 10', NULL, NULL, '9ojthgg0mevrc3p7ceu7n6eopu', '2026-05-20', '07:44:48', '2026-05-20 05:44:48'),
(249, '127.0.0.1', '/AimsGroupOfColleges/index.php', '', 'http://localhost/AimsGroupOfColleges/campus-portal.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:150.0) Gecko/20100101 Firefox/150.0', 'Desktop', 'Firefox', 'Windows 10', NULL, NULL, '9ojthgg0mevrc3p7ceu7n6eopu', '2026-05-20', '07:49:53', '2026-05-20 05:49:53'),
(250, '127.0.0.1', '/AimsGroupOfColleges/index.php', '', 'http://localhost/AimsGroupOfColleges/campus-portal.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:150.0) Gecko/20100101 Firefox/150.0', 'Desktop', 'Firefox', 'Windows 10', NULL, NULL, '9ojthgg0mevrc3p7ceu7n6eopu', '2026-05-20', '07:52:06', '2026-05-20 05:52:06'),
(251, '127.0.0.1', '/AimsGroupOfColleges/campuses.php', '', 'http://localhost/AimsGroupOfColleges/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:150.0) Gecko/20100101 Firefox/150.0', 'Desktop', 'Firefox', 'Windows 10', NULL, NULL, '9ojthgg0mevrc3p7ceu7n6eopu', '2026-05-20', '07:54:43', '2026-05-20 05:54:43'),
(252, '127.0.0.1', '/AimsGroupOfColleges/index.php', '', 'http://localhost/AimsGroupOfColleges/campuses.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:150.0) Gecko/20100101 Firefox/150.0', 'Desktop', 'Firefox', 'Windows 10', NULL, NULL, '9ojthgg0mevrc3p7ceu7n6eopu', '2026-05-20', '07:54:49', '2026-05-20 05:54:49'),
(253, '127.0.0.1', '/AimsGroupOfColleges/index.php', '', 'http://localhost/AimsGroupOfColleges/campuses.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:150.0) Gecko/20100101 Firefox/150.0', 'Desktop', 'Firefox', 'Windows 10', NULL, NULL, '9ojthgg0mevrc3p7ceu7n6eopu', '2026-05-20', '07:54:59', '2026-05-20 05:54:59'),
(254, '127.0.0.1', '/AimsGroupOfColleges/index.php', '', 'http://localhost/AimsGroupOfColleges/campuses.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:150.0) Gecko/20100101 Firefox/150.0', 'Desktop', 'Firefox', 'Windows 10', NULL, NULL, '9ojthgg0mevrc3p7ceu7n6eopu', '2026-05-20', '07:56:36', '2026-05-20 05:56:36'),
(255, '127.0.0.1', '/AimsGroupOfColleges/campus-portal.php', '', 'http://localhost/AimsGroupOfColleges/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:150.0) Gecko/20100101 Firefox/150.0', 'Desktop', 'Firefox', 'Windows 10', NULL, NULL, '9ojthgg0mevrc3p7ceu7n6eopu', '2026-05-20', '07:57:21', '2026-05-20 05:57:21'),
(256, '127.0.0.1', '/AimsGroupOfColleges/index.php', '', 'http://localhost/AimsGroupOfColleges/campus-portal.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:150.0) Gecko/20100101 Firefox/150.0', 'Desktop', 'Firefox', 'Windows 10', NULL, NULL, '9ojthgg0mevrc3p7ceu7n6eopu', '2026-05-20', '07:58:55', '2026-05-20 05:58:55'),
(257, '127.0.0.1', '/AimsGroupOfColleges/campus-portal.php', '', 'http://localhost/AimsGroupOfColleges/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:150.0) Gecko/20100101 Firefox/150.0', 'Desktop', 'Firefox', 'Windows 10', NULL, NULL, '9ojthgg0mevrc3p7ceu7n6eopu', '2026-05-20', '07:59:06', '2026-05-20 05:59:06'),
(258, '127.0.0.1', '/AimsGroupOfColleges/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:150.0) Gecko/20100101 Firefox/150.0', 'Desktop', 'Firefox', 'Windows 10', NULL, NULL, '69sc1n07dkbeanuknm10htke8n', '2026-05-20', '08:25:42', '2026-05-20 06:25:42'),
(259, '127.0.0.1', '/AimsGroupOfColleges/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:150.0) Gecko/20100101 Firefox/150.0', 'Desktop', 'Firefox', 'Windows 10', NULL, NULL, '69sc1n07dkbeanuknm10htke8n', '2026-05-20', '08:35:09', '2026-05-20 06:35:09'),
(260, '127.0.0.1', '/AimsGroupOfColleges/campus-portal.php', '', 'http://localhost/AimsGroupOfColleges/', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:150.0) Gecko/20100101 Firefox/150.0', 'Desktop', 'Firefox', 'Windows 10', NULL, NULL, '69sc1n07dkbeanuknm10htke8n', '2026-05-20', '08:35:16', '2026-05-20 06:35:16'),
(261, '127.0.0.1', '/AimsGroupOfColleges/index.php', '', 'http://localhost/AimsGroupOfColleges/campus-portal.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:150.0) Gecko/20100101 Firefox/150.0', 'Desktop', 'Firefox', 'Windows 10', NULL, NULL, '69sc1n07dkbeanuknm10htke8n', '2026-05-20', '08:35:35', '2026-05-20 06:35:35'),
(262, '::1', '/AimsGroupOfColleges/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'fsv002e0esc0pcp14407g6mgs0', '2026-05-21', '09:20:25', '2026-05-21 07:20:25'),
(263, '127.0.0.1', '/AimsGroupOfColleges/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '0qgocbogaeqlkah9gsj1sun0tp', '2026-06-08', '07:19:57', '2026-06-08 05:19:57'),
(264, '::1', '/AimsGroupOfColleges/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '0qgocbogaeqlkah9gsj1sun0tp', '2026-06-08', '07:21:28', '2026-06-08 05:21:28'),
(265, '::1', '/AimsGroupOfColleges/campus-portal.php', '', 'http://localhost/AimsGroupOfColleges/', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '0qgocbogaeqlkah9gsj1sun0tp', '2026-06-08', '07:23:20', '2026-06-08 05:23:20'),
(266, '::1', '/AimsGroupOfColleges/campus-portal.php', '', 'http://localhost/AimsGroupOfColleges/', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '0qgocbogaeqlkah9gsj1sun0tp', '2026-06-08', '07:34:36', '2026-06-08 05:34:36'),
(267, '::1', '/AimsGroupOfColleges/index.php', '', 'http://localhost/AimsGroupOfColleges/campus-portal.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '0qgocbogaeqlkah9gsj1sun0tp', '2026-06-08', '07:35:45', '2026-06-08 05:35:45'),
(268, '::1', '/AimsGroupOfColleges/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'mb3ua4k1aiblfh1hf090ephqp5', '2026-06-08', '08:10:12', '2026-06-08 06:10:12'),
(269, '::1', '/AimsGroupOfColleges/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'mb3ua4k1aiblfh1hf090ephqp5', '2026-06-08', '08:10:26', '2026-06-08 06:10:26'),
(270, '::1', '/AimsGroupOfColleges/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'mb3ua4k1aiblfh1hf090ephqp5', '2026-06-08', '08:11:29', '2026-06-08 06:11:29'),
(271, '::1', '/AimsGroupOfColleges/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'mb3ua4k1aiblfh1hf090ephqp5', '2026-06-08', '08:11:31', '2026-06-08 06:11:31'),
(272, '::1', '/AimsGroupOfColleges/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'mb3ua4k1aiblfh1hf090ephqp5', '2026-06-08', '08:12:01', '2026-06-08 06:12:01'),
(273, '::1', '/AimsGroupOfColleges/campus-portal.php', '', 'http://localhost/AimsGroupOfColleges/', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'mb3ua4k1aiblfh1hf090ephqp5', '2026-06-08', '08:12:10', '2026-06-08 06:12:10'),
(274, '::1', '/AimsGroupOfColleges/index.php', '', 'http://localhost/AimsGroupOfColleges/campus-portal.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'mb3ua4k1aiblfh1hf090ephqp5', '2026-06-08', '08:12:12', '2026-06-08 06:12:12'),
(275, '::1', '/AimsGroupOfColleges/index.php', '', 'http://localhost/AimsGroupOfColleges/campus-portal.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'mb3ua4k1aiblfh1hf090ephqp5', '2026-06-08', '08:20:19', '2026-06-08 06:20:19'),
(276, '::1', '/AimsGroupOfColleges/index.php', '', 'http://localhost/AimsGroupOfColleges/campus-portal.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'mb3ua4k1aiblfh1hf090ephqp5', '2026-06-08', '08:20:24', '2026-06-08 06:20:24'),
(277, '::1', '/AimsGroupOfColleges/index.php', '', 'http://localhost/AimsGroupOfColleges/campus-portal.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'mb3ua4k1aiblfh1hf090ephqp5', '2026-06-08', '08:20:35', '2026-06-08 06:20:35'),
(278, '::1', '/AimsGroupOfColleges/index.php', '', 'http://localhost/AimsGroupOfColleges/campus-portal.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'mb3ua4k1aiblfh1hf090ephqp5', '2026-06-08', '08:20:38', '2026-06-08 06:20:38'),
(279, '::1', '/AimsGroupOfColleges/index.php', '', 'http://localhost/AimsGroupOfColleges/campus-portal.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'mb3ua4k1aiblfh1hf090ephqp5', '2026-06-08', '08:22:19', '2026-06-08 06:22:19'),
(280, '::1', '/AimsGroupOfColleges/index.php', '', 'http://localhost/AimsGroupOfColleges/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'mb3ua4k1aiblfh1hf090ephqp5', '2026-06-08', '08:22:30', '2026-06-08 06:22:30'),
(281, '::1', '/AimsGroupOfColleges/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'df3j0s14o91vci4sai9gld39s5', '2026-07-25', '09:05:52', '2026-07-25 07:05:52'),
(282, '::1', '/ghzaliSwari/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'df3j0s14o91vci4sai9gld39s5', '2026-07-25', '09:06:34', '2026-07-25 07:06:34'),
(283, '::1', '/SHAHEENPUBLICHIGHSCHOOL/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'df3j0s14o91vci4sai9gld39s5', '2026-07-25', '09:06:56', '2026-07-25 07:06:56'),
(284, '::1', '/SHAHEENPUBLICHIGHSCHOOL/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'df3j0s14o91vci4sai9gld39s5', '2026-07-25', '09:07:00', '2026-07-25 07:07:00'),
(285, '::1', '/AimsGroupOfColleges/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'df3j0s14o91vci4sai9gld39s5', '2026-07-27', '07:30:13', '2026-07-27 05:30:13'),
(286, '::1', '/AimsGroupOfColleges/about.php', '', 'Direct', 'curl/8.15.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'rk47o3t9hjauf3qc63ufd4950n', '2026-07-27', '09:56:11', '2026-07-27 07:56:11'),
(287, '::1', '/AimsGroupOfColleges/mission-vision.php', '', 'Direct', 'curl/8.15.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'prc446hn4vgjra4o2nbcgvtvml', '2026-07-27', '09:57:58', '2026-07-27 07:57:58'),
(288, '::1', '/AimsGroupOfColleges/core-values.php', '', 'Direct', 'curl/8.15.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'fh6fbe16i3bpi5mi4kcf9tfblj', '2026-07-27', '09:59:11', '2026-07-27 07:59:11'),
(289, '::1', '/AimsGroupOfColleges/leadership.php', '', 'Direct', 'curl/8.15.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '8o31gbe9o8de36hglj2vt98kgg', '2026-07-27', '09:59:11', '2026-07-27 07:59:11'),
(290, '::1', '/AimsGroupOfColleges/leadership.php', '', 'Direct', 'curl/8.15.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '36gti1jgnlvtpdgq9b7l2vk79v', '2026-07-27', '09:59:21', '2026-07-27 07:59:21'),
(291, '::1', '/AimsGroupOfColleges/leadership.php', '', 'Direct', 'curl/8.15.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'pnll83hb9loph8pp91addmjt1l', '2026-07-27', '09:59:21', '2026-07-27 07:59:21'),
(292, '::1', '/AimsGroupOfColleges/news.php', '', 'Direct', 'curl/8.15.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'm6fq3sbcq7vskmltbui57209el', '2026-07-27', '10:00:07', '2026-07-27 08:00:07'),
(293, '::1', '/AimsGroupOfColleges/notifications.php', '', 'Direct', 'curl/8.15.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'jl38pb4kh4j4dl850601or2o2o', '2026-07-27', '10:00:41', '2026-07-27 08:00:41'),
(294, '::1', '/AimsGroupOfColleges/index.php', '', 'Direct', 'curl/8.15.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'hmia6j81rp5u7nc0en9e8eg21u', '2026-07-27', '10:05:20', '2026-07-27 08:05:20'),
(295, '::1', '/AimsGroupOfColleges/about.php', '', 'Direct', 'curl/8.15.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '2bflcihj6bnrm3sommuntkuo85', '2026-07-27', '10:05:20', '2026-07-27 08:05:20'),
(296, '::1', '/AimsGroupOfColleges/mission-vision.php', '', 'Direct', 'curl/8.15.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '64167go5n4ok8pp6pfjagkqcgd', '2026-07-27', '10:05:20', '2026-07-27 08:05:20'),
(297, '::1', '/AimsGroupOfColleges/core-values.php', '', 'Direct', 'curl/8.15.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'hjedb5h22p2ebcbqrtc8gkkols', '2026-07-27', '10:05:20', '2026-07-27 08:05:20'),
(298, '::1', '/AimsGroupOfColleges/leadership.php', '', 'Direct', 'curl/8.15.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'pbcf725a1t2h28vgp5a14s65qv', '2026-07-27', '10:05:21', '2026-07-27 08:05:21'),
(299, '::1', '/AimsGroupOfColleges/courses.php', '', 'Direct', 'curl/8.15.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'ig25097rnmq06eo48302pgue4b', '2026-07-27', '10:05:21', '2026-07-27 08:05:21'),
(300, '::1', '/AimsGroupOfColleges/faculty.php', '', 'Direct', 'curl/8.15.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'ftusouedofjsg12vult2ii6c2c', '2026-07-27', '10:05:21', '2026-07-27 08:05:21'),
(301, '::1', '/AimsGroupOfColleges/examination.php', '', 'Direct', 'curl/8.15.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'hekqcuhtubkbt1r59kjfkevvfq', '2026-07-27', '10:05:21', '2026-07-27 08:05:21'),
(302, '::1', '/AimsGroupOfColleges/admission.php', '', 'Direct', 'curl/8.15.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '7chjfcukis4j2p4k59fkkfv5fe', '2026-07-27', '10:05:21', '2026-07-27 08:05:21'),
(303, '::1', '/AimsGroupOfColleges/downloads.php', '', 'Direct', 'curl/8.15.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'f71dpadiouom3d22li8ibqrufb', '2026-07-27', '10:05:21', '2026-07-27 08:05:21'),
(304, '::1', '/AimsGroupOfColleges/notifications.php', '', 'Direct', 'curl/8.15.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'impci5lfabrdjuhds9j31e1hjj', '2026-07-27', '10:05:22', '2026-07-27 08:05:22'),
(305, '::1', '/AimsGroupOfColleges/campuses.php', '', 'Direct', 'curl/8.15.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'shil3d8jvs5lj591tks58t5cvb', '2026-07-27', '10:05:22', '2026-07-27 08:05:22'),
(306, '::1', '/AimsGroupOfColleges/campus-portal.php', '', 'Direct', 'curl/8.15.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'ic9utsgjl4ri3s969dvq34ou82', '2026-07-27', '10:05:22', '2026-07-27 08:05:22'),
(307, '::1', '/AimsGroupOfColleges/events.php', '', 'Direct', 'curl/8.15.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'vo6o0ecdood3sjse1s0a3610c3', '2026-07-27', '10:05:22', '2026-07-27 08:05:22'),
(308, '::1', '/AimsGroupOfColleges/news.php', '', 'Direct', 'curl/8.15.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '7ld4scmcilev1nnp7besrjk0ef', '2026-07-27', '10:05:22', '2026-07-27 08:05:22'),
(309, '::1', '/AimsGroupOfColleges/alumni.php', '', 'Direct', 'curl/8.15.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'fdqp42fn73crjftuk5c2to8vnc', '2026-07-27', '10:05:22', '2026-07-27 08:05:22'),
(310, '::1', '/AimsGroupOfColleges/gallery.php', '', 'Direct', 'curl/8.15.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'j11rm7ev9vjlrh0u5p6buegjbl', '2026-07-27', '10:05:22', '2026-07-27 08:05:22'),
(311, '::1', '/AimsGroupOfColleges/contact.php', '', 'Direct', 'curl/8.15.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '6pm2urkb6hha21q2binglstlpg', '2026-07-27', '10:05:23', '2026-07-27 08:05:23'),
(312, '::1', '/AimsGroupOfColleges/gallery.php', '', 'Direct', 'curl/8.15.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '84ci3dk2gq24vl1125fnid63ut', '2026-07-27', '10:06:14', '2026-07-27 08:06:14'),
(313, '::1', '/AimsGroupOfColleges/gallery.php', '', 'Direct', 'curl/8.15.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '8e1hmip16bvq8vf026gu0b565v', '2026-07-27', '10:07:19', '2026-07-27 08:07:19'),
(314, '::1', '/AimsGroupOfColleges/gallery.php', '', 'Direct', 'curl/8.15.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '05eklvds5ptd1g2s9g83vecnpl', '2026-07-27', '10:07:19', '2026-07-27 08:07:19'),
(315, '::1', '/AimsGroupOfColleges/gallery.php', '', 'Direct', 'curl/8.15.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'oujdrlhmd95ip6ngr52tksp1sp', '2026-07-27', '10:07:19', '2026-07-27 08:07:19'),
(316, '::1', '/AimsGroupOfColleges/gallery.php', '', 'Direct', 'curl/8.15.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'gqkqd9tsfahc60r7lam2euf4tg', '2026-07-27', '10:07:20', '2026-07-27 08:07:20');
INSERT INTO `website_analytics` (`id`, `visitor_ip`, `page_url`, `page_title`, `referrer`, `user_agent`, `device_type`, `browser`, `operating_system`, `country`, `city`, `session_id`, `visit_date`, `visit_time`, `created_at`) VALUES
(317, '::1', '/AimsGroupOfColleges/mission-vision.php', '', 'Direct', 'curl/8.15.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'hhrt2flsnvcdoifk6sbb3v4b4k', '2026-07-27', '10:07:20', '2026-07-27 08:07:20'),
(318, '::1', '/AimsGroupOfColleges/notifications.php', '', 'Direct', 'curl/8.15.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'hksg0k581jpm4hmg04mingfpgl', '2026-07-27', '10:07:20', '2026-07-27 08:07:20'),
(319, '::1', '/AimsGroupOfColleges/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'df3j0s14o91vci4sai9gld39s5', '2026-07-27', '10:11:11', '2026-07-27 08:11:11'),
(320, '::1', '/AimsGroupOfColleges/about.php', '', 'http://localhost/AimsGroupOfColleges/', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'df3j0s14o91vci4sai9gld39s5', '2026-07-27', '10:11:22', '2026-07-27 08:11:22'),
(321, '::1', '/AimsGroupOfColleges/mission-vision.php', '', 'http://localhost/AimsGroupOfColleges/about.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'df3j0s14o91vci4sai9gld39s5', '2026-07-27', '10:11:25', '2026-07-27 08:11:25'),
(322, '::1', '/AimsGroupOfColleges/core-values.php', '', 'http://localhost/AimsGroupOfColleges/mission-vision.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'df3j0s14o91vci4sai9gld39s5', '2026-07-27', '10:11:29', '2026-07-27 08:11:29'),
(323, '::1', '/AimsGroupOfColleges/leadership.php', '', 'http://localhost/AimsGroupOfColleges/core-values.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'df3j0s14o91vci4sai9gld39s5', '2026-07-27', '10:11:34', '2026-07-27 08:11:34'),
(324, '::1', '/AimsGroupOfColleges/courses.php', '', 'http://localhost/AimsGroupOfColleges/leadership.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'df3j0s14o91vci4sai9gld39s5', '2026-07-27', '10:11:41', '2026-07-27 08:11:41'),
(325, '::1', '/AimsGroupOfColleges/faculty.php', '', 'http://localhost/AimsGroupOfColleges/courses.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'df3j0s14o91vci4sai9gld39s5', '2026-07-27', '10:11:44', '2026-07-27 08:11:44'),
(326, '::1', '/AimsGroupOfColleges/examination.php', '', 'http://localhost/AimsGroupOfColleges/faculty.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'df3j0s14o91vci4sai9gld39s5', '2026-07-27', '10:11:49', '2026-07-27 08:11:49'),
(327, '::1', '/AimsGroupOfColleges/admission.php', '', 'http://localhost/AimsGroupOfColleges/examination.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'df3j0s14o91vci4sai9gld39s5', '2026-07-27', '10:11:53', '2026-07-27 08:11:53'),
(328, '::1', '/AimsGroupOfColleges/admission.php', '', 'http://localhost/AimsGroupOfColleges/examination.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'df3j0s14o91vci4sai9gld39s5', '2026-07-27', '10:14:03', '2026-07-27 08:14:03'),
(329, '::1', '/AimsGroupOfColleges/admission.php', '', 'http://localhost/AimsGroupOfColleges/examination.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'df3j0s14o91vci4sai9gld39s5', '2026-07-27', '10:14:07', '2026-07-27 08:14:07'),
(330, '::1', '/AimsGroupOfColleges/downloads.php', '', 'http://localhost/AimsGroupOfColleges/admission.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'df3j0s14o91vci4sai9gld39s5', '2026-07-27', '10:14:15', '2026-07-27 08:14:15'),
(331, '::1', '/AimsGroupOfColleges/index.php', '', 'http://localhost/AimsGroupOfColleges/downloads.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'df3j0s14o91vci4sai9gld39s5', '2026-07-27', '10:14:19', '2026-07-27 08:14:19'),
(332, '::1', '/AimsGroupOfColleges/index.php', '', 'Direct', 'curl/8.15.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'hci3thoo938surrdal8b9o7f6g', '2026-07-27', '10:17:16', '2026-07-27 08:17:16'),
(333, '::1', '/AimsGroupOfColleges/index.php', '', 'Direct', 'curl/8.15.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'f9psieimke0bbohad8n2nt03bh', '2026-07-27', '10:17:16', '2026-07-27 08:17:16'),
(334, '::1', '/AimsGroupOfColleges/index.php', '', 'Direct', 'curl/8.15.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'd25jbpgk2njcu54tun0dhjq2q3', '2026-07-27', '10:17:16', '2026-07-27 08:17:16'),
(335, '::1', '/AimsGroupOfColleges/index.php', '', 'Direct', 'curl/8.15.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'ic3kh7p6vogp3nont9ibmvird1', '2026-07-27', '10:17:16', '2026-07-27 08:17:16'),
(336, '::1', '/AimsGroupOfColleges/index.php', '', 'Direct', 'curl/8.15.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '6fpj1h7vko50atnqfvt372cuh7', '2026-07-27', '10:17:16', '2026-07-27 08:17:16'),
(337, '::1', '/AimsGroupOfColleges/index.php', '', 'Direct', 'curl/8.15.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'v3cit74gk23prsul4hvqu43jtk', '2026-07-27', '10:17:17', '2026-07-27 08:17:17'),
(338, '::1', '/AimsGroupOfColleges/index.php', '', 'Direct', 'curl/8.15.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'th2unoldhq41nf2b1h2m032mle', '2026-07-27', '10:17:30', '2026-07-27 08:17:30'),
(339, '::1', '/AimsGroupOfColleges/about.php', '', 'Direct', 'curl/8.15.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'rc63j3i25qc2rsm9nbr2olpa1a', '2026-07-27', '10:17:30', '2026-07-27 08:17:30'),
(340, '::1', '/AimsGroupOfColleges/core-values.php', '', 'Direct', 'curl/8.15.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '7tineb0li7hpndpdifr8goac61', '2026-07-27', '10:17:30', '2026-07-27 08:17:30'),
(341, '::1', '/AimsGroupOfColleges/mission-vision.php', '', 'Direct', 'curl/8.15.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'ul9mv2gs2ao34ski7vfjc691ol', '2026-07-27', '10:17:30', '2026-07-27 08:17:30'),
(342, '::1', '/AimsGroupOfColleges/leadership.php', '', 'Direct', 'curl/8.15.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'aci3df48lgpf40bdgm0c40ml4h', '2026-07-27', '10:17:30', '2026-07-27 08:17:30'),
(343, '::1', '/AimsGroupOfColleges/courses.php', '', 'Direct', 'curl/8.15.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'vuha86i043ae26uet2govnnjis', '2026-07-27', '10:17:30', '2026-07-27 08:17:30'),
(344, '::1', '/AimsGroupOfColleges/admission.php', '', 'Direct', 'curl/8.15.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'ftknb15vuu8o2f7do2fun5c3sn', '2026-07-27', '10:17:30', '2026-07-27 08:17:30'),
(345, '::1', '/AimsGroupOfColleges/examination.php', '', 'Direct', 'curl/8.15.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'gftaspkett7p4974dgngf5e5si', '2026-07-27', '10:17:30', '2026-07-27 08:17:30'),
(346, '::1', '/AimsGroupOfColleges/faculty.php', '', 'Direct', 'curl/8.15.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'phurh31dch51gfj5ihmf35dfu3', '2026-07-27', '10:17:30', '2026-07-27 08:17:30'),
(347, '::1', '/AimsGroupOfColleges/downloads.php', '', 'Direct', 'curl/8.15.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '0nptaqqcvhdqsi69i9aofgaird', '2026-07-27', '10:17:30', '2026-07-27 08:17:30'),
(348, '::1', '/AimsGroupOfColleges/campuses.php', '', 'Direct', 'curl/8.15.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'alf055cj1hv0i414g9cfvm4t4c', '2026-07-27', '10:17:30', '2026-07-27 08:17:30'),
(349, '::1', '/AimsGroupOfColleges/contact.php', '', 'Direct', 'curl/8.15.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '9aek9s0e237hv06uah89nhbkl1', '2026-07-27', '10:17:30', '2026-07-27 08:17:30'),
(350, '::1', '/AimsGroupOfColleges/gallery.php', '', 'Direct', 'curl/8.15.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'gfjcpovmbvp5fqlv2rbmc3rqqh', '2026-07-27', '10:17:30', '2026-07-27 08:17:30'),
(351, '::1', '/AimsGroupOfColleges/news.php', '', 'Direct', 'curl/8.15.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'edmesdq9arcqii272qm55ddb9k', '2026-07-27', '10:17:30', '2026-07-27 08:17:30'),
(352, '::1', '/AimsGroupOfColleges/notifications.php', '', 'Direct', 'curl/8.15.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '50o40j47s2o9808mtfbiuo5l7i', '2026-07-27', '10:17:30', '2026-07-27 08:17:30'),
(353, '::1', '/AimsGroupOfColleges/alumni.php', '', 'Direct', 'curl/8.15.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'ne9l9lt3miuej43is3mnc20mcp', '2026-07-27', '10:17:30', '2026-07-27 08:17:30'),
(354, '::1', '/AimsGroupOfColleges/events.php', '', 'Direct', 'curl/8.15.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'rmkeb3kn3q5topm8e5f2gaut5v', '2026-07-27', '10:17:31', '2026-07-27 08:17:31'),
(355, '::1', '/AimsGroupOfColleges/index.php', '', 'http://localhost/AimsGroupOfColleges/downloads.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'df3j0s14o91vci4sai9gld39s5', '2026-07-27', '10:17:58', '2026-07-27 08:17:58'),
(356, '::1', '/AimsGroupOfColleges/campuses.php', '', 'http://localhost/AimsGroupOfColleges/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'df3j0s14o91vci4sai9gld39s5', '2026-07-27', '10:18:04', '2026-07-27 08:18:04'),
(357, '::1', '/AimsGroupOfColleges/core-values.php', '', 'Direct', 'curl/8.15.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '01slk03unf5k03krgfe0d2b01h', '2026-07-27', '11:35:22', '2026-07-27 09:35:22'),
(358, '::1', '/AimsGroupOfColleges/core-values.php', '', 'Direct', 'curl/8.15.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '4s1oc4uhl3d92mc328n6sqeu93', '2026-07-27', '11:35:23', '2026-07-27 09:35:23'),
(359, '::1', '/AimsGroupOfColleges/core-values.php', '', 'Direct', 'curl/8.15.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'qd2bovg547fl4mapj32vaq47up', '2026-07-27', '11:35:47', '2026-07-27 09:35:47'),
(360, '::1', '/AimsGroupOfColleges/core-values.php', '', 'Direct', 'curl/8.15.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'dud8ivihnefdh56jollj4ol4m8', '2026-07-27', '11:35:47', '2026-07-27 09:35:47'),
(361, '::1', '/AimsGroupOfColleges/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36 Edg/151.0.0.0', 'Desktop', 'Edge', 'Windows 10', NULL, NULL, 'pu3tu3me8fmcpvfp2jghdjugpt', '2026-08-18', '11:12:11', '2026-08-18 09:12:11'),
(362, '::1', '/AimsGroupOfColleges/index.php', '', 'http://localhost/AimsGroupOfColleges/AdminCP/dashboard.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36 Edg/151.0.0.0', 'Desktop', 'Edge', 'Windows 10', NULL, NULL, 'pu3tu3me8fmcpvfp2jghdjugpt', '2026-08-18', '11:20:23', '2026-08-18 09:20:23'),
(363, '::1', '/AimsGroupOfColleges/index.php', '', 'http://localhost/AimsGroupOfColleges/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36 Edg/151.0.0.0', 'Desktop', 'Edge', 'Windows 10', NULL, NULL, 'pu3tu3me8fmcpvfp2jghdjugpt', '2026-08-18', '11:26:50', '2026-08-18 09:26:50'),
(364, '::1', '/AimsGroupOfColleges/index.php', '', 'Direct', 'curl/8.15.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'vs0td2jc8ekikj334jlmjdfh4s', '2026-08-18', '11:29:42', '2026-08-18 09:29:42'),
(365, '::1', '/AimsGroupOfColleges/index.php', '', 'Direct', 'curl/8.15.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'gvb4iqi86moaod09gjevpmmbnr', '2026-08-18', '11:45:42', '2026-08-18 09:45:42'),
(366, '::1', '/AimsGroupOfColleges/about.php', '', 'http://localhost/AimsGroupOfColleges/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36 Edg/151.0.0.0', 'Desktop', 'Edge', 'Windows 10', NULL, NULL, 'pu3tu3me8fmcpvfp2jghdjugpt', '2026-08-18', '11:47:12', '2026-08-18 09:47:12'),
(367, '::1', '/AimsGroupOfColleges/mission-vision.php', '', 'http://localhost/AimsGroupOfColleges/about.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36 Edg/151.0.0.0', 'Desktop', 'Edge', 'Windows 10', NULL, NULL, 'pu3tu3me8fmcpvfp2jghdjugpt', '2026-08-18', '11:47:28', '2026-08-18 09:47:28'),
(368, '::1', '/AimsGroupOfColleges/core-values.php', '', 'http://localhost/AimsGroupOfColleges/mission-vision.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36 Edg/151.0.0.0', 'Desktop', 'Edge', 'Windows 10', NULL, NULL, 'pu3tu3me8fmcpvfp2jghdjugpt', '2026-08-18', '11:47:41', '2026-08-18 09:47:41'),
(369, '::1', '/AimsGroupOfColleges/leadership.php', '', 'http://localhost/AimsGroupOfColleges/core-values.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36 Edg/151.0.0.0', 'Desktop', 'Edge', 'Windows 10', NULL, NULL, 'pu3tu3me8fmcpvfp2jghdjugpt', '2026-08-18', '11:47:55', '2026-08-18 09:47:55'),
(370, '::1', '/AimsGroupOfColleges/about.php', '', 'Direct', 'curl/8.15.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '8pf0d813s9qu7cgfl6kraliq6o', '2026-08-18', '11:52:03', '2026-08-18 09:52:03'),
(371, '::1', '/AimsGroupOfColleges/mission-vision.php', '', 'Direct', 'curl/8.15.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'coeb9gqql4rt4muj9u8elehe3d', '2026-08-18', '11:52:04', '2026-08-18 09:52:04'),
(372, '::1', '/AimsGroupOfColleges/core-values.php', '', 'Direct', 'curl/8.15.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '7rlds96bkv8qclo2vq25h6onq7', '2026-08-18', '11:52:04', '2026-08-18 09:52:04'),
(373, '::1', '/AimsGroupOfColleges/leadership.php', '', 'Direct', 'curl/8.15.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'qme6fu4pqi087v0466hg29b30h', '2026-08-18', '11:52:04', '2026-08-18 09:52:04'),
(374, '::1', '/AimsGroupOfColleges/about.php', '', 'Direct', 'curl/8.15.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'a34qvbpoq4nkkqiup51n8mkbo8', '2026-08-18', '11:52:31', '2026-08-18 09:52:31'),
(375, '::1', '/AimsGroupOfColleges/mission-vision.php', '', 'http://localhost/AimsGroupOfColleges/leadership.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36 Edg/151.0.0.0', 'Desktop', 'Edge', 'Windows 10', NULL, NULL, 'pu3tu3me8fmcpvfp2jghdjugpt', '2026-08-18', '11:54:26', '2026-08-18 09:54:26'),
(376, '::1', '/AimsGroupOfColleges/about.php', '', 'http://localhost/AimsGroupOfColleges/mission-vision.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36 Edg/151.0.0.0', 'Desktop', 'Edge', 'Windows 10', NULL, NULL, 'pu3tu3me8fmcpvfp2jghdjugpt', '2026-08-18', '11:54:31', '2026-08-18 09:54:31'),
(377, '::1', '/AimsGroupOfColleges/courses.php', '', 'http://localhost/AimsGroupOfColleges/about.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36 Edg/151.0.0.0', 'Desktop', 'Edge', 'Windows 10', NULL, NULL, 'pu3tu3me8fmcpvfp2jghdjugpt', '2026-08-18', '11:55:03', '2026-08-18 09:55:03'),
(378, '::1', '/AimsGroupOfColleges/faculty.php', '', 'http://localhost/AimsGroupOfColleges/courses.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36 Edg/151.0.0.0', 'Desktop', 'Edge', 'Windows 10', NULL, NULL, 'pu3tu3me8fmcpvfp2jghdjugpt', '2026-08-18', '11:55:14', '2026-08-18 09:55:14'),
(379, '::1', '/AimsGroupOfColleges/examination.php', '', 'http://localhost/AimsGroupOfColleges/faculty.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36 Edg/151.0.0.0', 'Desktop', 'Edge', 'Windows 10', NULL, NULL, 'pu3tu3me8fmcpvfp2jghdjugpt', '2026-08-18', '11:55:25', '2026-08-18 09:55:25'),
(380, '::1', '/AimsGroupOfColleges/courses.php', '', 'Direct', 'curl/8.15.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'ecc3c7fdcs0k8o97ve3v81bm9s', '2026-08-18', '12:07:26', '2026-08-18 10:07:26'),
(381, '::1', '/AimsGroupOfColleges/faculty.php', '', 'Direct', 'curl/8.15.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '3eabfgansasfmscroe8r09svev', '2026-08-18', '12:07:27', '2026-08-18 10:07:27'),
(382, '::1', '/AimsGroupOfColleges/examination.php', '', 'Direct', 'curl/8.15.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'sjhmuslralfpc77vfi82l1dtvk', '2026-08-18', '12:07:27', '2026-08-18 10:07:27'),
(383, '::1', '/AimsGroupOfColleges/courses.php', '', 'Direct', 'curl/8.15.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'h79nnso9ku5akfug1simmm75c5', '2026-08-18', '12:07:39', '2026-08-18 10:07:39'),
(384, '::1', '/AimsGroupOfColleges/examination.php', '', 'Direct', 'curl/8.15.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '0ip4no1mhhjada1rnrtfbh437h', '2026-08-18', '12:08:03', '2026-08-18 10:08:03'),
(385, '::1', '/AimsGroupOfColleges/admission.php', '', 'http://localhost/AimsGroupOfColleges/examination.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36 Edg/151.0.0.0', 'Desktop', 'Edge', 'Windows 10', NULL, NULL, 'pu3tu3me8fmcpvfp2jghdjugpt', '2026-08-18', '12:10:07', '2026-08-18 10:10:07'),
(386, '::1', '/AimsGroupOfColleges/downloads.php', '', 'http://localhost/AimsGroupOfColleges/admission.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36 Edg/151.0.0.0', 'Desktop', 'Edge', 'Windows 10', NULL, NULL, 'pu3tu3me8fmcpvfp2jghdjugpt', '2026-08-18', '12:10:23', '2026-08-18 10:10:23'),
(387, '::1', '/AimsGroupOfColleges/notifications.php', '', 'http://localhost/AimsGroupOfColleges/downloads.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36 Edg/151.0.0.0', 'Desktop', 'Edge', 'Windows 10', NULL, NULL, 'pu3tu3me8fmcpvfp2jghdjugpt', '2026-08-18', '12:10:32', '2026-08-18 10:10:32'),
(388, '::1', '/AimsGroupOfColleges/campus-portal.php', '', 'http://localhost/AimsGroupOfColleges/notifications.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36 Edg/151.0.0.0', 'Desktop', 'Edge', 'Windows 10', NULL, NULL, 'pu3tu3me8fmcpvfp2jghdjugpt', '2026-08-18', '12:16:18', '2026-08-18 10:16:18'),
(389, '::1', '/AimsGroupOfColleges/index.php', '', 'http://localhost/AimsGroupOfColleges/campus-portal.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36 Edg/151.0.0.0', 'Desktop', 'Edge', 'Windows 10', NULL, NULL, 'pu3tu3me8fmcpvfp2jghdjugpt', '2026-08-18', '12:16:27', '2026-08-18 10:16:27'),
(390, '::1', '/AimsGroupOfColleges/campuses.php', '', 'http://localhost/AimsGroupOfColleges/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36 Edg/151.0.0.0', 'Desktop', 'Edge', 'Windows 10', NULL, NULL, 'pu3tu3me8fmcpvfp2jghdjugpt', '2026-08-18', '12:16:31', '2026-08-18 10:16:31'),
(391, '::1', '/AimsGroupOfColleges/admission.php', '', 'Direct', 'curl/8.15.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'm1o7bdcl11an619fh771487j82', '2026-08-18', '12:17:34', '2026-08-18 10:17:34'),
(392, '::1', '/AimsGroupOfColleges/downloads.php', '', 'Direct', 'curl/8.15.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '372g97vspajmjjmtp2l868rj6g', '2026-08-18', '12:17:34', '2026-08-18 10:17:34'),
(393, '::1', '/AimsGroupOfColleges/notifications.php', '', 'Direct', 'curl/8.15.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '28icri8ipidc5h9lr2p1qdrtko', '2026-08-18', '12:17:34', '2026-08-18 10:17:34'),
(394, '::1', '/AimsGroupOfColleges/admission.php', '', 'Direct', 'curl/8.15.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'fbina1ednhd1vth0os9jurm894', '2026-08-18', '12:17:52', '2026-08-18 10:17:52'),
(395, '::1', '/AimsGroupOfColleges/campuses.php', '', 'http://localhost/AimsGroupOfColleges/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36 Edg/151.0.0.0', 'Desktop', 'Edge', 'Windows 10', NULL, NULL, 'pu3tu3me8fmcpvfp2jghdjugpt', '2026-08-18', '12:19:05', '2026-08-18 10:19:05'),
(396, '::1', '/AimsGroupOfColleges/campuses.php', '', 'Direct', 'curl/8.15.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'lpqqjota1si4mhvsm9pogvo0n4', '2026-08-18', '12:24:26', '2026-08-18 10:24:26'),
(397, '::1', '/AimsGroupOfColleges/campuses.php', '', 'Direct', 'curl/8.15.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'ngpvilu3en35fn6pcoie876r13', '2026-08-18', '12:26:25', '2026-08-18 10:26:25'),
(398, '::1', '/AimsGroupOfColleges/events.php', '', 'http://localhost/AimsGroupOfColleges/campuses.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36 Edg/151.0.0.0', 'Desktop', 'Edge', 'Windows 10', NULL, NULL, 'pu3tu3me8fmcpvfp2jghdjugpt', '2026-08-18', '12:29:38', '2026-08-18 10:29:38'),
(399, '::1', '/AimsGroupOfColleges/news.php', '', 'http://localhost/AimsGroupOfColleges/events.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36 Edg/151.0.0.0', 'Desktop', 'Edge', 'Windows 10', NULL, NULL, 'pu3tu3me8fmcpvfp2jghdjugpt', '2026-08-18', '12:29:58', '2026-08-18 10:29:58'),
(400, '::1', '/AimsGroupOfColleges/alumni.php', '', 'http://localhost/AimsGroupOfColleges/news.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36 Edg/151.0.0.0', 'Desktop', 'Edge', 'Windows 10', NULL, NULL, 'pu3tu3me8fmcpvfp2jghdjugpt', '2026-08-18', '12:30:11', '2026-08-18 10:30:11'),
(401, '::1', '/AimsGroupOfColleges/events.php', '', 'Direct', 'curl/8.15.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'guh1gfn70ehkvqoo163hf0c979', '2026-08-18', '12:34:01', '2026-08-18 10:34:01'),
(402, '::1', '/AimsGroupOfColleges/news.php', '', 'Direct', 'curl/8.15.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'sua54pkhpjubhsnk089g4utml7', '2026-08-18', '12:34:01', '2026-08-18 10:34:01'),
(403, '::1', '/AimsGroupOfColleges/alumni.php', '', 'Direct', 'curl/8.15.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'nqq7d3412a14ld7jt2n5i91dsg', '2026-08-18', '12:34:01', '2026-08-18 10:34:01'),
(404, '::1', '/AimsGroupOfColleges/news.php', '', 'Direct', 'curl/8.15.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'u14a51i44ncomk9uraeupqqpll', '2026-08-18', '12:34:12', '2026-08-18 10:34:12'),
(405, '::1', '/AimsGroupOfColleges/gallery.php', '', 'http://localhost/AimsGroupOfColleges/alumni.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36 Edg/151.0.0.0', 'Desktop', 'Edge', 'Windows 10', NULL, NULL, 'pu3tu3me8fmcpvfp2jghdjugpt', '2026-08-18', '12:38:23', '2026-08-18 10:38:23'),
(406, '::1', '/AimsGroupOfColleges/gallery.php', '', 'http://localhost/AimsGroupOfColleges/gallery.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36 Edg/151.0.0.0', 'Desktop', 'Edge', 'Windows 10', NULL, NULL, 'pu3tu3me8fmcpvfp2jghdjugpt', '2026-08-18', '12:38:37', '2026-08-18 10:38:37'),
(407, '::1', '/AimsGroupOfColleges/gallery.php', '', 'http://localhost/AimsGroupOfColleges/gallery.php?category=events', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36 Edg/151.0.0.0', 'Desktop', 'Edge', 'Windows 10', NULL, NULL, 'pu3tu3me8fmcpvfp2jghdjugpt', '2026-08-18', '12:39:02', '2026-08-18 10:39:02'),
(408, '::1', '/AimsGroupOfColleges/gallery.php', '', 'http://localhost/AimsGroupOfColleges/gallery.php?category=classes', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36 Edg/151.0.0.0', 'Desktop', 'Edge', 'Windows 10', NULL, NULL, 'pu3tu3me8fmcpvfp2jghdjugpt', '2026-08-18', '12:39:09', '2026-08-18 10:39:09'),
(409, '::1', '/AimsGroupOfColleges/gallery.php', '', 'http://localhost/AimsGroupOfColleges/gallery.php?category=activities', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36 Edg/151.0.0.0', 'Desktop', 'Edge', 'Windows 10', NULL, NULL, 'pu3tu3me8fmcpvfp2jghdjugpt', '2026-08-18', '12:39:12', '2026-08-18 10:39:12'),
(410, '::1', '/AimsGroupOfColleges/gallery.php', '', 'http://localhost/AimsGroupOfColleges/gallery.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36 Edg/151.0.0.0', 'Desktop', 'Edge', 'Windows 10', NULL, NULL, 'pu3tu3me8fmcpvfp2jghdjugpt', '2026-08-18', '12:39:14', '2026-08-18 10:39:14'),
(411, '::1', '/AimsGroupOfColleges/gallery.php', '', 'http://localhost/AimsGroupOfColleges/gallery.php?category=events', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36 Edg/151.0.0.0', 'Desktop', 'Edge', 'Windows 10', NULL, NULL, 'pu3tu3me8fmcpvfp2jghdjugpt', '2026-08-18', '12:39:34', '2026-08-18 10:39:34'),
(412, '::1', '/AimsGroupOfColleges/gallery.php', '', 'http://localhost/AimsGroupOfColleges/gallery.php?category=classes', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36 Edg/151.0.0.0', 'Desktop', 'Edge', 'Windows 10', NULL, NULL, 'pu3tu3me8fmcpvfp2jghdjugpt', '2026-08-18', '12:39:46', '2026-08-18 10:39:46'),
(413, '::1', '/AimsGroupOfColleges/gallery.php', '', 'http://localhost/AimsGroupOfColleges/gallery.php?category=activities', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36 Edg/151.0.0.0', 'Desktop', 'Edge', 'Windows 10', NULL, NULL, 'pu3tu3me8fmcpvfp2jghdjugpt', '2026-08-18', '12:39:57', '2026-08-18 10:39:57'),
(414, '::1', '/AimsGroupOfColleges/gallery.php', '', 'Direct', 'curl/8.15.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'psi3rvplrtu3dhl6dom80nrtk0', '2026-08-18', '12:41:12', '2026-08-18 10:41:12'),
(415, '::1', '/AimsGroupOfColleges/gallery.php', '', 'Direct', 'curl/8.15.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'ov64j6pk1o2u8akrsnu36gm5n9', '2026-08-18', '12:41:12', '2026-08-18 10:41:12'),
(416, '::1', '/AimsGroupOfColleges/contact.php', '', 'http://localhost/AimsGroupOfColleges/gallery.php?category=achievements', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36 Edg/151.0.0.0', 'Desktop', 'Edge', 'Windows 10', NULL, NULL, 'pu3tu3me8fmcpvfp2jghdjugpt', '2026-08-18', '12:41:45', '2026-08-18 10:41:45'),
(417, '::1', '/AimsGroupOfColleges/campuses.php', '', 'http://localhost/AimsGroupOfColleges/contact.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36 Edg/151.0.0.0', 'Desktop', 'Edge', 'Windows 10', NULL, NULL, 'pu3tu3me8fmcpvfp2jghdjugpt', '2026-08-18', '12:42:26', '2026-08-18 10:42:26'),
(418, '::1', '/AimsGroupOfColleges/contact.php', '', 'Direct', 'curl/8.15.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'hdb0psteuukq8458d3pun2abvh', '2026-08-18', '12:50:28', '2026-08-18 10:50:28'),
(419, '::1', '/AimsGroupOfColleges/campuses.php', '', 'Direct', 'curl/8.15.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '3bfd1upjsj5b0oi1ghl3337qa9', '2026-08-18', '12:50:28', '2026-08-18 10:50:28'),
(420, '::1', '/AimsGroupOfColleges/contact.php', '', 'Direct', 'curl/8.15.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'tcatjrkoi3lvojmaiuuc2sd986', '2026-08-18', '12:51:02', '2026-08-18 10:51:02'),
(421, '::1', '/AimsGroupOfColleges/contact.php', '', 'Direct', 'curl/8.15.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'c0ju1nfrasghvqp2v0qg0grqag', '2026-08-18', '12:51:15', '2026-08-18 10:51:15'),
(422, '::1', '/AimsGroupOfColleges/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'rnttge7rlsg1gijce2ne831ivm', '2026-08-20', '13:28:53', '2026-08-20 11:28:53'),
(423, '::1', '/AimsGroupOfColleges/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'rnttge7rlsg1gijce2ne831ivm', '2026-08-20', '13:28:59', '2026-08-20 11:28:59'),
(424, '::1', '/AimsGroupOfColleges/index.php', '', 'Direct', 'curl/8.15.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'rfsakn7efgvo9sftq9r2nbo1sn', '2026-08-20', '13:44:20', '2026-08-20 11:44:20'),
(425, '::1', '/AimsGroupOfColleges/index.php', '', 'Direct', 'curl/8.15.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'rkrfbpmnedvv3idfhjj8kff1mg', '2026-08-20', '13:44:29', '2026-08-20 11:44:29'),
(426, '::1', '/AimsGroupOfColleges/index.php', '', 'Direct', 'curl/8.15.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'v53iav7ot5g8li8j762404ejlq', '2026-08-20', '13:44:40', '2026-08-20 11:44:40'),
(427, '::1', '/AimsGroupOfColleges/index.php', '', 'Direct', 'curl/8.15.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'cijdrpnv2lg615mrp3fp7qola9', '2026-08-20', '13:45:25', '2026-08-20 11:45:25'),
(428, '::1', '/AimsGroupOfColleges/index.php', '', 'Direct', 'curl/8.15.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'l2h7k22gs2m1mmdamdf5me05ku', '2026-08-20', '13:45:31', '2026-08-20 11:45:31'),
(429, '::1', '/AimsGroupOfColleges/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'aa3bpdinsgv6dqu05p317fhl0a', '2026-08-21', '12:24:34', '2026-08-21 10:24:34'),
(430, '::1', '/AimsGroupOfColleges/about.php', '', 'http://localhost/AimsGroupOfColleges/', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'aa3bpdinsgv6dqu05p317fhl0a', '2026-08-21', '12:27:33', '2026-08-21 10:27:33'),
(431, '::1', '/AimsGroupOfColleges/about.php', '', 'Direct', 'curl/8.15.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'us39m15vnt1mde3j3d3p51st2f', '2026-08-21', '12:45:27', '2026-08-21 10:45:27'),
(432, '::1', '/AimsGroupOfColleges/about.php', '', 'Direct', 'curl/8.15.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'dp9jktkksoj6cc9cinkeaer8ss', '2026-08-21', '12:45:40', '2026-08-21 10:45:40'),
(433, '::1', '/AimsGroupOfColleges/about.php', '', 'Direct', 'curl/8.15.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'l70jrro8h2hk71t4u3i74d4gao', '2026-08-21', '12:45:40', '2026-08-21 10:45:40'),
(434, '::1', '/AimsGroupOfColleges/about.php', '', 'Direct', 'curl/8.15.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'tfoftnjhq6l1ud1nhjka0lqdb4', '2026-08-21', '13:11:10', '2026-08-21 11:11:10'),
(435, '::1', '/AimsGroupOfColleges/about.php', '', 'Direct', 'curl/8.15.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'fccuc519ne7gm7t7cq09ebt2tc', '2026-08-21', '13:11:17', '2026-08-21 11:11:17'),
(436, '::1', '/AimsGroupOfColleges/about.php', '', 'Direct', 'curl/8.15.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '8bot9pka0222tnj881405b52is', '2026-08-21', '13:11:17', '2026-08-21 11:11:17'),
(437, '::1', '/AimsGroupOfColleges/courses.php', '', 'Direct', 'curl/8.15.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '3k70vfs8p986j02n2sdfrep39p', '2026-08-21', '13:24:20', '2026-08-21 11:24:20'),
(438, '::1', '/AimsGroupOfColleges/faculty.php', '', 'Direct', 'curl/8.15.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'kccvevm92ldri54nkp92t8bnep', '2026-08-21', '13:24:20', '2026-08-21 11:24:20'),
(439, '::1', '/AimsGroupOfColleges/examination.php', '', 'Direct', 'curl/8.15.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '2jptcl78edjdtcm1u5hqou2erm', '2026-08-21', '13:24:21', '2026-08-21 11:24:21'),
(440, '::1', '/AimsGroupOfColleges/courses.php', '', 'Direct', 'curl/8.15.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'q9ijae71on09irm183oelm5qt5', '2026-08-21', '13:29:26', '2026-08-21 11:29:26'),
(441, '::1', '/AimsGroupOfColleges/faculty.php', '', 'Direct', 'curl/8.15.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'qsjt0tr3g4vrapl8muh1bb4rje', '2026-08-21', '13:29:26', '2026-08-21 11:29:26'),
(442, '::1', '/AimsGroupOfColleges/examination.php', '', 'Direct', 'curl/8.15.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '0vsj4ht8ciru14jadk71hs0le1', '2026-08-21', '13:29:27', '2026-08-21 11:29:27'),
(443, '::1', '/AimsGroupOfColleges/courses.php', '', 'Direct', 'curl/8.15.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'gu2tabnecjg2ksqo37evrhbi35', '2026-08-21', '13:29:37', '2026-08-21 11:29:37'),
(444, '::1', '/AimsGroupOfColleges/faculty.php', '', 'Direct', 'curl/8.15.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'bn8vsf27o48i19eb1vmufd20vc', '2026-08-21', '13:29:38', '2026-08-21 11:29:38'),
(445, '::1', '/AimsGroupOfColleges/examination.php', '', 'Direct', 'curl/8.15.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'mjb5q61kjuhlsuqufle94ncp5h', '2026-08-21', '13:29:39', '2026-08-21 11:29:39'),
(446, '::1', '/AimsGroupOfColleges/courses.php', '', 'Direct', 'curl/8.15.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'a1fdteb3aru95843gra0hg118u', '2026-08-21', '13:29:40', '2026-08-21 11:29:40'),
(447, '::1', '/AimsGroupOfColleges/faculty.php', '', 'Direct', 'curl/8.15.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'bgb39n3nviqk4m0ga0c5egpjl6', '2026-08-21', '13:29:46', '2026-08-21 11:29:46'),
(448, '::1', '/AimsGroupOfColleges/examination.php', '', 'Direct', 'curl/8.15.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'a84dd3nhf1g6ikjt8dbju8gm58', '2026-08-21', '13:29:47', '2026-08-21 11:29:47'),
(449, '::1', '/AimsGroupOfColleges/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '03nbnf85sis9vmescqqmr6cum4', '2026-08-24', '11:18:58', '2026-08-24 09:18:58'),
(450, '::1', '/bahawalcollegeofhealth/index.php', '', 'http://localhost/', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'f9c9tfn35t60e7hiv64q7d0boa', '2026-09-02', '09:47:51', '2026-09-02 07:47:51'),
(451, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'gkbti10s71t73v8v3ubscbi3l9', '2026-09-02', '10:20:47', '2026-09-02 08:20:47'),
(452, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'rvtr3dniec9v2m8uh6tp4f10fb', '2026-09-02', '10:23:57', '2026-09-02 08:23:57'),
(453, '::1', '/bahawalcollegeofhealth/about.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'pm0jvh52gfnl7p3hb8k7kchv7i', '2026-09-02', '10:24:16', '2026-09-02 08:24:16'),
(454, '::1', '/bahawalcollegeofhealth/contact.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '0ua0uhmvo2frrv2egjkt6jv3vn', '2026-09-02', '10:24:28', '2026-09-02 08:24:28'),
(455, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'qa5tsfjf8s8mkjugk9ee0o6ejo', '2026-09-02', '10:26:38', '2026-09-02 08:26:38'),
(456, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'ovg82ul6sh8ncsc17f2782fs0k', '2026-09-02', '10:27:06', '2026-09-02 08:27:06'),
(457, '::1', '/bahawalcollegeofhealth/contact.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'f2gtjt3dseo4apor6ul0ne4578', '2026-09-02', '10:27:27', '2026-09-02 08:27:27'),
(458, '::1', '/bahawalcollegeofhealth/contact.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 's1623givdm83cuiecqa7hnaa6g', '2026-09-02', '10:30:08', '2026-09-02 08:30:08'),
(459, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'lmnmdlf6qdng89qtfcsk2v4fmd', '2026-09-02', '10:32:43', '2026-09-02 08:32:43'),
(460, '::1', '/bahawalcollegeofhealth/about.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'g2hlhsfpq0ernpcj2kj65e3a21', '2026-09-02', '10:32:51', '2026-09-02 08:32:51'),
(461, '::1', '/bahawalcollegeofhealth/contact.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'gmfnhomjc2e91vebe9u2n2lcg6', '2026-09-02', '10:32:57', '2026-09-02 08:32:57'),
(462, '::1', '/bahawalcollegeofhealth/index.php', '', 'http://localhost/', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'f9c9tfn35t60e7hiv64q7d0boa', '2026-09-02', '10:41:51', '2026-09-02 08:41:51'),
(463, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'f9c9tfn35t60e7hiv64q7d0boa', '2026-09-02', '10:42:28', '2026-09-02 08:42:28'),
(464, '::1', '/bahawalcollegeofhealth/campus-portal.php', '', 'http://localhost/bahawalcollegeofhealth/', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'f9c9tfn35t60e7hiv64q7d0boa', '2026-09-02', '10:42:45', '2026-09-02 08:42:45'),
(465, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '8vl5d7940tv5k5n8uq8m25t1v2', '2026-09-02', '10:42:48', '2026-09-02 08:42:48'),
(466, '::1', '/bahawalcollegeofhealth/index.php', '', 'http://localhost/bahawalcollegeofhealth/campus-portal.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'f9c9tfn35t60e7hiv64q7d0boa', '2026-09-02', '10:42:57', '2026-09-02 08:42:57'),
(467, '::1', '/bahawalcollegeofhealth/about.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '1qpitq650i4f1edvh7rb276igr', '2026-09-02', '10:42:59', '2026-09-02 08:42:59'),
(468, '::1', '/bahawalcollegeofhealth/courses.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'sc2s50bas67alhl7a6gf6109bm', '2026-09-02', '10:43:08', '2026-09-02 08:43:08'),
(469, '::1', '/bahawalcollegeofhealth/admission.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'sebknp7blroq8ibhhemvpfhe03', '2026-09-02', '10:43:17', '2026-09-02 08:43:17'),
(470, '::1', '/bahawalcollegeofhealth/contact.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'lp7g5nanlglmcki5sae0g5a9rh', '2026-09-02', '10:43:20', '2026-09-02 08:43:20'),
(471, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '9fqrafm23dnp4gdi5ak7mqrpld', '2026-09-02', '10:43:25', '2026-09-02 08:43:25'),
(472, '::1', '/bahawalcollegeofhealth/events.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '1mb1auj4q4osfmoft3qbusg2p3', '2026-09-02', '10:43:28', '2026-09-02 08:43:28'),
(473, '::1', '/bahawalcollegeofhealth/news.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'tlchblk46ccassfap9s9hqkdkp', '2026-09-02', '10:43:31', '2026-09-02 08:43:31'),
(474, '::1', '/bahawalcollegeofhealth/gallery.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'u7oqibli1bf3i34mo8miskiq6i', '2026-09-02', '10:43:33', '2026-09-02 08:43:33'),
(475, '::1', '/bahawalcollegeofhealth/leadership.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'un6hgt07nppbg7ua6pfinldhvf', '2026-09-02', '10:43:38', '2026-09-02 08:43:38'),
(476, '::1', '/bahawalcollegeofhealth/mission-vision.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '7krbtdubrd1ljcrfk1g2f1que1', '2026-09-02', '10:43:47', '2026-09-02 08:43:47'),
(477, '::1', '/bahawalcollegeofhealth/core-values.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'nr8kh3hv0u8c78e6d2i696oeje', '2026-09-02', '10:43:54', '2026-09-02 08:43:54'),
(478, '::1', '/bahawalcollegeofhealth/campuses.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'pm1mnmdv5d34rpap4024p4dvnn', '2026-09-02', '10:43:59', '2026-09-02 08:43:59'),
(479, '::1', '/bahawalcollegeofhealth/campus-portal.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'f12k82d3sq2ggeeov5c1r5ht2p', '2026-09-02', '10:44:05', '2026-09-02 08:44:05'),
(480, '::1', '/bahawalcollegeofhealth/alumni.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '0qlh10qmrce330savvmna63146', '2026-09-02', '10:44:13', '2026-09-02 08:44:13'),
(481, '::1', '/bahawalcollegeofhealth/examination.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '04b1b2dpp3g64v46cjcu157k2q', '2026-09-02', '10:44:21', '2026-09-02 08:44:21'),
(482, '::1', '/bahawalcollegeofhealth/downloads.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'kbccas37kqohab4i9g58854dic', '2026-09-02', '10:44:29', '2026-09-02 08:44:29'),
(483, '::1', '/bahawalcollegeofhealth/notifications.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'dg4pamfdpeef9rd7tc4sessjhf', '2026-09-02', '10:44:38', '2026-09-02 08:44:38'),
(484, '::1', '/bahawalcollegeofhealth/index.php', '', 'http://localhost/bahawalcollegeofhealth/campus-portal.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'f9c9tfn35t60e7hiv64q7d0boa', '2026-09-02', '11:03:37', '2026-09-02 09:03:37'),
(485, '::1', '/bahawalcollegeofhealth/index.php', '', 'http://localhost/bahawalcollegeofhealth/campus-portal.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'f9c9tfn35t60e7hiv64q7d0boa', '2026-09-02', '11:03:40', '2026-09-02 09:03:40'),
(486, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'iur80q7ujg7spqn3o2cg11kj6q', '2026-09-02', '11:09:01', '2026-09-02 09:09:01'),
(487, '::1', '/bahawalcollegeofhealth/gallery.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'tc4fkm50c821itbe43pn3gh2c1', '2026-09-02', '11:32:04', '2026-09-02 09:32:04'),
(488, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'vu69qc0rrfai46fj77k8eeso96', '2026-09-02', '11:34:26', '2026-09-02 09:34:27'),
(489, '::1', '/bahawalcollegeofhealth/about.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'svkcg5qki66kdumm3nsnbantin', '2026-09-02', '11:34:36', '2026-09-02 09:34:36'),
(490, '::1', '/bahawalcollegeofhealth/courses.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'la6tq2qdndcj9e5b44vl4d67fb', '2026-09-02', '11:34:41', '2026-09-02 09:34:41'),
(491, '::1', '/bahawalcollegeofhealth/admission.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'csq2fb0h6qiuruhtq11m9l8mul', '2026-09-02', '11:34:44', '2026-09-02 09:34:44'),
(492, '::1', '/bahawalcollegeofhealth/contact.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'f8kighdsn9d4rf9k92qsuq1noe', '2026-09-02', '11:34:47', '2026-09-02 09:34:47'),
(493, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '3o6g75tne6cuc7tptfrg4lirjt', '2026-09-02', '11:34:54', '2026-09-02 09:34:54'),
(494, '::1', '/bahawalcollegeofhealth/events.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'iitiqdp0tke3o7uv7pfbdm568i', '2026-09-02', '11:35:02', '2026-09-02 09:35:02'),
(495, '::1', '/bahawalcollegeofhealth/news.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '202ne803j1h0ii33n2o02tabdr', '2026-09-02', '11:35:06', '2026-09-02 09:35:06');
INSERT INTO `website_analytics` (`id`, `visitor_ip`, `page_url`, `page_title`, `referrer`, `user_agent`, `device_type`, `browser`, `operating_system`, `country`, `city`, `session_id`, `visit_date`, `visit_time`, `created_at`) VALUES
(496, '::1', '/bahawalcollegeofhealth/gallery.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '1r4sqjdvpra7amreetkdiehs06', '2026-09-02', '11:35:10', '2026-09-02 09:35:10'),
(497, '::1', '/bahawalcollegeofhealth/leadership.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'l0rba3ld0hjhj5h9ssifimce3a', '2026-09-02', '11:35:14', '2026-09-02 09:35:14'),
(498, '::1', '/bahawalcollegeofhealth/mission-vision.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'hecaqpc58ml23qblgdo48nb8g5', '2026-09-02', '11:35:18', '2026-09-02 09:35:18'),
(499, '::1', '/bahawalcollegeofhealth/core-values.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'kfp7b1il8rh9hlp4gsce4dfvdk', '2026-09-02', '11:35:25', '2026-09-02 09:35:25'),
(500, '::1', '/bahawalcollegeofhealth/campuses.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '5nikf7nr89c4c3b15o1pud38r8', '2026-09-02', '11:35:33', '2026-09-02 09:35:33'),
(501, '::1', '/bahawalcollegeofhealth/campus-portal.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'kapmc1r4qe1ftjdg8athbe04ag', '2026-09-02', '11:35:39', '2026-09-02 09:35:39'),
(502, '::1', '/bahawalcollegeofhealth/alumni.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'rme9g0opbptkuejlh7bc2299tj', '2026-09-02', '11:35:45', '2026-09-02 09:35:45'),
(503, '::1', '/bahawalcollegeofhealth/examination.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'drootjmbkm49o8erk33j0csvkd', '2026-09-02', '11:35:50', '2026-09-02 09:35:50'),
(504, '::1', '/bahawalcollegeofhealth/downloads.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'rb42gab736sesgmcth5ta9e8hr', '2026-09-02', '11:35:54', '2026-09-02 09:35:54'),
(505, '::1', '/bahawalcollegeofhealth/notifications.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'celke0qm2ci5r5gian7j8s7odo', '2026-09-02', '11:36:00', '2026-09-02 09:36:00'),
(506, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'iur80q7ujg7spqn3o2cg11kj6q', '2026-09-02', '12:02:11', '2026-09-02 10:02:11'),
(507, '::1', '/bahawalcollegeofhealth/gallery.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '4pqtr9q02lt75hjhf41po2qeb2', '2026-09-02', '12:03:19', '2026-09-02 10:03:19'),
(508, '::1', '/bahawalcollegeofhealth/gallery.php', '', 'http://localhost/bahawalcollegeofhealth/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'iur80q7ujg7spqn3o2cg11kj6q', '2026-09-02', '12:08:15', '2026-09-02 10:08:15'),
(509, '::1', '/bahawalcollegeofhealth/gallery.php', '', 'http://localhost/bahawalcollegeofhealth/gallery.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'iur80q7ujg7spqn3o2cg11kj6q', '2026-09-02', '12:08:30', '2026-09-02 10:08:30'),
(510, '::1', '/bahawalcollegeofhealth/gallery.php', '', 'http://localhost/bahawalcollegeofhealth/gallery.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'iur80q7ujg7spqn3o2cg11kj6q', '2026-09-02', '12:14:44', '2026-09-02 10:14:44'),
(511, '::1', '/bahawalcollegeofhealth/gallery.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'rlgkcdhhqherbn5gjjl81v4l1r', '2026-09-02', '12:20:38', '2026-09-02 10:20:38'),
(512, '::1', '/bahawalcollegeofhealth/gallery.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'q4um6juduahjge7brqcr4lhvma', '2026-09-02', '12:20:49', '2026-09-02 10:20:49'),
(513, '::1', '/bahawalcollegeofhealth/gallery.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'm0h0leuqgnvnkfa6jgmqun2klh', '2026-09-02', '12:23:47', '2026-09-02 10:23:47'),
(514, '::1', '/bahawalcollegeofhealth/gallery.php', '', 'http://localhost/bahawalcollegeofhealth/gallery.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'iur80q7ujg7spqn3o2cg11kj6q', '2026-09-02', '12:24:54', '2026-09-02 10:24:54'),
(515, '::1', '/bahawalcollegeofhealth/campus-portal.php', '', 'http://localhost/bahawalcollegeofhealth/gallery.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'iur80q7ujg7spqn3o2cg11kj6q', '2026-09-02', '12:24:58', '2026-09-02 10:24:58'),
(516, '::1', '/bahawalcollegeofhealth/index.php', '', 'http://localhost/bahawalcollegeofhealth/gallery.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'iur80q7ujg7spqn3o2cg11kj6q', '2026-09-02', '12:27:49', '2026-09-02 10:27:49'),
(517, '::1', '/bahawalcollegeofhealth/gallery.php', '', 'http://localhost/bahawalcollegeofhealth/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'iur80q7ujg7spqn3o2cg11kj6q', '2026-09-02', '12:27:55', '2026-09-02 10:27:55'),
(518, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'glqbjh1prnrgrfg0m1e0ica7v8', '2026-09-02', '12:28:55', '2026-09-02 10:28:55'),
(519, '::1', '/bahawalcollegeofhealth/gallery.php', '', 'http://localhost/bahawalcollegeofhealth/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'glqbjh1prnrgrfg0m1e0ica7v8', '2026-09-02', '12:29:01', '2026-09-02 10:29:01'),
(520, '::1', '/bahawalcollegeofhealth/gallery.php', '', 'http://localhost/bahawalcollegeofhealth/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'iur80q7ujg7spqn3o2cg11kj6q', '2026-09-02', '12:29:56', '2026-09-02 10:29:56'),
(521, '::1', '/bahawalcollegeofhealth/gallery.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'djctvthfephdq34rk2j654ie4b', '2026-09-02', '12:32:20', '2026-09-02 10:32:20'),
(522, '::1', '/bahawalcollegeofhealth/gallery.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'jdkdl5glqt6ipunbcblm94tdh0', '2026-09-02', '12:32:28', '2026-09-02 10:32:28'),
(523, '::1', '/bahawalcollegeofhealth/gallery.php', '', 'http://localhost/bahawalcollegeofhealth/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'iur80q7ujg7spqn3o2cg11kj6q', '2026-09-02', '12:32:43', '2026-09-02 10:32:43'),
(524, '::1', '/bahawalcollegeofhealth/gallery.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '4qimhb8h3fgm396b06r0f52516', '2026-09-02', '12:33:11', '2026-09-02 10:33:11'),
(525, '::1', '/bahawalcollegeofhealth/index.php', '', 'http://localhost/bahawalcollegeofhealth/gallery.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'iur80q7ujg7spqn3o2cg11kj6q', '2026-09-02', '12:33:12', '2026-09-02 10:33:12'),
(526, '::1', '/bahawalcollegeofhealth/index.php', '', 'http://localhost/bahawalcollegeofhealth/gallery.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'iur80q7ujg7spqn3o2cg11kj6q', '2026-09-02', '12:35:55', '2026-09-02 10:35:55'),
(527, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'brq8ldqdi609qicd5balmb8dhu', '2026-09-02', '12:36:43', '2026-09-02 10:36:43'),
(528, '::1', '/bahawalcollegeofhealth/about.php', '', 'http://localhost/bahawalcollegeofhealth/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'iur80q7ujg7spqn3o2cg11kj6q', '2026-09-02', '12:36:52', '2026-09-02 10:36:53'),
(529, '::1', '/bahawalcollegeofhealth/index.php', '', 'http://localhost/bahawalcollegeofhealth/about.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'iur80q7ujg7spqn3o2cg11kj6q', '2026-09-02', '12:37:07', '2026-09-02 10:37:07'),
(530, '::1', '/bahawalcollegeofhealth/campuses.php', '', 'http://localhost/bahawalcollegeofhealth/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'iur80q7ujg7spqn3o2cg11kj6q', '2026-09-02', '12:37:12', '2026-09-02 10:37:12'),
(531, '::1', '/bahawalcollegeofhealth/campuses.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'iur80q7ujg7spqn3o2cg11kj6q', '2026-09-02', '12:39:54', '2026-09-02 10:39:54'),
(532, '::1', '/bahawalcollegeofhealth/campuses.php', '', 'http://localhost/bahawalcollegeofhealth/campuses.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'iur80q7ujg7spqn3o2cg11kj6q', '2026-09-02', '12:40:06', '2026-09-02 10:40:06'),
(533, '::1', '/bahawalcollegeofhealth/campus-portal.php', '', 'http://localhost/bahawalcollegeofhealth/campuses.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'iur80q7ujg7spqn3o2cg11kj6q', '2026-09-02', '12:40:10', '2026-09-02 10:40:10'),
(534, '::1', '/bahawalcollegeofhealth/campuses.php', '', 'http://localhost/bahawalcollegeofhealth/campus-portal.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'iur80q7ujg7spqn3o2cg11kj6q', '2026-09-02', '12:40:14', '2026-09-02 10:40:14'),
(535, '::1', '/bahawalcollegeofhealth/courses.php', '', 'http://localhost/bahawalcollegeofhealth/campuses.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'iur80q7ujg7spqn3o2cg11kj6q', '2026-09-02', '12:42:59', '2026-09-02 10:42:59'),
(536, '::1', '/bahawalcollegeofhealth/about.php', '', 'http://localhost/bahawalcollegeofhealth/courses.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'iur80q7ujg7spqn3o2cg11kj6q', '2026-09-02', '12:43:17', '2026-09-02 10:43:17'),
(537, '::1', '/bahawalcollegeofhealth/alumni.php', '', 'http://localhost/bahawalcollegeofhealth/about.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'iur80q7ujg7spqn3o2cg11kj6q', '2026-09-02', '12:43:42', '2026-09-02 10:43:42'),
(538, '::1', '/bahawalcollegeofhealth/campuses.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'tga56mc6toet3o10v64398hpi1', '2026-09-02', '12:43:59', '2026-09-02 10:43:59'),
(539, '::1', '/bahawalcollegeofhealth/alumni.php', '', 'http://localhost/bahawalcollegeofhealth/about.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'iur80q7ujg7spqn3o2cg11kj6q', '2026-09-02', '12:48:50', '2026-09-02 10:48:50'),
(540, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'pf1durq8i6bvpt9vvi8hs3v8km', '2026-09-02', '12:57:15', '2026-09-02 10:57:15'),
(541, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'gtb1dhma00ffah2mukldkf4sdi', '2026-09-02', '12:58:14', '2026-09-02 10:58:14'),
(542, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '6qletmriuk6hna61frepeqn9k1', '2026-09-02', '12:58:21', '2026-09-02 10:58:21'),
(543, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '3u0lfhvsfcff4upq0eqosb5lb9', '2026-09-02', '13:00:11', '2026-09-02 11:00:11'),
(544, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 't614b79fcadcj7gf970hdru9g1', '2026-09-02', '13:00:20', '2026-09-02 11:00:20'),
(545, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'nhi58j5m6vksob1n10e46o63kc', '2026-09-02', '13:01:11', '2026-09-02 11:01:11'),
(546, '::1', '/bahawalcollegeofhealth/about.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '82r9ev0pt1qq2ji7mr7pq8e62u', '2026-09-02', '13:01:19', '2026-09-02 11:01:19'),
(547, '::1', '/bahawalcollegeofhealth/courses.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'jb4fnm0qfoj114hl574g90i18i', '2026-09-02', '13:01:22', '2026-09-02 11:01:22'),
(548, '::1', '/bahawalcollegeofhealth/admission.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'dt63it090oocc44eu2emlrtthr', '2026-09-02', '13:01:26', '2026-09-02 11:01:26'),
(549, '::1', '/bahawalcollegeofhealth/contact.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'ib74djiqf21e7vrandnadchdfq', '2026-09-02', '13:01:33', '2026-09-02 11:01:33'),
(550, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'tis33egtj5dsst3e0lcd8kkl74', '2026-09-02', '13:01:40', '2026-09-02 11:01:40'),
(551, '::1', '/bahawalcollegeofhealth/events.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'v6ef6mvlntj5pjkh3gmmguproq', '2026-09-02', '13:01:47', '2026-09-02 11:01:47'),
(552, '::1', '/bahawalcollegeofhealth/news.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'uii2c11gqo84dl405s01k618g9', '2026-09-02', '13:01:52', '2026-09-02 11:01:52'),
(553, '::1', '/bahawalcollegeofhealth/gallery.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '29k88mencsk43jb2kmfkpurpou', '2026-09-02', '13:01:55', '2026-09-02 11:01:55'),
(554, '::1', '/bahawalcollegeofhealth/leadership.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '9qdqdcinbvs1ohg9g5efpsn42v', '2026-09-02', '13:01:59', '2026-09-02 11:01:59'),
(555, '::1', '/bahawalcollegeofhealth/mission-vision.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'pib4cn41b04q98uof0jdkelacr', '2026-09-02', '13:02:02', '2026-09-02 11:02:02'),
(556, '::1', '/bahawalcollegeofhealth/core-values.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'k94u3nt3pbfqrtomagk5lga7t5', '2026-09-02', '13:02:06', '2026-09-02 11:02:06'),
(557, '::1', '/bahawalcollegeofhealth/campuses.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '3jd65vdfooet1b0smpsohte0lb', '2026-09-02', '13:02:11', '2026-09-02 11:02:11'),
(558, '::1', '/bahawalcollegeofhealth/campus-portal.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '1j1ssfis34hd8uge4gj52qbtmk', '2026-09-02', '13:02:15', '2026-09-02 11:02:15'),
(559, '::1', '/bahawalcollegeofhealth/alumni.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '1ldpmvc46bnce1jhs149kgkok1', '2026-09-02', '13:02:22', '2026-09-02 11:02:22'),
(560, '::1', '/bahawalcollegeofhealth/examination.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'rs94qdv7c1sm2l98d6qjt4uhed', '2026-09-02', '13:02:25', '2026-09-02 11:02:25'),
(561, '::1', '/bahawalcollegeofhealth/downloads.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'ig6m2po6l68o4cvbqsn8k8rp4d', '2026-09-02', '13:02:30', '2026-09-02 11:02:30'),
(562, '::1', '/bahawalcollegeofhealth/notifications.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'cpdvll48610v3puca7gubo9tls', '2026-09-02', '13:02:43', '2026-09-02 11:02:43'),
(563, '::1', '/bahawalcollegeofhealth/alumni.php', '', 'http://localhost/bahawalcollegeofhealth/about.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'iur80q7ujg7spqn3o2cg11kj6q', '2026-09-02', '13:04:35', '2026-09-02 11:04:35'),
(564, '::1', '/bahawalcollegeofhealth/index.php', '', 'http://localhost/bahawalcollegeofhealth/alumni.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'iur80q7ujg7spqn3o2cg11kj6q', '2026-09-02', '13:04:38', '2026-09-02 11:04:38'),
(565, '::1', '/bahawalcollegeofhealth/index.php', '', 'http://localhost/bahawalcollegeofhealth/alumni.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'iur80q7ujg7spqn3o2cg11kj6q', '2026-09-02', '13:04:58', '2026-09-02 11:04:58'),
(566, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'i3ultrmrbtngssbqvlqfg41if5', '2026-09-02', '13:13:16', '2026-09-02 11:13:16'),
(567, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'vh10utunfv2jqrpkf9ohbm99qk', '2026-09-02', '13:14:24', '2026-09-02 11:14:24'),
(568, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'gmn7q7dvubsb5se31uppr76hne', '2026-09-02', '13:14:30', '2026-09-02 11:14:30'),
(569, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'g3raoaa3e9mldjus3g2jj2tgf9', '2026-09-02', '13:15:45', '2026-09-02 11:15:45'),
(570, '::1', '/bahawalcollegeofhealth/about.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'ihoiuujpn1ison02ouri28de22', '2026-09-02', '13:15:50', '2026-09-02 11:15:50'),
(571, '::1', '/bahawalcollegeofhealth/courses.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'gb3mttrknluuhs7c5smco8bi6l', '2026-09-02', '13:15:53', '2026-09-02 11:15:53'),
(572, '::1', '/bahawalcollegeofhealth/admission.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'c6edala4ah37gg2c8locqdv4b7', '2026-09-02', '13:15:57', '2026-09-02 11:15:57'),
(573, '::1', '/bahawalcollegeofhealth/contact.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'hk0la8oht4a731j862uidatopp', '2026-09-02', '13:16:01', '2026-09-02 11:16:01'),
(574, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '1hligojhh9e1l7jmrmn1j5hfld', '2026-09-02', '13:16:09', '2026-09-02 11:16:09'),
(575, '::1', '/bahawalcollegeofhealth/events.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'nvhqu3jd54eurn2ihcjset593p', '2026-09-02', '13:16:29', '2026-09-02 11:16:29'),
(576, '::1', '/bahawalcollegeofhealth/news.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'ehkfek0los9duccn15kc13jp1s', '2026-09-02', '13:16:32', '2026-09-02 11:16:32'),
(577, '::1', '/bahawalcollegeofhealth/gallery.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'lpn3jslbj19f3a896q3v129d58', '2026-09-02', '13:16:37', '2026-09-02 11:16:37'),
(578, '::1', '/bahawalcollegeofhealth/leadership.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'i873flqnbd61ddv52fqeh272g7', '2026-09-02', '13:16:40', '2026-09-02 11:16:40'),
(579, '::1', '/bahawalcollegeofhealth/mission-vision.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'aksshqcpmt51b69uo0bark3k5k', '2026-09-02', '13:16:43', '2026-09-02 11:16:43'),
(580, '::1', '/bahawalcollegeofhealth/core-values.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'pva7lr5s2c0r6dqoh66c3kg97a', '2026-09-02', '13:16:49', '2026-09-02 11:16:49'),
(581, '::1', '/bahawalcollegeofhealth/campuses.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '4ns7u20jjv84in1mdd7clm4td4', '2026-09-02', '13:16:58', '2026-09-02 11:16:58'),
(582, '::1', '/bahawalcollegeofhealth/campus-portal.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'lpmc5ku13l8nlgr0s0soicq4k8', '2026-09-02', '13:17:06', '2026-09-02 11:17:06'),
(583, '::1', '/bahawalcollegeofhealth/alumni.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '9efmc73f79gp9t0atb8late7ip', '2026-09-02', '13:17:17', '2026-09-02 11:17:17'),
(584, '::1', '/bahawalcollegeofhealth/examination.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'urelpu7cqm22jfedk3dn4vlnj5', '2026-09-02', '13:17:21', '2026-09-02 11:17:21'),
(585, '::1', '/bahawalcollegeofhealth/downloads.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'bve0jbbuprcgj6tfqngd61v0mp', '2026-09-02', '13:17:25', '2026-09-02 11:17:25'),
(586, '::1', '/bahawalcollegeofhealth/notifications.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'ahopk3ja9ftn5s73gc3k6l48k5', '2026-09-02', '13:17:29', '2026-09-02 11:17:29'),
(587, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'j5cq0394ss9gsc7u7dj8tlrdm1', '2026-09-02', '13:18:00', '2026-09-02 11:18:00'),
(588, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'f9c9tfn35t60e7hiv64q7d0boa', '2026-09-03', '05:00:02', '2026-09-03 03:00:02'),
(589, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'f9c9tfn35t60e7hiv64q7d0boa', '2026-09-03', '05:00:10', '2026-09-03 03:00:10'),
(590, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'f9c9tfn35t60e7hiv64q7d0boa', '2026-09-03', '05:00:20', '2026-09-03 03:00:20'),
(591, '::1', '/bahawalcollegeofhealth/index.php', '', 'http://localhost/bahawalcollegeofhealth/alumni.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'iur80q7ujg7spqn3o2cg11kj6q', '2026-09-03', '05:00:49', '2026-09-03 03:00:49'),
(592, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'f9c9tfn35t60e7hiv64q7d0boa', '2026-09-03', '05:03:17', '2026-09-03 03:03:17'),
(593, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'f9c9tfn35t60e7hiv64q7d0boa', '2026-09-03', '05:07:06', '2026-09-03 03:07:06'),
(594, '::1', '/bahawalcollegeofhealth/about.php', '', 'http://localhost/bahawalcollegeofhealth/', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'f9c9tfn35t60e7hiv64q7d0boa', '2026-09-03', '05:07:56', '2026-09-03 03:07:56'),
(595, '::1', '/bahawalcollegeofhealth/about.php', '', 'http://localhost/bahawalcollegeofhealth/', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'f9c9tfn35t60e7hiv64q7d0boa', '2026-09-03', '05:12:59', '2026-09-03 03:12:59'),
(596, '::1', '/bahawalcollegeofhealth/mission-vision.php', '', 'http://localhost/bahawalcollegeofhealth/about.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'f9c9tfn35t60e7hiv64q7d0boa', '2026-09-03', '05:13:43', '2026-09-03 03:13:43'),
(597, '::1', '/bahawalcollegeofhealth/core-values.php', '', 'http://localhost/bahawalcollegeofhealth/mission-vision.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'f9c9tfn35t60e7hiv64q7d0boa', '2026-09-03', '05:13:54', '2026-09-03 03:13:54'),
(598, '::1', '/bahawalcollegeofhealth/leadership.php', '', 'http://localhost/bahawalcollegeofhealth/core-values.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'f9c9tfn35t60e7hiv64q7d0boa', '2026-09-03', '05:14:01', '2026-09-03 03:14:01'),
(599, '::1', '/bahawalcollegeofhealth/courses.php', '', 'http://localhost/bahawalcollegeofhealth/leadership.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'f9c9tfn35t60e7hiv64q7d0boa', '2026-09-03', '05:14:13', '2026-09-03 03:14:13'),
(600, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'http://localhost/bahawalcollegeofhealth/courses.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'f9c9tfn35t60e7hiv64q7d0boa', '2026-09-03', '05:15:15', '2026-09-03 03:15:16'),
(601, '::1', '/bahawalcollegeofhealth/examination.php', '', 'http://localhost/bahawalcollegeofhealth/faculty.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'f9c9tfn35t60e7hiv64q7d0boa', '2026-09-03', '05:19:32', '2026-09-03 03:19:32'),
(602, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '8ljktshvujjbd3hsa3m65bc8vb', '2026-09-03', '05:21:26', '2026-09-03 03:21:26'),
(603, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'http://localhost/bahawalcollegeofhealth/examination.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'f9c9tfn35t60e7hiv64q7d0boa', '2026-09-03', '05:23:30', '2026-09-03 03:23:30'),
(604, '::1', '/bahawalcollegeofhealth/index.php', '', 'http://localhost/bahawalcollegeofhealth/faculty.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'f9c9tfn35t60e7hiv64q7d0boa', '2026-09-03', '05:23:34', '2026-09-03 03:23:34'),
(605, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'http://localhost/bahawalcollegeofhealth/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'f9c9tfn35t60e7hiv64q7d0boa', '2026-09-03', '05:24:39', '2026-09-03 03:24:39'),
(606, '::1', '/bahawalcollegeofhealth/leadership.php', '', 'http://localhost/bahawalcollegeofhealth/faculty.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'f9c9tfn35t60e7hiv64q7d0boa', '2026-09-03', '05:24:45', '2026-09-03 03:24:45'),
(607, '::1', '/bahawalcollegeofhealth/leadership.php', '', 'http://localhost/bahawalcollegeofhealth/faculty.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'f9c9tfn35t60e7hiv64q7d0boa', '2026-09-03', '05:25:46', '2026-09-03 03:25:46'),
(608, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'http://localhost/bahawalcollegeofhealth/leadership.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'f9c9tfn35t60e7hiv64q7d0boa', '2026-09-03', '05:25:51', '2026-09-03 03:25:51'),
(609, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'http://localhost/bahawalcollegeofhealth/leadership.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'f9c9tfn35t60e7hiv64q7d0boa', '2026-09-03', '05:26:28', '2026-09-03 03:26:28'),
(610, '::1', '/bahawalcollegeofhealth/admission.php', '', 'http://localhost/bahawalcollegeofhealth/faculty.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'f9c9tfn35t60e7hiv64q7d0boa', '2026-09-03', '05:26:48', '2026-09-03 03:26:48'),
(611, '::1', '/bahawalcollegeofhealth/downloads.php', '', 'http://localhost/bahawalcollegeofhealth/admission.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'f9c9tfn35t60e7hiv64q7d0boa', '2026-09-03', '05:27:12', '2026-09-03 03:27:12'),
(612, '::1', '/bahawalcollegeofhealth/notifications.php', '', 'http://localhost/bahawalcollegeofhealth/downloads.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'f9c9tfn35t60e7hiv64q7d0boa', '2026-09-03', '05:27:17', '2026-09-03 03:27:17'),
(613, '::1', '/bahawalcollegeofhealth/campuses.php', '', 'http://localhost/bahawalcollegeofhealth/notifications.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'f9c9tfn35t60e7hiv64q7d0boa', '2026-09-03', '05:27:18', '2026-09-03 03:27:18'),
(614, '::1', '/bahawalcollegeofhealth/campus-portal.php', '', 'http://localhost/bahawalcollegeofhealth/campuses.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'f9c9tfn35t60e7hiv64q7d0boa', '2026-09-03', '05:27:35', '2026-09-03 03:27:35'),
(615, '::1', '/bahawalcollegeofhealth/events.php', '', 'http://localhost/bahawalcollegeofhealth/campus-portal.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'f9c9tfn35t60e7hiv64q7d0boa', '2026-09-03', '05:27:43', '2026-09-03 03:27:43'),
(616, '::1', '/bahawalcollegeofhealth/news.php', '', 'http://localhost/bahawalcollegeofhealth/events.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'f9c9tfn35t60e7hiv64q7d0boa', '2026-09-03', '05:27:45', '2026-09-03 03:27:45'),
(617, '::1', '/bahawalcollegeofhealth/gallery.php', '', 'http://localhost/bahawalcollegeofhealth/news.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'f9c9tfn35t60e7hiv64q7d0boa', '2026-09-03', '05:27:49', '2026-09-03 03:27:49'),
(618, '::1', '/bahawalcollegeofhealth/contact.php', '', 'http://localhost/bahawalcollegeofhealth/gallery.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'f9c9tfn35t60e7hiv64q7d0boa', '2026-09-03', '05:27:58', '2026-09-03 03:27:58'),
(619, '::1', '/bahawalcollegeofhealth/index.php', '', 'http://localhost/bahawalcollegeofhealth/contact.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'f9c9tfn35t60e7hiv64q7d0boa', '2026-09-03', '05:28:19', '2026-09-03 03:28:19'),
(620, '::1', '/bahawalcollegeofhealth/events.php', '', 'http://localhost/bahawalcollegeofhealth/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'f9c9tfn35t60e7hiv64q7d0boa', '2026-09-03', '05:39:14', '2026-09-03 03:39:14'),
(621, '::1', '/bahawalcollegeofhealth/news.php', '', 'http://localhost/bahawalcollegeofhealth/events.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'f9c9tfn35t60e7hiv64q7d0boa', '2026-09-03', '05:39:19', '2026-09-03 03:39:19'),
(622, '::1', '/bahawalcollegeofhealth/events.php', '', 'http://localhost/bahawalcollegeofhealth/news.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'f9c9tfn35t60e7hiv64q7d0boa', '2026-09-03', '05:39:30', '2026-09-03 03:39:30'),
(623, '::1', '/bahawalcollegeofhealth/events.php', '', 'http://localhost/bahawalcollegeofhealth/news.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'f9c9tfn35t60e7hiv64q7d0boa', '2026-09-03', '06:12:20', '2026-09-03 04:12:20'),
(624, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'sshohav8bt7hfgbcp48bgrj6bl', '2026-09-03', '06:16:26', '2026-09-03 04:16:26'),
(625, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'g06jkllm39gqrt2aojnhn1ulq7', '2026-09-03', '06:16:26', '2026-09-03 04:16:26'),
(626, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'm74ffa904fav4ibt448cp8jl3k', '2026-09-03', '06:16:57', '2026-09-03 04:16:57'),
(627, '::1', '/bahawalcollegeofhealth/about.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'uqeehdhtioel35et8dn2qr2378', '2026-09-03', '06:17:05', '2026-09-03 04:17:05'),
(628, '::1', '/bahawalcollegeofhealth/courses.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'ffjqtpb07kvici83gu0rblps0i', '2026-09-03', '06:17:08', '2026-09-03 04:17:08'),
(629, '::1', '/bahawalcollegeofhealth/admission.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'jqmv87lils5mcqeaats7d7m0j4', '2026-09-03', '06:17:11', '2026-09-03 04:17:11'),
(630, '::1', '/bahawalcollegeofhealth/contact.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'c2datdb329p8qnfb3c2c3dhepf', '2026-09-03', '06:17:13', '2026-09-03 04:17:13'),
(631, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '3nm842d2ljh97jd4n52i7er855', '2026-09-03', '06:17:20', '2026-09-03 04:17:20'),
(632, '::1', '/bahawalcollegeofhealth/events.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'dvjg79a6resja2kaoj0b3fo9gv', '2026-09-03', '06:17:22', '2026-09-03 04:17:22'),
(633, '::1', '/bahawalcollegeofhealth/news.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'spvmqt0t9h301g2h6m0vvsfecl', '2026-09-03', '06:17:24', '2026-09-03 04:17:24'),
(634, '::1', '/bahawalcollegeofhealth/gallery.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '0rornt813k3g8js4pg76nsp0jp', '2026-09-03', '06:17:26', '2026-09-03 04:17:26'),
(635, '::1', '/bahawalcollegeofhealth/leadership.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'tiemhoh00h1mq5kt8f31uskssn', '2026-09-03', '06:17:30', '2026-09-03 04:17:30'),
(636, '::1', '/bahawalcollegeofhealth/mission-vision.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'jvsvu0h1uh276dq17dj5hmloe7', '2026-09-03', '06:17:34', '2026-09-03 04:17:34'),
(637, '::1', '/bahawalcollegeofhealth/core-values.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '1grbvignoiilb64lktl12nob7d', '2026-09-03', '06:17:36', '2026-09-03 04:17:36'),
(638, '::1', '/bahawalcollegeofhealth/campuses.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'm73bvc4mnfnelognlr0gk99o83', '2026-09-03', '06:17:38', '2026-09-03 04:17:38'),
(639, '::1', '/bahawalcollegeofhealth/campus-portal.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '4kp8fc38rhn53hap4irg1fb2l4', '2026-09-03', '06:17:42', '2026-09-03 04:17:42'),
(640, '::1', '/bahawalcollegeofhealth/alumni.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'gp957mk2ftr43hs6u205tm2mkj', '2026-09-03', '06:17:46', '2026-09-03 04:17:46'),
(641, '::1', '/bahawalcollegeofhealth/examination.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'be97pt1l9s6skt8a43uskote1d', '2026-09-03', '06:17:48', '2026-09-03 04:17:48'),
(642, '::1', '/bahawalcollegeofhealth/downloads.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'n73s619e0n030nfvlud8kunmrh', '2026-09-03', '06:17:50', '2026-09-03 04:17:50'),
(643, '::1', '/bahawalcollegeofhealth/notifications.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '1l9ok4nsmc0jh06vqeqar0cm3r', '2026-09-03', '06:17:53', '2026-09-03 04:17:53'),
(644, '::1', '/bahawalcollegeofhealth/events.php', '', 'http://localhost/bahawalcollegeofhealth/news.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'f9c9tfn35t60e7hiv64q7d0boa', '2026-09-03', '06:18:58', '2026-09-03 04:18:58'),
(645, '::1', '/bahawalcollegeofhealth/index.php', '', 'http://localhost/bahawalcollegeofhealth/events.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'f9c9tfn35t60e7hiv64q7d0boa', '2026-09-03', '06:19:03', '2026-09-03 04:19:03'),
(646, '::1', '/bahawalcollegeofhealth/campus-portal.php', '', 'http://localhost/bahawalcollegeofhealth/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'f9c9tfn35t60e7hiv64q7d0boa', '2026-09-03', '06:25:39', '2026-09-03 04:25:39');
INSERT INTO `website_analytics` (`id`, `visitor_ip`, `page_url`, `page_title`, `referrer`, `user_agent`, `device_type`, `browser`, `operating_system`, `country`, `city`, `session_id`, `visit_date`, `visit_time`, `created_at`) VALUES
(647, '::1', '/bahawalcollegeofhealth/index.php', '', 'http://localhost/bahawalcollegeofhealth/campus-portal.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'f9c9tfn35t60e7hiv64q7d0boa', '2026-09-03', '06:26:58', '2026-09-03 04:26:58'),
(648, '::1', '/bahawalcollegeofhealth/index.php', '', 'http://localhost/bahawalcollegeofhealth/campus-portal.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'f9c9tfn35t60e7hiv64q7d0boa', '2026-09-03', '08:19:20', '2026-09-03 06:19:20'),
(649, '::1', '/bahawalcollegeofhealth/index.php', '', 'http://localhost/bahawalcollegeofhealth/campus-portal.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'f9c9tfn35t60e7hiv64q7d0boa', '2026-09-03', '10:40:11', '2026-09-03 08:40:11'),
(650, '::1', '/bahawalcollegeofhealth/index.php', '', 'http://localhost/bahawalcollegeofhealth/campus-portal.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'f9c9tfn35t60e7hiv64q7d0boa', '2026-09-03', '12:41:01', '2026-09-03 10:41:01'),
(651, '::1', '/bahawalcollegeofhealth/index.php', '', 'http://localhost/bahawalcollegeofhealth/campus-portal.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'f9c9tfn35t60e7hiv64q7d0boa', '2026-09-03', '13:40:59', '2026-09-03 11:40:59'),
(652, '::1', '/bahawalcollegeofhealth/courses.php', '', 'http://localhost/bahawalcollegeofhealth/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'f9c9tfn35t60e7hiv64q7d0boa', '2026-09-04', '05:27:12', '2026-09-04 03:27:12'),
(653, '::1', '/bahawalcollegeofhealth/courses.php', '', 'http://localhost/bahawalcollegeofhealth/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'f9c9tfn35t60e7hiv64q7d0boa', '2026-09-04', '05:27:26', '2026-09-04 03:27:26'),
(654, '::1', '/bahawalcollegeofhealth/courses.php', '', 'http://localhost/bahawalcollegeofhealth/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'f9c9tfn35t60e7hiv64q7d0boa', '2026-09-04', '05:40:09', '2026-09-04 03:40:09'),
(655, '::1', '/bahawalcollegeofhealth/courses.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '9d70hqeneo9ilh8i2omgs239a3', '2026-09-04', '05:40:48', '2026-09-04 03:40:48'),
(656, '::1', '/bahawalcollegeofhealth/courses.php', '', 'http://localhost/bahawalcollegeofhealth/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'f9c9tfn35t60e7hiv64q7d0boa', '2026-09-04', '05:41:27', '2026-09-04 03:41:27'),
(657, '::1', '/bahawalcollegeofhealth/index.php', '', 'http://localhost/bahawalcollegeofhealth/courses.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'f9c9tfn35t60e7hiv64q7d0boa', '2026-09-04', '05:43:36', '2026-09-04 03:43:36'),
(658, '::1', '/bahawalcollegeofhealth/about.php', '', 'http://localhost/bahawalcollegeofhealth/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'f9c9tfn35t60e7hiv64q7d0boa', '2026-09-04', '05:44:13', '2026-09-04 03:44:13'),
(659, '::1', '/bahawalcollegeofhealth/core-values.php', '', 'http://localhost/bahawalcollegeofhealth/about.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'f9c9tfn35t60e7hiv64q7d0boa', '2026-09-04', '05:44:23', '2026-09-04 03:44:23'),
(660, '::1', '/bahawalcollegeofhealth/leadership.php', '', 'http://localhost/bahawalcollegeofhealth/core-values.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'f9c9tfn35t60e7hiv64q7d0boa', '2026-09-04', '05:44:28', '2026-09-04 03:44:28'),
(661, '::1', '/bahawalcollegeofhealth/leadership.php', '', 'http://localhost/bahawalcollegeofhealth/core-values.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'f9c9tfn35t60e7hiv64q7d0boa', '2026-09-04', '05:45:43', '2026-09-04 03:45:43'),
(662, '::1', '/bahawalcollegeofhealth/courses.php', '', 'http://localhost/bahawalcollegeofhealth/leadership.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'f9c9tfn35t60e7hiv64q7d0boa', '2026-09-04', '05:46:20', '2026-09-04 03:46:20'),
(663, '::1', '/bahawalcollegeofhealth/courses.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '5vrt7pr6lpgj2rd7ngqbguqe2u', '2026-09-04', '05:49:02', '2026-09-04 03:49:02'),
(664, '::1', '/bahawalcollegeofhealth/courses.php', '', 'http://localhost/bahawalcollegeofhealth/leadership.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'f9c9tfn35t60e7hiv64q7d0boa', '2026-09-04', '05:49:57', '2026-09-04 03:49:57'),
(665, '::1', '/bahawalcollegeofhealth/index.php', '', 'http://localhost/bahawalcollegeofhealth/courses.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'f9c9tfn35t60e7hiv64q7d0boa', '2026-09-04', '05:50:11', '2026-09-04 03:50:11'),
(666, '::1', '/bahawalcollegeofhealth/index.php', '', 'http://localhost/bahawalcollegeofhealth/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'f9c9tfn35t60e7hiv64q7d0boa', '2026-09-04', '05:50:24', '2026-09-04 03:50:24'),
(667, '::1', '/bahawalcollegeofhealth/admission.php', '', 'http://localhost/bahawalcollegeofhealth/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'f9c9tfn35t60e7hiv64q7d0boa', '2026-09-04', '05:50:45', '2026-09-04 03:50:45'),
(668, '::1', '/bahawalcollegeofhealth/courses.php', '', 'http://localhost/bahawalcollegeofhealth/admission.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'f9c9tfn35t60e7hiv64q7d0boa', '2026-09-04', '05:50:55', '2026-09-04 03:50:55'),
(669, '::1', '/bahawalcollegeofhealth/admission.php', '', 'http://localhost/bahawalcollegeofhealth/courses.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'f9c9tfn35t60e7hiv64q7d0boa', '2026-09-04', '05:50:58', '2026-09-04 03:50:58'),
(670, '::1', '/bahawalcollegeofhealth/courses.php', '', 'http://localhost/bahawalcollegeofhealth/admission.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'f9c9tfn35t60e7hiv64q7d0boa', '2026-09-04', '05:51:40', '2026-09-04 03:51:40'),
(671, '::1', '/bahawalcollegeofhealth/admission.php', '', 'http://localhost/bahawalcollegeofhealth/courses.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'f9c9tfn35t60e7hiv64q7d0boa', '2026-09-04', '05:51:41', '2026-09-04 03:51:41'),
(672, '::1', '/bahawalcollegeofhealth/index.php', '', 'http://localhost/bahawalcollegeofhealth/admission.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'f9c9tfn35t60e7hiv64q7d0boa', '2026-09-04', '05:51:47', '2026-09-04 03:51:47'),
(673, '::1', '/bahawalcollegeofhealth/campus-portal.php', '', 'http://localhost/bahawalcollegeofhealth/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'f9c9tfn35t60e7hiv64q7d0boa', '2026-09-04', '05:51:51', '2026-09-04 03:51:51'),
(674, '::1', '/bahawalcollegeofhealth/index.php', '', 'http://localhost/bahawalcollegeofhealth/campus-portal.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'f9c9tfn35t60e7hiv64q7d0boa', '2026-09-04', '05:52:07', '2026-09-04 03:52:07'),
(675, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'hb2scub74orl1vopiufmcd374u', '2026-09-04', '05:56:48', '2026-09-04 03:56:48'),
(676, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '63o0q5juj1t6hlif50hhjtjjcu', '2026-09-04', '05:59:37', '2026-09-04 03:59:37'),
(677, '::1', '/bahawalcollegeofhealth/index.php', '', 'http://localhost/bahawalcollegeofhealth/campus-portal.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'f9c9tfn35t60e7hiv64q7d0boa', '2026-09-04', '06:03:49', '2026-09-04 04:03:49'),
(678, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '0che42jtvvfn5tngg6e6sa87v8', '2026-09-04', '06:10:29', '2026-09-04 04:10:29'),
(679, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '668nilphahshstn6q9qi4l76g9', '2026-09-04', '06:11:19', '2026-09-04 04:11:19'),
(680, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'q3fr849jl5k55f69lrsist4nph', '2026-09-04', '06:12:06', '2026-09-04 04:12:06'),
(681, '::1', '/bahawalcollegeofhealth/about.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'mhd31lbveflt8c2apr2kqdb24h', '2026-09-04', '06:12:13', '2026-09-04 04:12:13'),
(682, '::1', '/bahawalcollegeofhealth/courses.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'notsaueglgp3iecv39hss0apf4', '2026-09-04', '06:12:15', '2026-09-04 04:12:15'),
(683, '::1', '/bahawalcollegeofhealth/admission.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'pp0gdf5vldignd99cbl5arjv5r', '2026-09-04', '06:12:18', '2026-09-04 04:12:18'),
(684, '::1', '/bahawalcollegeofhealth/contact.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'go2e44fo9d9l1c2i73ecui82mo', '2026-09-04', '06:12:21', '2026-09-04 04:12:21'),
(685, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'sl2vb6erlan2e24fir0l4il5qc', '2026-09-04', '06:12:25', '2026-09-04 04:12:25'),
(686, '::1', '/bahawalcollegeofhealth/events.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'v9qf8h4unlj19880ulr0k2mkbs', '2026-09-04', '06:12:28', '2026-09-04 04:12:28'),
(687, '::1', '/bahawalcollegeofhealth/news.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'mkgfs9b2th6o1g2uo5o96sfki0', '2026-09-04', '06:12:31', '2026-09-04 04:12:31'),
(688, '::1', '/bahawalcollegeofhealth/gallery.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'pnisergqegptfib4ec3h8fsui2', '2026-09-04', '06:12:33', '2026-09-04 04:12:33'),
(689, '::1', '/bahawalcollegeofhealth/leadership.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '43sakjgs96krtrai0qjsjo9cjd', '2026-09-04', '06:12:36', '2026-09-04 04:12:36'),
(690, '::1', '/bahawalcollegeofhealth/mission-vision.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'aabk8eab232f1q9ns4mavjoa2t', '2026-09-04', '06:12:40', '2026-09-04 04:12:40'),
(691, '::1', '/bahawalcollegeofhealth/core-values.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '73bgr3n4ff6s5crfqip8m9fd98', '2026-09-04', '06:12:42', '2026-09-04 04:12:42'),
(692, '::1', '/bahawalcollegeofhealth/campuses.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '7g4cql0rsuh6gjl9gmi8gcunan', '2026-09-04', '06:12:44', '2026-09-04 04:12:44'),
(693, '::1', '/bahawalcollegeofhealth/campus-portal.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '79t6at25ulpo82issvd7mi71bl', '2026-09-04', '06:12:50', '2026-09-04 04:12:50'),
(694, '::1', '/bahawalcollegeofhealth/alumni.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'gsici04vgmgbt5b23osdd64j3v', '2026-09-04', '06:12:56', '2026-09-04 04:12:56'),
(695, '::1', '/bahawalcollegeofhealth/examination.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'il28asv5b72aldi774ide5pvnl', '2026-09-04', '06:12:59', '2026-09-04 04:12:59'),
(696, '::1', '/bahawalcollegeofhealth/downloads.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'spvl0c4l2l5f8kt97k14b429f7', '2026-09-04', '06:13:02', '2026-09-04 04:13:02'),
(697, '::1', '/bahawalcollegeofhealth/notifications.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'sv751ih07ct6qe42c668gc9kmc', '2026-09-04', '06:13:05', '2026-09-04 04:13:05'),
(698, '::1', '/bahawalcollegeofhealth/index.php', '', 'http://localhost/bahawalcollegeofhealth/campus-portal.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'f9c9tfn35t60e7hiv64q7d0boa', '2026-09-04', '06:14:51', '2026-09-04 04:14:51'),
(699, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'hk72rtcbcq6nqubuhlneim7g42', '2026-09-04', '06:17:17', '2026-09-04 04:17:17'),
(700, '::1', '/bahawalcollegeofhealth/index.php', '', 'http://localhost/bahawalcollegeofhealth/campus-portal.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'f9c9tfn35t60e7hiv64q7d0boa', '2026-09-04', '06:20:34', '2026-09-04 04:20:34'),
(701, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '0rp8nfo97taf4o0j01p68o57jt', '2026-09-04', '06:25:02', '2026-09-04 04:25:02'),
(702, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'j3ier0ei8rst2pemosjoq5qu32', '2026-09-04', '06:27:11', '2026-09-04 04:27:11'),
(703, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'g41gql8kge4merkjbig1ug41rl', '2026-09-04', '06:27:11', '2026-09-04 04:27:11'),
(704, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'a3chgkk73h3kdm5bfgn5o4ace7', '2026-09-04', '06:27:29', '2026-09-04 04:27:29'),
(705, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'jj0jpb2rkjce5ap78krpd0do68', '2026-09-04', '06:27:52', '2026-09-04 04:27:52'),
(706, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '7858da3elp31ns5bktjnq34psq', '2026-09-04', '06:29:20', '2026-09-04 04:29:20'),
(707, '::1', '/bahawalcollegeofhealth/about.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '0t3gbcsn6q1unatn4ev4i9ek25', '2026-09-04', '06:29:23', '2026-09-04 04:29:23'),
(708, '::1', '/bahawalcollegeofhealth/courses.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'nfh7q5kjpd85t67roh4vib60b2', '2026-09-04', '06:29:27', '2026-09-04 04:29:27'),
(709, '::1', '/bahawalcollegeofhealth/admission.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '01mjm1pgjuo8dic70lg9ogak2i', '2026-09-04', '06:29:30', '2026-09-04 04:29:30'),
(710, '::1', '/bahawalcollegeofhealth/contact.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'k3j6ufj2u4b21r91jeohbponrl', '2026-09-04', '06:29:37', '2026-09-04 04:29:37'),
(711, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '3gnc64flc0lebrtqjrnodfcv37', '2026-09-04', '06:29:42', '2026-09-04 04:29:42'),
(712, '::1', '/bahawalcollegeofhealth/events.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '880u5oo7tg81nrn8teajn47rr3', '2026-09-04', '06:29:45', '2026-09-04 04:29:45'),
(713, '::1', '/bahawalcollegeofhealth/news.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '22ffv13esl34d26g3tqfuqh5gv', '2026-09-04', '06:29:47', '2026-09-04 04:29:47'),
(714, '::1', '/bahawalcollegeofhealth/gallery.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '0oprrgqqfsh95qs6cbk603kk6m', '2026-09-04', '06:29:49', '2026-09-04 04:29:49'),
(715, '::1', '/bahawalcollegeofhealth/leadership.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'rb6rfq0dfg3dtblpkn2k1kla91', '2026-09-04', '06:29:52', '2026-09-04 04:29:52'),
(716, '::1', '/bahawalcollegeofhealth/mission-vision.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'el1uf9f7ofi6maaevu1e39gt7e', '2026-09-04', '06:29:55', '2026-09-04 04:29:55'),
(717, '::1', '/bahawalcollegeofhealth/core-values.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '9m889ehi780mnftgkkkp7fudeo', '2026-09-04', '06:29:57', '2026-09-04 04:29:57'),
(718, '::1', '/bahawalcollegeofhealth/campuses.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'el22m3nu5od11kacps2t4gtdq4', '2026-09-04', '06:30:00', '2026-09-04 04:30:00'),
(719, '::1', '/bahawalcollegeofhealth/campus-portal.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 't86lv44sgggg0mj3mvv7cii34t', '2026-09-04', '06:30:05', '2026-09-04 04:30:05'),
(720, '::1', '/bahawalcollegeofhealth/alumni.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 't1ofug2957g5u4e748co7hr2rm', '2026-09-04', '06:30:09', '2026-09-04 04:30:09'),
(721, '::1', '/bahawalcollegeofhealth/examination.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '8go19f5m33muvgc5rls77gcj0s', '2026-09-04', '06:30:11', '2026-09-04 04:30:11'),
(722, '::1', '/bahawalcollegeofhealth/downloads.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'fjjiusprsidlc5a2dmm7bceabp', '2026-09-04', '06:30:14', '2026-09-04 04:30:14'),
(723, '::1', '/bahawalcollegeofhealth/notifications.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'eot36pripum08a75c9chcpgrs9', '2026-09-04', '06:30:18', '2026-09-04 04:30:18'),
(724, '::1', '/bahawalcollegeofhealth/index.php', '', 'http://localhost/bahawalcollegeofhealth/campus-portal.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'f9c9tfn35t60e7hiv64q7d0boa', '2026-09-04', '06:32:09', '2026-09-04 04:32:09'),
(725, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'f9c9tfn35t60e7hiv64q7d0boa', '2026-09-04', '08:37:58', '2026-09-04 06:37:58'),
(726, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'f9c9tfn35t60e7hiv64q7d0boa', '2026-09-04', '09:04:38', '2026-09-04 07:04:38'),
(727, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'f9c9tfn35t60e7hiv64q7d0boa', '2026-09-04', '09:25:43', '2026-09-04 07:25:43'),
(728, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'f9c9tfn35t60e7hiv64q7d0boa', '2026-09-04', '09:29:01', '2026-09-04 07:29:01'),
(729, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'f9c9tfn35t60e7hiv64q7d0boa', '2026-09-04', '09:30:07', '2026-09-04 07:30:07'),
(730, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'o92d021quemle22e91s9fc4jnp', '2026-09-04', '09:35:02', '2026-09-04 07:35:02'),
(731, '::1', '/bahawalcollegeofhealth/about.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'tprtofq68cov5lassafk12b7f7', '2026-09-04', '09:35:08', '2026-09-04 07:35:08'),
(732, '::1', '/bahawalcollegeofhealth/courses.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'c5e730ekfpe1m1o4p3k48jtfhp', '2026-09-04', '09:35:11', '2026-09-04 07:35:11'),
(733, '::1', '/bahawalcollegeofhealth/admission.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'j30iumrlqv2m354dls92f68nj7', '2026-09-04', '09:35:14', '2026-09-04 07:35:14'),
(734, '::1', '/bahawalcollegeofhealth/contact.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '8aq5gpar9tsd17mrue5bls2hfb', '2026-09-04', '09:35:16', '2026-09-04 07:35:16'),
(735, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '0kv67aiorvk1uv4a19ue8c7b97', '2026-09-04', '09:35:22', '2026-09-04 07:35:22'),
(736, '::1', '/bahawalcollegeofhealth/events.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '7vq4fej6kg41nuf9ftg3s7ot94', '2026-09-04', '09:35:29', '2026-09-04 07:35:29'),
(737, '::1', '/bahawalcollegeofhealth/news.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'ect525f2melmccdp7fn5uk6ci6', '2026-09-04', '09:35:39', '2026-09-04 07:35:39'),
(738, '::1', '/bahawalcollegeofhealth/gallery.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '4kvrc6gunmpmd95fevugghu1a1', '2026-09-04', '09:35:42', '2026-09-04 07:35:42'),
(739, '::1', '/bahawalcollegeofhealth/leadership.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'k71qnfkrg7orbeqdaee0h71bo1', '2026-09-04', '09:35:47', '2026-09-04 07:35:47'),
(740, '::1', '/bahawalcollegeofhealth/mission-vision.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'bpvnur1b588v50t1olmpufc96p', '2026-09-04', '09:35:52', '2026-09-04 07:35:52'),
(741, '::1', '/bahawalcollegeofhealth/core-values.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '4af3gohblgvs6h4g2p29qbcqgp', '2026-09-04', '09:35:55', '2026-09-04 07:35:55'),
(742, '::1', '/bahawalcollegeofhealth/campuses.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'k2jjme8pg7o35gdk533ll3s8pa', '2026-09-04', '09:36:01', '2026-09-04 07:36:01'),
(743, '::1', '/bahawalcollegeofhealth/campus-portal.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'o4jbspmuhn35832ngbgkvrdeec', '2026-09-04', '09:36:07', '2026-09-04 07:36:07'),
(744, '::1', '/bahawalcollegeofhealth/alumni.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'oj5ghcis2fe6anamrv85iqooj5', '2026-09-04', '09:36:14', '2026-09-04 07:36:14'),
(745, '::1', '/bahawalcollegeofhealth/examination.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'lhlif7i2ctpivfp50dcbt3ek08', '2026-09-04', '09:36:21', '2026-09-04 07:36:21'),
(746, '::1', '/bahawalcollegeofhealth/downloads.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'gj2qorhe9u6q1gea7pk1nioe4p', '2026-09-04', '09:36:24', '2026-09-04 07:36:24'),
(747, '::1', '/bahawalcollegeofhealth/notifications.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '3g0c6s66f9taq716p82lg4c9h0', '2026-09-04', '09:36:32', '2026-09-04 07:36:32'),
(748, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'f9c9tfn35t60e7hiv64q7d0boa', '2026-09-04', '09:52:14', '2026-09-04 07:52:14'),
(749, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'f9c9tfn35t60e7hiv64q7d0boa', '2026-09-04', '09:52:20', '2026-09-04 07:52:20'),
(750, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'f9c9tfn35t60e7hiv64q7d0boa', '2026-09-04', '09:53:31', '2026-09-04 07:53:31'),
(751, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'f9c9tfn35t60e7hiv64q7d0boa', '2026-09-04', '09:55:10', '2026-09-04 07:55:10'),
(752, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'f9c9tfn35t60e7hiv64q7d0boa', '2026-09-04', '09:56:15', '2026-09-04 07:56:15'),
(753, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'f9c9tfn35t60e7hiv64q7d0boa', '2026-09-04', '09:57:00', '2026-09-04 07:57:00'),
(754, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'oacbprkr50a46marackfhsdsl2', '2026-09-04', '09:57:33', '2026-09-04 07:57:33'),
(755, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'f9c9tfn35t60e7hiv64q7d0boa', '2026-09-04', '09:58:07', '2026-09-04 07:58:07'),
(756, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '7j5cdm1octiha1a82lbkntisbk', '2026-09-04', '09:59:06', '2026-09-04 07:59:06'),
(757, '::1', '/bahawalcollegeofhealth/about.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '0h13mh9iumfa20tebe3uimk26k', '2026-09-04', '09:59:11', '2026-09-04 07:59:11'),
(758, '::1', '/bahawalcollegeofhealth/courses.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'ma8vprpiemvbvg7r54b7jrbh3i', '2026-09-04', '09:59:15', '2026-09-04 07:59:15'),
(759, '::1', '/bahawalcollegeofhealth/admission.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '3a2aopkma8qvmpc364s75aibvn', '2026-09-04', '09:59:18', '2026-09-04 07:59:18'),
(760, '::1', '/bahawalcollegeofhealth/contact.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '9k690673noc7knkurc8u5rnb74', '2026-09-04', '09:59:21', '2026-09-04 07:59:21'),
(761, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'k053ogsj1cdv5ghsn9nmfbgenp', '2026-09-04', '09:59:26', '2026-09-04 07:59:26'),
(762, '::1', '/bahawalcollegeofhealth/events.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '2mjfcsck2mae6ae6n1u0mmapde', '2026-09-04', '09:59:30', '2026-09-04 07:59:30'),
(763, '::1', '/bahawalcollegeofhealth/news.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 't4rs15aacmluk9prd31a5ku0nb', '2026-09-04', '09:59:38', '2026-09-04 07:59:38'),
(764, '::1', '/bahawalcollegeofhealth/gallery.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'miea6r0d6eruhf1crcd6a2rd1p', '2026-09-04', '09:59:43', '2026-09-04 07:59:43'),
(765, '::1', '/bahawalcollegeofhealth/leadership.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '51k4kt4gmjo4goflj58e2iln49', '2026-09-04', '09:59:49', '2026-09-04 07:59:49'),
(766, '::1', '/bahawalcollegeofhealth/mission-vision.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'gf4f9b70p3akr91oa2itias3jr', '2026-09-04', '09:59:54', '2026-09-04 07:59:54'),
(767, '::1', '/bahawalcollegeofhealth/core-values.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'jnbkistkogk43i56klhofpcar7', '2026-09-04', '09:59:57', '2026-09-04 07:59:57'),
(768, '::1', '/bahawalcollegeofhealth/campuses.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 's5d0is41a6da3kltopusscjqdi', '2026-09-04', '10:00:05', '2026-09-04 08:00:05'),
(769, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'f9c9tfn35t60e7hiv64q7d0boa', '2026-09-04', '10:00:11', '2026-09-04 08:00:11'),
(770, '::1', '/bahawalcollegeofhealth/campus-portal.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'jjdgpvl5krb4fi83uv8sdjh2io', '2026-09-04', '10:00:22', '2026-09-04 08:00:23'),
(771, '::1', '/bahawalcollegeofhealth/alumni.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '83acrl4k5ine7u11bp87ttojg7', '2026-09-04', '10:00:40', '2026-09-04 08:00:40'),
(772, '::1', '/bahawalcollegeofhealth/examination.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'rntrv845t2sed42qa18cc6k2d5', '2026-09-04', '10:00:47', '2026-09-04 08:00:47'),
(773, '::1', '/bahawalcollegeofhealth/downloads.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'va6f8cdp6rvte1dacd47ts9ok8', '2026-09-04', '10:01:06', '2026-09-04 08:01:06'),
(774, '::1', '/bahawalcollegeofhealth/notifications.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '3okk38uekj6tdjqahanopp6roj', '2026-09-04', '10:01:14', '2026-09-04 08:01:14'),
(775, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'h82cvtef2nu5iml0lhqm5dglkc', '2026-09-04', '10:01:31', '2026-09-04 08:01:31'),
(776, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'f9c9tfn35t60e7hiv64q7d0boa', '2026-09-04', '10:02:03', '2026-09-04 08:02:03'),
(777, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '7ppcl12q2tm7i4f7ic12a374mu', '2026-09-04', '10:02:34', '2026-09-04 08:02:34'),
(778, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '7ppcl12q2tm7i4f7ic12a374mu', '2026-09-04', '10:05:41', '2026-09-04 08:05:41'),
(779, '::1', '/bahawalcollegeofhealth/admission.php', '', 'http://localhost/bahawalcollegeofhealth/', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '7ppcl12q2tm7i4f7ic12a374mu', '2026-09-04', '10:05:49', '2026-09-04 08:05:49'),
(780, '::1', '/bahawalcollegeofhealth/admission.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'coaouklep6c8t4o0t14d6cdm73', '2026-09-04', '10:32:09', '2026-09-04 08:32:09'),
(781, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'l5rh9nd327e44skncq94ap8ovj', '2026-09-04', '10:33:06', '2026-09-04 08:33:06'),
(782, '::1', '/bahawalcollegeofhealth/about.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '5d7s15ue0rcv9qh1upo9lq9rma', '2026-09-04', '10:33:10', '2026-09-04 08:33:10'),
(783, '::1', '/bahawalcollegeofhealth/courses.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '3hkaaoen63rrp3d3e3le9l8sa9', '2026-09-04', '10:33:13', '2026-09-04 08:33:13'),
(784, '::1', '/bahawalcollegeofhealth/admission.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'cpdngnb0hcdejfq40dn4omfonh', '2026-09-04', '10:33:17', '2026-09-04 08:33:17'),
(785, '::1', '/bahawalcollegeofhealth/contact.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'l5u7ofb5kuq9lde22e5rse6k7r', '2026-09-04', '10:33:21', '2026-09-04 08:33:21'),
(786, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'tqkkec5u8qebb4koc604su4app', '2026-09-04', '10:33:25', '2026-09-04 08:33:25'),
(787, '::1', '/bahawalcollegeofhealth/events.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'i29ia7qmojqqom31hq0jbuptdl', '2026-09-04', '10:33:27', '2026-09-04 08:33:27'),
(788, '::1', '/bahawalcollegeofhealth/news.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'vhbe9ag1p8tcapife7e6mllegi', '2026-09-04', '10:33:30', '2026-09-04 08:33:30'),
(789, '::1', '/bahawalcollegeofhealth/gallery.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '1gjfa1ea37ajeooj9ri37clm6j', '2026-09-04', '10:33:32', '2026-09-04 08:33:32'),
(790, '::1', '/bahawalcollegeofhealth/leadership.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'vqh2ihc3q69evrrj19bg48q1vd', '2026-09-04', '10:33:35', '2026-09-04 08:33:35'),
(791, '::1', '/bahawalcollegeofhealth/mission-vision.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '35503lc04fc35rruutquihbv9b', '2026-09-04', '10:33:38', '2026-09-04 08:33:38'),
(792, '::1', '/bahawalcollegeofhealth/core-values.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'dagp8vm7ir0unhqi09d9pgdgr0', '2026-09-04', '10:33:40', '2026-09-04 08:33:40'),
(793, '::1', '/bahawalcollegeofhealth/campuses.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '41smaafib6g5bsdnimh1jf6gtg', '2026-09-04', '10:33:42', '2026-09-04 08:33:42'),
(794, '::1', '/bahawalcollegeofhealth/campus-portal.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'j5hjb9h9q0jbn5nsasil4fc103', '2026-09-04', '10:33:46', '2026-09-04 08:33:46'),
(795, '::1', '/bahawalcollegeofhealth/alumni.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '8tf0a30fkhc2g14f6q9hmgrjrg', '2026-09-04', '10:33:50', '2026-09-04 08:33:50'),
(796, '::1', '/bahawalcollegeofhealth/examination.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'urqn273h336977tgfhf20rklbj', '2026-09-04', '10:33:53', '2026-09-04 08:33:53'),
(797, '::1', '/bahawalcollegeofhealth/downloads.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'fdmi884bq3k58qcibqf2ap48kk', '2026-09-04', '10:33:57', '2026-09-04 08:33:57'),
(798, '::1', '/bahawalcollegeofhealth/notifications.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '0e76cdv2jgvjlnco8k00q313nj', '2026-09-04', '10:34:02', '2026-09-04 08:34:02'),
(799, '::1', '/bahawalcollegeofhealth/admission.php', '', 'http://localhost/bahawalcollegeofhealth/', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '7ppcl12q2tm7i4f7ic12a374mu', '2026-09-04', '10:54:46', '2026-09-04 08:54:46'),
(800, '::1', '/bahawalcollegeofhealth/admission.php', '', 'http://localhost/bahawalcollegeofhealth/', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '7ppcl12q2tm7i4f7ic12a374mu', '2026-09-04', '10:54:48', '2026-09-04 08:54:48'),
(801, '::1', '/bahawalcollegeofhealth/admission.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '6rtgo5uk58ps5q0to1agj2vt91', '2026-09-04', '11:00:55', '2026-09-04 09:00:55');
INSERT INTO `website_analytics` (`id`, `visitor_ip`, `page_url`, `page_title`, `referrer`, `user_agent`, `device_type`, `browser`, `operating_system`, `country`, `city`, `session_id`, `visit_date`, `visit_time`, `created_at`) VALUES
(802, '::1', '/bahawalcollegeofhealth/admission.php', '', 'http://localhost/bahawalcollegeofhealth/', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '7ppcl12q2tm7i4f7ic12a374mu', '2026-09-04', '11:02:40', '2026-09-04 09:02:40'),
(803, '::1', '/bahawalcollegeofhealth/index.php', '', 'http://localhost/bahawalcollegeofhealth/admission.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '7ppcl12q2tm7i4f7ic12a374mu', '2026-09-04', '11:03:02', '2026-09-04 09:03:02'),
(804, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '7ppcl12q2tm7i4f7ic12a374mu', '2026-09-04', '11:07:46', '2026-09-04 09:07:46'),
(805, '::1', '/bahawalcollegeofhealth/index.php', '', 'http://localhost/bahawalcollegeofhealth/admission.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '7ppcl12q2tm7i4f7ic12a374mu', '2026-09-04', '11:33:03', '2026-09-04 09:33:03'),
(806, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'Mozilla/5.0 (Linux; Android 15; Pixel 9) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Mobile Safari/537.36', 'Mobile', 'Chrome', 'Linux', NULL, NULL, '7ppcl12q2tm7i4f7ic12a374mu', '2026-09-04', '11:39:39', '2026-09-04 09:39:40'),
(807, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'Mozilla/5.0 (Linux; Android 15; Pixel 9) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Mobile Safari/537.36', 'Mobile', 'Chrome', 'Linux', NULL, NULL, '7ppcl12q2tm7i4f7ic12a374mu', '2026-09-04', '11:42:17', '2026-09-04 09:42:17'),
(808, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'rp65gpfs4id319aogkq47nrptj', '2026-09-04', '11:43:04', '2026-09-04 09:43:04'),
(809, '127.0.0.1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'Mozilla/5.0 (Linux; Android 15; Pixel 9) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Mobile Safari/537.36', 'Mobile', 'Chrome', 'Linux', NULL, NULL, '7ppcl12q2tm7i4f7ic12a374mu', '2026-09-04', '11:43:48', '2026-09-04 09:43:48'),
(810, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'Mozilla/5.0 (Linux; Android 15; Pixel 9) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Mobile Safari/537.36', 'Mobile', 'Chrome', 'Linux', NULL, NULL, '7ppcl12q2tm7i4f7ic12a374mu', '2026-09-04', '11:46:01', '2026-09-04 09:46:01'),
(811, '::1', '/bahawalcollegeofhealth/index.php', '', 'http://localhost/', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'vpuco0rltvpkp83hfelv4dano7', '2026-09-04', '11:46:37', '2026-09-04 09:46:37'),
(812, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'Mozilla/5.0 (Linux; Android 15; Pixel 9) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Mobile Safari/537.36', 'Mobile', 'Chrome', 'Linux', NULL, NULL, '7ppcl12q2tm7i4f7ic12a374mu', '2026-09-04', '11:54:18', '2026-09-04 09:54:18'),
(813, '::1', '/bahawalcollegeofhealth/index.php', '', 'http://localhost/', 'Mozilla/5.0 (Linux; Android 15; Pixel 9) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Mobile Safari/537.36', 'Mobile', 'Chrome', 'Linux', NULL, NULL, 'vpuco0rltvpkp83hfelv4dano7', '2026-09-04', '11:54:26', '2026-09-04 09:54:26'),
(814, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'slj6dvbt5lv9ku6bl05ehhiuks', '2026-09-04', '11:55:20', '2026-09-04 09:55:20'),
(815, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'Mozilla/5.0 (Linux; Android 15; Pixel 9) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Mobile Safari/537.36', 'Mobile', 'Chrome', 'Linux', NULL, NULL, '7ppcl12q2tm7i4f7ic12a374mu', '2026-09-04', '11:56:02', '2026-09-04 09:56:02'),
(816, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'evi5vl5qtmikfshk1clue7o2qq', '2026-09-04', '11:57:53', '2026-09-04 09:57:53'),
(817, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'vu7u4n39q6oc4kfid0clpqml7s', '2026-09-04', '11:59:07', '2026-09-04 09:59:07'),
(818, '127.0.0.1', '/bahawalcollegeofhealth/index.php', '', 'http://localhost/', 'Mozilla/5.0 (Linux; Android 15; Pixel 9) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Mobile Safari/537.36', 'Mobile', 'Chrome', 'Linux', NULL, NULL, 'vpuco0rltvpkp83hfelv4dano7', '2026-09-04', '12:03:04', '2026-09-04 10:03:04'),
(819, '::1', '/bahawalcollegeofhealth/index.php', '', 'http://localhost/', 'Mozilla/5.0 (Linux; Android 15; Pixel 9) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Mobile Safari/537.36', 'Mobile', 'Chrome', 'Linux', NULL, NULL, 'vpuco0rltvpkp83hfelv4dano7', '2026-09-04', '12:06:05', '2026-09-04 10:06:05'),
(820, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '267suchufdmsqibtdirjqep20q', '2026-09-04', '12:08:34', '2026-09-04 10:08:34'),
(821, '::1', '/bahawalcollegeofhealth/index.php', '', 'http://localhost/', 'Mozilla/5.0 (Linux; Android 15; Pixel 9) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Mobile Safari/537.36', 'Mobile', 'Chrome', 'Linux', NULL, NULL, 'vpuco0rltvpkp83hfelv4dano7', '2026-09-04', '12:09:33', '2026-09-04 10:09:33'),
(822, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'ujnt9243eko87kbf85jvhpihga', '2026-09-04', '12:10:19', '2026-09-04 10:10:19'),
(823, '::1', '/bahawalcollegeofhealth/index.php', '', 'http://localhost/', 'Mozilla/5.0 (Linux; Android 15; Pixel 9) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Mobile Safari/537.36', 'Mobile', 'Chrome', 'Linux', NULL, NULL, 'vpuco0rltvpkp83hfelv4dano7', '2026-09-04', '12:13:10', '2026-09-04 10:13:10'),
(824, '::1', '/bahawalcollegeofhealth/index.php', '', 'http://localhost/', 'Mozilla/5.0 (Linux; Android 15; Pixel 9) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Mobile Safari/537.36', 'Mobile', 'Chrome', 'Linux', NULL, NULL, 'vpuco0rltvpkp83hfelv4dano7', '2026-09-04', '12:15:15', '2026-09-04 10:15:15'),
(825, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'vgk522a9hdj21h1jpjtt4f3rrg', '2026-09-04', '12:15:46', '2026-09-04 10:15:46'),
(826, '::1', '/bahawalcollegeofhealth/about.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'ku1mjipfk17r6ndfi3veu17f6f', '2026-09-04', '12:15:51', '2026-09-04 10:15:51'),
(827, '::1', '/bahawalcollegeofhealth/courses.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '420198rk0vqh269f9u6rkasi2k', '2026-09-04', '12:15:55', '2026-09-04 10:15:55'),
(828, '::1', '/bahawalcollegeofhealth/admission.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'om05tml4cai4r56ltgdt2bup5c', '2026-09-04', '12:16:00', '2026-09-04 10:16:00'),
(829, '::1', '/bahawalcollegeofhealth/contact.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'qef559nbbtrnrf7goil3ontikf', '2026-09-04', '12:16:04', '2026-09-04 10:16:04'),
(830, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'a0hq00rqod44ia0e6hoc7n0stl', '2026-09-04', '12:16:08', '2026-09-04 10:16:08'),
(831, '::1', '/bahawalcollegeofhealth/events.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'uhis8adh7f55n6gnkv2l49m313', '2026-09-04', '12:16:11', '2026-09-04 10:16:11'),
(832, '::1', '/bahawalcollegeofhealth/news.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'd3j397bickrrl3u2c7f64ekm5k', '2026-09-04', '12:16:14', '2026-09-04 10:16:14'),
(833, '::1', '/bahawalcollegeofhealth/gallery.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'ikvf25hnhuuf63j6h4qpqqr8fo', '2026-09-04', '12:16:18', '2026-09-04 10:16:18'),
(834, '::1', '/bahawalcollegeofhealth/leadership.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'ethke6hkse7cs8v6pqqrarn8s4', '2026-09-04', '12:16:21', '2026-09-04 10:16:21'),
(835, '::1', '/bahawalcollegeofhealth/mission-vision.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'v67dsoc39ji12uo7s7hhdtmdnt', '2026-09-04', '12:16:24', '2026-09-04 10:16:24'),
(836, '::1', '/bahawalcollegeofhealth/core-values.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '01n0j8j6o7sbj7bdvngv06m2jk', '2026-09-04', '12:16:27', '2026-09-04 10:16:27'),
(837, '::1', '/bahawalcollegeofhealth/campuses.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'n3pc43gvdia9ke30p79lgrsn42', '2026-09-04', '12:16:31', '2026-09-04 10:16:31'),
(838, '::1', '/bahawalcollegeofhealth/campus-portal.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'p7k2nj778fpnloqe804kl9ii3c', '2026-09-04', '12:16:36', '2026-09-04 10:16:36'),
(839, '::1', '/bahawalcollegeofhealth/alumni.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'hjtml97vnaq7uvppusmgcmtrr7', '2026-09-04', '12:16:41', '2026-09-04 10:16:41'),
(840, '::1', '/bahawalcollegeofhealth/examination.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'opqelmofi6ll3doc6p83agab9c', '2026-09-04', '12:16:45', '2026-09-04 10:16:45'),
(841, '::1', '/bahawalcollegeofhealth/downloads.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'jd96r0dv4svlm90p3krql03i6t', '2026-09-04', '12:16:49', '2026-09-04 10:16:49'),
(842, '::1', '/bahawalcollegeofhealth/index.php', '', 'http://localhost/', 'Mozilla/5.0 (Linux; Android 15; Pixel 9) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Mobile Safari/537.36', 'Mobile', 'Chrome', 'Linux', NULL, NULL, 'vpuco0rltvpkp83hfelv4dano7', '2026-09-04', '12:17:01', '2026-09-04 10:17:01'),
(843, '::1', '/bahawalcollegeofhealth/notifications.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'a1dklv1rurq1sanfmlcnn1sqi6', '2026-09-04', '12:17:04', '2026-09-04 10:17:04'),
(844, '::1', '/bahawalcollegeofhealth/index.php', '', 'http://localhost/', 'Mozilla/5.0 (Linux; Android 15; Pixel 9) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Mobile Safari/537.36', 'Mobile', 'Chrome', 'Linux', NULL, NULL, 'vpuco0rltvpkp83hfelv4dano7', '2026-09-04', '12:18:19', '2026-09-04 10:18:19'),
(845, '::1', '/bahawalcollegeofhealth/index.php', '', 'http://localhost/', 'Mozilla/5.0 (Linux; Android 15; Pixel 9) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Mobile Safari/537.36', 'Mobile', 'Chrome', 'Linux', NULL, NULL, 'vpuco0rltvpkp83hfelv4dano7', '2026-09-04', '12:19:16', '2026-09-04 10:19:16'),
(846, '::1', '/bahawalcollegeofhealth/index.php', '', 'http://localhost/', 'Mozilla/5.0 (Linux; Android 15; Pixel 9) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Mobile Safari/537.36', 'Mobile', 'Chrome', 'Linux', NULL, NULL, 'vpuco0rltvpkp83hfelv4dano7', '2026-09-04', '12:22:17', '2026-09-04 10:22:17'),
(847, '::1', '/bahawalcollegeofhealth/index.php', '', 'http://localhost/', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'gsph9kh6osqelsgipsjfhr5e31', '2026-09-14', '09:47:00', '2026-09-14 07:47:00'),
(848, '::1', '/bahawalcollegeofhealth/index.php', '', 'http://localhost/', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'gsph9kh6osqelsgipsjfhr5e31', '2026-09-14', '10:48:21', '2026-09-14 08:48:21'),
(849, '::1', '/bahawalcollegeofhealth/courses.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'pig835esdj9jdvbvtsfccf7f3h', '2026-09-14', '11:21:12', '2026-09-14 09:21:12'),
(850, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'cq4u2euvrkpp3ji4ehss7shd9b', '2026-09-14', '11:21:54', '2026-09-14 09:21:54'),
(851, '::1', '/bahawalcollegeofhealth/about.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '5ufc2mvo0ac9mc2mf5ndjr717c', '2026-09-14', '11:21:54', '2026-09-14 09:21:54'),
(852, '::1', '/bahawalcollegeofhealth/courses.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 't8523kudrci117mnhk83bps2cp', '2026-09-14', '11:21:54', '2026-09-14 09:21:54'),
(853, '::1', '/bahawalcollegeofhealth/admission.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'c9jjadmheg5ga9ut16jhs32mtq', '2026-09-14', '11:21:55', '2026-09-14 09:21:55'),
(854, '::1', '/bahawalcollegeofhealth/contact.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'apfauj0ca7b98h639ls7t3nvn7', '2026-09-14', '11:21:55', '2026-09-14 09:21:55'),
(855, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'cllp7arit75g3ci7263eiocc7t', '2026-09-14', '11:21:56', '2026-09-14 09:21:56'),
(856, '::1', '/bahawalcollegeofhealth/events.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '79jrrss6lhsgrqo0jodp3e9i9n', '2026-09-14', '11:21:56', '2026-09-14 09:21:56'),
(857, '::1', '/bahawalcollegeofhealth/news.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'ak8oe01qg0b2sgfv1bhvitvqan', '2026-09-14', '11:21:57', '2026-09-14 09:21:57'),
(858, '::1', '/bahawalcollegeofhealth/gallery.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'ifkeem09c2kvpva81b2iptgo68', '2026-09-14', '11:21:57', '2026-09-14 09:21:57'),
(859, '::1', '/bahawalcollegeofhealth/leadership.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'qs3qtjrgvp5h5hp82cmkuh0b1i', '2026-09-14', '11:21:58', '2026-09-14 09:21:58'),
(860, '::1', '/bahawalcollegeofhealth/mission-vision.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'r41ta9tugmt542hdj4r95ln78k', '2026-09-14', '11:21:58', '2026-09-14 09:21:58'),
(861, '::1', '/bahawalcollegeofhealth/core-values.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '7rlfqcnpd85rt575ohst5qncmk', '2026-09-14', '11:21:58', '2026-09-14 09:21:58'),
(862, '::1', '/bahawalcollegeofhealth/campuses.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'nad6sggjq3qjmakd0cbddk8jmm', '2026-09-14', '11:21:59', '2026-09-14 09:21:59'),
(863, '::1', '/bahawalcollegeofhealth/campus-portal.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '74hjamilp3mjp07cdppev32p9g', '2026-09-14', '11:21:59', '2026-09-14 09:21:59'),
(864, '::1', '/bahawalcollegeofhealth/alumni.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'ir33nbkdk8n0jqfonagv114dqp', '2026-09-14', '11:21:59', '2026-09-14 09:21:59'),
(865, '::1', '/bahawalcollegeofhealth/examination.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '65hrkquo0n47h1040r1f8eeu72', '2026-09-14', '11:22:00', '2026-09-14 09:22:00'),
(866, '::1', '/bahawalcollegeofhealth/downloads.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '6bc3redmvmodl4gjn1f5ns1bb4', '2026-09-14', '11:22:00', '2026-09-14 09:22:00'),
(867, '::1', '/bahawalcollegeofhealth/notifications.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '7s92016nvulim9ot1julumn1s4', '2026-09-14', '11:22:01', '2026-09-14 09:22:01'),
(868, '::1', '/bahawalcollegeofhealth/clinical-training.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'nf3g8uq2itt6r5mlmr1nm274sp', '2026-09-14', '11:26:38', '2026-09-14 09:26:38'),
(869, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'd76hmchj6foo493f8r60304msm', '2026-09-14', '11:26:39', '2026-09-14 09:26:39'),
(870, '::1', '/bahawalcollegeofhealth/clinical-training.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'tp32ojbb208u8gmj7ganhfkmkd', '2026-09-14', '11:27:29', '2026-09-14 09:27:29'),
(871, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'vpfebl9gl8tl8oum4tijac0p1a', '2026-09-14', '11:27:53', '2026-09-14 09:27:53'),
(872, '::1', '/bahawalcollegeofhealth/about.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'nr5sj1apf141gsa4l0jiqc06ls', '2026-09-14', '11:27:54', '2026-09-14 09:27:54'),
(873, '::1', '/bahawalcollegeofhealth/courses.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'hkiqqgles2eib0es191fbvpr8r', '2026-09-14', '11:27:55', '2026-09-14 09:27:55'),
(874, '::1', '/bahawalcollegeofhealth/admission.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '85kld7atldf396toeb87ca79i3', '2026-09-14', '11:27:57', '2026-09-14 09:27:57'),
(875, '::1', '/bahawalcollegeofhealth/contact.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'td8kdhafpaqpbbmenlipm823hf', '2026-09-14', '11:27:59', '2026-09-14 09:27:59'),
(876, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'ppemt7hab17qrt8vui1r468uel', '2026-09-14', '11:28:01', '2026-09-14 09:28:01'),
(877, '::1', '/bahawalcollegeofhealth/events.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '82g7t8khr104avrju2hcdgt7dc', '2026-09-14', '11:28:03', '2026-09-14 09:28:03'),
(878, '::1', '/bahawalcollegeofhealth/news.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '8507cimmlf2qkkuej78t63drqm', '2026-09-14', '11:28:05', '2026-09-14 09:28:05'),
(879, '::1', '/bahawalcollegeofhealth/gallery.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '3mdref42ndj2nqqi4d29hfla4u', '2026-09-14', '11:28:06', '2026-09-14 09:28:06'),
(880, '::1', '/bahawalcollegeofhealth/leadership.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '2mp35792pa7fcpq1cjpe0gdm9d', '2026-09-14', '11:28:07', '2026-09-14 09:28:07'),
(881, '::1', '/bahawalcollegeofhealth/mission-vision.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'atilacl7mklv87p0t2j746datl', '2026-09-14', '11:28:08', '2026-09-14 09:28:08'),
(882, '::1', '/bahawalcollegeofhealth/core-values.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'i8ml04knuplo4jctkpikfumsah', '2026-09-14', '11:28:13', '2026-09-14 09:28:13'),
(883, '::1', '/bahawalcollegeofhealth/campuses.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'trolhvm7d42d7kh90btrv147rm', '2026-09-14', '11:28:14', '2026-09-14 09:28:14'),
(884, '::1', '/bahawalcollegeofhealth/campus-portal.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'qt4m4t7i4fdlek2uuqku527497', '2026-09-14', '11:28:15', '2026-09-14 09:28:15'),
(885, '::1', '/bahawalcollegeofhealth/alumni.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'm53bfe92novmnc2mnpst2lr1bj', '2026-09-14', '11:28:15', '2026-09-14 09:28:15'),
(886, '::1', '/bahawalcollegeofhealth/examination.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'j9bkhmgt6mf6cispm1d5v17r4j', '2026-09-14', '11:28:16', '2026-09-14 09:28:16'),
(887, '::1', '/bahawalcollegeofhealth/downloads.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '4it1rg36bkuvekuj5ebtgv8j6g', '2026-09-14', '11:28:16', '2026-09-14 09:28:16'),
(888, '::1', '/bahawalcollegeofhealth/notifications.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'hrfdgkd9gbpcg5qs3rch9euv8m', '2026-09-14', '11:28:17', '2026-09-14 09:28:17'),
(889, '::1', '/bahawalcollegeofhealth/clinical-training.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'ufokf1flm5plttponogauijet2', '2026-09-14', '11:28:18', '2026-09-14 09:28:18'),
(890, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'jjd0b1l50mrb44m57fd471q456', '2026-09-14', '11:31:13', '2026-09-14 09:31:13'),
(891, '::1', '/bahawalcollegeofhealth/courses.php', '', 'http://localhost/bahawalcollegeofhealth/', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'jjd0b1l50mrb44m57fd471q456', '2026-09-14', '11:31:23', '2026-09-14 09:31:23'),
(892, '::1', '/bahawalcollegeofhealth/fee-calculator.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '7mrghi62m4louhs3c9bca0m812', '2026-09-14', '11:32:28', '2026-09-14 09:32:28'),
(893, '::1', '/bahawalcollegeofhealth/fee-calculator.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'e4f0qf148qul1nftksagqqs3ff', '2026-09-14', '11:33:17', '2026-09-14 09:33:17'),
(894, '::1', '/bahawalcollegeofhealth/fee-calculator.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '67n1e1rvjm74qklmtt08vrgu7d', '2026-09-14', '11:35:43', '2026-09-14 09:35:43'),
(895, '::1', '/bahawalcollegeofhealth/fee-calculator.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'kd88cuk2ipun9mk3urfuas5tej', '2026-09-14', '11:36:53', '2026-09-14 09:36:53'),
(896, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'tbij89cka54ajolq02io48qve7', '2026-09-14', '11:37:01', '2026-09-14 09:37:01'),
(897, '::1', '/bahawalcollegeofhealth/about.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'bgm21iqb3mter46i7qolas2tn5', '2026-09-14', '11:37:02', '2026-09-14 09:37:02'),
(898, '::1', '/bahawalcollegeofhealth/courses.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'p97ta19f1k0crm381vtb8snl5k', '2026-09-14', '11:37:02', '2026-09-14 09:37:02'),
(899, '::1', '/bahawalcollegeofhealth/admission.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'ab94smh4eut65f76lbjf0q8ir6', '2026-09-14', '11:37:03', '2026-09-14 09:37:03'),
(900, '::1', '/bahawalcollegeofhealth/contact.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'qu98uh8qagm242p8uj45k8g0nd', '2026-09-14', '11:37:04', '2026-09-14 09:37:04'),
(901, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'isvb23dd83ggd5erq1bpvlvl6f', '2026-09-14', '11:37:07', '2026-09-14 09:37:07'),
(902, '::1', '/bahawalcollegeofhealth/events.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '59lj9jojpq6vdg4kp0m5t0v99i', '2026-09-14', '11:37:07', '2026-09-14 09:37:07'),
(903, '::1', '/bahawalcollegeofhealth/news.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '8kj2ur66jpa3quglq238oevtc7', '2026-09-14', '11:37:09', '2026-09-14 09:37:09'),
(904, '::1', '/bahawalcollegeofhealth/gallery.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'kf4rkss22g44vngbvndla1t4fp', '2026-09-14', '11:37:09', '2026-09-14 09:37:09'),
(905, '::1', '/bahawalcollegeofhealth/leadership.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'sqft24fvrnh5o63q78dngcl8j2', '2026-09-14', '11:37:10', '2026-09-14 09:37:10'),
(906, '::1', '/bahawalcollegeofhealth/mission-vision.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '73ps41q4gtap8d05a87g9mng43', '2026-09-14', '11:37:10', '2026-09-14 09:37:10'),
(907, '::1', '/bahawalcollegeofhealth/core-values.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'i86ets133b3uun0h77u8umacmi', '2026-09-14', '11:37:11', '2026-09-14 09:37:11'),
(908, '::1', '/bahawalcollegeofhealth/campuses.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'egcbq1951q5mdjc232o9b30oog', '2026-09-14', '11:37:11', '2026-09-14 09:37:11'),
(909, '::1', '/bahawalcollegeofhealth/campus-portal.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'n6579617b1ik6dtdn8slumkch9', '2026-09-14', '11:37:12', '2026-09-14 09:37:12'),
(910, '::1', '/bahawalcollegeofhealth/alumni.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'amdhkt8bjdalcclkl5s8uatru5', '2026-09-14', '11:37:12', '2026-09-14 09:37:12'),
(911, '::1', '/bahawalcollegeofhealth/examination.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'gbk0bbsgnujfbera44b1n802lm', '2026-09-14', '11:37:13', '2026-09-14 09:37:13'),
(912, '::1', '/bahawalcollegeofhealth/downloads.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 's0h79a5a1fa13s7d59b8vdi1dv', '2026-09-14', '11:37:14', '2026-09-14 09:37:14'),
(913, '::1', '/bahawalcollegeofhealth/notifications.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'taiue0h8iv5kinmsdcoma63nld', '2026-09-14', '11:37:14', '2026-09-14 09:37:14'),
(914, '::1', '/bahawalcollegeofhealth/clinical-training.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '0okd2bv12mo2lh3k945vh3dedb', '2026-09-14', '11:37:15', '2026-09-14 09:37:15'),
(915, '::1', '/bahawalcollegeofhealth/fee-calculator.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'ucqjefqvovkemj01dk4ms4kb2i', '2026-09-14', '11:37:15', '2026-09-14 09:37:15'),
(916, '::1', '/bahawalcollegeofhealth/courses.php', '', 'http://localhost/bahawalcollegeofhealth/', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'jjd0b1l50mrb44m57fd471q456', '2026-09-14', '11:37:38', '2026-09-14 09:37:38'),
(917, '::1', '/bahawalcollegeofhealth/scholarships.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'hlsrf3abpd2qatlbogcsgubd46', '2026-09-14', '11:43:30', '2026-09-14 09:43:30'),
(918, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'ah1cbjncdaekh85q5b60mim4lb', '2026-09-14', '11:43:31', '2026-09-14 09:43:31'),
(919, '::1', '/bahawalcollegeofhealth/scholarships.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'qpsvid53ksmobv164bruvsdodc', '2026-09-14', '11:44:13', '2026-09-14 09:44:13'),
(920, '::1', '/bahawalcollegeofhealth/scholarships.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '1vclvt046l171s2fag308m80b7', '2026-09-14', '11:44:58', '2026-09-14 09:44:58'),
(921, '::1', '/bahawalcollegeofhealth/admission.php', '', 'http://localhost/bahawalcollegeofhealth/scholarships.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '1vclvt046l171s2fag308m80b7', '2026-09-14', '11:45:18', '2026-09-14 09:45:18'),
(922, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'on9nkcoq4kgf8llq41l6f9biof', '2026-09-14', '11:46:09', '2026-09-14 09:46:09'),
(923, '::1', '/bahawalcollegeofhealth/about.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'ul5o0ef6mh1h0vj2dabmn8guvn', '2026-09-14', '11:46:10', '2026-09-14 09:46:10'),
(924, '::1', '/bahawalcollegeofhealth/courses.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'uo8a9fqnl2dqefaf4h5dc4sm3k', '2026-09-14', '11:46:11', '2026-09-14 09:46:11'),
(925, '::1', '/bahawalcollegeofhealth/admission.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'ekeneoa7153dsejkqa73cp6ghn', '2026-09-14', '11:46:11', '2026-09-14 09:46:11'),
(926, '::1', '/bahawalcollegeofhealth/contact.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '7tno2e48ljk0q977coqd5bqqel', '2026-09-14', '11:46:11', '2026-09-14 09:46:11'),
(927, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'pq0ugd9p2rua37griubautk3q7', '2026-09-14', '11:46:12', '2026-09-14 09:46:12'),
(928, '::1', '/bahawalcollegeofhealth/events.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'e6g3bkg753ik0m394h9e9chbn0', '2026-09-14', '11:46:12', '2026-09-14 09:46:12'),
(929, '::1', '/bahawalcollegeofhealth/news.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'ipu4961rg7ean6t0fgk3qvhsca', '2026-09-14', '11:46:13', '2026-09-14 09:46:13'),
(930, '::1', '/bahawalcollegeofhealth/gallery.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '3fv7kr8q98tn2mspb3bijp6s50', '2026-09-14', '11:46:13', '2026-09-14 09:46:13'),
(931, '::1', '/bahawalcollegeofhealth/leadership.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '3f4lqdgknbujvasf21iib8gvfh', '2026-09-14', '11:46:14', '2026-09-14 09:46:14'),
(932, '::1', '/bahawalcollegeofhealth/mission-vision.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '3irpifijhi49v4ninhat7vbv9k', '2026-09-14', '11:46:14', '2026-09-14 09:46:14'),
(933, '::1', '/bahawalcollegeofhealth/core-values.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'p26hosb4n791fmu3624feo49gv', '2026-09-14', '11:46:15', '2026-09-14 09:46:15'),
(934, '::1', '/bahawalcollegeofhealth/campuses.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'jtb98nblurl5hs3n04gjpkoi22', '2026-09-14', '11:46:16', '2026-09-14 09:46:16'),
(935, '::1', '/bahawalcollegeofhealth/campus-portal.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'ucansc62unp5nbljcq12mse3gk', '2026-09-14', '11:46:16', '2026-09-14 09:46:16'),
(936, '::1', '/bahawalcollegeofhealth/alumni.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'aits8eq4p6u5ngpv9553nu19dd', '2026-09-14', '11:46:17', '2026-09-14 09:46:17'),
(937, '::1', '/bahawalcollegeofhealth/examination.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'oobl7770vhd8e4o1or61ajrmou', '2026-09-14', '11:46:18', '2026-09-14 09:46:18'),
(938, '::1', '/bahawalcollegeofhealth/downloads.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'jkt3li1e030sh86mg26p92pjlf', '2026-09-14', '11:46:18', '2026-09-14 09:46:18'),
(939, '::1', '/bahawalcollegeofhealth/notifications.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'suemhmr369470pr7039g145bo7', '2026-09-14', '11:46:19', '2026-09-14 09:46:19'),
(940, '::1', '/bahawalcollegeofhealth/clinical-training.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'qcln0ugf4f5k71f2i56i5v3tka', '2026-09-14', '11:46:19', '2026-09-14 09:46:19'),
(941, '::1', '/bahawalcollegeofhealth/fee-calculator.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'n0kf4clpuv7fa4em0d1gfqunsc', '2026-09-14', '11:46:20', '2026-09-14 09:46:20'),
(942, '::1', '/bahawalcollegeofhealth/scholarships.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'bu9tugm143p82qnuddkq1l2saj', '2026-09-14', '11:46:23', '2026-09-14 09:46:23'),
(943, '::1', '/bahawalcollegeofhealth/scholarships.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'cu7nplv43l1lu1rqul0h1i2rm3', '2026-09-14', '11:51:33', '2026-09-14 09:51:33'),
(944, '::1', '/bahawalcollegeofhealth/scholarships.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'atti0iko715n1r25lkq7o08r45', '2026-09-14', '11:52:43', '2026-09-14 09:52:43'),
(945, '::1', '/bahawalcollegeofhealth/scholarships.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'avmp9sra1esgt36qm1vg7ruic5', '2026-09-14', '11:52:54', '2026-09-14 09:52:54'),
(946, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'lnel30h8md4tr2n1c8oil7bk4i', '2026-09-14', '11:54:12', '2026-09-14 09:54:12'),
(947, '::1', '/bahawalcollegeofhealth/about.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'ru36ffobogj6r9qbo1o1prsmj1', '2026-09-14', '11:54:13', '2026-09-14 09:54:13'),
(948, '::1', '/bahawalcollegeofhealth/courses.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'isltel66dic82tk8crielv9ru7', '2026-09-14', '11:54:13', '2026-09-14 09:54:13'),
(949, '::1', '/bahawalcollegeofhealth/admission.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'uoe3pkl37hnhdfiiojb242guh0', '2026-09-14', '11:54:14', '2026-09-14 09:54:14'),
(950, '::1', '/bahawalcollegeofhealth/contact.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '2ee0694jmi8tvi9d5mimi96d3h', '2026-09-14', '11:54:14', '2026-09-14 09:54:14'),
(951, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'ono0e8hu58301leke7fbg3qoga', '2026-09-14', '11:54:15', '2026-09-14 09:54:15'),
(952, '::1', '/bahawalcollegeofhealth/events.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'bs26shbic423i9oo1cimi71r2d', '2026-09-14', '11:54:16', '2026-09-14 09:54:16'),
(953, '::1', '/bahawalcollegeofhealth/news.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '71j3uu6mfn5crtm1eg3r9hkpbd', '2026-09-14', '11:54:16', '2026-09-14 09:54:16'),
(954, '::1', '/bahawalcollegeofhealth/gallery.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'htv064pe0k7nq0afodvesgvns9', '2026-09-14', '11:54:21', '2026-09-14 09:54:21'),
(955, '::1', '/bahawalcollegeofhealth/leadership.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'hjqcope32lfpiq2gpefahtr6ri', '2026-09-14', '11:54:23', '2026-09-14 09:54:23'),
(956, '::1', '/bahawalcollegeofhealth/mission-vision.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '2navs1f49dn4k2t987gg6go8um', '2026-09-14', '11:54:24', '2026-09-14 09:54:24'),
(957, '::1', '/bahawalcollegeofhealth/core-values.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'v7ji4bgnbnn5rpd2qstik1erie', '2026-09-14', '11:54:24', '2026-09-14 09:54:24'),
(958, '::1', '/bahawalcollegeofhealth/campuses.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'gbba4ludpk8ifiloav0ktl0u2t', '2026-09-14', '11:54:24', '2026-09-14 09:54:24'),
(959, '::1', '/bahawalcollegeofhealth/campus-portal.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'qisauv3lhhbmmpr7nqlo0ps9dt', '2026-09-14', '11:54:25', '2026-09-14 09:54:25'),
(960, '::1', '/bahawalcollegeofhealth/alumni.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '0fum4eni3f06hgpq25bb6e8vde', '2026-09-14', '11:54:25', '2026-09-14 09:54:25'),
(961, '::1', '/bahawalcollegeofhealth/examination.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'miti9g81aouatr1lsd38a45c8h', '2026-09-14', '11:54:26', '2026-09-14 09:54:26'),
(962, '::1', '/bahawalcollegeofhealth/downloads.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'p4e93dhgkenc1f9nt9dvce4q4u', '2026-09-14', '11:54:26', '2026-09-14 09:54:26'),
(963, '::1', '/bahawalcollegeofhealth/notifications.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '68g090m0np3q5jrl8591cdtrk3', '2026-09-14', '11:54:27', '2026-09-14 09:54:27'),
(964, '::1', '/bahawalcollegeofhealth/clinical-training.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'q632cn11vuppdmeak3pr46cclj', '2026-09-14', '11:54:28', '2026-09-14 09:54:28'),
(965, '::1', '/bahawalcollegeofhealth/fee-calculator.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '22g1domo843cq9l87scqn4as84', '2026-09-14', '11:54:29', '2026-09-14 09:54:29'),
(966, '::1', '/bahawalcollegeofhealth/scholarships.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '6ts032169k1u4r6ed13pvijt40', '2026-09-14', '11:54:29', '2026-09-14 09:54:29'),
(967, '::1', '/bahawalcollegeofhealth/fee-calculator.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '5ill8sjb02uhcacmbpsn2uf4ep', '2026-09-14', '12:02:12', '2026-09-14 10:02:12'),
(968, '::1', '/bahawalcollegeofhealth/fee-calculator.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'nik6md340utubvu6b71g2aacca', '2026-09-14', '12:02:13', '2026-09-14 10:02:13'),
(969, '::1', '/bahawalcollegeofhealth/fee-calculator.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'qad2vt1up9g4kqdlmlcff505nj', '2026-09-14', '12:02:13', '2026-09-14 10:02:13'),
(970, '::1', '/bahawalcollegeofhealth/scholarships.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'cv8v617pqc3fie7ala1fkl6r36', '2026-09-14', '12:02:20', '2026-09-14 10:02:20'),
(971, '::1', '/bahawalcollegeofhealth/scholarships.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'qm8ljgcajao27g1apvmjg3atvi', '2026-09-14', '12:02:20', '2026-09-14 10:02:20'),
(972, '::1', '/bahawalcollegeofhealth/fee-calculator.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'g37gvq2q4475npn86ukqksat3b', '2026-09-14', '12:03:02', '2026-09-14 10:03:02'),
(973, '::1', '/bahawalcollegeofhealth/fee-calculator.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '38jdcqse9i1febf6hmblr1b0qs', '2026-09-14', '12:03:49', '2026-09-14 10:03:49'),
(974, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'nks1i2iobtlcojhjjl93jqs3u3', '2026-09-14', '12:04:12', '2026-09-14 10:04:12'),
(975, '::1', '/bahawalcollegeofhealth/courses.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'ep5mi7p842hvgunhjaj1rbs1tp', '2026-09-14', '12:04:13', '2026-09-14 10:04:13'),
(976, '::1', '/bahawalcollegeofhealth/clinical-training.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'so22rlntl4fljjvs1lv0m9crfs', '2026-09-14', '12:04:13', '2026-09-14 10:04:13'),
(977, '::1', '/bahawalcollegeofhealth/fee-calculator.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '774h60ap58drpdao4vijvq3v64', '2026-09-14', '12:04:14', '2026-09-14 10:04:14'),
(978, '::1', '/bahawalcollegeofhealth/scholarships.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '6412o92q1hoe2bd4gmtigrti64', '2026-09-14', '12:04:14', '2026-09-14 10:04:14'),
(979, '::1', '/bahawalcollegeofhealth/admission.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'n82b0iirl4e151jlbp224rmjdd', '2026-09-14', '12:04:15', '2026-09-14 10:04:15'),
(980, '::1', '/bahawalcollegeofhealth/about.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '3c4gkuq2uvm9rg1vdrp4nk6dui', '2026-09-14', '12:04:15', '2026-09-14 10:04:15'),
(981, '::1', '/bahawalcollegeofhealth/contact.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '80lqvejfp9vcoh60329ao4u931', '2026-09-14', '12:04:16', '2026-09-14 10:04:16'),
(982, '::1', '/bahawalcollegeofhealth/our-networks.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'sqpkaetv4nn20nddekonq5p0qh', '2026-09-14', '12:16:23', '2026-09-14 10:16:23'),
(983, '::1', '/bahawalcollegeofhealth/our-networks.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'jjnrh3a1sjl1blcc15ogk1sffr', '2026-09-14', '12:16:24', '2026-09-14 10:16:24'),
(984, '::1', '/bahawalcollegeofhealth/our-networks.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '7b6tmjej83po83rlcdk790aubt', '2026-09-14', '12:17:37', '2026-09-14 10:17:37'),
(985, '::1', '/bahawalcollegeofhealth/our-networks.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'opng8alk6rnslpf133780jc8st', '2026-09-14', '12:18:03', '2026-09-14 10:18:03'),
(986, '::1', '/bahawalcollegeofhealth/our-networks.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '8kinc7m4jes72030segk33lkdu', '2026-09-14', '12:18:34', '2026-09-14 10:18:34'),
(987, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'jt10jrrm1r2hb9intdhlrr2jhb', '2026-09-14', '12:19:35', '2026-09-14 10:19:35'),
(988, '::1', '/bahawalcollegeofhealth/courses.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'm8u54bcuvvnpbqe959amvq6ca8', '2026-09-14', '12:19:36', '2026-09-14 10:19:36'),
(989, '::1', '/bahawalcollegeofhealth/clinical-training.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'qcvq136fnpdmuq7h0hovuolfdk', '2026-09-14', '12:19:36', '2026-09-14 10:19:36'),
(990, '::1', '/bahawalcollegeofhealth/fee-calculator.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'uj9h1d3mr57p049023p36sdi6r', '2026-09-14', '12:19:37', '2026-09-14 10:19:37'),
(991, '::1', '/bahawalcollegeofhealth/scholarships.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '5cnr17mub76815duksh0a0shkv', '2026-09-14', '12:19:38', '2026-09-14 10:19:38'),
(992, '::1', '/bahawalcollegeofhealth/our-networks.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'hv8basgsp5l5j7o2dbqsks1unn', '2026-09-14', '12:19:38', '2026-09-14 10:19:38'),
(993, '::1', '/bahawalcollegeofhealth/admission.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '035bi6883049j681jaf71bja1l', '2026-09-14', '12:19:39', '2026-09-14 10:19:39'),
(994, '::1', '/bahawalcollegeofhealth/about.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'lfm2s08bh5nknojp7ua1qvmdj5', '2026-09-14', '12:19:39', '2026-09-14 10:19:39'),
(995, '::1', '/bahawalcollegeofhealth/contact.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'us9j4ogurl3a77g2an2dblnfhd', '2026-09-14', '12:19:40', '2026-09-14 10:19:40'),
(996, '::1', '/bahawalcollegeofhealth/our-networks.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'q4nhua36lsd7shu8c1a3d7kvil', '2026-09-14', '12:19:41', '2026-09-14 10:19:41'),
(997, '::1', '/bahawalcollegeofhealth/our-projects.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '668tm1tqtc4cpugp7ks2ean6ct', '2026-09-14', '12:25:49', '2026-09-14 10:25:49'),
(998, '::1', '/bahawalcollegeofhealth/index.php', '', 'http://localhost/', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'gsph9kh6osqelsgipsjfhr5e31', '2026-09-14', '12:26:31', '2026-09-14 10:26:31'),
(999, '::1', '/bahawalcollegeofhealth/our-projects.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'eoibh95iud4m2acjh4btlkhlm8', '2026-09-14', '12:26:51', '2026-09-14 10:26:51'),
(1000, '::1', '/bahawalcollegeofhealth/courses.php', '', 'http://localhost/bahawalcollegeofhealth/', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'jjd0b1l50mrb44m57fd471q456', '2026-09-14', '12:27:03', '2026-09-14 10:27:03'),
(1001, '::1', '/bahawalcollegeofhealth/our-projects.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'sg5q3ipkjnq7cb8flpqanqtc4q', '2026-09-14', '12:27:22', '2026-09-14 10:27:22'),
(1002, '::1', '/bahawalcollegeofhealth/our-projects.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '2iqs0j5e8bsnrhpu11ls774kj4', '2026-09-14', '12:27:37', '2026-09-14 10:27:37'),
(1003, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 't8dus0can1d5mcj9gpvaja59e6', '2026-09-14', '12:28:34', '2026-09-14 10:28:34'),
(1004, '::1', '/bahawalcollegeofhealth/courses.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'd1g6ujbe8upoi4g4ikki1dntqu', '2026-09-14', '12:28:36', '2026-09-14 10:28:36'),
(1005, '::1', '/bahawalcollegeofhealth/clinical-training.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'uadu5pu8vb0p4v0fuiav93u8uq', '2026-09-14', '12:28:37', '2026-09-14 10:28:37');
INSERT INTO `website_analytics` (`id`, `visitor_ip`, `page_url`, `page_title`, `referrer`, `user_agent`, `device_type`, `browser`, `operating_system`, `country`, `city`, `session_id`, `visit_date`, `visit_time`, `created_at`) VALUES
(1006, '::1', '/bahawalcollegeofhealth/fee-calculator.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'plfcgug2fvelvml21efreq3bgl', '2026-09-14', '12:28:38', '2026-09-14 10:28:38'),
(1007, '::1', '/bahawalcollegeofhealth/scholarships.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'ivn8n2jp9l2sht0at2vqbv6lgv', '2026-09-14', '12:28:40', '2026-09-14 10:28:40'),
(1008, '::1', '/bahawalcollegeofhealth/our-networks.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '1v6tjimvn2o0bfmjqjovd6tspc', '2026-09-14', '12:28:41', '2026-09-14 10:28:41'),
(1009, '::1', '/bahawalcollegeofhealth/our-projects.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'caeodj73q6okskkq7sptlqkea5', '2026-09-14', '12:28:42', '2026-09-14 10:28:42'),
(1010, '::1', '/bahawalcollegeofhealth/admission.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '46jpjc4j7s1p1864q136cuj0as', '2026-09-14', '12:28:42', '2026-09-14 10:28:42'),
(1011, '::1', '/bahawalcollegeofhealth/about.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'd51kbk4nvia9l3qd5hslrfaccq', '2026-09-14', '12:28:43', '2026-09-14 10:28:43'),
(1012, '::1', '/bahawalcollegeofhealth/contact.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 's27a577tvtqs6n39d3uo5lqpal', '2026-09-14', '12:28:44', '2026-09-14 10:28:44'),
(1013, '::1', '/bahawalcollegeofhealth/our-projects.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'e85p7qkguv0s50lc8jlfsi05vs', '2026-09-14', '12:28:45', '2026-09-14 10:28:45'),
(1014, '::1', '/bahawalcollegeofhealth/accreditation.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '9seq0m8okhtm2eijt72fd4g6nd', '2026-09-14', '12:32:07', '2026-09-14 10:32:07'),
(1015, '::1', '/bahawalcollegeofhealth/accreditation.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'kt4d5jkmnna4goup10cks0c0e4', '2026-09-14', '12:32:41', '2026-09-14 10:32:41'),
(1016, '::1', '/bahawalcollegeofhealth/accreditation.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'cn3v1g526r0a5pccjff1vsf13o', '2026-09-14', '12:33:15', '2026-09-14 10:33:15'),
(1017, '::1', '/bahawalcollegeofhealth/accreditation.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'dl5cfbba9nk635nm7psh104anl', '2026-09-14', '12:33:27', '2026-09-14 10:33:28'),
(1018, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'uroevudb5i8tpsmrqk7qa5chn6', '2026-09-14', '12:34:35', '2026-09-14 10:34:35'),
(1019, '::1', '/bahawalcollegeofhealth/courses.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '5qq9l52jcqrc570q6clk621ue6', '2026-09-14', '12:34:36', '2026-09-14 10:34:36'),
(1020, '::1', '/bahawalcollegeofhealth/clinical-training.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '0uj3t1joe0vceabnu6v7ae20kv', '2026-09-14', '12:34:36', '2026-09-14 10:34:36'),
(1021, '::1', '/bahawalcollegeofhealth/fee-calculator.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '0lkmaho799bc7b38u6npqerqi1', '2026-09-14', '12:34:37', '2026-09-14 10:34:37'),
(1022, '::1', '/bahawalcollegeofhealth/scholarships.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'fv3lf8h3dgajkdd16rrme9fuhk', '2026-09-14', '12:34:37', '2026-09-14 10:34:37'),
(1023, '::1', '/bahawalcollegeofhealth/our-networks.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'chpbv9mcrchqr110k5mgfdveuq', '2026-09-14', '12:34:38', '2026-09-14 10:34:38'),
(1024, '::1', '/bahawalcollegeofhealth/our-projects.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '09qu2ol2i367md5fe3r2gpbmn0', '2026-09-14', '12:34:38', '2026-09-14 10:34:38'),
(1025, '::1', '/bahawalcollegeofhealth/accreditation.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'ch3b82ll33p7flqt74hu6qj6s0', '2026-09-14', '12:34:39', '2026-09-14 10:34:39'),
(1026, '::1', '/bahawalcollegeofhealth/admission.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'p7noqr3tnov8f7g593grjaktt4', '2026-09-14', '12:34:40', '2026-09-14 10:34:40'),
(1027, '::1', '/bahawalcollegeofhealth/about.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '2uro45ru6fhn1355rtfmjslf4v', '2026-09-14', '12:34:40', '2026-09-14 10:34:40'),
(1028, '::1', '/bahawalcollegeofhealth/contact.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'q1f0v07jpbvkt26s246d0aabad', '2026-09-14', '12:34:41', '2026-09-14 10:34:41'),
(1029, '::1', '/bahawalcollegeofhealth/accreditation.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '90lue8ldd79uerqg129emsbafd', '2026-09-14', '12:34:42', '2026-09-14 10:34:42'),
(1030, '::1', '/bahawalcollegeofhealth/eligibility-checker.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'iuqphmrr9le1mv0hb48ge2fopk', '2026-09-14', '12:42:50', '2026-09-14 10:42:50'),
(1031, '::1', '/bahawalcollegeofhealth/eligibility-checker.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'lp25amdtk19glquf7fotvhck4a', '2026-09-14', '12:43:19', '2026-09-14 10:43:19'),
(1032, '::1', '/bahawalcollegeofhealth/eligibility-checker.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'tnn1ar21d6a33k0sdhrpnqhqil', '2026-09-14', '12:43:29', '2026-09-14 10:43:29'),
(1033, '::1', '/bahawalcollegeofhealth/eligibility-checker.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '6hfh2qckiutb6iso8kju6rd45m', '2026-09-14', '12:44:10', '2026-09-14 10:44:10'),
(1034, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '8jjpadkt1db9icgsu8aqa29hd5', '2026-09-14', '12:44:39', '2026-09-14 10:44:39'),
(1035, '::1', '/bahawalcollegeofhealth/courses.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'aeifpmuvc1f8s9fhioemlpk1hr', '2026-09-14', '12:44:40', '2026-09-14 10:44:40'),
(1036, '::1', '/bahawalcollegeofhealth/clinical-training.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '7r79dagk2efc4fous1aeobqdpr', '2026-09-14', '12:44:41', '2026-09-14 10:44:41'),
(1037, '::1', '/bahawalcollegeofhealth/fee-calculator.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'l7fnm8cghejahhpemi52tcnuqe', '2026-09-14', '12:44:42', '2026-09-14 10:44:42'),
(1038, '::1', '/bahawalcollegeofhealth/scholarships.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '38dt2boop86iddocofv4bkabo9', '2026-09-14', '12:44:42', '2026-09-14 10:44:42'),
(1039, '::1', '/bahawalcollegeofhealth/our-networks.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '98hno5dv1inumq2tb3u4p0vnso', '2026-09-14', '12:44:43', '2026-09-14 10:44:43'),
(1040, '::1', '/bahawalcollegeofhealth/our-projects.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'dratj3h56e8f8el8gmkfvebhbk', '2026-09-14', '12:44:43', '2026-09-14 10:44:43'),
(1041, '::1', '/bahawalcollegeofhealth/accreditation.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '39g8sujuskbgubq43junm08mse', '2026-09-14', '12:44:44', '2026-09-14 10:44:44'),
(1042, '::1', '/bahawalcollegeofhealth/eligibility-checker.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'reekf3ku0m0b4436htal2th1t1', '2026-09-14', '12:44:44', '2026-09-14 10:44:44'),
(1043, '::1', '/bahawalcollegeofhealth/admission.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'tl7i66eq5gdt3tu0tuf5skmunv', '2026-09-14', '12:44:45', '2026-09-14 10:44:45'),
(1044, '::1', '/bahawalcollegeofhealth/about.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '0rae5co74c92vrjvi9gdh7871a', '2026-09-14', '12:44:45', '2026-09-14 10:44:45'),
(1045, '::1', '/bahawalcollegeofhealth/contact.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'p6c2jespb5rpi6murjk05sn7vt', '2026-09-14', '12:44:46', '2026-09-14 10:44:46'),
(1046, '::1', '/bahawalcollegeofhealth/admission.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'tnnogemf99l8ht8h5u21pko7bq', '2026-09-14', '12:51:00', '2026-09-14 10:51:00'),
(1047, '::1', '/bahawalcollegeofhealth/admission.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '99210rh7asf3qbvj7ksh02hqn4', '2026-09-14', '12:51:34', '2026-09-14 10:51:34'),
(1048, '::1', '/bahawalcollegeofhealth/admission.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'ojrhn0nio6qncoscgs91igt091', '2026-09-14', '12:51:35', '2026-09-14 10:51:35'),
(1049, '::1', '/bahawalcollegeofhealth/admission.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'ssn81od9rvd19vir3vp4c6mu04', '2026-09-14', '12:52:06', '2026-09-14 10:52:06'),
(1050, '::1', '/bahawalcollegeofhealth/admission.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'epusb5h8ju6m7na0uefb2dlndl', '2026-09-14', '12:52:06', '2026-09-14 10:52:06'),
(1051, '::1', '/bahawalcollegeofhealth/admission.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '5ehekcuui7tkt76k6gib5u61cp', '2026-09-14', '12:53:08', '2026-09-14 10:53:08'),
(1052, '::1', '/bahawalcollegeofhealth/admission.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'ulnlnvmgvg3tl522fa421uejpo', '2026-09-14', '12:53:25', '2026-09-14 10:53:25'),
(1053, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'o786fcglapnk5o04krivfvo6lo', '2026-09-14', '12:53:51', '2026-09-14 10:53:51'),
(1054, '::1', '/bahawalcollegeofhealth/courses.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'duuo71mcbptep1439stb2krfum', '2026-09-14', '12:53:51', '2026-09-14 10:53:51'),
(1055, '::1', '/bahawalcollegeofhealth/clinical-training.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'dhkempjulhadbat4cq4ise4hin', '2026-09-14', '12:53:52', '2026-09-14 10:53:52'),
(1056, '::1', '/bahawalcollegeofhealth/fee-calculator.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'r1ekut0hvsj17ubdc2abt5b99b', '2026-09-14', '12:53:52', '2026-09-14 10:53:52'),
(1057, '::1', '/bahawalcollegeofhealth/scholarships.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'c2if3ci99i9nutt52m5965l6mc', '2026-09-14', '12:53:53', '2026-09-14 10:53:53'),
(1058, '::1', '/bahawalcollegeofhealth/our-networks.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '3vkc3iuvg93296l4k9vnckj60b', '2026-09-14', '12:53:53', '2026-09-14 10:53:53'),
(1059, '::1', '/bahawalcollegeofhealth/our-projects.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '88h283jltsrk7rhnif942dr6t7', '2026-09-14', '12:53:54', '2026-09-14 10:53:54'),
(1060, '::1', '/bahawalcollegeofhealth/accreditation.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'edq11s1bi4d8t9m1afpqucdh8p', '2026-09-14', '12:53:54', '2026-09-14 10:53:54'),
(1061, '::1', '/bahawalcollegeofhealth/eligibility-checker.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'dvm1rqaknsl0i6fmmag5bo9hjq', '2026-09-14', '12:53:54', '2026-09-14 10:53:54'),
(1062, '::1', '/bahawalcollegeofhealth/admission.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'imm4s39hlp6487vkm0p0smkmg5', '2026-09-14', '12:53:55', '2026-09-14 10:53:55'),
(1063, '::1', '/bahawalcollegeofhealth/about.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'c134vov6q1vt39k11585hpv3i4', '2026-09-14', '12:53:55', '2026-09-14 10:53:55'),
(1064, '::1', '/bahawalcollegeofhealth/contact.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'hqeurscjlp7suj5l9cp2hls81u', '2026-09-14', '12:53:56', '2026-09-14 10:53:56'),
(1065, '::1', '/bahawalcollegeofhealth/admission.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'hroh570qeadmagru2tigjr07p5', '2026-09-14', '12:53:57', '2026-09-14 10:53:57'),
(1066, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'ldq1thdde7mkf7t1clbmpb62cv', '2026-09-14', '13:03:42', '2026-09-14 11:03:42'),
(1067, '::1', '/bahawalcollegeofhealth/courses.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'qnf1albibppo12jsrqae2tpem3', '2026-09-14', '13:03:44', '2026-09-14 11:03:44'),
(1068, '::1', '/bahawalcollegeofhealth/about.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'r55b52pn6smub3ti80dj4bicgu', '2026-09-14', '13:03:45', '2026-09-14 11:03:45'),
(1069, '::1', '/bahawalcollegeofhealth/contact.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '9m06755cu22ev4r0jq4mrfij03', '2026-09-14', '13:03:45', '2026-09-14 11:03:45'),
(1070, '::1', '/bahawalcollegeofhealth/campus-portal.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '7p1m2r0v2dnhav6pcrdlokja8m', '2026-09-14', '13:03:47', '2026-09-14 11:03:47'),
(1071, '::1', '/bahawalcollegeofhealth/clinical-training.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 't2ro5n6ri782mjmb62r4f8cbr3', '2026-09-14', '13:03:48', '2026-09-14 11:03:48'),
(1072, '::1', '/bahawalcollegeofhealth/fee-calculator.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'dljjt64u26rd78cmj0frmsu02n', '2026-09-14', '13:03:49', '2026-09-14 11:03:49'),
(1073, '::1', '/bahawalcollegeofhealth/scholarships.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'dd3nncu3pe6vn3q2rjg84l15ur', '2026-09-14', '13:03:49', '2026-09-14 11:03:49'),
(1074, '::1', '/bahawalcollegeofhealth/our-networks.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'ch86h634qpiu421b1dcltta2mp', '2026-09-14', '13:03:50', '2026-09-14 11:03:50'),
(1075, '::1', '/bahawalcollegeofhealth/our-projects.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'o43sciuu1717n31lsd4qt4vrkq', '2026-09-14', '13:03:50', '2026-09-14 11:03:50'),
(1076, '::1', '/bahawalcollegeofhealth/accreditation.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '46r71eia7fnihqkfrs72dcebpr', '2026-09-14', '13:03:51', '2026-09-14 11:03:51'),
(1077, '::1', '/bahawalcollegeofhealth/eligibility-checker.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'vlvj6q01igp1e2afjdjjnakjm5', '2026-09-14', '13:03:52', '2026-09-14 11:03:52'),
(1078, '::1', '/bahawalcollegeofhealth/admission.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'agp6fuvi17gj6v34pgks7i1bet', '2026-09-14', '13:03:53', '2026-09-14 11:03:53'),
(1079, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '3lnt4c869futbr9s3nbgr5tu9u', '2026-09-14', '13:03:54', '2026-09-14 11:03:54'),
(1080, '::1', '/bahawalcollegeofhealth/gallery.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'ro6kpca8utvp02qv3kg12e8bpg', '2026-09-14', '13:03:55', '2026-09-14 11:03:55'),
(1081, '::1', '/bahawalcollegeofhealth/events.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '8ooc7vf8h80d5lcqmlao2ikmro', '2026-09-14', '13:03:55', '2026-09-14 11:03:55'),
(1082, '::1', '/bahawalcollegeofhealth/news.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'dr3pgsvjrr7vkksoelaagcu55f', '2026-09-14', '13:03:56', '2026-09-14 11:03:56'),
(1083, '::1', '/bahawalcollegeofhealth/downloads.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '63ol5jp4l3cdl6rda6o2atcdbf', '2026-09-14', '13:03:56', '2026-09-14 11:03:56'),
(1084, '::1', '/bahawalcollegeofhealth/examination.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'tcbo71fmi7toear0mbmbn1qnnc', '2026-09-14', '13:03:57', '2026-09-14 11:03:57'),
(1085, '::1', '/bahawalcollegeofhealth/campuses.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '5hfm763v6g0fsj045552r9mtq5', '2026-09-14', '13:03:58', '2026-09-14 11:03:58'),
(1086, '::1', '/bahawalcollegeofhealth/admission.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'qvknmc03q2sh6pv5rbos4vufcu', '2026-09-14', '13:04:09', '2026-09-14 11:04:09'),
(1087, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'gp769lvcg2jtkmr2fgvvfaqect', '2026-09-14', '13:05:17', '2026-09-14 11:05:17'),
(1088, '::1', '/bahawalcollegeofhealth/admission.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'ttbeab3spl2afbre4m3pc8ut19', '2026-09-14', '13:05:17', '2026-09-14 11:05:17'),
(1089, '::1', '/bahawalcollegeofhealth/courses.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 't1pnbrmhb79r8kgvff6hmkl16t', '2026-09-14', '13:05:18', '2026-09-14 11:05:18'),
(1090, '::1', '/bahawalcollegeofhealth/campus-portal.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'ef69jiv5qif309iq7gaoog2o1b', '2026-09-14', '13:05:18', '2026-09-14 11:05:18'),
(1091, '::1', '/bahawalcollegeofhealth/index.php', '', 'http://localhost/', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'gsph9kh6osqelsgipsjfhr5e31', '2026-09-14', '13:07:48', '2026-09-14 11:07:48'),
(1092, '::1', '/bahawalcollegeofhealth/our-networks.php', '', 'http://localhost/bahawalcollegeofhealth/', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'gsph9kh6osqelsgipsjfhr5e31', '2026-09-14', '13:07:55', '2026-09-14 11:07:55'),
(1093, '::1', '/bahawalcollegeofhealth/our-projects.php', '', 'http://localhost/bahawalcollegeofhealth/our-networks.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'gsph9kh6osqelsgipsjfhr5e31', '2026-09-14', '13:08:01', '2026-09-14 11:08:01'),
(1094, '::1', '/bahawalcollegeofhealth/accreditation.php', '', 'http://localhost/bahawalcollegeofhealth/our-projects.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'gsph9kh6osqelsgipsjfhr5e31', '2026-09-14', '13:08:03', '2026-09-14 11:08:03'),
(1095, '::1', '/bahawalcollegeofhealth/index.php', '', 'http://localhost/bahawalcollegeofhealth/accreditation.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'gsph9kh6osqelsgipsjfhr5e31', '2026-09-14', '13:08:06', '2026-09-14 11:08:06'),
(1096, '::1', '/bahawalcollegeofhealth/activities.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'fe5286ubk4h2dqu0si9i9e2gjn', '2026-09-15', '05:11:30', '2026-09-15 03:11:30'),
(1097, '::1', '/bahawalcollegeofhealth/activities.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'm4bmk53i82j0c9m9u459np4i8c', '2026-09-15', '05:15:04', '2026-09-15 03:15:04'),
(1098, '::1', '/bahawalcollegeofhealth/activities.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'hjrbuc5bqj2ov75negcp86d4e7', '2026-09-15', '05:16:18', '2026-09-15 03:16:18'),
(1099, '::1', '/bahawalcollegeofhealth/activities.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'sdpeqhpf81rdh9f6vml8vrn53u', '2026-09-15', '05:16:43', '2026-09-15 03:16:43'),
(1100, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'snr2aielr918guur50dpb6rqg0', '2026-09-15', '05:20:41', '2026-09-15 03:20:41'),
(1101, '::1', '/bahawalcollegeofhealth/events.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'dpjm2pgn0a1rmn2n4ajur9bhp8', '2026-09-15', '05:20:43', '2026-09-15 03:20:43'),
(1102, '::1', '/bahawalcollegeofhealth/news.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '49i74b5rf52qf1pidgce7og0ha', '2026-09-15', '05:20:44', '2026-09-15 03:20:44'),
(1103, '::1', '/bahawalcollegeofhealth/activities.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'o632ft2ciu6kp8d7u5abvisasa', '2026-09-15', '05:20:45', '2026-09-15 03:20:45'),
(1104, '::1', '/bahawalcollegeofhealth/courses.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '4bfg5h40gv9kpr767mti3rag78', '2026-09-15', '05:20:46', '2026-09-15 03:20:46'),
(1105, '::1', '/bahawalcollegeofhealth/clinical-training.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'faffrq7bd75vmmg7sh6dqtpo09', '2026-09-15', '05:20:47', '2026-09-15 03:20:47'),
(1106, '::1', '/bahawalcollegeofhealth/fee-calculator.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'somg77gbob1hiqknah8hqeggk7', '2026-09-15', '05:20:47', '2026-09-15 03:20:47'),
(1107, '::1', '/bahawalcollegeofhealth/scholarships.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '23iu2g4v1d71h0evari0r7994u', '2026-09-15', '05:20:48', '2026-09-15 03:20:48'),
(1108, '::1', '/bahawalcollegeofhealth/our-networks.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'r6itluqdkve6576ofhtmr388vp', '2026-09-15', '05:20:49', '2026-09-15 03:20:49'),
(1109, '::1', '/bahawalcollegeofhealth/our-projects.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '1skm4l15shnlkn2h9imdh5i6n4', '2026-09-15', '05:20:50', '2026-09-15 03:20:50'),
(1110, '::1', '/bahawalcollegeofhealth/accreditation.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'ed9kp4uf3b5i1f9c6hfegojk9i', '2026-09-15', '05:20:51', '2026-09-15 03:20:51'),
(1111, '::1', '/bahawalcollegeofhealth/eligibility-checker.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'hbkdjid0c6td5vb7284me09f9o', '2026-09-15', '05:20:51', '2026-09-15 03:20:51'),
(1112, '::1', '/bahawalcollegeofhealth/admission.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '3odlh2mkrbqu1r7o66ojn3gv5j', '2026-09-15', '05:20:52', '2026-09-15 03:20:52'),
(1113, '::1', '/bahawalcollegeofhealth/about.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '2bi344rtn0aae5fgnntnmrvqqh', '2026-09-15', '05:20:53', '2026-09-15 03:20:53'),
(1114, '::1', '/bahawalcollegeofhealth/contact.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '5cgn54kslsc0lbg0aepscf3u2j', '2026-09-15', '05:20:54', '2026-09-15 03:20:54'),
(1115, '::1', '/bahawalcollegeofhealth/activities.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'm8fgat3tbdg6d2uiicet9ct2fh', '2026-09-15', '05:20:55', '2026-09-15 03:20:55'),
(1116, '::1', '/bahawalcollegeofhealth/foundation.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'kvo74c5q3n54k5e6ceq6hrb1pj', '2026-09-15', '05:30:34', '2026-09-15 03:30:34'),
(1117, '::1', '/bahawalcollegeofhealth/foundation.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'q1jv7ql7ti3278q72815qk3via', '2026-09-15', '05:31:35', '2026-09-15 03:31:35'),
(1118, '::1', '/bahawalcollegeofhealth/foundation.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'q1m01u4fb8a9hcj59dne5itkd6', '2026-09-15', '05:32:16', '2026-09-15 03:32:16'),
(1119, '::1', '/bahawalcollegeofhealth/foundation.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'boogot2tgsb7r9tfsrf8ipbs74', '2026-09-15', '05:32:27', '2026-09-15 03:32:27'),
(1120, '::1', '/bahawalcollegeofhealth/index.php', '', 'http://localhost/bahawalcollegeofhealth/accreditation.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'gsph9kh6osqelsgipsjfhr5e31', '2026-09-15', '05:33:12', '2026-09-15 03:33:12'),
(1121, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'k56sfon8ou9lk6ej0qsld17s2c', '2026-09-15', '05:38:34', '2026-09-15 03:38:34'),
(1122, '::1', '/bahawalcollegeofhealth/about.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'b7artn8q6qnhkn6e78td7o4g9n', '2026-09-15', '05:38:42', '2026-09-15 03:38:42'),
(1123, '::1', '/bahawalcollegeofhealth/foundation.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '7c8cmguk1anhdbm57cs8hlhl6l', '2026-09-15', '05:38:46', '2026-09-15 03:38:46'),
(1124, '::1', '/bahawalcollegeofhealth/mission-vision.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'o0ibhlilc8u5cqkpl6pcjeabod', '2026-09-15', '05:38:48', '2026-09-15 03:38:48'),
(1125, '::1', '/bahawalcollegeofhealth/core-values.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'kkim3c0h19l6f46vc0lrnh3ha7', '2026-09-15', '05:38:49', '2026-09-15 03:38:49'),
(1126, '::1', '/bahawalcollegeofhealth/leadership.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'g6t8tce92p2dinqdohk1tqvk4t', '2026-09-15', '05:38:50', '2026-09-15 03:38:50'),
(1127, '::1', '/bahawalcollegeofhealth/courses.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'vmca49u6f79ktgkvr4d2ism8rm', '2026-09-15', '05:38:52', '2026-09-15 03:38:52'),
(1128, '::1', '/bahawalcollegeofhealth/clinical-training.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'tdj6tm60uasg8c44dubpu987ai', '2026-09-15', '05:38:53', '2026-09-15 03:38:53'),
(1129, '::1', '/bahawalcollegeofhealth/fee-calculator.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'aj9nkgb17smsflr7jfq7o5oikf', '2026-09-15', '05:38:56', '2026-09-15 03:38:56'),
(1130, '::1', '/bahawalcollegeofhealth/scholarships.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'b7aq5qv79jgs3slotle9m82u8q', '2026-09-15', '05:38:57', '2026-09-15 03:38:57'),
(1131, '::1', '/bahawalcollegeofhealth/our-networks.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'qu69aj5dgglt6ba4fa3le3os49', '2026-09-15', '05:38:58', '2026-09-15 03:38:58'),
(1132, '::1', '/bahawalcollegeofhealth/our-projects.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'dt8fvu1ig275agguhgepmtvpea', '2026-09-15', '05:38:58', '2026-09-15 03:38:58'),
(1133, '::1', '/bahawalcollegeofhealth/accreditation.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'h1vvbhlju02ds6cj654uhcgmpp', '2026-09-15', '05:39:00', '2026-09-15 03:39:00'),
(1134, '::1', '/bahawalcollegeofhealth/eligibility-checker.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'fe08pq5tu66gjd68edobmcjpr9', '2026-09-15', '05:39:01', '2026-09-15 03:39:01'),
(1135, '::1', '/bahawalcollegeofhealth/admission.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '6faeu0eb38kunk56lfuom24dal', '2026-09-15', '05:39:02', '2026-09-15 03:39:02'),
(1136, '::1', '/bahawalcollegeofhealth/activities.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'bqukqasa6r6vucndjofv2df1g7', '2026-09-15', '05:39:03', '2026-09-15 03:39:03'),
(1137, '::1', '/bahawalcollegeofhealth/events.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'osuuin30e25rl48mea2ghrq8bn', '2026-09-15', '05:39:05', '2026-09-15 03:39:05'),
(1138, '::1', '/bahawalcollegeofhealth/contact.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '5161c8gc50re4fshf9hcfkva5q', '2026-09-15', '05:39:07', '2026-09-15 03:39:07'),
(1139, '::1', '/bahawalcollegeofhealth/foundation.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'q8pidg6r4j8qtatbu4pacc72ud', '2026-09-15', '05:39:08', '2026-09-15 03:39:08'),
(1140, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '57nib4a463rlvn4ks3dp907tgd', '2026-09-15', '05:55:44', '2026-09-15 03:55:45'),
(1141, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'ib08p6o4fr3g2gof631ahgj18s', '2026-09-15', '05:57:20', '2026-09-15 03:57:20'),
(1142, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '68g8f8461eouk1ro497c6h7rdd', '2026-09-15', '05:59:25', '2026-09-15 03:59:26'),
(1143, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'hs1s17c04dnni25klflj6408lr', '2026-09-15', '06:00:08', '2026-09-15 04:00:08'),
(1144, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'baprhle8alru9hksbuc4kqogr0', '2026-09-15', '06:04:26', '2026-09-15 04:04:26'),
(1145, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'up371okv09fpgebg1geu2ae153', '2026-09-15', '06:04:55', '2026-09-15 04:04:55'),
(1146, '::1', '/bahawalcollegeofhealth/courses.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '7j97jl5532m0sk26lgp9bhd2kj', '2026-09-15', '06:05:46', '2026-09-15 04:05:46'),
(1147, '::1', '/bahawalcollegeofhealth/clinical-training.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'pmk231jp8o0b17gugh7j81haqm', '2026-09-15', '06:05:58', '2026-09-15 04:05:58'),
(1148, '::1', '/bahawalcollegeofhealth/fee-calculator.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'u6aj4vijq5cqcuec38rsnpah3v', '2026-09-15', '06:06:13', '2026-09-15 04:06:13'),
(1149, '::1', '/bahawalcollegeofhealth/scholarships.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'ti5v6m500uhoa7hga1ppbkrnta', '2026-09-15', '06:06:31', '2026-09-15 04:06:31'),
(1150, '::1', '/bahawalcollegeofhealth/our-networks.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'b4uf509j1uk76b6sa2ktoe7hj2', '2026-09-15', '06:06:45', '2026-09-15 04:06:45'),
(1151, '::1', '/bahawalcollegeofhealth/our-projects.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'jcr4ja08dm5rjvr63vp2hkuijs', '2026-09-15', '06:06:56', '2026-09-15 04:06:56'),
(1152, '::1', '/bahawalcollegeofhealth/accreditation.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '38fq87fdith59bc4ku09rmlgpg', '2026-09-15', '06:07:02', '2026-09-15 04:07:02'),
(1153, '::1', '/bahawalcollegeofhealth/eligibility-checker.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '2rvei2c12gf8ko76qaf430dlf2', '2026-09-15', '06:07:04', '2026-09-15 04:07:04'),
(1154, '::1', '/bahawalcollegeofhealth/admission.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'gh4vsr08av077jbg8upi9c5239', '2026-09-15', '06:07:08', '2026-09-15 04:07:08'),
(1155, '::1', '/bahawalcollegeofhealth/activities.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '4dc37ioo8n0v148fivdcrk8k6l', '2026-09-15', '06:07:13', '2026-09-15 04:07:13'),
(1156, '::1', '/bahawalcollegeofhealth/foundation.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'qce0r0tbhehq9irbu0pr7lejpc', '2026-09-15', '06:07:17', '2026-09-15 04:07:17'),
(1157, '::1', '/bahawalcollegeofhealth/about.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'l3vj90946o6vhqv7q8r712ostq', '2026-09-15', '06:07:26', '2026-09-15 04:07:26'),
(1158, '::1', '/bahawalcollegeofhealth/contact.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'pbv7mgdqh7197aq59ehgdf3hm2', '2026-09-15', '06:07:33', '2026-09-15 04:07:33'),
(1159, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'int8vtg02buqf2ckrd80qf7ggb', '2026-09-15', '06:07:39', '2026-09-15 04:07:39'),
(1160, '::1', '/bahawalcollegeofhealth/about.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '4o6uqajedov85tlst6nbfcoesq', '2026-09-15', '06:07:55', '2026-09-15 04:07:55'),
(1161, '::1', '/bahawalcollegeofhealth/contact.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'c1a72bfjig6oh5apvigj4fs89h', '2026-09-15', '06:08:14', '2026-09-15 04:08:14'),
(1162, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '2c7ida0crftd1gdeti62cmp0iq', '2026-09-15', '06:08:27', '2026-09-15 04:08:27'),
(1163, '::1', '/bahawalcollegeofhealth/chairman-message.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '9ppnb43qoavvp16s499c5fhlt9', '2026-09-15', '06:16:26', '2026-09-15 04:16:26'),
(1164, '::1', '/bahawalcollegeofhealth/chairman-message.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'iqehjmng11gonvfvea29s586ms', '2026-09-15', '06:17:24', '2026-09-15 04:17:24'),
(1165, '::1', '/bahawalcollegeofhealth/chairman-message.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'nvib3g5pmg0qjvkpg177mspueo', '2026-09-15', '06:17:37', '2026-09-15 04:17:37'),
(1166, '::1', '/bahawalcollegeofhealth/chairman-message.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '53a8mupnthtvkrtnbaf4gec989', '2026-09-15', '06:19:04', '2026-09-15 04:19:04'),
(1167, '::1', '/bahawalcollegeofhealth/chairman-message.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'mfiigurgir3mk900m7u4acptg1', '2026-09-15', '06:20:11', '2026-09-15 04:20:11'),
(1168, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'bk4s81rj5lv2aa90chep3qrc3d', '2026-09-15', '06:20:12', '2026-09-15 04:20:12'),
(1169, '::1', '/bahawalcollegeofhealth/about.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'kp02iine7ovn4i1albkeeprgve', '2026-09-15', '06:20:14', '2026-09-15 04:20:14'),
(1170, '::1', '/bahawalcollegeofhealth/leadership.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '76l59lmi84r19ckuea5voholph', '2026-09-15', '06:20:15', '2026-09-15 04:20:15'),
(1171, '::1', '/bahawalcollegeofhealth/chairman-message.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '795sp22kekd910bde5cdb65oji', '2026-09-15', '06:20:15', '2026-09-15 04:20:15'),
(1172, '::1', '/bahawalcollegeofhealth/foundation.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'begmuco5lo72kp16c4ousc6m0n', '2026-09-15', '06:20:16', '2026-09-15 04:20:16'),
(1173, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'itaokqb1v8k6dt67ak8soop2o0', '2026-09-15', '06:20:17', '2026-09-15 04:20:17'),
(1174, '::1', '/bahawalcollegeofhealth/courses.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '5t416bh05fqdf6nve5os07coeg', '2026-09-15', '06:20:17', '2026-09-15 04:20:17'),
(1175, '::1', '/bahawalcollegeofhealth/admission.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'sn20auq0budklhim7g98cd7kc0', '2026-09-15', '06:20:18', '2026-09-15 04:20:18'),
(1176, '::1', '/bahawalcollegeofhealth/contact.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '0jj1c4bqcvmc34dqbriujsvg2n', '2026-09-15', '06:20:24', '2026-09-15 04:20:24'),
(1177, '::1', '/bahawalcollegeofhealth/principal-message.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '45eu83knv9i4qoru3ftfvhpf87', '2026-09-15', '06:24:59', '2026-09-15 04:24:59'),
(1178, '::1', '/bahawalcollegeofhealth/principal-message.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'jds16fnshd72diqeu4e9624koi', '2026-09-15', '06:25:52', '2026-09-15 04:25:52'),
(1179, '::1', '/bahawalcollegeofhealth/principal-message.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'g1gl72doknlp5jumb5l1q74512', '2026-09-15', '06:26:33', '2026-09-15 04:26:33'),
(1180, '::1', '/bahawalcollegeofhealth/principal-message.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'vl5gc7n2drrsoip1afvg2g7nbs', '2026-09-15', '06:26:40', '2026-09-15 04:26:40'),
(1181, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '32kf1q30ek48rcvrv8mubnove6', '2026-09-15', '06:27:34', '2026-09-15 04:27:34'),
(1182, '::1', '/bahawalcollegeofhealth/about.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'dltpelq01e244kj4cd6hbji038', '2026-09-15', '06:27:35', '2026-09-15 04:27:35'),
(1183, '::1', '/bahawalcollegeofhealth/leadership.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '66ln2r28q9i5fr4j57cs246gh3', '2026-09-15', '06:27:36', '2026-09-15 04:27:36'),
(1184, '::1', '/bahawalcollegeofhealth/chairman-message.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'c5et9fag3rnogoscqhdjv8juo6', '2026-09-15', '06:27:37', '2026-09-15 04:27:37'),
(1185, '::1', '/bahawalcollegeofhealth/principal-message.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '5d6gu76c95qp4ptq9rlhfd57ri', '2026-09-15', '06:27:37', '2026-09-15 04:27:37'),
(1186, '::1', '/bahawalcollegeofhealth/foundation.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'nl5n9dpvsgqe2n18ua218sbk6f', '2026-09-15', '06:27:38', '2026-09-15 04:27:38'),
(1187, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'hrv25htgq8d4ncv377fgkshkns', '2026-09-15', '06:27:39', '2026-09-15 04:27:39'),
(1188, '::1', '/bahawalcollegeofhealth/courses.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '46l0pmcvk704t0ddeocu9fpbqc', '2026-09-15', '06:27:39', '2026-09-15 04:27:39'),
(1189, '::1', '/bahawalcollegeofhealth/admission.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '11icdajom0u91cblh44u333vnh', '2026-09-15', '06:27:40', '2026-09-15 04:27:40'),
(1190, '::1', '/bahawalcollegeofhealth/contact.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'tpn9arekm95qhq9dqfk8kltns0', '2026-09-15', '06:27:41', '2026-09-15 04:27:41'),
(1191, '::1', '/bahawalcollegeofhealth/principal-message.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'o42d9ljfirjag95ddag2vtm3b9', '2026-09-15', '06:27:41', '2026-09-15 04:27:41'),
(1192, '127.0.0.1', '/bahawalcollegeofhealth/courses.php', '', 'http://localhost/bahawalcollegeofhealth/', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'jjd0b1l50mrb44m57fd471q456', '2026-09-15', '06:28:04', '2026-09-15 04:28:04'),
(1193, '127.0.0.1', '/bahawalcollegeofhealth/index.php', '', 'http://localhost/bahawalcollegeofhealth/courses.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'jjd0b1l50mrb44m57fd471q456', '2026-09-15', '06:28:07', '2026-09-15 04:28:08'),
(1194, '127.0.0.1', '/bahawalcollegeofhealth/index.php', '', 'http://localhost/bahawalcollegeofhealth/courses.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'jjd0b1l50mrb44m57fd471q456', '2026-09-15', '06:28:11', '2026-09-15 04:28:11'),
(1195, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '2f5tkg1ltsqahtp25q12khth7v', '2026-09-15', '06:34:50', '2026-09-15 04:34:50'),
(1196, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'r0c1staftkn8ei6a9ulup8u1ls', '2026-09-15', '06:35:38', '2026-09-15 04:35:38'),
(1197, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'bp5hc6a3pcq69l4ms2d1kvjmhs', '2026-09-15', '06:36:22', '2026-09-15 04:36:23'),
(1198, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'i4qlfjjijhun5jv72h1tji7dtt', '2026-09-15', '06:38:02', '2026-09-15 04:38:02'),
(1199, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 't2raulspvt6c7e5vakcq8dtmv2', '2026-09-15', '06:38:03', '2026-09-15 04:38:03'),
(1200, '::1', '/bahawalcollegeofhealth/about.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '4j8lcf22lc3304i0r3fqtnikre', '2026-09-15', '06:38:05', '2026-09-15 04:38:05'),
(1201, '::1', '/bahawalcollegeofhealth/courses.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '1lf490mmgod9tgpj88n367u6is', '2026-09-15', '06:38:09', '2026-09-15 04:38:09'),
(1202, '::1', '/bahawalcollegeofhealth/admission.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '8g9kmog0gtl116cdndokvmdqhe', '2026-09-15', '06:38:10', '2026-09-15 04:38:10'),
(1203, '::1', '/bahawalcollegeofhealth/campuses.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'vd8bn9hfodb8mnbk0hssv9fm9h', '2026-09-15', '06:38:12', '2026-09-15 04:38:12'),
(1204, '::1', '/bahawalcollegeofhealth/events.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '0u5idos0hsc05qqgjoqul7nndr', '2026-09-15', '06:38:14', '2026-09-15 04:38:14'),
(1205, '::1', '/bahawalcollegeofhealth/gallery.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'q61bb1qsnr4tqkhm4dpnjum30u', '2026-09-15', '06:38:16', '2026-09-15 04:38:16'),
(1206, '::1', '/bahawalcollegeofhealth/contact.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'r28o804dcnjgt0e62rftkinl6p', '2026-09-15', '06:38:17', '2026-09-15 04:38:17'),
(1207, '::1', '/bahawalcollegeofhealth/our-networks.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '2jjp8ho0jq44vv04acreici0tn', '2026-09-15', '06:38:18', '2026-09-15 04:38:18'),
(1208, '::1', '/bahawalcollegeofhealth/our-projects.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'k0i29hmnt5vk0uvqu7uomebbit', '2026-09-15', '06:38:20', '2026-09-15 04:38:20'),
(1209, '::1', '/bahawalcollegeofhealth/clinical-training.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'ft299i32ro1vseftep4qipjmj8', '2026-09-15', '06:38:21', '2026-09-15 04:38:21'),
(1210, '::1', '/bahawalcollegeofhealth/accreditation.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 't8un44qrslh010oucc312ndj43', '2026-09-15', '06:38:22', '2026-09-15 04:38:22'),
(1211, '::1', '/bahawalcollegeofhealth/foundation.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'q20hsn34q5kf866ts3bdeu18pn', '2026-09-15', '06:38:24', '2026-09-15 04:38:24'),
(1212, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'fvfjb9j3f6er7qg7g1e3arspjc', '2026-09-15', '06:38:25', '2026-09-15 04:38:25'),
(1213, '::1', '/bahawalcollegeofhealth/scholarships.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'mh5rm99dbaloc43tn443aklldk', '2026-09-15', '06:38:27', '2026-09-15 04:38:27'),
(1214, '::1', '/bahawalcollegeofhealth/fee-calculator.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '5f9rfqgj930qs0osqoot0ljekb', '2026-09-15', '06:38:29', '2026-09-15 04:38:29'),
(1215, '::1', '/bahawalcollegeofhealth/eligibility-checker.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'gbak2v4ofrhq5l9lh5o0kgusac', '2026-09-15', '06:38:31', '2026-09-15 04:38:31'),
(1216, '::1', '/bahawalcollegeofhealth/chairman-message.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'bsopea1jhb89du9an1jndfr6fk', '2026-09-15', '06:38:32', '2026-09-15 04:38:32'),
(1217, '::1', '/bahawalcollegeofhealth/principal-message.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'ikmlkkv4jvdvmg45f0mvomiom8', '2026-09-15', '06:38:33', '2026-09-15 04:38:33'),
(1218, '::1', '/bahawalcollegeofhealth/activities.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'aj4tioqkvujemdp63qt6s6as3c', '2026-09-15', '06:38:36', '2026-09-15 04:38:36'),
(1219, '::1', '/bahawalcollegeofhealth/leadership.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'q57lnui25hrp5f9n1t9rfok9e0', '2026-09-15', '06:38:37', '2026-09-15 04:38:37'),
(1220, '::1', '/bahawalcollegeofhealth/index.php', '', 'http://localhost/bahawalcollegeofhealth/courses.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'jjd0b1l50mrb44m57fd471q456', '2026-09-15', '06:39:28', '2026-09-15 04:39:28'),
(1221, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'jjd0b1l50mrb44m57fd471q456', '2026-09-15', '06:39:35', '2026-09-15 04:39:36'),
(1222, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '3sn4hokfokma8moodk19jsmhcj', '2026-09-15', '06:45:14', '2026-09-15 04:45:14');
INSERT INTO `website_analytics` (`id`, `visitor_ip`, `page_url`, `page_title`, `referrer`, `user_agent`, `device_type`, `browser`, `operating_system`, `country`, `city`, `session_id`, `visit_date`, `visit_time`, `created_at`) VALUES
(1223, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'pu16pmus7at09t1nbq70m92o71', '2026-09-15', '06:46:15', '2026-09-15 04:46:15'),
(1224, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'dkltjiahteseld2o0pp0f0dotr', '2026-09-15', '06:46:43', '2026-09-15 04:46:43'),
(1225, '127.0.0.1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '9tgtmqaqb2b7u19uibeckutpec', '2026-09-15', '06:48:39', '2026-09-15 04:48:39'),
(1226, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'gt182a6ivu08a3il8nqvvhfve8', '2026-09-15', '06:52:07', '2026-09-15 04:52:07'),
(1227, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'kt95pt2s81csociosj2uu4bqlc', '2026-09-15', '06:53:46', '2026-09-15 04:53:46'),
(1228, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'tjct48c61gmfel8ha6j3kdcacq', '2026-09-15', '06:54:22', '2026-09-15 04:54:22'),
(1229, '::1', '/bahawalcollegeofhealth/about.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'vgi83t6gpcu6ldka55i5a01hpi', '2026-09-15', '06:54:24', '2026-09-15 04:54:24'),
(1230, '::1', '/bahawalcollegeofhealth/courses.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'rbghr7vse63fi08nv8hbr820mb', '2026-09-15', '06:54:24', '2026-09-15 04:54:24'),
(1231, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'poh60su1qu1ssrqr2jjbu7mlr4', '2026-09-15', '06:54:25', '2026-09-15 04:54:25'),
(1232, '::1', '/bahawalcollegeofhealth/clinical-training.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'ce5tp0maq33brervjsrsja9u76', '2026-09-15', '06:54:26', '2026-09-15 04:54:26'),
(1233, '::1', '/bahawalcollegeofhealth/our-networks.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '3mghp7ef7udhbp6e23u3cftue7', '2026-09-15', '06:54:26', '2026-09-15 04:54:26'),
(1234, '::1', '/bahawalcollegeofhealth/our-projects.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'fgffvc15a0e6p6g289hnqq6i43', '2026-09-15', '06:54:27', '2026-09-15 04:54:27'),
(1235, '::1', '/bahawalcollegeofhealth/accreditation.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'n3cd2j963cmqkouaa3altqh77h', '2026-09-15', '06:54:27', '2026-09-15 04:54:27'),
(1236, '::1', '/bahawalcollegeofhealth/foundation.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'g7erct584u13t0kf0l7o788mj8', '2026-09-15', '06:54:28', '2026-09-15 04:54:28'),
(1237, '::1', '/bahawalcollegeofhealth/scholarships.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'k7ch5khrsdt42fqc1vcm091jgp', '2026-09-15', '06:54:29', '2026-09-15 04:54:29'),
(1238, '::1', '/bahawalcollegeofhealth/fee-calculator.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'eoeen9dpgdedheljhh0ve1goiu', '2026-09-15', '06:54:30', '2026-09-15 04:54:30'),
(1239, '::1', '/bahawalcollegeofhealth/eligibility-checker.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'rfcak2epuvcl81iatmtvbg1cdd', '2026-09-15', '06:54:31', '2026-09-15 04:54:31'),
(1240, '::1', '/bahawalcollegeofhealth/activities.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'jek4rnc77d0ukfnu06o5l0e01q', '2026-09-15', '06:54:32', '2026-09-15 04:54:32'),
(1241, '::1', '/bahawalcollegeofhealth/admission.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'ad2fe0jifci6t3e9genvd17i4n', '2026-09-15', '06:54:32', '2026-09-15 04:54:32'),
(1242, '::1', '/bahawalcollegeofhealth/leadership.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'j0kfrce9tva39ceb3sp9f49rvv', '2026-09-15', '06:54:33', '2026-09-15 04:54:33'),
(1243, '::1', '/bahawalcollegeofhealth/chairman-message.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'iasstvha7eo632bkggl61df8pk', '2026-09-15', '06:54:34', '2026-09-15 04:54:34'),
(1244, '::1', '/bahawalcollegeofhealth/principal-message.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'mdchmlgcg7r276fblvu7jp9o15', '2026-09-15', '06:54:34', '2026-09-15 04:54:34'),
(1245, '::1', '/bahawalcollegeofhealth/contact.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'snuo63gbes1aa6agpvdsmdjbg1', '2026-09-15', '06:54:35', '2026-09-15 04:54:35'),
(1246, '::1', '/bahawalcollegeofhealth/index.php', '', 'http://localhost/bahawalcollegeofhealth/accreditation.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'gsph9kh6osqelsgipsjfhr5e31', '2026-09-15', '07:30:12', '2026-09-15 05:30:12'),
(1247, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '7jpsc9l7dfnd91mpgf1c98nkab', '2026-09-15', '07:32:40', '2026-09-15 05:32:40'),
(1248, '::1', '/bahawalcollegeofhealth/courses.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'mrjrd0v6jsh0to4mf36bbf4lmj', '2026-09-15', '07:32:41', '2026-09-15 05:32:41'),
(1249, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'sgdv0g7hnrhjnkvkmq0hm8thds', '2026-09-15', '07:33:27', '2026-09-15 05:33:27'),
(1250, '::1', '/bahawalcollegeofhealth/courses.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'sgdv0g7hnrhjnkvkmq0hm8thds', '2026-09-15', '07:33:37', '2026-09-15 05:33:37'),
(1251, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'actkur22164p5pr6bf6gkj2ara', '2026-09-15', '07:34:10', '2026-09-15 05:34:10'),
(1252, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'ifo13nhvd19og9fsjgadav7n8d', '2026-09-15', '07:34:11', '2026-09-15 05:34:11'),
(1253, '::1', '/bahawalcollegeofhealth/courses.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '016knhas1j8gsi1k5chs848ho0', '2026-09-15', '07:34:12', '2026-09-15 05:34:12'),
(1254, '::1', '/bahawalcollegeofhealth/our-networks.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '60n16n0pok278c3mvhecbj582l', '2026-09-15', '07:34:13', '2026-09-15 05:34:13'),
(1255, '::1', '/bahawalcollegeofhealth/our-projects.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 't427corua89a268ri9lgumu77n', '2026-09-15', '07:34:14', '2026-09-15 05:34:14'),
(1256, '::1', '/bahawalcollegeofhealth/accreditation.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'bj4bu23k15s537493uk5sbi9a8', '2026-09-15', '07:34:15', '2026-09-15 05:34:15'),
(1257, '::1', '/bahawalcollegeofhealth/eligibility-checker.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'omheol67m85abeiv20uk36ibmg', '2026-09-15', '07:34:17', '2026-09-15 05:34:17'),
(1258, '::1', '/bahawalcollegeofhealth/foundation.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'f4fnamd4u8h80pa4ndvnpbk4hm', '2026-09-15', '07:34:19', '2026-09-15 05:34:19'),
(1259, '::1', '/bahawalcollegeofhealth/chairman-message.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'kautjnsfsuu98pe0pt7qqphq33', '2026-09-15', '07:34:19', '2026-09-15 05:34:19'),
(1260, '::1', '/bahawalcollegeofhealth/principal-message.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '0m17qhnojk6tk3a9if8l4au0nn', '2026-09-15', '07:34:20', '2026-09-15 05:34:20'),
(1261, '::1', '/bahawalcollegeofhealth/clinical-training.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'mrra5b2pj100du8ubpsie909j3', '2026-09-15', '07:34:21', '2026-09-15 05:34:21'),
(1262, '::1', '/bahawalcollegeofhealth/fee-calculator.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'r9merfgsed2afgsrpf3leeilui', '2026-09-15', '07:34:22', '2026-09-15 05:34:22'),
(1263, '::1', '/bahawalcollegeofhealth/scholarships.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'u767u7hmqriffmmraafidcdkej', '2026-09-15', '07:34:22', '2026-09-15 05:34:22'),
(1264, '::1', '/bahawalcollegeofhealth/activities.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '65vale5r7d1c6e0qgb77vpq1kc', '2026-09-15', '07:34:23', '2026-09-15 05:34:23'),
(1265, '::1', '/bahawalcollegeofhealth/admission.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '69pvf8au3qpue3ng7kv6ep8he4', '2026-09-15', '07:34:24', '2026-09-15 05:34:24'),
(1266, '::1', '/bahawalcollegeofhealth/about.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'avspafika15npa5s21925fevks', '2026-09-15', '07:34:24', '2026-09-15 05:34:24'),
(1267, '::1', '/bahawalcollegeofhealth/contact.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'c5b53jk3njnmfb1s0nagv10urh', '2026-09-15', '07:34:25', '2026-09-15 05:34:25'),
(1268, '::1', '/bahawalcollegeofhealth/courses.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'ittprokikf7qqepu97vgbml02k', '2026-09-15', '07:43:54', '2026-09-15 05:43:54'),
(1269, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '7ruqmaakbni6l347qagvodopuh', '2026-09-15', '07:43:55', '2026-09-15 05:43:55'),
(1270, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '3h3t7a7iunvagqhiumfvfh4n8g', '2026-09-15', '07:44:13', '2026-09-15 05:44:13'),
(1271, '::1', '/bahawalcollegeofhealth/courses.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '3evohi57gdu6le27n6h6d8ago5', '2026-09-15', '07:44:17', '2026-09-15 05:44:17'),
(1272, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'pbi3k72m6fanhkorupu4msc5ii', '2026-09-15', '07:44:17', '2026-09-15 05:44:17'),
(1273, '::1', '/bahawalcollegeofhealth/fee-calculator.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '1cmtj312ir35i3s5e1nslobc6j', '2026-09-15', '07:44:20', '2026-09-15 05:44:20'),
(1274, '::1', '/bahawalcollegeofhealth/scholarships.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'us1e2v8gvifqnml1b117iobe1j', '2026-09-15', '07:44:21', '2026-09-15 05:44:21'),
(1275, '::1', '/bahawalcollegeofhealth/eligibility-checker.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'scsoe29k458li130938t22h2ur', '2026-09-15', '07:44:22', '2026-09-15 05:44:22'),
(1276, '::1', '/bahawalcollegeofhealth/clinical-training.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '2i7m041blhuo4t311crb8crkct', '2026-09-15', '07:44:22', '2026-09-15 05:44:22'),
(1277, '::1', '/bahawalcollegeofhealth/admission.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'vlvv7cibncljcq6p5tcaj9cfcp', '2026-09-15', '07:44:23', '2026-09-15 05:44:23'),
(1278, '::1', '/bahawalcollegeofhealth/accreditation.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'issov9hbpi04sv73o3t1j56kq7', '2026-09-15', '07:44:25', '2026-09-15 05:44:25'),
(1279, '::1', '/bahawalcollegeofhealth/our-networks.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'gebcs1n0uj9608qvqs2clqkt9s', '2026-09-15', '07:44:27', '2026-09-15 05:44:27'),
(1280, '::1', '/bahawalcollegeofhealth/our-projects.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '0munoslrus14163e6tl0rado9v', '2026-09-15', '07:44:29', '2026-09-15 05:44:29'),
(1281, '::1', '/bahawalcollegeofhealth/activities.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'fnvklcp9rgo66o7emcb84pnrmn', '2026-09-15', '07:44:34', '2026-09-15 05:44:34'),
(1282, '::1', '/bahawalcollegeofhealth/foundation.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'a92av14qffpvh7i4am5hhff1ma', '2026-09-15', '07:44:36', '2026-09-15 05:44:36'),
(1283, '::1', '/bahawalcollegeofhealth/about.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'v8gdc1k9mt534arkpiq3sg4tt2', '2026-09-15', '07:44:37', '2026-09-15 05:44:37'),
(1284, '::1', '/bahawalcollegeofhealth/contact.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'elp7f3o5gjssru5e0b06me4i2j', '2026-09-15', '07:44:38', '2026-09-15 05:44:38'),
(1285, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '6br37247756mnfgtv50mtr88r3', '2026-09-15', '07:48:29', '2026-09-15 05:48:29'),
(1286, '::1', '/bahawalcollegeofhealth/about.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'g6cjn4ptpgh2eq5g887htlmqcv', '2026-09-15', '07:48:31', '2026-09-15 05:48:31'),
(1287, '::1', '/bahawalcollegeofhealth/mission-vision.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'su89ohrp1s1871nr143vcp14ec', '2026-09-15', '07:48:32', '2026-09-15 05:48:32'),
(1288, '::1', '/bahawalcollegeofhealth/core-values.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'm6lpqgmdjiokhu1dngpfjh36em', '2026-09-15', '07:48:33', '2026-09-15 05:48:33'),
(1289, '::1', '/bahawalcollegeofhealth/leadership.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'kch4vvj1npfu68jlrqogucd94f', '2026-09-15', '07:48:34', '2026-09-15 05:48:34'),
(1290, '::1', '/bahawalcollegeofhealth/chairman-message.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'kuhbg5hjdrm6ipbam2vlemssjt', '2026-09-15', '07:48:34', '2026-09-15 05:48:34'),
(1291, '::1', '/bahawalcollegeofhealth/principal-message.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'bjr2emcpt9svj1ogjniuerlv72', '2026-09-15', '07:48:35', '2026-09-15 05:48:35'),
(1292, '::1', '/bahawalcollegeofhealth/foundation.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'okmstj1ocnd3kfu8dhigin45pm', '2026-09-15', '07:48:35', '2026-09-15 05:48:35'),
(1293, '::1', '/bahawalcollegeofhealth/courses.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'dorkoi9c5rte4md0bv7ac4p0cd', '2026-09-15', '07:48:36', '2026-09-15 05:48:36'),
(1294, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '2cip235g0fbma6kib34qvf08ae', '2026-09-15', '07:48:36', '2026-09-15 05:48:36'),
(1295, '::1', '/bahawalcollegeofhealth/examination.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'kngg7a8i6rv3k68oncd67mdbu4', '2026-09-15', '07:48:37', '2026-09-15 05:48:37'),
(1296, '::1', '/bahawalcollegeofhealth/clinical-training.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '4d1ajrherq5325i2knfdfi57aa', '2026-09-15', '07:48:38', '2026-09-15 05:48:38'),
(1297, '::1', '/bahawalcollegeofhealth/our-networks.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'vksk2nqrhs15bs5sadelo70ab8', '2026-09-15', '07:48:39', '2026-09-15 05:48:39'),
(1298, '::1', '/bahawalcollegeofhealth/our-projects.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'mjs2ti5pi8g4v0ql9bjout35uq', '2026-09-15', '07:48:39', '2026-09-15 05:48:39'),
(1299, '::1', '/bahawalcollegeofhealth/accreditation.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'vooars2jst2tt17f19e02smvu4', '2026-09-15', '07:48:40', '2026-09-15 05:48:40'),
(1300, '::1', '/bahawalcollegeofhealth/admission.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'n45r04p8gdrm6r0kntcs8gpkk6', '2026-09-15', '07:48:40', '2026-09-15 05:48:40'),
(1301, '::1', '/bahawalcollegeofhealth/downloads.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '06u7vtchv32uh152s9uodm7o83', '2026-09-15', '07:48:41', '2026-09-15 05:48:41'),
(1302, '::1', '/bahawalcollegeofhealth/notifications.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'qd2kklhoivfavulu922esd9p0f', '2026-09-15', '07:48:42', '2026-09-15 05:48:42'),
(1303, '::1', '/bahawalcollegeofhealth/fee-calculator.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '46mc1nscdhf3o7tfd5ttfkqm0m', '2026-09-15', '07:48:42', '2026-09-15 05:48:42'),
(1304, '::1', '/bahawalcollegeofhealth/scholarships.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'jitjafb8vh151s6mhuu0241jgn', '2026-09-15', '07:48:43', '2026-09-15 05:48:43'),
(1305, '::1', '/bahawalcollegeofhealth/eligibility-checker.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '6c0nio07puj8mc871b3ia9s3u5', '2026-09-15', '07:48:44', '2026-09-15 05:48:44'),
(1306, '::1', '/bahawalcollegeofhealth/campuses.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '1jibgo57dvqviq7qthn293ue6g', '2026-09-15', '07:48:44', '2026-09-15 05:48:44'),
(1307, '::1', '/bahawalcollegeofhealth/campus-portal.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'fnpu522cd0i4ueeimc9h9rsq0h', '2026-09-15', '07:48:45', '2026-09-15 05:48:45'),
(1308, '::1', '/bahawalcollegeofhealth/events.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '73uqnnqbsm0bk6v11uip9ucgq3', '2026-09-15', '07:48:46', '2026-09-15 05:48:46'),
(1309, '::1', '/bahawalcollegeofhealth/news.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '0ie2lllme428daktttjjasag7p', '2026-09-15', '07:48:46', '2026-09-15 05:48:46'),
(1310, '::1', '/bahawalcollegeofhealth/activities.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'tbk1occ8ul07n39ps40er0r3vi', '2026-09-15', '07:48:47', '2026-09-15 05:48:47'),
(1311, '::1', '/bahawalcollegeofhealth/gallery.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'jjrt3mkodt0pk1j0n854ofa88e', '2026-09-15', '07:48:48', '2026-09-15 05:48:48'),
(1312, '::1', '/bahawalcollegeofhealth/contact.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'hvthfdnhij0j6mk9u1na2u2tqc', '2026-09-15', '07:48:48', '2026-09-15 05:48:48'),
(1313, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'cj7ca818pv94fstqr73gfjknug', '2026-09-15', '07:51:33', '2026-09-15 05:51:33'),
(1314, '::1', '/bahawalcollegeofhealth/about.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'm7o2us3t5comila45m1f6ahlvc', '2026-09-15', '07:51:33', '2026-09-15 05:51:33'),
(1315, '::1', '/bahawalcollegeofhealth/mission-vision.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'ingj276267m6804o2ab5413p2s', '2026-09-15', '07:51:34', '2026-09-15 05:51:34'),
(1316, '::1', '/bahawalcollegeofhealth/core-values.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'fon9okctn27gb3v5p02dgabj9b', '2026-09-15', '07:51:34', '2026-09-15 05:51:34'),
(1317, '::1', '/bahawalcollegeofhealth/leadership.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'irg9bvo0kmgpeu47pi3vdj2a8q', '2026-09-15', '07:51:35', '2026-09-15 05:51:35'),
(1318, '::1', '/bahawalcollegeofhealth/chairman-message.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '9oo23gj5f50s1k6msfeou1tv8m', '2026-09-15', '07:51:36', '2026-09-15 05:51:36'),
(1319, '::1', '/bahawalcollegeofhealth/principal-message.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'el7e6tnvd10vhc0s6nlm3u3qqa', '2026-09-15', '07:51:36', '2026-09-15 05:51:36'),
(1320, '::1', '/bahawalcollegeofhealth/foundation.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '69sau23klu589va34t7e0hopij', '2026-09-15', '07:51:37', '2026-09-15 05:51:37'),
(1321, '::1', '/bahawalcollegeofhealth/courses.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '2ud2hf0mt8k8pur675pmuf6rs2', '2026-09-15', '07:51:38', '2026-09-15 05:51:38'),
(1322, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'ke9n3agd7g01ebmoi4h4ddj3tt', '2026-09-15', '07:51:38', '2026-09-15 05:51:38'),
(1323, '::1', '/bahawalcollegeofhealth/examination.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '9f3psrqbf1n2g674apph16q2ei', '2026-09-15', '07:51:39', '2026-09-15 05:51:39'),
(1324, '::1', '/bahawalcollegeofhealth/clinical-training.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '3ghcg61cg77mv9vv0kmma0pvi9', '2026-09-15', '07:51:39', '2026-09-15 05:51:39'),
(1325, '::1', '/bahawalcollegeofhealth/our-networks.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'afn9987cvhjdilp8slpsk724l6', '2026-09-15', '07:51:40', '2026-09-15 05:51:40'),
(1326, '::1', '/bahawalcollegeofhealth/our-projects.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'pd4nmfi4tt1irbd6q11hc84up5', '2026-09-15', '07:51:41', '2026-09-15 05:51:41'),
(1327, '::1', '/bahawalcollegeofhealth/accreditation.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'v5tf4u0r2b3v7pr6e958fvcbvt', '2026-09-15', '07:51:41', '2026-09-15 05:51:41'),
(1328, '::1', '/bahawalcollegeofhealth/admission.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'ct0kdb973sv7sa2i9skgrpug27', '2026-09-15', '07:51:42', '2026-09-15 05:51:42'),
(1329, '::1', '/bahawalcollegeofhealth/downloads.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '1uuk3pf23ica5rr7j19jlvd65b', '2026-09-15', '07:51:42', '2026-09-15 05:51:42'),
(1330, '::1', '/bahawalcollegeofhealth/notifications.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '34anjlkgpp1j783tcd5i6sstj5', '2026-09-15', '07:51:43', '2026-09-15 05:51:43'),
(1331, '::1', '/bahawalcollegeofhealth/fee-calculator.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'ub9dl06mmmih4v9tbhvk1uocvr', '2026-09-15', '07:51:43', '2026-09-15 05:51:43'),
(1332, '::1', '/bahawalcollegeofhealth/scholarships.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '04a950p7kavdun8b6ml89uo7be', '2026-09-15', '07:51:44', '2026-09-15 05:51:44'),
(1333, '::1', '/bahawalcollegeofhealth/eligibility-checker.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'hlhvkd0j4dsnjldeh7jc6cvrat', '2026-09-15', '07:51:44', '2026-09-15 05:51:44'),
(1334, '::1', '/bahawalcollegeofhealth/campuses.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'hadjd9tgapni9pber6vb9d7bbp', '2026-09-15', '07:51:45', '2026-09-15 05:51:45'),
(1335, '::1', '/bahawalcollegeofhealth/campus-portal.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'd8mcpmurdfverh1qnb6q2rvg3i', '2026-09-15', '07:51:46', '2026-09-15 05:51:46'),
(1336, '::1', '/bahawalcollegeofhealth/events.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '1cnaa58boc59ro6qcu8s07lagh', '2026-09-15', '07:51:46', '2026-09-15 05:51:46'),
(1337, '::1', '/bahawalcollegeofhealth/news.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '0q6hr2vo8rsaa09pg7ssu6iir1', '2026-09-15', '07:51:47', '2026-09-15 05:51:47'),
(1338, '::1', '/bahawalcollegeofhealth/activities.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'fd8ss15bam7bgj3ve56mpfiaqm', '2026-09-15', '07:51:48', '2026-09-15 05:51:48'),
(1339, '::1', '/bahawalcollegeofhealth/gallery.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'fbfr7j330jbal7mbgkcrpnbsng', '2026-09-15', '07:51:48', '2026-09-15 05:51:48'),
(1340, '::1', '/bahawalcollegeofhealth/contact.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'lae4o8cj67shglg1ukea1urtf3', '2026-09-15', '07:51:49', '2026-09-15 05:51:49'),
(1341, '::1', '/bahawalcollegeofhealth/about.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '1efuf0n3gh9cnccljvsbhubb2v', '2026-09-15', '07:52:00', '2026-09-15 05:52:00'),
(1342, '::1', '/bahawalcollegeofhealth/accreditation.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '1htala61l1dbddls3hnh0jhr2d', '2026-09-15', '07:52:01', '2026-09-15 05:52:01'),
(1343, '::1', '/bahawalcollegeofhealth/activities.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'cdsj18rc88lgttp8ke3rg9v7ac', '2026-09-15', '07:52:01', '2026-09-15 05:52:01'),
(1344, '::1', '/bahawalcollegeofhealth/admission.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'bmu5san1c283486po2d5gn69ka', '2026-09-15', '07:52:01', '2026-09-15 05:52:01'),
(1345, '::1', '/bahawalcollegeofhealth/campus-portal.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'cs9gia7tdl0tgshftjeojsnjio', '2026-09-15', '07:52:02', '2026-09-15 05:52:02'),
(1346, '::1', '/bahawalcollegeofhealth/campuses.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '49ir6k2v5a1v3itir8c9t15eh7', '2026-09-15', '07:52:02', '2026-09-15 05:52:02'),
(1347, '::1', '/bahawalcollegeofhealth/chairman-message.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'u4jjiudtpkuuvo1oo4jqg067ek', '2026-09-15', '07:52:03', '2026-09-15 05:52:03'),
(1348, '::1', '/bahawalcollegeofhealth/clinical-training.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'lnlgis9j83bqo7arpv0mrlkrea', '2026-09-15', '07:52:04', '2026-09-15 05:52:04'),
(1349, '::1', '/bahawalcollegeofhealth/contact.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'h0pbev80hj08tpamejcm59pt57', '2026-09-15', '07:52:04', '2026-09-15 05:52:04'),
(1350, '::1', '/bahawalcollegeofhealth/core-values.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '8rfcrv846ig69d5u8586i6ri7g', '2026-09-15', '07:52:04', '2026-09-15 05:52:04'),
(1351, '::1', '/bahawalcollegeofhealth/courses.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'kj9rsde37amgatig6e35d5cnno', '2026-09-15', '07:52:05', '2026-09-15 05:52:05'),
(1352, '::1', '/bahawalcollegeofhealth/downloads.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '5ivid2g74q4pdtijiqvfpe7513', '2026-09-15', '07:52:05', '2026-09-15 05:52:05'),
(1353, '::1', '/bahawalcollegeofhealth/eligibility-checker.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'bgc0pp2umm0jcgamk4khdrf173', '2026-09-15', '07:52:06', '2026-09-15 05:52:06'),
(1354, '::1', '/bahawalcollegeofhealth/events.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'qj1n0fqe6s9ps1t4ohtv7lkr83', '2026-09-15', '07:52:06', '2026-09-15 05:52:06'),
(1355, '::1', '/bahawalcollegeofhealth/examination.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'fq61iqpoiatm635k6db529fcc8', '2026-09-15', '07:52:06', '2026-09-15 05:52:06'),
(1356, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'qpsgbqpe5clrri01ml0ahguhr4', '2026-09-15', '07:52:07', '2026-09-15 05:52:07'),
(1357, '::1', '/bahawalcollegeofhealth/fee-calculator.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'kb5pj6ua972m7kbqsitqo7t19a', '2026-09-15', '07:52:07', '2026-09-15 05:52:07'),
(1358, '::1', '/bahawalcollegeofhealth/foundation.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'i6svq465ci5jidvukhbo61n4ae', '2026-09-15', '07:52:07', '2026-09-15 05:52:07'),
(1359, '::1', '/bahawalcollegeofhealth/gallery.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'j5p5cfo0u9l1piebel81n54cls', '2026-09-15', '07:52:08', '2026-09-15 05:52:08'),
(1360, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '29fpv1p1925dhnbm91m6hr7eul', '2026-09-15', '07:52:08', '2026-09-15 05:52:08'),
(1361, '::1', '/bahawalcollegeofhealth/leadership.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '8r1r8a2tgk31dbi5prm10bca9t', '2026-09-15', '07:52:08', '2026-09-15 05:52:08'),
(1362, '::1', '/bahawalcollegeofhealth/mission-vision.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '7tv3g0slftdpug0dnnd4gueppg', '2026-09-15', '07:52:09', '2026-09-15 05:52:09'),
(1363, '::1', '/bahawalcollegeofhealth/news.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'jn38spj69rq0jspqqpfoigd85k', '2026-09-15', '07:52:09', '2026-09-15 05:52:09'),
(1364, '::1', '/bahawalcollegeofhealth/notifications.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '8mk2m0g8sj1bcn6bpjg6rtvbtb', '2026-09-15', '07:52:09', '2026-09-15 05:52:09'),
(1365, '::1', '/bahawalcollegeofhealth/our-networks.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'ipce85ilo9b32tjeghfke286e2', '2026-09-15', '07:52:10', '2026-09-15 05:52:10'),
(1366, '::1', '/bahawalcollegeofhealth/our-projects.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'dhtvn5d6h18p74t9gc8vubbot8', '2026-09-15', '07:52:10', '2026-09-15 05:52:10'),
(1367, '::1', '/bahawalcollegeofhealth/principal-message.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'usruhrf7n0sa67sq8pufjgvhk1', '2026-09-15', '07:52:11', '2026-09-15 05:52:11'),
(1368, '::1', '/bahawalcollegeofhealth/scholarships.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'ea7gpiucob4rsfb5a9qv45vko3', '2026-09-15', '07:52:11', '2026-09-15 05:52:11'),
(1369, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '3t63o6d899eq6u84m4r5jg3qoe', '2026-09-15', '07:52:22', '2026-09-15 05:52:22'),
(1370, '::1', '/bahawalcollegeofhealth/about.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'spjd52ds6jeoc8ea3sm4tc09th', '2026-09-15', '07:52:22', '2026-09-15 05:52:22'),
(1371, '::1', '/bahawalcollegeofhealth/mission-vision.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 't1hbe8aomtj1f7n6hfcipqkdh0', '2026-09-15', '07:52:23', '2026-09-15 05:52:23'),
(1372, '::1', '/bahawalcollegeofhealth/core-values.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'up8fj67dje0v9q1ft0rtu5oad7', '2026-09-15', '07:52:23', '2026-09-15 05:52:23'),
(1373, '::1', '/bahawalcollegeofhealth/leadership.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '7mcl9sr1o65lfa3ru383mfj368', '2026-09-15', '07:52:24', '2026-09-15 05:52:24'),
(1374, '::1', '/bahawalcollegeofhealth/chairman-message.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'lf54a7d2fr387975a8elf4ffor', '2026-09-15', '07:52:24', '2026-09-15 05:52:24'),
(1375, '::1', '/bahawalcollegeofhealth/principal-message.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'mnjmn3pu68s7qphiapq6qd5vvl', '2026-09-15', '07:52:25', '2026-09-15 05:52:25'),
(1376, '::1', '/bahawalcollegeofhealth/foundation.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '3bk5gfkkuar3u75vlu9g4p4bud', '2026-09-15', '07:52:25', '2026-09-15 05:52:25'),
(1377, '::1', '/bahawalcollegeofhealth/courses.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '18hpe3al9oe0k3rge2lbpb6i5i', '2026-09-15', '07:52:26', '2026-09-15 05:52:26'),
(1378, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'scd097l6fs3651p0hs3pi7vtem', '2026-09-15', '07:52:27', '2026-09-15 05:52:27'),
(1379, '::1', '/bahawalcollegeofhealth/examination.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '02b9v1h7ruulmbbqg129an4rps', '2026-09-15', '07:52:27', '2026-09-15 05:52:27'),
(1380, '::1', '/bahawalcollegeofhealth/clinical-training.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'mn2spvo3dor28e3eaak2cfu5c8', '2026-09-15', '07:52:28', '2026-09-15 05:52:28'),
(1381, '::1', '/bahawalcollegeofhealth/our-networks.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'lem9qacghjtcfm5pvdd3mktntb', '2026-09-15', '07:52:29', '2026-09-15 05:52:29'),
(1382, '::1', '/bahawalcollegeofhealth/our-projects.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '5d09v106ccvquqthibojefoqpj', '2026-09-15', '07:52:30', '2026-09-15 05:52:30'),
(1383, '::1', '/bahawalcollegeofhealth/accreditation.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'a63qplkun7ca7t0oac3md81uuc', '2026-09-15', '07:52:30', '2026-09-15 05:52:30'),
(1384, '::1', '/bahawalcollegeofhealth/admission.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'qml62grqb9r2b21r259j12vmjf', '2026-09-15', '07:52:31', '2026-09-15 05:52:31'),
(1385, '::1', '/bahawalcollegeofhealth/fee-calculator.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'augcildpturcm3ur5c7q207alg', '2026-09-15', '07:52:31', '2026-09-15 05:52:31'),
(1386, '::1', '/bahawalcollegeofhealth/scholarships.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '9csrfnm7nkomofq95p22772oe5', '2026-09-15', '07:52:32', '2026-09-15 05:52:32'),
(1387, '::1', '/bahawalcollegeofhealth/eligibility-checker.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 's0eima7i0pd3ors70q0ii70sq6', '2026-09-15', '07:52:32', '2026-09-15 05:52:32'),
(1388, '::1', '/bahawalcollegeofhealth/campuses.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '6qlg34hrrro1ef3i1joeo3gkft', '2026-09-15', '07:52:33', '2026-09-15 05:52:33'),
(1389, '::1', '/bahawalcollegeofhealth/events.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'rsife0cu2igusalktkelevlrog', '2026-09-15', '07:52:34', '2026-09-15 05:52:34'),
(1390, '::1', '/bahawalcollegeofhealth/activities.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'adfi71bq81dendr4lf13h9lcir', '2026-09-15', '07:52:34', '2026-09-15 05:52:34'),
(1391, '::1', '/bahawalcollegeofhealth/gallery.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'vgcsromke4rn0idoge5hftfpcv', '2026-09-15', '07:52:35', '2026-09-15 05:52:35'),
(1392, '::1', '/bahawalcollegeofhealth/contact.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'bqo7o5v1nj55u4licd2he0e8t3', '2026-09-15', '07:52:35', '2026-09-15 05:52:35'),
(1393, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'jjd0b1l50mrb44m57fd471q456', '2026-09-15', '07:53:35', '2026-09-15 05:53:35'),
(1394, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'jjd0b1l50mrb44m57fd471q456', '2026-09-15', '07:53:36', '2026-09-15 05:53:36'),
(1395, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'fm0nm0td1n4cfj7pkn922uf24o', '2026-09-15', '07:53:53', '2026-09-15 05:53:53'),
(1396, '::1', '/bahawalcollegeofhealth/about.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '1uul5rsk3d2bi83gcjv2tivqkq', '2026-09-15', '07:54:03', '2026-09-15 05:54:03'),
(1397, '::1', '/bahawalcollegeofhealth/chairman-message.php', '', 'http://localhost/bahawalcollegeofhealth/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'jjd0b1l50mrb44m57fd471q456', '2026-09-15', '07:54:10', '2026-09-15 05:54:10'),
(1398, '::1', '/bahawalcollegeofhealth/mission-vision.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '46r3re1dmct4fieu29i04d66qa', '2026-09-15', '07:54:11', '2026-09-15 05:54:11'),
(1399, '::1', '/bahawalcollegeofhealth/core-values.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'lrqqgtci5jc98ar2f5rhebld2i', '2026-09-15', '07:54:15', '2026-09-15 05:54:15'),
(1400, '::1', '/bahawalcollegeofhealth/principal-message.php', '', 'http://localhost/bahawalcollegeofhealth/chairman-message.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'jjd0b1l50mrb44m57fd471q456', '2026-09-15', '07:54:18', '2026-09-15 05:54:18'),
(1401, '::1', '/bahawalcollegeofhealth/leadership.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '84ja3vh11gpssugg0rail39v7a', '2026-09-15', '07:54:20', '2026-09-15 05:54:20'),
(1402, '::1', '/bahawalcollegeofhealth/chairman-message.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'gk3ah891li7pqsnmbivnnahi21', '2026-09-15', '07:54:23', '2026-09-15 05:54:23'),
(1403, '::1', '/bahawalcollegeofhealth/index.php', '', 'http://localhost/bahawalcollegeofhealth/principal-message.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'jjd0b1l50mrb44m57fd471q456', '2026-09-15', '07:54:24', '2026-09-15 05:54:24'),
(1404, '::1', '/bahawalcollegeofhealth/principal-message.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'opegtnngng6alv7ar9gvns54tk', '2026-09-15', '07:54:26', '2026-09-15 05:54:26'),
(1405, '::1', '/bahawalcollegeofhealth/foundation.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'bhb1bfo66q5fdiafl4aboqu2p9', '2026-09-15', '07:54:30', '2026-09-15 05:54:30'),
(1406, '::1', '/bahawalcollegeofhealth/courses.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'kajoh6l0s9pjncqeg6d50b8bde', '2026-09-15', '07:54:33', '2026-09-15 05:54:33'),
(1407, '::1', '/bahawalcollegeofhealth/principal-message.php', '', 'http://localhost/bahawalcollegeofhealth/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'jjd0b1l50mrb44m57fd471q456', '2026-09-15', '07:54:43', '2026-09-15 05:54:43'),
(1408, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '21u6unvl8h8s83ph2jt6m96260', '2026-09-15', '07:54:44', '2026-09-15 05:54:44'),
(1409, '::1', '/bahawalcollegeofhealth/examination.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '6bq60uv24k312p1pobb7ktjf7d', '2026-09-15', '07:54:48', '2026-09-15 05:54:48'),
(1410, '::1', '/bahawalcollegeofhealth/clinical-training.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'fnk6o694jq8dogrk4so1hma5m1', '2026-09-15', '07:55:08', '2026-09-15 05:55:08'),
(1411, '::1', '/bahawalcollegeofhealth/our-networks.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'gd6tpmgchbdupmla73drf6qjv0', '2026-09-15', '07:55:22', '2026-09-15 05:55:22'),
(1412, '::1', '/bahawalcollegeofhealth/our-projects.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'cc4690o8c90if300fv12sd5o8b', '2026-09-15', '07:55:30', '2026-09-15 05:55:30'),
(1413, '::1', '/bahawalcollegeofhealth/accreditation.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'cpu8vgj9koe40hnnpnbakpn7bf', '2026-09-15', '07:55:40', '2026-09-15 05:55:40'),
(1414, '::1', '/bahawalcollegeofhealth/admission.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'kshqpk80t7f9817vm76hpshqq2', '2026-09-15', '07:56:03', '2026-09-15 05:56:03'),
(1415, '::1', '/bahawalcollegeofhealth/downloads.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'bjcd3as9pi2mdit2k2a3rq4co8', '2026-09-15', '07:56:24', '2026-09-15 05:56:24'),
(1416, '::1', '/bahawalcollegeofhealth/notifications.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'o0srn1dbrtivvjdnsvel1nu2tm', '2026-09-15', '07:56:44', '2026-09-15 05:56:44'),
(1417, '::1', '/bahawalcollegeofhealth/fee-calculator.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'e6qvhrvflnvsgqlsn9l0behmga', '2026-09-15', '07:56:52', '2026-09-15 05:56:53'),
(1418, '::1', '/bahawalcollegeofhealth/fee-calculator.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'lll1hqrqsc4olsdbiq35mm7l25', '2026-09-15', '07:56:54', '2026-09-15 05:56:54'),
(1419, '::1', '/bahawalcollegeofhealth/eligibility-checker.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'e6qvhrvflnvsgqlsn9l0behmga', '2026-09-15', '07:56:57', '2026-09-15 05:56:57'),
(1420, '::1', '/bahawalcollegeofhealth/scholarships.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'ouee1vb8073mi30p81skljbhrc', '2026-09-15', '07:56:58', '2026-09-15 05:56:58'),
(1421, '::1', '/bahawalcollegeofhealth/eligibility-checker.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'mdsk0ge5fq9dg0ogfmddc7i3ok', '2026-09-15', '07:57:06', '2026-09-15 05:57:06'),
(1422, '::1', '/bahawalcollegeofhealth/scholarships.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'e6qvhrvflnvsgqlsn9l0behmga', '2026-09-15', '07:57:15', '2026-09-15 05:57:15'),
(1423, '::1', '/bahawalcollegeofhealth/campuses.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'g4m0afsi63de3ld5ulk8kp78pk', '2026-09-15', '07:57:16', '2026-09-15 05:57:16'),
(1424, '::1', '/bahawalcollegeofhealth/campus-portal.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'm67dqlbfr00j210fut5nrmliin', '2026-09-15', '07:57:25', '2026-09-15 05:57:25'),
(1425, '::1', '/bahawalcollegeofhealth/events.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '875gfpeurmvph976qmdmeot1ml', '2026-09-15', '07:57:35', '2026-09-15 05:57:35'),
(1426, '::1', '/bahawalcollegeofhealth/news.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'b0u2u8bhm3gg1fbuod4nrbfdu1', '2026-09-15', '07:57:38', '2026-09-15 05:57:38'),
(1427, '::1', '/bahawalcollegeofhealth/activities.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'tt9m7f550sm3pdd2j0nmb8g0h5', '2026-09-15', '07:57:44', '2026-09-15 05:57:44'),
(1428, '::1', '/bahawalcollegeofhealth/gallery.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'in35bdco3o5n7o411nj4l8hirl', '2026-09-15', '07:57:50', '2026-09-15 05:57:50'),
(1429, '::1', '/bahawalcollegeofhealth/contact.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '4vd19ospsgbs6b5btsq72glg46', '2026-09-15', '07:57:59', '2026-09-15 05:57:59'),
(1430, '::1', '/bahawalcollegeofhealth/admission.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'h3p59nobaq8tcvmeuppf1gqq82', '2026-09-15', '07:58:30', '2026-09-15 05:58:30'),
(1431, '::1', '/bahawalcollegeofhealth/examination.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'ampeifa2pvum3v0afutc6jk6ji', '2026-09-15', '07:59:04', '2026-09-15 05:59:04');
INSERT INTO `website_analytics` (`id`, `visitor_ip`, `page_url`, `page_title`, `referrer`, `user_agent`, `device_type`, `browser`, `operating_system`, `country`, `city`, `session_id`, `visit_date`, `visit_time`, `created_at`) VALUES
(1432, '::1', '/bahawalcollegeofhealth/accreditation.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'aa5im6l9iu02qdmbqu6qmk6o3n', '2026-09-15', '07:59:20', '2026-09-15 05:59:20'),
(1433, '::1', '/bahawalcollegeofhealth/admission.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'h3patsnb1887feuqd9r0q6hc49', '2026-09-15', '07:59:30', '2026-09-15 05:59:30'),
(1434, '::1', '/bahawalcollegeofhealth/downloads.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'f4klvf6ko2koc1p5rloa4v3nbc', '2026-09-15', '07:59:43', '2026-09-15 05:59:43'),
(1435, '::1', '/bahawalcollegeofhealth/examination.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'e0c31k0l94gnlvn0o5u9uclp64', '2026-09-15', '08:00:03', '2026-09-15 06:00:03'),
(1436, '::1', '/bahawalcollegeofhealth/examination.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'aejp3018dl78miimedsi1vm3tj', '2026-09-15', '08:00:38', '2026-09-15 06:00:38'),
(1437, '::1', '/bahawalcollegeofhealth/examination.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'qjtid9uqvoukhkei9nar9g3ugo', '2026-09-15', '08:00:45', '2026-09-15 06:00:45'),
(1438, '::1', '/bahawalcollegeofhealth/examination.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'f6o4499ds2h1u41ko5j3cgt9tg', '2026-09-15', '08:00:51', '2026-09-15 06:00:51'),
(1439, '::1', '/bahawalcollegeofhealth/examination.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'al080qrane4c8i8bogn2sbdpo4', '2026-09-15', '08:01:35', '2026-09-15 06:01:35'),
(1440, '::1', '/bahawalcollegeofhealth/examination.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'helgqcj4ul2p69354b3kpbanic', '2026-09-15', '08:05:54', '2026-09-15 06:05:54'),
(1441, '::1', '/bahawalcollegeofhealth/examination.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'h5391pe4bgfc8igm2e16bo5dsu', '2026-09-15', '08:06:03', '2026-09-15 06:06:03'),
(1442, '::1', '/bahawalcollegeofhealth/examination.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'ka6ulf5shdh866bvr88g96a0sl', '2026-09-15', '08:06:10', '2026-09-15 06:06:10'),
(1443, '::1', '/bahawalcollegeofhealth/principal-message.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'jjd0b1l50mrb44m57fd471q456', '2026-09-15', '08:06:21', '2026-09-15 06:06:21'),
(1444, '::1', '/bahawalcollegeofhealth/examination.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'be3bc80d03ojdop1i8na90e1j6', '2026-09-15', '08:07:36', '2026-09-15 06:07:36'),
(1445, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '6vdjj8g69c6ish58k1c8fv14k9', '2026-09-15', '08:10:12', '2026-09-15 06:10:12'),
(1446, '::1', '/bahawalcollegeofhealth/about.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '87nthfdh95aqcah0017p3644r2', '2026-09-15', '08:10:21', '2026-09-15 06:10:21'),
(1447, '::1', '/bahawalcollegeofhealth/courses.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '5p6euus9s4l2k4pefutag9pva5', '2026-09-15', '08:10:26', '2026-09-15 06:10:26'),
(1448, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '8g8i8p5gc6433q13cuudd33i4u', '2026-09-15', '08:10:32', '2026-09-15 06:10:32'),
(1449, '::1', '/bahawalcollegeofhealth/clinical-training.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '0oa12s9cqnqmvkdvlbjvt8k3lr', '2026-09-15', '08:10:56', '2026-09-15 06:10:56'),
(1450, '::1', '/bahawalcollegeofhealth/our-networks.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'o57atqdl2ugmh6mjnn7tav7hu8', '2026-09-15', '08:11:04', '2026-09-15 06:11:04'),
(1451, '::1', '/bahawalcollegeofhealth/our-projects.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '1ob7e0sbsdjvhrh6lik0ijrrjl', '2026-09-15', '08:11:10', '2026-09-15 06:11:10'),
(1452, '::1', '/bahawalcollegeofhealth/accreditation.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'tiomc5ng7qt96tgb38rqoij5g7', '2026-09-15', '08:11:13', '2026-09-15 06:11:13'),
(1453, '::1', '/bahawalcollegeofhealth/admission.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '20nuo93r2grt5ab2htk4a3sa2k', '2026-09-15', '08:11:21', '2026-09-15 06:11:21'),
(1454, '::1', '/bahawalcollegeofhealth/fee-calculator.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '0616rfvsvamk010e1pubnabs1t', '2026-09-15', '08:11:26', '2026-09-15 06:11:26'),
(1455, '::1', '/bahawalcollegeofhealth/scholarships.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'jdkplnttikggod3carh4pga3uc', '2026-09-15', '08:11:29', '2026-09-15 06:11:29'),
(1456, '::1', '/bahawalcollegeofhealth/eligibility-checker.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'p7vklvltk8gqp2pbiuqkqqbsdl', '2026-09-15', '08:11:33', '2026-09-15 06:11:33'),
(1457, '::1', '/bahawalcollegeofhealth/foundation.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'a0t0h1q6e0jtp71681j96jvtjm', '2026-09-15', '08:11:39', '2026-09-15 06:11:39'),
(1458, '::1', '/bahawalcollegeofhealth/chairman-message.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '1a37nqfsc14kfqjqndlq20rhgm', '2026-09-15', '08:11:43', '2026-09-15 06:11:43'),
(1459, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'u5v1hos772fpv6bleb7ic24tqt', '2026-09-15', '08:11:51', '2026-09-15 06:11:51'),
(1460, '::1', '/bahawalcollegeofhealth/admission.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'ckil2658hs5si3hka7sb3kfu6i', '2026-09-15', '08:11:52', '2026-09-15 06:11:52'),
(1461, '::1', '/bahawalcollegeofhealth/principal-message.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '0bqfktk7r1fodi2mjlbur6daso', '2026-09-15', '08:11:53', '2026-09-15 06:11:53'),
(1462, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'kc7tvfet4bid6fl7njo6ki9fnu', '2026-09-15', '08:11:53', '2026-09-15 06:11:53'),
(1463, '::1', '/bahawalcollegeofhealth/our-networks.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '7vm2fh67eno7epntq4j2h2opl6', '2026-09-15', '08:11:54', '2026-09-15 06:11:54'),
(1464, '::1', '/bahawalcollegeofhealth/our-projects.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '02k2locb4558kefca9vsi3u2d6', '2026-09-15', '08:11:56', '2026-09-15 06:11:56'),
(1465, '::1', '/bahawalcollegeofhealth/clinical-training.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '7esabhr78ofht763ij3abdrqur', '2026-09-15', '08:11:56', '2026-09-15 06:11:56'),
(1466, '::1', '/bahawalcollegeofhealth/activities.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '1akgh46flvj8hf8uf045apvuqk', '2026-09-15', '08:12:01', '2026-09-15 06:12:01'),
(1467, '::1', '/bahawalcollegeofhealth/contact.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'r4sjdp0c8cud803q9c3cm2ihnp', '2026-09-15', '08:12:06', '2026-09-15 06:12:06'),
(1468, '::1', '/bahawalcollegeofhealth/admission.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '8upummt61mmlamq8rce1943bfk', '2026-09-15', '08:12:14', '2026-09-15 06:12:14'),
(1469, '::1', '/bahawalcollegeofhealth/gallery.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'msh5f35e4d5mbd5aseo8nvacqn', '2026-09-15', '08:12:18', '2026-09-15 06:12:18'),
(1470, '::1', '/bahawalcollegeofhealth/campuses.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'h0rt7qiuq0d79piic3egddshn4', '2026-09-15', '08:12:24', '2026-09-15 06:12:25'),
(1471, '::1', '/bahawalcollegeofhealth/admission.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '6258g5k10sh4ov8dtpkig37cf7', '2026-09-15', '08:12:32', '2026-09-15 06:12:32'),
(1472, '::1', '/bahawalcollegeofhealth/examination.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'guvp6cd89ddskq3tocjoni9a3g', '2026-09-15', '08:12:32', '2026-09-15 06:12:32'),
(1473, '::1', '/bahawalcollegeofhealth/leadership.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'cdbe5rqvubi59befh7egvn5is7', '2026-09-15', '08:12:49', '2026-09-15 06:12:49'),
(1474, '127.0.0.1', '/bahawalcollegeofhealth/principal-message.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'jjd0b1l50mrb44m57fd471q456', '2026-09-15', '08:15:37', '2026-09-15 06:15:37'),
(1475, '::1', '/bahawalcollegeofhealth/index.php', '', 'http://localhost/bahawalcollegeofhealth/principal-message.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'jjd0b1l50mrb44m57fd471q456', '2026-09-15', '08:15:46', '2026-09-15 06:15:46'),
(1476, '::1', '/bahawalcollegeofhealth/contact.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'lft3c3is8ekcnjrt8bgch6jaen', '2026-09-15', '08:19:24', '2026-09-15 06:19:24'),
(1477, '::1', '/bahawalcollegeofhealth/admission.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'n5jhat43unf8pu3i327vqpgbsg', '2026-09-15', '08:21:26', '2026-09-15 06:21:26'),
(1478, '::1', '/bahawalcollegeofhealth/alumni.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'hm8sphfb3lf157gpor6ukhq46j', '2026-09-15', '08:21:28', '2026-09-15 06:21:28'),
(1479, '::1', '/bahawalcollegeofhealth/eligibility-checker.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'upisf9ulf96pbitauel3id5vod', '2026-09-15', '08:21:29', '2026-09-15 06:21:29'),
(1480, '::1', '/bahawalcollegeofhealth/fee-calculator.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '50f70s1naj15tb94qiap9i5v8v', '2026-09-15', '08:21:31', '2026-09-15 06:21:31'),
(1481, '::1', '/bahawalcollegeofhealth/contact.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '7d9ebvdrtb7rsfgtc8em4u4695', '2026-09-15', '08:21:32', '2026-09-15 06:21:32'),
(1482, '::1', '/bahawalcollegeofhealth/contact.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '36t548m95bkflgktm05dv9eo70', '2026-09-15', '08:22:37', '2026-09-15 06:22:37'),
(1483, '::1', '/bahawalcollegeofhealth/admission.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '36t548m95bkflgktm05dv9eo70', '2026-09-15', '08:22:48', '2026-09-15 06:22:48'),
(1484, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'mf7mlq845qjdjr9sqooe7msmkj', '2026-09-15', '08:23:13', '2026-09-15 06:23:13'),
(1485, '::1', '/bahawalcollegeofhealth/about.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '813jfmbjcqgi2lf27ptruldedv', '2026-09-15', '08:23:14', '2026-09-15 06:23:14'),
(1486, '::1', '/bahawalcollegeofhealth/mission-vision.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'ueupnmmv0pjadasdpomrnhas3r', '2026-09-15', '08:23:14', '2026-09-15 06:23:14'),
(1487, '::1', '/bahawalcollegeofhealth/core-values.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'lphpvtskae3vhup5leeerenkdo', '2026-09-15', '08:23:15', '2026-09-15 06:23:15'),
(1488, '::1', '/bahawalcollegeofhealth/leadership.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '6j4akn78uglcig0h687m8vl46h', '2026-09-15', '08:23:15', '2026-09-15 06:23:15'),
(1489, '::1', '/bahawalcollegeofhealth/chairman-message.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '3atomltdfnp5ai5ao7ru0u1qu5', '2026-09-15', '08:23:16', '2026-09-15 06:23:16'),
(1490, '::1', '/bahawalcollegeofhealth/principal-message.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'dajqqkb7h8o2saqk8marrfo3j9', '2026-09-15', '08:23:16', '2026-09-15 06:23:16'),
(1491, '::1', '/bahawalcollegeofhealth/foundation.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'jjhpn8iq3a3uaanj6dcsjp3skh', '2026-09-15', '08:23:17', '2026-09-15 06:23:17'),
(1492, '::1', '/bahawalcollegeofhealth/courses.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'gucb6r5ed7glfc0eoead7fl021', '2026-09-15', '08:23:17', '2026-09-15 06:23:17'),
(1493, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'eb1gqmbqucr76675c881ilh8rj', '2026-09-15', '08:23:18', '2026-09-15 06:23:18'),
(1494, '::1', '/bahawalcollegeofhealth/examination.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'feivh3njuu8ac00q6l9btg7t6v', '2026-09-15', '08:23:18', '2026-09-15 06:23:18'),
(1495, '::1', '/bahawalcollegeofhealth/clinical-training.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'vndvatqeb111onakba3el4n55f', '2026-09-15', '08:23:19', '2026-09-15 06:23:19'),
(1496, '::1', '/bahawalcollegeofhealth/our-networks.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'idbt50hrl2a1q8gv53kuos2bm9', '2026-09-15', '08:23:19', '2026-09-15 06:23:19'),
(1497, '::1', '/bahawalcollegeofhealth/our-projects.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 't7fss0jcmgt5bgn1rsdohchktp', '2026-09-15', '08:23:20', '2026-09-15 06:23:20'),
(1498, '::1', '/bahawalcollegeofhealth/accreditation.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '9v091lmg4s4hdbshnm8bcheogu', '2026-09-15', '08:23:21', '2026-09-15 06:23:21'),
(1499, '::1', '/bahawalcollegeofhealth/admission.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'g589vi4c3lvnd64am7548bv10r', '2026-09-15', '08:23:22', '2026-09-15 06:23:22'),
(1500, '::1', '/bahawalcollegeofhealth/downloads.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'pidc97001hqgb9o9afha1fd5ie', '2026-09-15', '08:23:23', '2026-09-15 06:23:23'),
(1501, '::1', '/bahawalcollegeofhealth/notifications.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'ijpsljp0jutlgsga1anjhjeq3g', '2026-09-15', '08:23:24', '2026-09-15 06:23:24'),
(1502, '::1', '/bahawalcollegeofhealth/fee-calculator.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '1lsusrtlgthq978gaghsn57e89', '2026-09-15', '08:23:25', '2026-09-15 06:23:25'),
(1503, '::1', '/bahawalcollegeofhealth/scholarships.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'gkkvs3qo8oqlp2cosrlo4if67e', '2026-09-15', '08:23:25', '2026-09-15 06:23:25'),
(1504, '::1', '/bahawalcollegeofhealth/eligibility-checker.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'pulo8i71js9a5c7mtsdob24sjl', '2026-09-15', '08:23:26', '2026-09-15 06:23:26'),
(1505, '::1', '/bahawalcollegeofhealth/campuses.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '5doqgmeli41oad3m0bmnkv4n0j', '2026-09-15', '08:23:26', '2026-09-15 06:23:26'),
(1506, '::1', '/bahawalcollegeofhealth/campus-portal.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '4soqp7fk77l4erthq0g88pspli', '2026-09-15', '08:23:27', '2026-09-15 06:23:27'),
(1507, '::1', '/bahawalcollegeofhealth/events.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '3an7gnms1k13vh5kgc5nbtc692', '2026-09-15', '08:23:27', '2026-09-15 06:23:27'),
(1508, '::1', '/bahawalcollegeofhealth/news.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'qm2gvimuihlsabl9qbb0daqbe3', '2026-09-15', '08:23:28', '2026-09-15 06:23:28'),
(1509, '::1', '/bahawalcollegeofhealth/activities.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '22rg5rjgigs84qbj55sgi3dga0', '2026-09-15', '08:23:28', '2026-09-15 06:23:28'),
(1510, '::1', '/bahawalcollegeofhealth/gallery.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'p9q3ncu3p7uv24kuv57ekr4keq', '2026-09-15', '08:23:29', '2026-09-15 06:23:29'),
(1511, '::1', '/bahawalcollegeofhealth/contact.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'jsod9d07bh2meclj0jukebugv6', '2026-09-15', '08:23:29', '2026-09-15 06:23:29'),
(1512, '::1', '/bahawalcollegeofhealth/alumni.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'ng4pfacs3aq7vph82u53arje57', '2026-09-15', '08:23:30', '2026-09-15 06:23:30'),
(1513, '::1', '/bahawalcollegeofhealth/about.php', '', 'http://localhost/bahawalcollegeofhealth/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'jjd0b1l50mrb44m57fd471q456', '2026-09-15', '08:24:58', '2026-09-15 06:24:58'),
(1514, '::1', '/bahawalcollegeofhealth/leadership.php', '', 'http://localhost/bahawalcollegeofhealth/about.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'jjd0b1l50mrb44m57fd471q456', '2026-09-15', '08:25:15', '2026-09-15 06:25:15'),
(1515, '::1', '/bahawalcollegeofhealth/chairman-message.php', '', 'http://localhost/bahawalcollegeofhealth/leadership.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'jjd0b1l50mrb44m57fd471q456', '2026-09-15', '08:25:38', '2026-09-15 06:25:38'),
(1516, '::1', '/bahawalcollegeofhealth/about.php', '', 'http://localhost/bahawalcollegeofhealth/chairman-message.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'jjd0b1l50mrb44m57fd471q456', '2026-09-15', '08:25:41', '2026-09-15 06:25:41'),
(1517, '::1', '/bahawalcollegeofhealth/principal-message.php', '', 'http://localhost/bahawalcollegeofhealth/about.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'jjd0b1l50mrb44m57fd471q456', '2026-09-15', '08:25:43', '2026-09-15 06:25:43'),
(1518, '::1', '/bahawalcollegeofhealth/leadership.php', '', 'http://localhost/bahawalcollegeofhealth/principal-message.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'jjd0b1l50mrb44m57fd471q456', '2026-09-15', '08:25:47', '2026-09-15 06:25:47'),
(1519, '::1', '/bahawalcollegeofhealth/leadership.php', '', 'http://localhost/bahawalcollegeofhealth/principal-message.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'jjd0b1l50mrb44m57fd471q456', '2026-09-15', '08:26:39', '2026-09-15 06:26:39'),
(1520, '::1', '/bahawalcollegeofhealth/chairman-message.php', '', 'http://localhost/bahawalcollegeofhealth/leadership.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'jjd0b1l50mrb44m57fd471q456', '2026-09-15', '08:27:07', '2026-09-15 06:27:07'),
(1521, '::1', '/bahawalcollegeofhealth/about.php', '', 'http://localhost/bahawalcollegeofhealth/chairman-message.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'jjd0b1l50mrb44m57fd471q456', '2026-09-15', '08:27:18', '2026-09-15 06:27:18'),
(1522, '::1', '/bahawalcollegeofhealth/principal-message.php', '', 'http://localhost/bahawalcollegeofhealth/about.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'jjd0b1l50mrb44m57fd471q456', '2026-09-15', '08:27:20', '2026-09-15 06:27:20'),
(1523, '::1', '/bahawalcollegeofhealth/chairman-message.php', '', 'http://localhost/bahawalcollegeofhealth/principal-message.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'jjd0b1l50mrb44m57fd471q456', '2026-09-15', '08:27:31', '2026-09-15 06:27:31'),
(1524, '::1', '/bahawalcollegeofhealth/leadership.php', '', 'http://localhost/bahawalcollegeofhealth/chairman-message.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'jjd0b1l50mrb44m57fd471q456', '2026-09-15', '08:27:36', '2026-09-15 06:27:36'),
(1525, '::1', '/bahawalcollegeofhealth/leadership.php', '', 'http://localhost/bahawalcollegeofhealth/chairman-message.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'jjd0b1l50mrb44m57fd471q456', '2026-09-15', '09:13:53', '2026-09-15 07:13:53'),
(1526, '::1', '/bahawalcollegeofhealth/index.php', '', 'http://localhost/bahawalcollegeofhealth/leadership.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'jjd0b1l50mrb44m57fd471q456', '2026-09-15', '09:13:57', '2026-09-15 07:13:57'),
(1527, '::1', '/bahawalcollegeofhealth/index.php', '', 'http://localhost/bahawalcollegeofhealth/leadership.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'jjd0b1l50mrb44m57fd471q456', '2026-09-15', '11:04:44', '2026-09-15 09:04:44'),
(1528, '::1', '/bahawalcollegeofhealth/index.php', '', 'http://localhost/bahawalcollegeofhealth/leadership.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'jjd0b1l50mrb44m57fd471q456', '2026-09-15', '11:12:38', '2026-09-15 09:12:38'),
(1529, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'bqjar5g56q4g591fln55k2s6p9', '2026-09-15', '11:14:44', '2026-09-15 09:14:44'),
(1530, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '9ibt1o9rf3r81trhnnhq1ml88k', '2026-09-15', '11:14:55', '2026-09-15 09:14:55'),
(1531, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'npc4nt07gkl2vos1vdv674t54b', '2026-09-15', '11:15:11', '2026-09-15 09:15:12'),
(1532, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'u87nm4cb8k06uv3teqtpvgg0qv', '2026-09-15', '11:17:14', '2026-09-15 09:17:14'),
(1533, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'a4eir489bmvh4s65gd72jjf14b', '2026-09-15', '11:17:27', '2026-09-15 09:17:27'),
(1534, '::1', '/bahawalcollegeofhealth/index.php', '', 'http://localhost/bahawalcollegeofhealth/leadership.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'jjd0b1l50mrb44m57fd471q456', '2026-09-15', '11:17:34', '2026-09-15 09:17:34'),
(1535, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'isllogph628k8ah806spapk500', '2026-09-15', '11:17:36', '2026-09-15 09:17:36'),
(1536, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'qvfr8ev4v492i0ek3nt013k766', '2026-09-15', '11:17:48', '2026-09-15 09:17:48'),
(1537, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'hqv7k3r8ush7t9opq43hrvrfk7', '2026-09-15', '11:18:27', '2026-09-15 09:18:27'),
(1538, '::1', '/bahawalcollegeofhealth/index.php', '', 'http://localhost/bahawalcollegeofhealth/leadership.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'jjd0b1l50mrb44m57fd471q456', '2026-09-15', '11:18:39', '2026-09-15 09:18:39'),
(1539, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'e3fpdl5gi0i3k7afl41jm2vs5t', '2026-09-15', '11:20:38', '2026-09-15 09:20:38'),
(1540, '::1', '/bahawalcollegeofhealth/about.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'rmhq6qpsmnh6k5om0vnmmate2e', '2026-09-15', '11:20:39', '2026-09-15 09:20:39'),
(1541, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'nbmkn2pigbimg7auo5qv6sa6ho', '2026-09-15', '11:20:59', '2026-09-15 09:20:59'),
(1542, '::1', '/bahawalcollegeofhealth/index.php', '', 'http://localhost/bahawalcollegeofhealth/leadership.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'jjd0b1l50mrb44m57fd471q456', '2026-09-15', '11:21:29', '2026-09-15 09:21:29'),
(1543, '::1', '/bahawalcollegeofhealth/about.php', '', 'http://localhost/bahawalcollegeofhealth/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'jjd0b1l50mrb44m57fd471q456', '2026-09-15', '11:21:47', '2026-09-15 09:21:47'),
(1544, '::1', '/bahawalcollegeofhealth/index.php', '', 'http://localhost/bahawalcollegeofhealth/about.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'jjd0b1l50mrb44m57fd471q456', '2026-09-15', '11:22:00', '2026-09-15 09:22:00'),
(1545, '::1', '/bahawalcollegeofhealth/courses.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '1mcbrgf65cvojliubrmmm5qcrv', '2026-09-15', '11:34:37', '2026-09-15 09:34:37'),
(1546, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'bc5cdd0roc68ci3um63n7irhgp', '2026-09-15', '11:34:38', '2026-09-15 09:34:38'),
(1547, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'l0m0kbhvpvav0h7d0hhsp9ecqd', '2026-09-15', '12:19:53', '2026-09-15 10:19:53'),
(1548, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'jjd0b1l50mrb44m57fd471q456', '2026-09-16', '08:37:36', '2026-09-16 06:37:36'),
(1549, '::1', '/bahawalcollegeofhealth/index.php', '', 'http://localhost/bahawalcollegeofhealth/AdminCP/dashboard.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'jjd0b1l50mrb44m57fd471q456', '2026-09-16', '08:38:11', '2026-09-16 06:38:11'),
(1550, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'dsg8ji3v51ufb5ehgs3269bv6q', '2026-09-16', '09:19:25', '2026-09-16 07:19:25'),
(1551, '::1', '/bahawalcollegeofhealth/index.php', '', 'http://localhost/bahawalcollegeofhealth/AdminCP/dashboard.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'jjd0b1l50mrb44m57fd471q456', '2026-09-16', '09:22:05', '2026-09-16 07:22:05'),
(1552, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'http://localhost/bahawalcollegeofhealth/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'jjd0b1l50mrb44m57fd471q456', '2026-09-16', '09:22:20', '2026-09-16 07:22:20'),
(1553, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'http://localhost/bahawalcollegeofhealth/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'jjd0b1l50mrb44m57fd471q456', '2026-09-16', '09:40:51', '2026-09-16 07:40:51'),
(1554, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'jjd0b1l50mrb44m57fd471q456', '2026-09-16', '09:46:36', '2026-09-16 07:46:36'),
(1555, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'ltlmrthrt71k0a4ma3mhbiio49', '2026-09-16', '09:50:28', '2026-09-16 07:50:28'),
(1556, '::1', '/bahawalcollegeofhealth/campus-portal.php', '', 'http://localhost/bahawalcollegeofhealth/faculty.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'jjd0b1l50mrb44m57fd471q456', '2026-09-16', '09:52:10', '2026-09-16 07:52:10'),
(1557, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'cnmem2ehkgg3h73ubnm7dgmbp2', '2026-09-16', '10:16:17', '2026-09-16 08:16:17'),
(1558, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'cnmem2ehkgg3h73ubnm7dgmbp2', '2026-09-16', '10:16:27', '2026-09-16 08:16:27'),
(1559, '::1', '/bahawalcollegeofhealth/campus-portal.php', '', 'http://localhost/bahawalcollegeofhealth/faculty.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'jjd0b1l50mrb44m57fd471q456', '2026-09-16', '10:26:16', '2026-09-16 08:26:16'),
(1560, '::1', '/bahawalcollegeofhealth/campus-portal.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'jjd0b1l50mrb44m57fd471q456', '2026-09-16', '10:26:18', '2026-09-16 08:26:18'),
(1561, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'http://localhost/bahawalcollegeofhealth/campus-portal.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'jjd0b1l50mrb44m57fd471q456', '2026-09-16', '10:26:26', '2026-09-16 08:26:26'),
(1562, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'http://localhost/bahawalcollegeofhealth/campus-portal.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'jjd0b1l50mrb44m57fd471q456', '2026-09-16', '10:27:11', '2026-09-16 08:27:11'),
(1563, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'http://localhost/bahawalcollegeofhealth/campus-portal.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'jjd0b1l50mrb44m57fd471q456', '2026-09-16', '10:47:03', '2026-09-16 08:47:04'),
(1564, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'http://localhost/bahawalcollegeofhealth/campus-portal.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'jjd0b1l50mrb44m57fd471q456', '2026-09-16', '10:47:12', '2026-09-16 08:47:12'),
(1565, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'glvo8bs1o97djptnau3s1eul55', '2026-09-16', '10:48:52', '2026-09-16 08:48:52'),
(1566, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'liuuj7dr22u9ojch5j87ljp2e4', '2026-09-16', '10:50:56', '2026-09-16 08:50:56'),
(1567, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'http://localhost/bahawalcollegeofhealth/campus-portal.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'jjd0b1l50mrb44m57fd471q456', '2026-09-16', '10:52:31', '2026-09-16 08:52:31'),
(1568, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'http://localhost/bahawalcollegeofhealth/campus-portal.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'jjd0b1l50mrb44m57fd471q456', '2026-09-16', '10:52:40', '2026-09-16 08:52:40'),
(1569, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'http://localhost/bahawalcollegeofhealth/campus-portal.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'jjd0b1l50mrb44m57fd471q456', '2026-09-16', '10:53:18', '2026-09-16 08:53:18'),
(1570, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'http://localhost/bahawalcollegeofhealth/campus-portal.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'jjd0b1l50mrb44m57fd471q456', '2026-09-16', '10:58:39', '2026-09-16 08:58:39'),
(1571, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'http://localhost/bahawalcollegeofhealth/campus-portal.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'jjd0b1l50mrb44m57fd471q456', '2026-09-16', '11:01:17', '2026-09-16 09:01:17'),
(1572, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'http://localhost/bahawalcollegeofhealth/campus-portal.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'jjd0b1l50mrb44m57fd471q456', '2026-09-16', '11:04:37', '2026-09-16 09:04:37'),
(1573, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'govde5ngcu303pkvnh2sp2pj61', '2026-09-16', '11:05:20', '2026-09-16 09:05:20'),
(1574, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'http://localhost/bahawalcollegeofhealth/campus-portal.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'jjd0b1l50mrb44m57fd471q456', '2026-09-16', '11:06:21', '2026-09-16 09:06:21'),
(1575, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'http://localhost/bahawalcollegeofhealth/campus-portal.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'jjd0b1l50mrb44m57fd471q456', '2026-09-16', '11:16:57', '2026-09-16 09:16:57'),
(1576, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'p6mnqulbnjcph09ghauo7ak1m9', '2026-09-16', '11:22:53', '2026-09-16 09:22:53'),
(1577, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'http://localhost/bahawalcollegeofhealth/campus-portal.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'jjd0b1l50mrb44m57fd471q456', '2026-09-16', '11:24:10', '2026-09-16 09:24:10'),
(1578, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'fuamral9eu34ouc6bgirp4nisu', '2026-09-16', '11:24:47', '2026-09-16 09:24:47'),
(1579, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'dkqe0cf5rsed7a2ff3qtee88kl', '2026-09-16', '11:26:08', '2026-09-16 09:26:08'),
(1580, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36 Edg/153.0.0.0', 'Desktop', 'Edge', 'Windows 10', NULL, NULL, 'ihjk3si0lq2m0a0aq4r6gni0qr', '2026-09-16', '11:28:27', '2026-09-16 09:28:27'),
(1581, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'http://localhost/bahawalcollegeofhealth/campus-portal.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'jjd0b1l50mrb44m57fd471q456', '2026-09-16', '11:32:47', '2026-09-16 09:32:47'),
(1582, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'http://localhost/bahawalcollegeofhealth/campus-portal.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'jjd0b1l50mrb44m57fd471q456', '2026-09-16', '11:33:21', '2026-09-16 09:33:21'),
(1583, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'http://localhost/bahawalcollegeofhealth/campus-portal.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'jjd0b1l50mrb44m57fd471q456', '2026-09-16', '11:35:40', '2026-09-16 09:35:40'),
(1584, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36 Edg/153.0.0.0', 'Desktop', 'Edge', 'Windows 10', NULL, NULL, 'ihjk3si0lq2m0a0aq4r6gni0qr', '2026-09-16', '11:39:45', '2026-09-16 09:39:45'),
(1585, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36 Edg/153.0.0.0', 'Desktop', 'Edge', 'Windows 10', NULL, NULL, 'ihjk3si0lq2m0a0aq4r6gni0qr', '2026-09-16', '11:39:48', '2026-09-16 09:39:48'),
(1586, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'http://localhost/bahawalcollegeofhealth/campus-portal.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'jjd0b1l50mrb44m57fd471q456', '2026-09-16', '11:41:30', '2026-09-16 09:41:30'),
(1587, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'http://localhost/bahawalcollegeofhealth/campus-portal.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'jjd0b1l50mrb44m57fd471q456', '2026-09-16', '11:43:23', '2026-09-16 09:43:23'),
(1588, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'a543dq3eoa61u1cksqkkgiltju', '2026-09-16', '11:43:39', '2026-09-16 09:43:39'),
(1589, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '7em8k2601r1l7cl6qrrb33qhc5', '2026-09-16', '11:44:38', '2026-09-16 09:44:38'),
(1590, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '688h0ui10atto936mlhea6vii2', '2026-09-16', '11:45:58', '2026-09-16 09:45:58'),
(1591, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36 Edg/153.0.0.0', 'Desktop', 'Edge', 'Windows 10', NULL, NULL, 'ihjk3si0lq2m0a0aq4r6gni0qr', '2026-09-16', '11:47:08', '2026-09-16 09:47:08'),
(1592, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'jjd0b1l50mrb44m57fd471q456', '2026-09-16', '11:47:38', '2026-09-16 09:47:38'),
(1593, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36 Edg/153.0.0.0', 'Desktop', 'Edge', 'Windows 10', NULL, NULL, 'ihjk3si0lq2m0a0aq4r6gni0qr', '2026-09-16', '11:48:26', '2026-09-16 09:48:26'),
(1594, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36 Edg/153.0.0.0', 'Desktop', 'Edge', 'Windows 10', NULL, NULL, 'ihjk3si0lq2m0a0aq4r6gni0qr', '2026-09-16', '11:50:57', '2026-09-16 09:50:57'),
(1595, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'jjd0b1l50mrb44m57fd471q456', '2026-09-16', '11:51:15', '2026-09-16 09:51:15'),
(1596, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'jjd0b1l50mrb44m57fd471q456', '2026-09-16', '11:51:19', '2026-09-16 09:51:19'),
(1597, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '688h0ui10atto936mlhea6vii2', '2026-09-16', '11:51:58', '2026-09-16 09:51:58'),
(1598, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36 Edg/153.0.0.0', 'Desktop', 'Edge', 'Windows 10', NULL, NULL, 'ihjk3si0lq2m0a0aq4r6gni0qr', '2026-09-16', '11:52:14', '2026-09-16 09:52:14'),
(1599, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36 Edg/153.0.0.0', 'Desktop', 'Edge', 'Windows 10', NULL, NULL, 'ihjk3si0lq2m0a0aq4r6gni0qr', '2026-09-16', '11:53:36', '2026-09-16 09:53:36');
INSERT INTO `website_analytics` (`id`, `visitor_ip`, `page_url`, `page_title`, `referrer`, `user_agent`, `device_type`, `browser`, `operating_system`, `country`, `city`, `session_id`, `visit_date`, `visit_time`, `created_at`) VALUES
(1600, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'jjd0b1l50mrb44m57fd471q456', '2026-09-16', '11:54:17', '2026-09-16 09:54:17'),
(1601, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '97r2e2chv4cuvp0ibqhknj1up0', '2026-09-16', '11:54:29', '2026-09-16 09:54:29'),
(1602, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '97r2e2chv4cuvp0ibqhknj1up0', '2026-09-16', '11:54:47', '2026-09-16 09:54:47'),
(1603, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36 Edg/153.0.0.0', 'Desktop', 'Edge', 'Windows 10', NULL, NULL, 'ihjk3si0lq2m0a0aq4r6gni0qr', '2026-09-16', '11:55:24', '2026-09-16 09:55:24'),
(1604, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '1ups4cmjv84nbgurvhetnrrf2q', '2026-09-16', '11:56:39', '2026-09-16 09:56:39'),
(1605, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'jjd0b1l50mrb44m57fd471q456', '2026-09-16', '11:57:52', '2026-09-16 09:57:52'),
(1606, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'jjd0b1l50mrb44m57fd471q456', '2026-09-16', '11:59:02', '2026-09-16 09:59:02'),
(1607, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'jjd0b1l50mrb44m57fd471q456', '2026-09-16', '11:59:42', '2026-09-16 09:59:42'),
(1608, '::1', '/bahawalcollegeofhealth/examination.php', '', 'http://localhost/bahawalcollegeofhealth/faculty.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'jjd0b1l50mrb44m57fd471q456', '2026-09-16', '12:00:11', '2026-09-16 10:00:11'),
(1609, '::1', '/bahawalcollegeofhealth/chairman-message.php', '', 'http://localhost/bahawalcollegeofhealth/examination.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'jjd0b1l50mrb44m57fd471q456', '2026-09-16', '12:01:17', '2026-09-16 10:01:17'),
(1610, '::1', '/bahawalcollegeofhealth/principal-message.php', '', 'http://localhost/bahawalcollegeofhealth/chairman-message.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'jjd0b1l50mrb44m57fd471q456', '2026-09-16', '12:01:24', '2026-09-16 10:01:24'),
(1611, '::1', '/bahawalcollegeofhealth/index.php', '', 'http://localhost/bahawalcollegeofhealth/principal-message.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'jjd0b1l50mrb44m57fd471q456', '2026-09-16', '12:03:09', '2026-09-16 10:03:09'),
(1612, '::1', '/bahawalcollegeofhealth/campus-portal.php', '', 'http://localhost/bahawalcollegeofhealth/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'jjd0b1l50mrb44m57fd471q456', '2026-09-16', '12:03:50', '2026-09-16 10:03:50'),
(1613, '::1', '/bahawalcollegeofhealth/index.php', '', 'http://localhost/bahawalcollegeofhealth/campus-portal.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'jjd0b1l50mrb44m57fd471q456', '2026-09-16', '12:04:13', '2026-09-16 10:04:13'),
(1614, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36 Edg/153.0.0.0', 'Desktop', 'Edge', 'Windows 10', NULL, NULL, 'ihjk3si0lq2m0a0aq4r6gni0qr', '2026-09-16', '12:04:35', '2026-09-16 10:04:35'),
(1615, '::1', '/bahawalcollegeofhealth/index.php', '', 'http://localhost/bahawalcollegeofhealth/faculty.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36 Edg/153.0.0.0', 'Desktop', 'Edge', 'Windows 10', NULL, NULL, 'ihjk3si0lq2m0a0aq4r6gni0qr', '2026-09-16', '12:05:26', '2026-09-16 10:05:26'),
(1616, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'fr2utu986i74hslt84f20ol4h2', '2026-09-16', '12:14:00', '2026-09-16 10:14:00'),
(1617, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'beihu258f6nrjtntk9st4srdp8', '2026-09-16', '12:14:10', '2026-09-16 10:14:10'),
(1618, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '44mg7jf85df5e14eb7lq00sufj', '2026-09-16', '12:14:20', '2026-09-16 10:14:20'),
(1619, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 't9gifmn60v3s1n55r8d1mm4383', '2026-09-16', '12:14:24', '2026-09-16 10:14:24'),
(1620, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'i4nv6jm6a1qbkq19icvgdcus77', '2026-09-16', '12:14:29', '2026-09-16 10:14:29'),
(1621, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'l1nl96nr853sjrt26mb2i5ofmo', '2026-09-16', '12:14:33', '2026-09-16 10:14:33'),
(1622, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'coau71t1uk366h5i3bhn26muab', '2026-09-16', '12:14:43', '2026-09-16 10:14:43'),
(1623, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '689itk6juop37fc763ruts8tnb', '2026-09-16', '12:14:47', '2026-09-16 10:14:47'),
(1624, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'fvgib04a19chcuh6scju52hq8o', '2026-09-16', '12:14:54', '2026-09-16 10:14:54'),
(1625, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'otttd7lhdodb6d4jh6ptcjk4ba', '2026-09-16', '12:14:56', '2026-09-16 10:14:56'),
(1626, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '35osj8vua6g6dmbpnfki5u4o7m', '2026-09-16', '12:15:03', '2026-09-16 10:15:03'),
(1627, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'mvjddflji3it9tmo3rkllgca10', '2026-09-16', '12:15:12', '2026-09-16 10:15:12'),
(1628, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'ej9u21iciai2mqd9eojo8lk4t9', '2026-09-16', '12:16:04', '2026-09-16 10:16:04'),
(1629, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '24qjv99u1oecilag68eq2aet8m', '2026-09-16', '12:16:55', '2026-09-16 10:16:55'),
(1630, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'bck6liq5rmckjqt02tlf01kg2i', '2026-09-16', '12:18:59', '2026-09-16 10:18:59'),
(1631, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'dah0c12khlthjnsjee384vg9ni', '2026-09-16', '12:19:04', '2026-09-16 10:19:04'),
(1632, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '3moargt2l71iq1jecuc2gvjs0a', '2026-09-16', '12:19:45', '2026-09-16 10:19:45'),
(1633, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'qi76h579hi3gmqadphetng7f5a', '2026-09-16', '12:19:54', '2026-09-16 10:19:54'),
(1634, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'ngtd886inn8lkt888uuj4aj4os', '2026-09-16', '12:20:01', '2026-09-16 10:20:01'),
(1635, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'qjegqrhp98cvst056j3tpg30p4', '2026-09-16', '12:20:08', '2026-09-16 10:20:08'),
(1636, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'hbeilek0r2r19u329gdpt9etfg', '2026-09-16', '12:20:37', '2026-09-16 10:20:37'),
(1637, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '2c86p5quigp32cjfshlmmbf039', '2026-09-16', '12:20:45', '2026-09-16 10:20:45'),
(1638, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'ujm5kf7jt2ue72jdr5ur3menp7', '2026-09-16', '12:21:10', '2026-09-16 10:21:10'),
(1639, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'mbermrie8l7bdthi5nmavqte70', '2026-09-16', '12:21:14', '2026-09-16 10:21:14'),
(1640, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'qjsl16hd1q35qu2uc4dkdbujd6', '2026-09-16', '12:21:19', '2026-09-16 10:21:19'),
(1641, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '43vmig524hqsp1fcbqgbaof094', '2026-09-16', '12:21:32', '2026-09-16 10:21:32'),
(1642, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'gadho3rtsc9acpnffffkm4iqf8', '2026-09-16', '12:23:25', '2026-09-16 10:23:25'),
(1643, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'f7rthr9otves1ksttmifdvh8tv', '2026-09-16', '12:23:32', '2026-09-16 10:23:33'),
(1644, '::1', '/bahawalcollegeofhealth/gallery.php', '', 'http://localhost/bahawalcollegeofhealth/index.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'jjd0b1l50mrb44m57fd471q456', '2026-09-16', '12:35:19', '2026-09-16 10:35:19'),
(1645, '::1', '/bahawalcollegeofhealth/index.php', '', 'http://localhost/bahawalcollegeofhealth/gallery.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'jjd0b1l50mrb44m57fd471q456', '2026-09-16', '12:35:31', '2026-09-16 10:35:31'),
(1646, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '688h0ui10atto936mlhea6vii2', '2026-09-16', '12:43:11', '2026-09-16 10:43:11'),
(1647, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '8e7p62v8c6tug52gt3fofdc85l', '2026-09-16', '12:52:46', '2026-09-16 10:52:46'),
(1648, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '22o893abrf7rmagmj244512rka', '2026-09-16', '12:52:53', '2026-09-16 10:52:53'),
(1649, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'ksbpmd806am01eqlo3ol6n7352', '2026-09-16', '12:53:15', '2026-09-16 10:53:15'),
(1650, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'pc57gke27mu6smnjhgql53d28v', '2026-09-16', '12:53:20', '2026-09-16 10:53:20'),
(1651, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'r6uvj0g1ufce1iifaemu0a6f6c', '2026-09-16', '12:53:26', '2026-09-16 10:53:26'),
(1652, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '2mshcv7bsth4064vpilcbo56jb', '2026-09-16', '12:53:35', '2026-09-16 10:53:35'),
(1653, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'qu36callon0lduin9n90vmabdk', '2026-09-16', '12:53:49', '2026-09-16 10:53:49'),
(1654, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '6j35v9er1g43bg0heml258gd3e', '2026-09-16', '12:57:18', '2026-09-16 10:57:18'),
(1655, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'lb7p6q1i7v8d411prqde3ccb72', '2026-09-16', '12:57:26', '2026-09-16 10:57:26'),
(1656, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 've7u96pvqkih4p47lpttcefarp', '2026-09-16', '12:57:37', '2026-09-16 10:57:37'),
(1657, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'pq4j4mrv7pje8ilenfjulqurfp', '2026-09-16', '12:57:51', '2026-09-16 10:57:51'),
(1658, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'mp1ssj2jmmjurrt2ros5tomppm', '2026-09-16', '12:58:21', '2026-09-16 10:58:21'),
(1659, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '7iqvcq06eq8j7h5gndnr8vstsv', '2026-09-16', '12:58:24', '2026-09-16 10:58:24'),
(1660, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '12h706mm4tr35tk41fqspi60qk', '2026-09-16', '12:58:45', '2026-09-16 10:58:45'),
(1661, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '80vm4ddh693kpg61nmrv021gjr', '2026-09-16', '13:02:20', '2026-09-16 11:02:20'),
(1662, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '49nkep5uui4uiv5o5fg837niif', '2026-09-16', '13:02:26', '2026-09-16 11:02:26'),
(1663, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'g68sc3v5ksj6da3mv7hr4pvfel', '2026-09-16', '13:02:30', '2026-09-16 11:02:30'),
(1664, '::1', '/bahawalcollegeofhealth/courses.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'phl4opsb0biiqse930bp6bu4du', '2026-09-16', '13:02:36', '2026-09-16 11:02:36'),
(1665, '::1', '/bahawalcollegeofhealth/courses.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'bkn32uv4f5c5b92jdn3asrhklo', '2026-09-16', '13:02:45', '2026-09-16 11:02:45'),
(1666, '::1', '/bahawalcollegeofhealth/courses.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'l12derebc44msrd4hkir7tqqt0', '2026-09-16', '13:02:55', '2026-09-16 11:02:55'),
(1667, '::1', '/bahawalcollegeofhealth/about.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'd1vvqe0nlsk7nnudghr0d12amc', '2026-09-16', '13:03:02', '2026-09-16 11:03:02'),
(1668, '::1', '/bahawalcollegeofhealth/about.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '40qjv5ooo9dj5e0qu4ud64u3q8', '2026-09-16', '13:03:06', '2026-09-16 11:03:06'),
(1669, '::1', '/bahawalcollegeofhealth/about.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'uk3ihoeldv3krad322i9brghft', '2026-09-16', '13:03:12', '2026-09-16 11:03:12'),
(1670, '::1', '/bahawalcollegeofhealth/admission.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'ut46vj4s9mar6f60g57j6nt9bl', '2026-09-16', '13:03:15', '2026-09-16 11:03:15'),
(1671, '::1', '/bahawalcollegeofhealth/admission.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'mrn0atuk41adt407t9igls2p54', '2026-09-16', '13:03:19', '2026-09-16 11:03:19'),
(1672, '::1', '/bahawalcollegeofhealth/admission.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '8n672lks2cri837v66p5q49d24', '2026-09-16', '13:03:22', '2026-09-16 11:03:22'),
(1673, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '1g5r2r1lbkcapgg256c3luf9ua', '2026-09-16', '13:03:34', '2026-09-16 11:03:34'),
(1674, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'maouva04jcrvhktsnl8ch9mufk', '2026-09-16', '13:03:45', '2026-09-16 11:03:45'),
(1675, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '7nn6jhbclmgm91oj1kfomo5a7v', '2026-09-16', '13:08:14', '2026-09-16 11:08:14'),
(1676, '::1', '/bahawalcollegeofhealth/about.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'bri77hjnuf97vqvibr2resvppg', '2026-09-16', '13:11:26', '2026-09-16 11:11:26'),
(1677, '::1', '/bahawalcollegeofhealth/accreditation.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'p4euvs6ltmuv1var54fbeok8cr', '2026-09-16', '13:11:28', '2026-09-16 11:11:28'),
(1678, '::1', '/bahawalcollegeofhealth/activities.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'tek24ims3nonicl2aj29id791f', '2026-09-16', '13:11:29', '2026-09-16 11:11:29'),
(1679, '::1', '/bahawalcollegeofhealth/admission.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'cvivmmlsnquodmoruh2n3h0ohm', '2026-09-16', '13:11:32', '2026-09-16 11:11:32'),
(1680, '::1', '/bahawalcollegeofhealth/alumni.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '4vrq64dr332afuor3php3dkr18', '2026-09-16', '13:11:33', '2026-09-16 11:11:33'),
(1681, '::1', '/bahawalcollegeofhealth/campus-portal.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'nvi099fuf2o1q0gi3t90pb84is', '2026-09-16', '13:11:34', '2026-09-16 11:11:34'),
(1682, '::1', '/bahawalcollegeofhealth/campuses.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'v1e5pv2f72com1op5414j2h1u7', '2026-09-16', '13:11:35', '2026-09-16 11:11:35'),
(1683, '::1', '/bahawalcollegeofhealth/chairman-message.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'vpfmmejhjajd42d3vrq6hk5rlc', '2026-09-16', '13:11:36', '2026-09-16 11:11:36'),
(1684, '::1', '/bahawalcollegeofhealth/clinical-training.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'n010lpktmtutavqht7nrj56ld6', '2026-09-16', '13:11:37', '2026-09-16 11:11:37'),
(1685, '::1', '/bahawalcollegeofhealth/contact.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '49cgk7b3bh7juk2jh0r943pdmg', '2026-09-16', '13:11:38', '2026-09-16 11:11:38'),
(1686, '::1', '/bahawalcollegeofhealth/core-values.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '33226j3h0lgn8darrhmt0c37fk', '2026-09-16', '13:11:39', '2026-09-16 11:11:39'),
(1687, '::1', '/bahawalcollegeofhealth/courses.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'o8cek4t8o8a0gmde4l174reln5', '2026-09-16', '13:11:40', '2026-09-16 11:11:40'),
(1688, '::1', '/bahawalcollegeofhealth/downloads.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'tfr07sgqg5po6vhsr7kufe2o4o', '2026-09-16', '13:11:41', '2026-09-16 11:11:41'),
(1689, '::1', '/bahawalcollegeofhealth/eligibility-checker.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '9a7ukcokuvhv63ti94o42g66h5', '2026-09-16', '13:11:42', '2026-09-16 11:11:42'),
(1690, '::1', '/bahawalcollegeofhealth/events.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'spndi9u975aaujc6l1krtk183j', '2026-09-16', '13:11:42', '2026-09-16 11:11:42'),
(1691, '::1', '/bahawalcollegeofhealth/examination.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'anll3ail3t925nmunuactkqnv4', '2026-09-16', '13:11:43', '2026-09-16 11:11:43'),
(1692, '::1', '/bahawalcollegeofhealth/gallery.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '6lbp6puq3sonfqfc2vt4n30cm9', '2026-09-16', '13:11:44', '2026-09-16 11:11:44'),
(1693, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'pkqgiou7el1iph6hhcbhgb1h5v', '2026-09-16', '13:11:45', '2026-09-16 11:11:45'),
(1694, '::1', '/bahawalcollegeofhealth/leadership.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'ev8ju4ue10ie5f1atro2jdr3ht', '2026-09-16', '13:11:46', '2026-09-16 11:11:46'),
(1695, '::1', '/bahawalcollegeofhealth/mission-vision.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'qk6bakfiht04kbpgidofs2tncu', '2026-09-16', '13:11:47', '2026-09-16 11:11:47'),
(1696, '::1', '/bahawalcollegeofhealth/news.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'si4m8rem4lbukfeg5o1f6gk8gn', '2026-09-16', '13:11:48', '2026-09-16 11:11:48'),
(1697, '::1', '/bahawalcollegeofhealth/notifications.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'egl42a7c6fidrst7mh5rki1dkb', '2026-09-16', '13:11:49', '2026-09-16 11:11:49'),
(1698, '::1', '/bahawalcollegeofhealth/our-networks.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'ijfjpajald0nhvhaljor5gsgqp', '2026-09-16', '13:11:50', '2026-09-16 11:11:50'),
(1699, '::1', '/bahawalcollegeofhealth/our-projects.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '83bpb80o0kqv5s0803p0tfm355', '2026-09-16', '13:11:50', '2026-09-16 11:11:50'),
(1700, '::1', '/bahawalcollegeofhealth/principal-message.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'u552vtcmfljq7nl8c429l19bhd', '2026-09-16', '13:11:51', '2026-09-16 11:11:51'),
(1701, '::1', '/bahawalcollegeofhealth/scholarships.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'n1vsn73tqqissgh4cmrdpsfqti', '2026-09-16', '13:11:52', '2026-09-16 11:11:52'),
(1702, '::1', '/bahawalcollegeofhealth/about.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '5eghq9kbpu2vch17cifrgm57vr', '2026-09-16', '13:12:50', '2026-09-16 11:12:50'),
(1703, '::1', '/bahawalcollegeofhealth/accreditation.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '5eghq9kbpu2vch17cifrgm57vr', '2026-09-16', '13:13:06', '2026-09-16 11:13:06'),
(1704, '::1', '/bahawalcollegeofhealth/activities.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '5eghq9kbpu2vch17cifrgm57vr', '2026-09-16', '13:13:09', '2026-09-16 11:13:09'),
(1705, '::1', '/bahawalcollegeofhealth/admission.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '5eghq9kbpu2vch17cifrgm57vr', '2026-09-16', '13:13:12', '2026-09-16 11:13:12'),
(1706, '::1', '/bahawalcollegeofhealth/alumni.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '5eghq9kbpu2vch17cifrgm57vr', '2026-09-16', '13:13:16', '2026-09-16 11:13:16'),
(1707, '::1', '/bahawalcollegeofhealth/campus-portal.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '5eghq9kbpu2vch17cifrgm57vr', '2026-09-16', '13:13:20', '2026-09-16 11:13:20'),
(1708, '::1', '/bahawalcollegeofhealth/campuses.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '5eghq9kbpu2vch17cifrgm57vr', '2026-09-16', '13:13:29', '2026-09-16 11:13:29'),
(1709, '::1', '/bahawalcollegeofhealth/chairman-message.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '5eghq9kbpu2vch17cifrgm57vr', '2026-09-16', '13:13:34', '2026-09-16 11:13:34'),
(1710, '::1', '/bahawalcollegeofhealth/clinical-training.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '5eghq9kbpu2vch17cifrgm57vr', '2026-09-16', '13:13:37', '2026-09-16 11:13:37'),
(1711, '::1', '/bahawalcollegeofhealth/contact.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '5eghq9kbpu2vch17cifrgm57vr', '2026-09-16', '13:13:40', '2026-09-16 11:13:40'),
(1712, '::1', '/bahawalcollegeofhealth/core-values.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '5eghq9kbpu2vch17cifrgm57vr', '2026-09-16', '13:13:46', '2026-09-16 11:13:46'),
(1713, '::1', '/bahawalcollegeofhealth/courses.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '5eghq9kbpu2vch17cifrgm57vr', '2026-09-16', '13:14:03', '2026-09-16 11:14:03'),
(1714, '::1', '/bahawalcollegeofhealth/downloads.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '5eghq9kbpu2vch17cifrgm57vr', '2026-09-16', '13:14:12', '2026-09-16 11:14:12'),
(1715, '::1', '/bahawalcollegeofhealth/eligibility-checker.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '5eghq9kbpu2vch17cifrgm57vr', '2026-09-16', '13:14:14', '2026-09-16 11:14:14'),
(1716, '::1', '/bahawalcollegeofhealth/events.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '5eghq9kbpu2vch17cifrgm57vr', '2026-09-16', '13:14:17', '2026-09-16 11:14:17'),
(1717, '::1', '/bahawalcollegeofhealth/examination.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '5eghq9kbpu2vch17cifrgm57vr', '2026-09-16', '13:14:22', '2026-09-16 11:14:22'),
(1718, '::1', '/bahawalcollegeofhealth/gallery.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '5eghq9kbpu2vch17cifrgm57vr', '2026-09-16', '13:14:25', '2026-09-16 11:14:25'),
(1719, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '5eghq9kbpu2vch17cifrgm57vr', '2026-09-16', '13:14:32', '2026-09-16 11:14:32'),
(1720, '::1', '/bahawalcollegeofhealth/leadership.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '5eghq9kbpu2vch17cifrgm57vr', '2026-09-16', '13:14:43', '2026-09-16 11:14:43'),
(1721, '::1', '/bahawalcollegeofhealth/mission-vision.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '5eghq9kbpu2vch17cifrgm57vr', '2026-09-16', '13:14:47', '2026-09-16 11:14:47'),
(1722, '::1', '/bahawalcollegeofhealth/news.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '5eghq9kbpu2vch17cifrgm57vr', '2026-09-16', '13:14:50', '2026-09-16 11:14:50'),
(1723, '::1', '/bahawalcollegeofhealth/notifications.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '5eghq9kbpu2vch17cifrgm57vr', '2026-09-16', '13:14:53', '2026-09-16 11:14:53'),
(1724, '::1', '/bahawalcollegeofhealth/our-networks.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '5eghq9kbpu2vch17cifrgm57vr', '2026-09-16', '13:14:55', '2026-09-16 11:14:55'),
(1725, '::1', '/bahawalcollegeofhealth/our-projects.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '5eghq9kbpu2vch17cifrgm57vr', '2026-09-16', '13:14:59', '2026-09-16 11:14:59'),
(1726, '::1', '/bahawalcollegeofhealth/principal-message.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '5eghq9kbpu2vch17cifrgm57vr', '2026-09-16', '13:15:04', '2026-09-16 11:15:04'),
(1727, '::1', '/bahawalcollegeofhealth/scholarships.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '5eghq9kbpu2vch17cifrgm57vr', '2026-09-16', '13:15:10', '2026-09-16 11:15:10'),
(1728, '::1', '/bahawalcollegeofhealth/about.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'gcvnpp7lohejci75nbatuosfh2', '2026-09-16', '13:15:17', '2026-09-16 11:15:17'),
(1729, '::1', '/bahawalcollegeofhealth/accreditation.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'gcvnpp7lohejci75nbatuosfh2', '2026-09-16', '13:15:21', '2026-09-16 11:15:21'),
(1730, '::1', '/bahawalcollegeofhealth/activities.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'gcvnpp7lohejci75nbatuosfh2', '2026-09-16', '13:15:22', '2026-09-16 11:15:22'),
(1731, '::1', '/bahawalcollegeofhealth/admission.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'gcvnpp7lohejci75nbatuosfh2', '2026-09-16', '13:15:23', '2026-09-16 11:15:23'),
(1732, '::1', '/bahawalcollegeofhealth/alumni.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'gcvnpp7lohejci75nbatuosfh2', '2026-09-16', '13:15:23', '2026-09-16 11:15:23'),
(1733, '::1', '/bahawalcollegeofhealth/campus-portal.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'gcvnpp7lohejci75nbatuosfh2', '2026-09-16', '13:15:25', '2026-09-16 11:15:25'),
(1734, '::1', '/bahawalcollegeofhealth/campuses.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'gcvnpp7lohejci75nbatuosfh2', '2026-09-16', '13:15:25', '2026-09-16 11:15:25'),
(1735, '::1', '/bahawalcollegeofhealth/chairman-message.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'gcvnpp7lohejci75nbatuosfh2', '2026-09-16', '13:15:26', '2026-09-16 11:15:26'),
(1736, '::1', '/bahawalcollegeofhealth/clinical-training.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'gcvnpp7lohejci75nbatuosfh2', '2026-09-16', '13:15:27', '2026-09-16 11:15:27'),
(1737, '::1', '/bahawalcollegeofhealth/contact.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'gcvnpp7lohejci75nbatuosfh2', '2026-09-16', '13:15:28', '2026-09-16 11:15:28'),
(1738, '::1', '/bahawalcollegeofhealth/core-values.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'gcvnpp7lohejci75nbatuosfh2', '2026-09-16', '13:15:29', '2026-09-16 11:15:29'),
(1739, '::1', '/bahawalcollegeofhealth/courses.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'gcvnpp7lohejci75nbatuosfh2', '2026-09-16', '13:15:29', '2026-09-16 11:15:29'),
(1740, '::1', '/bahawalcollegeofhealth/downloads.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'gcvnpp7lohejci75nbatuosfh2', '2026-09-16', '13:15:30', '2026-09-16 11:15:30'),
(1741, '::1', '/bahawalcollegeofhealth/eligibility-checker.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'gcvnpp7lohejci75nbatuosfh2', '2026-09-16', '13:15:32', '2026-09-16 11:15:32'),
(1742, '::1', '/bahawalcollegeofhealth/events.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'gcvnpp7lohejci75nbatuosfh2', '2026-09-16', '13:15:33', '2026-09-16 11:15:33'),
(1743, '::1', '/bahawalcollegeofhealth/examination.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'gcvnpp7lohejci75nbatuosfh2', '2026-09-16', '13:15:34', '2026-09-16 11:15:34'),
(1744, '::1', '/bahawalcollegeofhealth/gallery.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'gcvnpp7lohejci75nbatuosfh2', '2026-09-16', '13:15:34', '2026-09-16 11:15:34'),
(1745, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'gcvnpp7lohejci75nbatuosfh2', '2026-09-16', '13:15:35', '2026-09-16 11:15:35'),
(1746, '::1', '/bahawalcollegeofhealth/leadership.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'gcvnpp7lohejci75nbatuosfh2', '2026-09-16', '13:15:36', '2026-09-16 11:15:36'),
(1747, '::1', '/bahawalcollegeofhealth/mission-vision.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'gcvnpp7lohejci75nbatuosfh2', '2026-09-16', '13:15:37', '2026-09-16 11:15:37'),
(1748, '::1', '/bahawalcollegeofhealth/news.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'gcvnpp7lohejci75nbatuosfh2', '2026-09-16', '13:15:39', '2026-09-16 11:15:39'),
(1749, '::1', '/bahawalcollegeofhealth/notifications.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'gcvnpp7lohejci75nbatuosfh2', '2026-09-16', '13:15:41', '2026-09-16 11:15:41'),
(1750, '::1', '/bahawalcollegeofhealth/our-networks.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'gcvnpp7lohejci75nbatuosfh2', '2026-09-16', '13:15:42', '2026-09-16 11:15:42'),
(1751, '::1', '/bahawalcollegeofhealth/our-projects.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'gcvnpp7lohejci75nbatuosfh2', '2026-09-16', '13:15:46', '2026-09-16 11:15:46'),
(1752, '::1', '/bahawalcollegeofhealth/principal-message.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'gcvnpp7lohejci75nbatuosfh2', '2026-09-16', '13:15:47', '2026-09-16 11:15:47'),
(1753, '::1', '/bahawalcollegeofhealth/scholarships.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'gcvnpp7lohejci75nbatuosfh2', '2026-09-16', '13:15:48', '2026-09-16 11:15:48'),
(1754, '::1', '/bahawalcollegeofhealth/about.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '7r5ulprl2829l8os1pjok2q599', '2026-09-16', '13:15:50', '2026-09-16 11:15:50'),
(1755, '::1', '/bahawalcollegeofhealth/accreditation.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '7r5ulprl2829l8os1pjok2q599', '2026-09-16', '13:15:57', '2026-09-16 11:15:57'),
(1756, '::1', '/bahawalcollegeofhealth/activities.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '7r5ulprl2829l8os1pjok2q599', '2026-09-16', '13:15:58', '2026-09-16 11:15:58'),
(1757, '::1', '/bahawalcollegeofhealth/admission.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '7r5ulprl2829l8os1pjok2q599', '2026-09-16', '13:15:59', '2026-09-16 11:15:59'),
(1758, '::1', '/bahawalcollegeofhealth/alumni.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '7r5ulprl2829l8os1pjok2q599', '2026-09-16', '13:15:59', '2026-09-16 11:15:59'),
(1759, '::1', '/bahawalcollegeofhealth/campus-portal.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '7r5ulprl2829l8os1pjok2q599', '2026-09-16', '13:16:00', '2026-09-16 11:16:00'),
(1760, '::1', '/bahawalcollegeofhealth/campuses.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '7r5ulprl2829l8os1pjok2q599', '2026-09-16', '13:16:01', '2026-09-16 11:16:01'),
(1761, '::1', '/bahawalcollegeofhealth/chairman-message.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '7r5ulprl2829l8os1pjok2q599', '2026-09-16', '13:16:04', '2026-09-16 11:16:04'),
(1762, '::1', '/bahawalcollegeofhealth/clinical-training.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '7r5ulprl2829l8os1pjok2q599', '2026-09-16', '13:16:05', '2026-09-16 11:16:05');
INSERT INTO `website_analytics` (`id`, `visitor_ip`, `page_url`, `page_title`, `referrer`, `user_agent`, `device_type`, `browser`, `operating_system`, `country`, `city`, `session_id`, `visit_date`, `visit_time`, `created_at`) VALUES
(1763, '::1', '/bahawalcollegeofhealth/contact.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '7r5ulprl2829l8os1pjok2q599', '2026-09-16', '13:16:05', '2026-09-16 11:16:05'),
(1764, '::1', '/bahawalcollegeofhealth/core-values.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '7r5ulprl2829l8os1pjok2q599', '2026-09-16', '13:16:06', '2026-09-16 11:16:06'),
(1765, '::1', '/bahawalcollegeofhealth/courses.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '7r5ulprl2829l8os1pjok2q599', '2026-09-16', '13:16:07', '2026-09-16 11:16:07'),
(1766, '::1', '/bahawalcollegeofhealth/downloads.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '7r5ulprl2829l8os1pjok2q599', '2026-09-16', '13:16:08', '2026-09-16 11:16:08'),
(1767, '::1', '/bahawalcollegeofhealth/eligibility-checker.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '7r5ulprl2829l8os1pjok2q599', '2026-09-16', '13:16:08', '2026-09-16 11:16:08'),
(1768, '::1', '/bahawalcollegeofhealth/events.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '7r5ulprl2829l8os1pjok2q599', '2026-09-16', '13:16:09', '2026-09-16 11:16:09'),
(1769, '::1', '/bahawalcollegeofhealth/examination.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '7r5ulprl2829l8os1pjok2q599', '2026-09-16', '13:16:10', '2026-09-16 11:16:10'),
(1770, '::1', '/bahawalcollegeofhealth/gallery.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '7r5ulprl2829l8os1pjok2q599', '2026-09-16', '13:16:10', '2026-09-16 11:16:10'),
(1771, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '7r5ulprl2829l8os1pjok2q599', '2026-09-16', '13:16:11', '2026-09-16 11:16:11'),
(1772, '::1', '/bahawalcollegeofhealth/leadership.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '7r5ulprl2829l8os1pjok2q599', '2026-09-16', '13:16:12', '2026-09-16 11:16:12'),
(1773, '::1', '/bahawalcollegeofhealth/mission-vision.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '7r5ulprl2829l8os1pjok2q599', '2026-09-16', '13:16:13', '2026-09-16 11:16:13'),
(1774, '::1', '/bahawalcollegeofhealth/news.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '7r5ulprl2829l8os1pjok2q599', '2026-09-16', '13:16:13', '2026-09-16 11:16:13'),
(1775, '::1', '/bahawalcollegeofhealth/notifications.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '7r5ulprl2829l8os1pjok2q599', '2026-09-16', '13:16:14', '2026-09-16 11:16:14'),
(1776, '::1', '/bahawalcollegeofhealth/our-networks.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '7r5ulprl2829l8os1pjok2q599', '2026-09-16', '13:16:15', '2026-09-16 11:16:15'),
(1777, '::1', '/bahawalcollegeofhealth/our-projects.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '7r5ulprl2829l8os1pjok2q599', '2026-09-16', '13:16:15', '2026-09-16 11:16:15'),
(1778, '::1', '/bahawalcollegeofhealth/principal-message.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '7r5ulprl2829l8os1pjok2q599', '2026-09-16', '13:16:16', '2026-09-16 11:16:16'),
(1779, '::1', '/bahawalcollegeofhealth/scholarships.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '7r5ulprl2829l8os1pjok2q599', '2026-09-16', '13:16:17', '2026-09-16 11:16:17'),
(1780, '::1', '/bahawalcollegeofhealth/about.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '7rhr1d0am15e0s6fn2nmtb5c06', '2026-09-16', '13:16:18', '2026-09-16 11:16:18'),
(1781, '::1', '/bahawalcollegeofhealth/accreditation.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '7rhr1d0am15e0s6fn2nmtb5c06', '2026-09-16', '13:16:22', '2026-09-16 11:16:22'),
(1782, '::1', '/bahawalcollegeofhealth/activities.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '7rhr1d0am15e0s6fn2nmtb5c06', '2026-09-16', '13:16:23', '2026-09-16 11:16:23'),
(1783, '::1', '/bahawalcollegeofhealth/admission.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '7rhr1d0am15e0s6fn2nmtb5c06', '2026-09-16', '13:16:24', '2026-09-16 11:16:24'),
(1784, '::1', '/bahawalcollegeofhealth/alumni.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '7rhr1d0am15e0s6fn2nmtb5c06', '2026-09-16', '13:16:25', '2026-09-16 11:16:25'),
(1785, '::1', '/bahawalcollegeofhealth/campus-portal.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '7rhr1d0am15e0s6fn2nmtb5c06', '2026-09-16', '13:16:26', '2026-09-16 11:16:26'),
(1786, '::1', '/bahawalcollegeofhealth/campuses.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '7rhr1d0am15e0s6fn2nmtb5c06', '2026-09-16', '13:16:26', '2026-09-16 11:16:26'),
(1787, '::1', '/bahawalcollegeofhealth/chairman-message.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '7rhr1d0am15e0s6fn2nmtb5c06', '2026-09-16', '13:16:27', '2026-09-16 11:16:27'),
(1788, '::1', '/bahawalcollegeofhealth/clinical-training.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '7rhr1d0am15e0s6fn2nmtb5c06', '2026-09-16', '13:16:30', '2026-09-16 11:16:30'),
(1789, '::1', '/bahawalcollegeofhealth/contact.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '7rhr1d0am15e0s6fn2nmtb5c06', '2026-09-16', '13:16:31', '2026-09-16 11:16:31'),
(1790, '::1', '/bahawalcollegeofhealth/core-values.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '7rhr1d0am15e0s6fn2nmtb5c06', '2026-09-16', '13:16:35', '2026-09-16 11:16:35'),
(1791, '::1', '/bahawalcollegeofhealth/courses.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '7rhr1d0am15e0s6fn2nmtb5c06', '2026-09-16', '13:16:37', '2026-09-16 11:16:37'),
(1792, '::1', '/bahawalcollegeofhealth/downloads.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '7rhr1d0am15e0s6fn2nmtb5c06', '2026-09-16', '13:16:39', '2026-09-16 11:16:39'),
(1793, '::1', '/bahawalcollegeofhealth/eligibility-checker.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '7rhr1d0am15e0s6fn2nmtb5c06', '2026-09-16', '13:16:41', '2026-09-16 11:16:41'),
(1794, '::1', '/bahawalcollegeofhealth/events.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '7rhr1d0am15e0s6fn2nmtb5c06', '2026-09-16', '13:16:42', '2026-09-16 11:16:42'),
(1795, '::1', '/bahawalcollegeofhealth/examination.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '7rhr1d0am15e0s6fn2nmtb5c06', '2026-09-16', '13:16:43', '2026-09-16 11:16:43'),
(1796, '::1', '/bahawalcollegeofhealth/gallery.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '7rhr1d0am15e0s6fn2nmtb5c06', '2026-09-16', '13:16:44', '2026-09-16 11:16:44'),
(1797, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '7rhr1d0am15e0s6fn2nmtb5c06', '2026-09-16', '13:16:46', '2026-09-16 11:16:46'),
(1798, '::1', '/bahawalcollegeofhealth/leadership.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '7rhr1d0am15e0s6fn2nmtb5c06', '2026-09-16', '13:16:48', '2026-09-16 11:16:48'),
(1799, '::1', '/bahawalcollegeofhealth/mission-vision.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '7rhr1d0am15e0s6fn2nmtb5c06', '2026-09-16', '13:16:48', '2026-09-16 11:16:48'),
(1800, '::1', '/bahawalcollegeofhealth/news.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '7rhr1d0am15e0s6fn2nmtb5c06', '2026-09-16', '13:16:51', '2026-09-16 11:16:51'),
(1801, '::1', '/bahawalcollegeofhealth/notifications.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '7rhr1d0am15e0s6fn2nmtb5c06', '2026-09-16', '13:16:53', '2026-09-16 11:16:53'),
(1802, '::1', '/bahawalcollegeofhealth/our-networks.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '7rhr1d0am15e0s6fn2nmtb5c06', '2026-09-16', '13:16:53', '2026-09-16 11:16:53'),
(1803, '::1', '/bahawalcollegeofhealth/our-projects.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '7rhr1d0am15e0s6fn2nmtb5c06', '2026-09-16', '13:16:54', '2026-09-16 11:16:54'),
(1804, '::1', '/bahawalcollegeofhealth/principal-message.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '7rhr1d0am15e0s6fn2nmtb5c06', '2026-09-16', '13:16:55', '2026-09-16 11:16:55'),
(1805, '::1', '/bahawalcollegeofhealth/scholarships.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '7rhr1d0am15e0s6fn2nmtb5c06', '2026-09-16', '13:16:55', '2026-09-16 11:16:55'),
(1806, '127.0.0.1', '/bahawalcollegeofhealth/faculty.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '688h0ui10atto936mlhea6vii2', '2026-09-16', '13:18:13', '2026-09-16 11:18:13'),
(1807, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'evvbibcqjf7aqu3ik2ni0g2jg0', '2026-09-16', '13:18:57', '2026-09-16 11:18:57'),
(1808, '::1', '/bahawalcollegeofhealth/about.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '6hrf8dbfns57etqghoq77gm7ie', '2026-09-16', '13:21:12', '2026-09-16 11:21:12'),
(1809, '::1', '/bahawalcollegeofhealth/accreditation.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '6hrf8dbfns57etqghoq77gm7ie', '2026-09-16', '13:21:28', '2026-09-16 11:21:28'),
(1810, '::1', '/bahawalcollegeofhealth/activities.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '6hrf8dbfns57etqghoq77gm7ie', '2026-09-16', '13:21:33', '2026-09-16 11:21:33'),
(1811, '::1', '/bahawalcollegeofhealth/admission.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '6hrf8dbfns57etqghoq77gm7ie', '2026-09-16', '13:21:38', '2026-09-16 11:21:38'),
(1812, '::1', '/bahawalcollegeofhealth/alumni.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '6hrf8dbfns57etqghoq77gm7ie', '2026-09-16', '13:21:46', '2026-09-16 11:21:46'),
(1813, '::1', '/bahawalcollegeofhealth/campus-portal.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '6hrf8dbfns57etqghoq77gm7ie', '2026-09-16', '13:21:53', '2026-09-16 11:21:53'),
(1814, '::1', '/bahawalcollegeofhealth/campuses.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '6hrf8dbfns57etqghoq77gm7ie', '2026-09-16', '13:21:58', '2026-09-16 11:21:58'),
(1815, '::1', '/bahawalcollegeofhealth/chairman-message.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '6hrf8dbfns57etqghoq77gm7ie', '2026-09-16', '13:22:11', '2026-09-16 11:22:11'),
(1816, '::1', '/bahawalcollegeofhealth/clinical-training.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '6hrf8dbfns57etqghoq77gm7ie', '2026-09-16', '13:22:19', '2026-09-16 11:22:19'),
(1817, '::1', '/bahawalcollegeofhealth/contact.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '6hrf8dbfns57etqghoq77gm7ie', '2026-09-16', '13:22:25', '2026-09-16 11:22:25'),
(1818, '::1', '/bahawalcollegeofhealth/core-values.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '6hrf8dbfns57etqghoq77gm7ie', '2026-09-16', '13:22:38', '2026-09-16 11:22:38'),
(1819, '::1', '/bahawalcollegeofhealth/courses.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '6hrf8dbfns57etqghoq77gm7ie', '2026-09-16', '13:22:47', '2026-09-16 11:22:47'),
(1820, '::1', '/bahawalcollegeofhealth/downloads.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '6hrf8dbfns57etqghoq77gm7ie', '2026-09-16', '13:23:10', '2026-09-16 11:23:10'),
(1821, '::1', '/bahawalcollegeofhealth/eligibility-checker.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '6hrf8dbfns57etqghoq77gm7ie', '2026-09-16', '13:23:27', '2026-09-16 11:23:27'),
(1822, '::1', '/bahawalcollegeofhealth/events.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '6hrf8dbfns57etqghoq77gm7ie', '2026-09-16', '13:23:32', '2026-09-16 11:23:32'),
(1823, '::1', '/bahawalcollegeofhealth/examination.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '6hrf8dbfns57etqghoq77gm7ie', '2026-09-16', '13:23:40', '2026-09-16 11:23:40'),
(1824, '::1', '/bahawalcollegeofhealth/gallery.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '6hrf8dbfns57etqghoq77gm7ie', '2026-09-16', '13:23:44', '2026-09-16 11:23:44'),
(1825, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '6hrf8dbfns57etqghoq77gm7ie', '2026-09-16', '13:24:11', '2026-09-16 11:24:12'),
(1826, '::1', '/bahawalcollegeofhealth/leadership.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '6hrf8dbfns57etqghoq77gm7ie', '2026-09-16', '13:24:36', '2026-09-16 11:24:36'),
(1827, '::1', '/bahawalcollegeofhealth/mission-vision.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '6hrf8dbfns57etqghoq77gm7ie', '2026-09-16', '13:24:44', '2026-09-16 11:24:44'),
(1828, '::1', '/bahawalcollegeofhealth/news.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '6hrf8dbfns57etqghoq77gm7ie', '2026-09-16', '13:24:48', '2026-09-16 11:24:48'),
(1829, '::1', '/bahawalcollegeofhealth/notifications.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '6hrf8dbfns57etqghoq77gm7ie', '2026-09-16', '13:24:52', '2026-09-16 11:24:52'),
(1830, '::1', '/bahawalcollegeofhealth/our-networks.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '6hrf8dbfns57etqghoq77gm7ie', '2026-09-16', '13:24:55', '2026-09-16 11:24:55'),
(1831, '::1', '/bahawalcollegeofhealth/our-projects.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '6hrf8dbfns57etqghoq77gm7ie', '2026-09-16', '13:25:01', '2026-09-16 11:25:01'),
(1832, '::1', '/bahawalcollegeofhealth/principal-message.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '6hrf8dbfns57etqghoq77gm7ie', '2026-09-16', '13:25:04', '2026-09-16 11:25:04'),
(1833, '::1', '/bahawalcollegeofhealth/scholarships.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '6hrf8dbfns57etqghoq77gm7ie', '2026-09-16', '13:25:07', '2026-09-16 11:25:07'),
(1834, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '688h0ui10atto936mlhea6vii2', '2026-09-16', '13:27:50', '2026-09-16 11:27:50'),
(1835, '::1', '/bahawalcollegeofhealth/campus-portal.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '7b8fcgj0ue5o8bi3n57ps5solv', '2026-09-16', '13:30:15', '2026-09-16 11:30:15'),
(1836, '::1', '/bahawalcollegeofhealth/campus-portal.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'sv91ie0hfhn4vcngpaleibkmb3', '2026-09-16', '13:31:04', '2026-09-16 11:31:04'),
(1837, '::1', '/bahawalcollegeofhealth/alumni.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'p3md7262tl156gqka3lt7gto7m', '2026-09-16', '13:35:30', '2026-09-16 11:35:30'),
(1838, '::1', '/bahawalcollegeofhealth/alumni.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'p3md7262tl156gqka3lt7gto7m', '2026-09-16', '13:35:39', '2026-09-16 11:35:39'),
(1839, '::1', '/bahawalcollegeofhealth/alumni.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, '89nirokgb643ff7hu504pn3vjt', '2026-09-16', '13:36:08', '2026-09-16 11:36:08'),
(1840, '::1', '/bahawalcollegeofhealth/alumni.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'pi5oijkoqjnv07er5i5k95tlo2', '2026-09-16', '13:36:40', '2026-09-16 11:36:40'),
(1841, '::1', '/bahawalcollegeofhealth/alumni.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'c39a5bmohblfaoip50qf1q3eb8', '2026-09-16', '13:37:48', '2026-09-16 11:37:48'),
(1842, '::1', '/bahawalcollegeofhealth/events.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'ffjl7mmn1cvacnd9j3hl3k9e5j', '2026-09-16', '13:40:41', '2026-09-16 11:40:41'),
(1843, '::1', '/bahawalcollegeofhealth/events.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'ffjl7mmn1cvacnd9j3hl3k9e5j', '2026-09-16', '13:40:51', '2026-09-16 11:40:51'),
(1844, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'jo482r0r7n238gle69k6m2pp8j', '2026-09-16', '13:43:47', '2026-09-16 11:43:47'),
(1845, '::1', '/bahawalcollegeofhealth/core-values.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'qha1l9j8q2mhjcnvstg53qiorn', '2026-09-16', '16:47:00', '2026-09-16 14:47:00'),
(1846, '::1', '/bahawalcollegeofhealth/examination.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'nj4fie8emiblhoq58d86t5jl1u', '2026-09-16', '16:50:15', '2026-09-16 14:50:15'),
(1847, '::1', '/bahawalcollegeofhealth/examination.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '86unht2ok8eqnoj8d7t6gf5dmq', '2026-09-16', '16:51:18', '2026-09-16 14:51:18'),
(1848, '::1', '/bahawalcollegeofhealth/examination.php', '', 'Direct', 'curl/8.19.0', 'Desktop', 'Unknown', 'Unknown OS', NULL, NULL, 'b2qd9uheiq3eqt35pf3603kf3t', '2026-09-16', '16:52:07', '2026-09-16 14:52:07'),
(1849, '::1', '/bahawalcollegeofhealth/examination.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'rfqke3hh0j1rs4sggjfm8sgcma', '2026-09-16', '16:52:45', '2026-09-16 14:52:45'),
(1850, '::1', '/bahawalcollegeofhealth/examination.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'ejivbdvjs05ccl3dtk3plchgtn', '2026-09-16', '16:53:42', '2026-09-16 14:53:42'),
(1851, '::1', '/bahawalcollegeofhealth/examination.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '2qitp1tclb7trsvvqkvs9c2afp', '2026-09-16', '16:54:57', '2026-09-16 14:54:57'),
(1852, '::1', '/bahawalcollegeofhealth/downloads.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'r0ss0ncj2o83stfdshtimmr3ip', '2026-09-16', '16:58:38', '2026-09-16 14:58:38'),
(1853, '::1', '/bahawalcollegeofhealth/downloads.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'r0ss0ncj2o83stfdshtimmr3ip', '2026-09-16', '16:58:44', '2026-09-16 14:58:44'),
(1854, '::1', '/bahawalcollegeofhealth/about.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'lho446oq5eadj3im744hd309q6', '2026-09-16', '17:00:34', '2026-09-16 15:00:34'),
(1855, '::1', '/bahawalcollegeofhealth/activities.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'rnnhn77avh79ro2fdcpb85r4u8', '2026-09-17', '06:11:06', '2026-09-17 04:11:06'),
(1856, '::1', '/bahawalcollegeofhealth/gallery.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'rnnhn77avh79ro2fdcpb85r4u8', '2026-09-17', '06:11:21', '2026-09-17 04:11:21'),
(1857, '::1', '/bahawalcollegeofhealth/campuses.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'rnnhn77avh79ro2fdcpb85r4u8', '2026-09-17', '06:11:55', '2026-09-17 04:11:55'),
(1858, '::1', '/bahawalcollegeofhealth/chairman-message.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'rnnhn77avh79ro2fdcpb85r4u8', '2026-09-17', '06:12:05', '2026-09-17 04:12:05'),
(1859, '::1', '/bahawalcollegeofhealth/principal-message.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'rnnhn77avh79ro2fdcpb85r4u8', '2026-09-17', '06:12:10', '2026-09-17 04:12:10'),
(1860, '::1', '/bahawalcollegeofhealth/leadership.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'rnnhn77avh79ro2fdcpb85r4u8', '2026-09-17', '06:12:16', '2026-09-17 04:12:16'),
(1861, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456', 'Desktop', 'Unknown', 'Windows 10', NULL, NULL, 'ho02knc0ujoae7l5msnj38urtp', '2026-09-17', '06:54:06', '2026-09-17 04:54:06'),
(1862, '::1', '/bahawalcollegeofhealth/about.php', '', 'Direct', 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456', 'Desktop', 'Unknown', 'Windows 10', NULL, NULL, '9104phmvt66cr99vto1jk19vjc', '2026-09-17', '06:54:07', '2026-09-17 04:54:07'),
(1863, '::1', '/bahawalcollegeofhealth/leadership.php', '', 'Direct', 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456', 'Desktop', 'Unknown', 'Windows 10', NULL, NULL, '4jebv4gk6mmqdndma93nloa1bi', '2026-09-17', '06:54:07', '2026-09-17 04:54:07'),
(1864, '::1', '/bahawalcollegeofhealth/accreditation.php', '', 'Direct', 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456', 'Desktop', 'Unknown', 'Windows 10', NULL, NULL, '4m1rr3d9j4hli2g5797gbq8eem', '2026-09-17', '07:00:57', '2026-09-17 05:00:57'),
(1865, '::1', '/bahawalcollegeofhealth/about.php', '', 'Direct', 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456', 'Desktop', 'Unknown', 'Windows 10', NULL, NULL, 'sfi98fjadn802484udd3slv3al', '2026-09-17', '07:00:59', '2026-09-17 05:00:59'),
(1866, '::1', '/bahawalcollegeofhealth/activities.php', '', 'Direct', 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456', 'Desktop', 'Unknown', 'Windows 10', NULL, NULL, 'mh2okudjjj8hdbovh17f7nujk9', '2026-09-17', '07:00:59', '2026-09-17 05:00:59'),
(1867, '::1', '/bahawalcollegeofhealth/chairman-message.php', '', 'Direct', 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456', 'Desktop', 'Unknown', 'Windows 10', NULL, NULL, 'cp1vbr5bb2263ivve5h13nlhh0', '2026-09-17', '07:01:00', '2026-09-17 05:01:00'),
(1868, '::1', '/bahawalcollegeofhealth/principal-message.php', '', 'Direct', 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456', 'Desktop', 'Unknown', 'Windows 10', NULL, NULL, 'tcajiuin6it8mj4hurf6pq0lvi', '2026-09-17', '07:01:00', '2026-09-17 05:01:00'),
(1869, '::1', '/bahawalcollegeofhealth/leadership.php', '', 'Direct', 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456', 'Desktop', 'Unknown', 'Windows 10', NULL, NULL, '3b3tcunuf4dds2j2sbbf6dgv3i', '2026-09-17', '07:01:00', '2026-09-17 05:01:00'),
(1870, '::1', '/bahawalcollegeofhealth/events.php', '', 'Direct', 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456', 'Desktop', 'Unknown', 'Windows 10', NULL, NULL, 'h0lr4ris4hn4fvssjurn1e4ssj', '2026-09-17', '07:01:01', '2026-09-17 05:01:01'),
(1871, '::1', '/bahawalcollegeofhealth/alumni.php', '', 'Direct', 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456', 'Desktop', 'Unknown', 'Windows 10', NULL, NULL, '92tme9ftnl1hu5unlp00j6gqvg', '2026-09-17', '07:01:03', '2026-09-17 05:01:03'),
(1872, '::1', '/bahawalcollegeofhealth/clinical-training.php', '', 'Direct', 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456', 'Desktop', 'Unknown', 'Windows 10', NULL, NULL, 'beehu7bcitf592hhci854ah99r', '2026-09-17', '07:01:04', '2026-09-17 05:01:04'),
(1873, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456', 'Desktop', 'Unknown', 'Windows 10', NULL, NULL, 'dtfmtt4i7v654ag7c3urge99l2', '2026-09-17', '07:01:04', '2026-09-17 05:01:04'),
(1874, '::1', '/bahawalcollegeofhealth/our-projects.php', '', 'Direct', 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456', 'Desktop', 'Unknown', 'Windows 10', NULL, NULL, 'p9pgbk45a85pk44gpinplc4i7i', '2026-09-17', '07:01:05', '2026-09-17 05:01:05'),
(1875, '::1', '/bahawalcollegeofhealth/our-networks.php', '', 'Direct', 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456', 'Desktop', 'Unknown', 'Windows 10', NULL, NULL, 'j4taqg53mskqg9plvvom3e2qim', '2026-09-17', '07:01:05', '2026-09-17 05:01:05'),
(1876, '::1', '/bahawalcollegeofhealth/news.php', '', 'Direct', 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456', 'Desktop', 'Unknown', 'Windows 10', NULL, NULL, 'la5khlnh9ev7le689brv37pif5', '2026-09-17', '07:01:06', '2026-09-17 05:01:06'),
(1877, '::1', '/bahawalcollegeofhealth/examination.php', '', 'Direct', 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456', 'Desktop', 'Unknown', 'Windows 10', NULL, NULL, '64scqhognblrbboeraradn158o', '2026-09-17', '07:01:06', '2026-09-17 05:01:06'),
(1878, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'Direct', 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456', 'Desktop', 'Unknown', 'Windows 10', NULL, NULL, '3acht7j52upg0dtss04qjs9fi0', '2026-09-17', '07:01:06', '2026-09-17 05:01:06'),
(1879, '::1', '/bahawalcollegeofhealth/gallery.php', '', 'Direct', 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456', 'Desktop', 'Unknown', 'Windows 10', NULL, NULL, '0d5tknm8meliqu4o79n0o0e6ph', '2026-09-17', '07:01:07', '2026-09-17 05:01:07'),
(1880, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456', 'Desktop', 'Unknown', 'Windows 10', NULL, NULL, '8b82652u34gcbiqssjo35njvlm', '2026-09-17', '07:01:41', '2026-09-17 05:01:41'),
(1881, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'Direct', 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456', 'Desktop', 'Unknown', 'Windows 10', NULL, NULL, 'geg7ljm9o8a64qbk0duvc9snav', '2026-09-17', '07:01:42', '2026-09-17 05:01:42'),
(1882, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'kn93jgg5bu1idsmva94tg6ldva', '2026-09-17', '07:02:20', '2026-09-17 05:02:20'),
(1883, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456', 'Desktop', 'Unknown', 'Windows 10', NULL, NULL, 'g5ojp5hkv1ph0a3jmse1qv75pg', '2026-09-17', '07:07:39', '2026-09-17 05:07:39'),
(1884, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456', 'Desktop', 'Unknown', 'Windows 10', NULL, NULL, '2ktluphmt7dnmccof3j4fkc35l', '2026-09-17', '07:08:11', '2026-09-17 05:08:11'),
(1885, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'Direct', 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456', 'Desktop', 'Unknown', 'Windows 10', NULL, NULL, 'a28u7tn0efrb9582nvn6v2aq70', '2026-09-17', '07:08:11', '2026-09-17 05:08:11'),
(1886, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456', 'Desktop', 'Unknown', 'Windows 10', NULL, NULL, 'or098inucrjenduo0d5auf0vlk', '2026-09-17', '07:10:34', '2026-09-17 05:10:34'),
(1887, '::1', '/bahawalcollegeofhealth/about.php', '', 'Direct', 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456', 'Desktop', 'Unknown', 'Windows 10', NULL, NULL, 'jagic82tt9agcqhnko062t1cj2', '2026-09-17', '07:10:35', '2026-09-17 05:10:35'),
(1888, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'Direct', 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456', 'Desktop', 'Unknown', 'Windows 10', NULL, NULL, 'j0kinif9mrbi3ecb5fed41hf7q', '2026-09-17', '07:10:35', '2026-09-17 05:10:35'),
(1889, '::1', '/bahawalcollegeofhealth/courses.php', '', 'Direct', 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456', 'Desktop', 'Unknown', 'Windows 10', NULL, NULL, 'u2mrda1la4bti56pbgk8dg00i9', '2026-09-17', '07:10:35', '2026-09-17 05:10:35'),
(1890, '::1', '/bahawalcollegeofhealth/admission.php', '', 'Direct', 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456', 'Desktop', 'Unknown', 'Windows 10', NULL, NULL, 'laavnhjm7sk58l93tmfjr9a0tt', '2026-09-17', '07:10:36', '2026-09-17 05:10:36'),
(1891, '::1', '/bahawalcollegeofhealth/contact.php', '', 'Direct', 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456', 'Desktop', 'Unknown', 'Windows 10', NULL, NULL, 'f824qqjuj35iop3urrclldq77q', '2026-09-17', '07:10:36', '2026-09-17 05:10:36'),
(1892, '::1', '/bahawalcollegeofhealth/gallery.php', '', 'Direct', 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456', 'Desktop', 'Unknown', 'Windows 10', NULL, NULL, 't9j6uu7undb3m0iji1o6a97ts4', '2026-09-17', '07:10:36', '2026-09-17 05:10:36'),
(1893, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '688h0ui10atto936mlhea6vii2', '2026-09-17', '07:14:22', '2026-09-17 05:14:22'),
(1894, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456', 'Desktop', 'Unknown', 'Windows 10', NULL, NULL, 'f2iqqq2l5enmv7nb9rfool9h4l', '2026-09-17', '07:15:19', '2026-09-17 05:15:19'),
(1895, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456', 'Desktop', 'Unknown', 'Windows 10', NULL, NULL, 'jukgi0e9gfdflc7cnqduuhld1k', '2026-09-17', '07:22:26', '2026-09-17 05:22:26'),
(1896, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456', 'Desktop', 'Unknown', 'Windows 10', NULL, NULL, 'uihii3ub114tigv8nr75da5fsb', '2026-09-17', '07:22:50', '2026-09-17 05:22:50'),
(1897, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456', 'Desktop', 'Unknown', 'Windows 10', NULL, NULL, '3cr88cfkricfgmimg5gnv76kvv', '2026-09-17', '07:23:27', '2026-09-17 05:23:27'),
(1898, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456', 'Desktop', 'Unknown', 'Windows 10', NULL, NULL, 'emfttkqsjh92elfqnu11hj05qu', '2026-09-17', '07:23:50', '2026-09-17 05:23:50'),
(1899, '::1', '/bahawalcollegeofhealth/campus-portal.php', '', 'Direct', 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456', 'Desktop', 'Unknown', 'Windows 10', NULL, NULL, 'a4d3lq0np490k89tnlc2e8jdhi', '2026-09-17', '07:25:13', '2026-09-17 05:25:13'),
(1900, '::1', '/bahawalcollegeofhealth/campus-portal.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'g26bk2smuhplf9l21tbr57rarv', '2026-09-17', '07:25:40', '2026-09-17 05:25:40'),
(1901, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456', 'Desktop', 'Unknown', 'Windows 10', NULL, NULL, 't0bfce05u8p3fr9maico40388n', '2026-09-17', '07:26:09', '2026-09-17 05:26:09'),
(1902, '::1', '/bahawalcollegeofhealth/about.php', '', 'Direct', 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456', 'Desktop', 'Unknown', 'Windows 10', NULL, NULL, 'n6of767er9guf0n6q9l6qnaglk', '2026-09-17', '07:26:10', '2026-09-17 05:26:10'),
(1903, '::1', '/bahawalcollegeofhealth/admission.php', '', 'Direct', 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456', 'Desktop', 'Unknown', 'Windows 10', NULL, NULL, '3vu1sgem9letne7rsn4kka493d', '2026-09-17', '07:26:10', '2026-09-17 05:26:10'),
(1904, '::1', '/bahawalcollegeofhealth/courses.php', '', 'Direct', 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456', 'Desktop', 'Unknown', 'Windows 10', NULL, NULL, 'q64t7hldc5rdmab635e64hu0q9', '2026-09-17', '07:26:11', '2026-09-17 05:26:11'),
(1905, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'Direct', 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456', 'Desktop', 'Unknown', 'Windows 10', NULL, NULL, 'ile38gq75egkc4iv1mpnaeorq7', '2026-09-17', '07:26:11', '2026-09-17 05:26:11'),
(1906, '::1', '/bahawalcollegeofhealth/contact.php', '', 'Direct', 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456', 'Desktop', 'Unknown', 'Windows 10', NULL, NULL, 'ls4o9h6fbsa9sor5d8g04se8ml', '2026-09-17', '07:26:11', '2026-09-17 05:26:11'),
(1907, '::1', '/bahawalcollegeofhealth/gallery.php', '', 'Direct', 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456', 'Desktop', 'Unknown', 'Windows 10', NULL, NULL, '1muvon45t36t4v8nkluk6aokkd', '2026-09-17', '07:26:12', '2026-09-17 05:26:12'),
(1908, '::1', '/bahawalcollegeofhealth/scholarships.php', '', 'Direct', 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456', 'Desktop', 'Unknown', 'Windows 10', NULL, NULL, '13372ljrkpsk70i1r2dmp136j0', '2026-09-17', '07:26:12', '2026-09-17 05:26:12'),
(1909, '::1', '/bahawalcollegeofhealth/campuses.php', '', 'Direct', 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456', 'Desktop', 'Unknown', 'Windows 10', NULL, NULL, 'k2qig1f8t2b91u3c40sr601f5d', '2026-09-17', '07:26:12', '2026-09-17 05:26:12'),
(1910, '::1', '/bahawalcollegeofhealth/examination.php', '', 'Direct', 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456', 'Desktop', 'Unknown', 'Windows 10', NULL, NULL, 'i18vtj8boabbdh5oucs58lu15r', '2026-09-17', '07:26:13', '2026-09-17 05:26:13'),
(1911, '::1', '/bahawalcollegeofhealth/downloads.php', '', 'Direct', 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456', 'Desktop', 'Unknown', 'Windows 10', NULL, NULL, 'l0afs1foem8hconb7rdv47g07l', '2026-09-17', '07:26:13', '2026-09-17 05:26:13'),
(1912, '::1', '/bahawalcollegeofhealth/alumni.php', '', 'Direct', 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456', 'Desktop', 'Unknown', 'Windows 10', NULL, NULL, 'oijlfla2g3acbg62r5hvmivvj6', '2026-09-17', '07:26:13', '2026-09-17 05:26:13'),
(1913, '::1', '/bahawalcollegeofhealth/events.php', '', 'Direct', 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456', 'Desktop', 'Unknown', 'Windows 10', NULL, NULL, 'oh8aeufp8gbbqph1id6m75mo5s', '2026-09-17', '07:26:14', '2026-09-17 05:26:14'),
(1914, '::1', '/bahawalcollegeofhealth/news.php', '', 'Direct', 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456', 'Desktop', 'Unknown', 'Windows 10', NULL, NULL, 'm2qaqbhgdleddohg9pev5bjm6c', '2026-09-17', '07:26:14', '2026-09-17 05:26:14'),
(1915, '::1', '/bahawalcollegeofhealth/notifications.php', '', 'Direct', 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456', 'Desktop', 'Unknown', 'Windows 10', NULL, NULL, 'bbgl2kpianbgb27rid603gqr7f', '2026-09-17', '07:26:14', '2026-09-17 05:26:14'),
(1916, '::1', '/bahawalcollegeofhealth/mission-vision.php', '', 'Direct', 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456', 'Desktop', 'Unknown', 'Windows 10', NULL, NULL, '4qi0117h7lffprs89akvcpge08', '2026-09-17', '07:26:14', '2026-09-17 05:26:14'),
(1917, '::1', '/bahawalcollegeofhealth/core-values.php', '', 'Direct', 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456', 'Desktop', 'Unknown', 'Windows 10', NULL, NULL, 'grlufqhhqsqv81ft4oohfrab9t', '2026-09-17', '07:26:15', '2026-09-17 05:26:15'),
(1918, '::1', '/bahawalcollegeofhealth/leadership.php', '', 'Direct', 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456', 'Desktop', 'Unknown', 'Windows 10', NULL, NULL, '2ssl0nd4uis9ghesoha68m9ha2', '2026-09-17', '07:26:15', '2026-09-17 05:26:15'),
(1919, '::1', '/bahawalcollegeofhealth/chairman-message.php', '', 'Direct', 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456', 'Desktop', 'Unknown', 'Windows 10', NULL, NULL, '47nsnfkrin05knke5pc5623nsc', '2026-09-17', '07:26:16', '2026-09-17 05:26:16'),
(1920, '::1', '/bahawalcollegeofhealth/principal-message.php', '', 'Direct', 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456', 'Desktop', 'Unknown', 'Windows 10', NULL, NULL, 's9d28bpct1vkdrn060vnu21ipj', '2026-09-17', '07:26:16', '2026-09-17 05:26:16'),
(1921, '::1', '/bahawalcollegeofhealth/accreditation.php', '', 'Direct', 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456', 'Desktop', 'Unknown', 'Windows 10', NULL, NULL, '8b6tscfsr7g2mjkgrhv87tl6eq', '2026-09-17', '07:26:16', '2026-09-17 05:26:16'),
(1922, '::1', '/bahawalcollegeofhealth/clinical-training.php', '', 'Direct', 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456', 'Desktop', 'Unknown', 'Windows 10', NULL, NULL, 'e6lmp9i11kovj4g7o6eotj6jmq', '2026-09-17', '07:26:16', '2026-09-17 05:26:16'),
(1923, '::1', '/bahawalcollegeofhealth/our-projects.php', '', 'Direct', 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456', 'Desktop', 'Unknown', 'Windows 10', NULL, NULL, '2u82akvrpua5sup4catna44tm1', '2026-09-17', '07:26:16', '2026-09-17 05:26:16'),
(1924, '::1', '/bahawalcollegeofhealth/our-networks.php', '', 'Direct', 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456', 'Desktop', 'Unknown', 'Windows 10', NULL, NULL, 'vuch9dc5dmn86av72p62pu4dqt', '2026-09-17', '07:26:17', '2026-09-17 05:26:17'),
(1925, '::1', '/bahawalcollegeofhealth/foundation.php', '', 'Direct', 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456', 'Desktop', 'Unknown', 'Windows 10', NULL, NULL, 'ljr12qvlto37p81bvfk8a5s2bq', '2026-09-17', '07:26:17', '2026-09-17 05:26:17');
INSERT INTO `website_analytics` (`id`, `visitor_ip`, `page_url`, `page_title`, `referrer`, `user_agent`, `device_type`, `browser`, `operating_system`, `country`, `city`, `session_id`, `visit_date`, `visit_time`, `created_at`) VALUES
(1926, '::1', '/bahawalcollegeofhealth/activities.php', '', 'Direct', 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456', 'Desktop', 'Unknown', 'Windows 10', NULL, NULL, '7121srto84c0uc2kb73mhelc3t', '2026-09-17', '07:26:17', '2026-09-17 05:26:17'),
(1927, '::1', '/bahawalcollegeofhealth/eligibility-checker.php', '', 'Direct', 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456', 'Desktop', 'Unknown', 'Windows 10', NULL, NULL, 'qm3tc2cckc6k6e2ngv2r08pagv', '2026-09-17', '07:26:17', '2026-09-17 05:26:17'),
(1928, '::1', '/bahawalcollegeofhealth/fee-calculator.php', '', 'Direct', 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456', 'Desktop', 'Unknown', 'Windows 10', NULL, NULL, 'g1vu650a40n6sa5hp8gtsvh3rg', '2026-09-17', '07:26:18', '2026-09-17 05:26:18'),
(1929, '::1', '/bahawalcollegeofhealth/campus-portal.php', '', 'Direct', 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456', 'Desktop', 'Unknown', 'Windows 10', NULL, NULL, 'bvptdbkv1qba0hjonu5pggdh9c', '2026-09-17', '07:26:18', '2026-09-17 05:26:18'),
(1930, '::1', '/bahawalcollegeofhealth/scholarships.php', '', 'Direct', 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456', 'Desktop', 'Unknown', 'Windows 10', NULL, NULL, 'rcr03bai3apj9nsjje8kd0k38q', '2026-09-17', '07:36:56', '2026-09-17 05:36:56'),
(1931, '::1', '/bahawalcollegeofhealth/fee-calculator.php', '', 'Direct', 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456', 'Desktop', 'Unknown', 'Windows 10', NULL, NULL, 'glbb23vbo67242bkdganqrqv8o', '2026-09-17', '07:36:57', '2026-09-17 05:36:57'),
(1932, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456', 'Desktop', 'Unknown', 'Windows 10', NULL, NULL, '3nqruhivoottn9jpe48ogs2n3r', '2026-09-17', '07:36:57', '2026-09-17 05:36:57'),
(1933, '::1', '/bahawalcollegeofhealth/scholarships.php', '', 'Direct', 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456', 'Desktop', 'Unknown', 'Windows 10', NULL, NULL, 'knge2nuidd38q1bb8jdrei96tg', '2026-09-17', '07:39:36', '2026-09-17 05:39:36'),
(1934, '::1', '/bahawalcollegeofhealth/fee-calculator.php', '', 'Direct', 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456', 'Desktop', 'Unknown', 'Windows 10', NULL, NULL, 'dmdashs6pl9aop8qkgletfdvhl', '2026-09-17', '07:39:36', '2026-09-17 05:39:36'),
(1935, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456', 'Desktop', 'Unknown', 'Windows 10', NULL, NULL, 'd5megqcsfv7k166sn3n9nt7s3g', '2026-09-17', '07:40:06', '2026-09-17 05:40:06'),
(1936, '::1', '/bahawalcollegeofhealth/scholarships.php', '', 'Direct', 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456', 'Desktop', 'Unknown', 'Windows 10', NULL, NULL, 'msi4tohe2mha4re5ouvqm0r2pa', '2026-09-17', '07:40:07', '2026-09-17 05:40:07'),
(1937, '::1', '/bahawalcollegeofhealth/fee-calculator.php', '', 'Direct', 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456', 'Desktop', 'Unknown', 'Windows 10', NULL, NULL, 'hdcuhq296o3tv3c8ffd9pv4er3', '2026-09-17', '07:40:07', '2026-09-17 05:40:07'),
(1938, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456', 'Desktop', 'Unknown', 'Windows 10', NULL, NULL, 'n18ucodvpmekt9do3h76e9126m', '2026-09-17', '07:52:18', '2026-09-17 05:52:18'),
(1939, '::1', '/bahawalcollegeofhealth/downloads.php', '', 'Direct', 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456', 'Desktop', 'Unknown', 'Windows 10', NULL, NULL, 'hutmebgv1gj90ugpmp4403pe9e', '2026-09-17', '07:52:19', '2026-09-17 05:52:19'),
(1940, '::1', '/bahawalcollegeofhealth/alumni.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'gk2rv5nnntmdj7lf9e4dieungq', '2026-09-17', '07:55:23', '2026-09-17 05:55:23'),
(1941, '::1', '/bahawalcollegeofhealth/alumni.php', '', 'http://localhost/bahawalcollegeofhealth/alumni.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'gk2rv5nnntmdj7lf9e4dieungq', '2026-09-17', '07:55:31', '2026-09-17 05:55:31'),
(1942, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456', 'Desktop', 'Unknown', 'Windows 10', NULL, NULL, '2vtcv029813k0ec1sbog2qck73', '2026-09-17', '08:00:42', '2026-09-17 06:00:42'),
(1943, '::1', '/bahawalcollegeofhealth/about.php', '', 'Direct', 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456', 'Desktop', 'Unknown', 'Windows 10', NULL, NULL, 'h0qqg31ed3r4c3f4n0tsdi9lto', '2026-09-17', '08:00:43', '2026-09-17 06:00:43'),
(1944, '::1', '/bahawalcollegeofhealth/admission.php', '', 'Direct', 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456', 'Desktop', 'Unknown', 'Windows 10', NULL, NULL, '6ug70ibe35s5r14ng55ghuig9e', '2026-09-17', '08:00:43', '2026-09-17 06:00:43'),
(1945, '::1', '/bahawalcollegeofhealth/alumni.php', '', 'Direct', 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456', 'Desktop', 'Unknown', 'Windows 10', NULL, NULL, '55pq5rhaung7rd2mj0du3ijk4l', '2026-09-17', '08:00:44', '2026-09-17 06:00:44'),
(1946, '::1', '/bahawalcollegeofhealth/contact.php', '', 'Direct', 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456', 'Desktop', 'Unknown', 'Windows 10', NULL, NULL, 'tjoj6ndmeu1so90mum2k8vf6rh', '2026-09-17', '08:00:44', '2026-09-17 06:00:44'),
(1947, '::1', '/bahawalcollegeofhealth/gallery.php', '', 'Direct', 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456', 'Desktop', 'Unknown', 'Windows 10', NULL, NULL, 'l6hag28i55aug3823qaussu9t3', '2026-09-17', '08:00:44', '2026-09-17 06:00:44'),
(1948, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'Direct', 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456', 'Desktop', 'Unknown', 'Windows 10', NULL, NULL, '09lmuu7bv3h4bpd9if3f6g3v4h', '2026-09-17', '08:00:45', '2026-09-17 06:00:45'),
(1949, '::1', '/bahawalcollegeofhealth/courses.php', '', 'Direct', 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456', 'Desktop', 'Unknown', 'Windows 10', NULL, NULL, 'p3gsd6ho9c9nu5fpqgb29l9d9n', '2026-09-17', '08:00:45', '2026-09-17 06:00:45'),
(1950, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456', 'Desktop', 'Unknown', 'Windows 10', NULL, NULL, '1284g7c40vtr29hoe436u6rdgd', '2026-09-17', '08:28:31', '2026-09-17 06:28:31'),
(1951, '::1', '/bahawalcollegeofhealth/about.php', '', 'Direct', 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456', 'Desktop', 'Unknown', 'Windows 10', NULL, NULL, '9e9gte2qgdf7ovv40c3hlut1ve', '2026-09-17', '08:28:48', '2026-09-17 06:28:48'),
(1952, '::1', '/bahawalcollegeofhealth/admission.php', '', 'Direct', 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456', 'Desktop', 'Unknown', 'Windows 10', NULL, NULL, 'scipcuguur8eni5dg03ocbt8uk', '2026-09-17', '08:28:49', '2026-09-17 06:28:49'),
(1953, '::1', '/bahawalcollegeofhealth/alumni.php', '', 'Direct', 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456', 'Desktop', 'Unknown', 'Windows 10', NULL, NULL, 's8juohencg9ssbgecb94jh9j4c', '2026-09-17', '08:29:32', '2026-09-17 06:29:32'),
(1954, '::1', '/bahawalcollegeofhealth/contact.php', '', 'Direct', 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456', 'Desktop', 'Unknown', 'Windows 10', NULL, NULL, '72qblc7298sb9duae14tkhcbo5', '2026-09-17', '08:29:36', '2026-09-17 06:29:36'),
(1955, '::1', '/bahawalcollegeofhealth/gallery.php', '', 'Direct', 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456', 'Desktop', 'Unknown', 'Windows 10', NULL, NULL, 'u82p0rtoa3iebi1j84h5q0h9pd', '2026-09-17', '08:29:37', '2026-09-17 06:29:37'),
(1956, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'Direct', 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456', 'Desktop', 'Unknown', 'Windows 10', NULL, NULL, 'r2mnmu9399kqc9ojqgfq58foj3', '2026-09-17', '08:29:39', '2026-09-17 06:29:39'),
(1957, '::1', '/bahawalcollegeofhealth/courses.php', '', 'Direct', 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456', 'Desktop', 'Unknown', 'Windows 10', NULL, NULL, 'mabrv2vj6gr8vatspfvsutlluq', '2026-09-17', '08:29:40', '2026-09-17 06:29:40'),
(1958, '::1', '/bahawalcollegeofhealth/scholarships.php', '', 'Direct', 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456', 'Desktop', 'Unknown', 'Windows 10', NULL, NULL, 'ojcoh2qf6lbohs1540nvp3c5ih', '2026-09-17', '08:29:46', '2026-09-17 06:29:46'),
(1959, '::1', '/bahawalcollegeofhealth/fee-calculator.php', '', 'Direct', 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456', 'Desktop', 'Unknown', 'Windows 10', NULL, NULL, '2hsjp4a98empvp0pq26rf8nn49', '2026-09-17', '08:30:22', '2026-09-17 06:30:22'),
(1960, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 't4drb27c2v5ef384ddmb1mj1k5', '2026-09-17', '08:36:35', '2026-09-17 06:36:35'),
(1961, '::1', '/bahawalcollegeofhealth/about.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 't4drb27c2v5ef384ddmb1mj1k5', '2026-09-17', '08:36:44', '2026-09-17 06:36:44'),
(1962, '::1', '/bahawalcollegeofhealth/mission-vision.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 't4drb27c2v5ef384ddmb1mj1k5', '2026-09-17', '08:36:48', '2026-09-17 06:36:48'),
(1963, '::1', '/bahawalcollegeofhealth/core-values.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 't4drb27c2v5ef384ddmb1mj1k5', '2026-09-17', '08:36:50', '2026-09-17 06:36:50'),
(1964, '::1', '/bahawalcollegeofhealth/leadership.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 't4drb27c2v5ef384ddmb1mj1k5', '2026-09-17', '08:36:52', '2026-09-17 06:36:52'),
(1965, '::1', '/bahawalcollegeofhealth/chairman-message.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 't4drb27c2v5ef384ddmb1mj1k5', '2026-09-17', '08:36:54', '2026-09-17 06:36:54'),
(1966, '::1', '/bahawalcollegeofhealth/principal-message.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 't4drb27c2v5ef384ddmb1mj1k5', '2026-09-17', '08:36:56', '2026-09-17 06:36:56'),
(1967, '::1', '/bahawalcollegeofhealth/accreditation.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 't4drb27c2v5ef384ddmb1mj1k5', '2026-09-17', '08:36:57', '2026-09-17 06:36:57'),
(1968, '::1', '/bahawalcollegeofhealth/foundation.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 't4drb27c2v5ef384ddmb1mj1k5', '2026-09-17', '08:36:59', '2026-09-17 06:36:59'),
(1969, '::1', '/bahawalcollegeofhealth/our-projects.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 't4drb27c2v5ef384ddmb1mj1k5', '2026-09-17', '08:37:02', '2026-09-17 06:37:02'),
(1970, '::1', '/bahawalcollegeofhealth/our-networks.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 't4drb27c2v5ef384ddmb1mj1k5', '2026-09-17', '08:37:07', '2026-09-17 06:37:07'),
(1971, '::1', '/bahawalcollegeofhealth/courses.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 't4drb27c2v5ef384ddmb1mj1k5', '2026-09-17', '08:37:10', '2026-09-17 06:37:10'),
(1972, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 't4drb27c2v5ef384ddmb1mj1k5', '2026-09-17', '08:37:14', '2026-09-17 06:37:14'),
(1973, '::1', '/bahawalcollegeofhealth/clinical-training.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 't4drb27c2v5ef384ddmb1mj1k5', '2026-09-17', '08:37:16', '2026-09-17 06:37:16'),
(1974, '::1', '/bahawalcollegeofhealth/examination.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 't4drb27c2v5ef384ddmb1mj1k5', '2026-09-17', '08:37:18', '2026-09-17 06:37:18'),
(1975, '::1', '/bahawalcollegeofhealth/campuses.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 't4drb27c2v5ef384ddmb1mj1k5', '2026-09-17', '08:37:21', '2026-09-17 06:37:22'),
(1976, '::1', '/bahawalcollegeofhealth/admission.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 't4drb27c2v5ef384ddmb1mj1k5', '2026-09-17', '08:37:34', '2026-09-17 06:37:34'),
(1977, '::1', '/bahawalcollegeofhealth/scholarships.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 't4drb27c2v5ef384ddmb1mj1k5', '2026-09-17', '08:37:39', '2026-09-17 06:37:39'),
(1978, '::1', '/bahawalcollegeofhealth/fee-calculator.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 't4drb27c2v5ef384ddmb1mj1k5', '2026-09-17', '08:37:46', '2026-09-17 06:37:47'),
(1979, '::1', '/bahawalcollegeofhealth/eligibility-checker.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 't4drb27c2v5ef384ddmb1mj1k5', '2026-09-17', '08:37:53', '2026-09-17 06:37:53'),
(1980, '::1', '/bahawalcollegeofhealth/downloads.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 't4drb27c2v5ef384ddmb1mj1k5', '2026-09-17', '08:37:56', '2026-09-17 06:37:56'),
(1981, '::1', '/bahawalcollegeofhealth/activities.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 't4drb27c2v5ef384ddmb1mj1k5', '2026-09-17', '08:37:58', '2026-09-17 06:37:58'),
(1982, '::1', '/bahawalcollegeofhealth/events.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 't4drb27c2v5ef384ddmb1mj1k5', '2026-09-17', '08:38:01', '2026-09-17 06:38:01'),
(1983, '::1', '/bahawalcollegeofhealth/news.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 't4drb27c2v5ef384ddmb1mj1k5', '2026-09-17', '08:38:03', '2026-09-17 06:38:03'),
(1984, '::1', '/bahawalcollegeofhealth/notifications.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 't4drb27c2v5ef384ddmb1mj1k5', '2026-09-17', '08:38:07', '2026-09-17 06:38:07'),
(1985, '::1', '/bahawalcollegeofhealth/alumni.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 't4drb27c2v5ef384ddmb1mj1k5', '2026-09-17', '08:38:10', '2026-09-17 06:38:10'),
(1986, '::1', '/bahawalcollegeofhealth/gallery.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 't4drb27c2v5ef384ddmb1mj1k5', '2026-09-17', '08:38:13', '2026-09-17 06:38:13'),
(1987, '::1', '/bahawalcollegeofhealth/contact.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 't4drb27c2v5ef384ddmb1mj1k5', '2026-09-17', '08:38:16', '2026-09-17 06:38:16'),
(1988, '::1', '/bahawalcollegeofhealth/campus-portal.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 't4drb27c2v5ef384ddmb1mj1k5', '2026-09-17', '08:38:18', '2026-09-17 06:38:18'),
(1989, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 't4drb27c2v5ef384ddmb1mj1k5', '2026-09-17', '08:38:20', '2026-09-17 06:38:20'),
(1990, '::1', '/bahawalcollegeofhealth/campus-portal.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 't4drb27c2v5ef384ddmb1mj1k5', '2026-09-17', '08:38:21', '2026-09-17 06:38:21'),
(1991, '::1', '/bahawalcollegeofhealth/about.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 't4drb27c2v5ef384ddmb1mj1k5', '2026-09-17', '08:38:21', '2026-09-17 06:38:21'),
(1992, '::1', '/bahawalcollegeofhealth/mission-vision.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 't4drb27c2v5ef384ddmb1mj1k5', '2026-09-17', '08:38:21', '2026-09-17 06:38:21'),
(1993, '::1', '/bahawalcollegeofhealth/core-values.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 't4drb27c2v5ef384ddmb1mj1k5', '2026-09-17', '08:38:21', '2026-09-17 06:38:21'),
(1994, '::1', '/bahawalcollegeofhealth/leadership.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 't4drb27c2v5ef384ddmb1mj1k5', '2026-09-17', '08:38:21', '2026-09-17 06:38:21'),
(1995, '::1', '/bahawalcollegeofhealth/chairman-message.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 't4drb27c2v5ef384ddmb1mj1k5', '2026-09-17', '08:38:21', '2026-09-17 06:38:21'),
(1996, '::1', '/bahawalcollegeofhealth/principal-message.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 't4drb27c2v5ef384ddmb1mj1k5', '2026-09-17', '08:38:21', '2026-09-17 06:38:21'),
(1997, '::1', '/bahawalcollegeofhealth/courses.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 't4drb27c2v5ef384ddmb1mj1k5', '2026-09-17', '08:38:22', '2026-09-17 06:38:22'),
(1998, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 't4drb27c2v5ef384ddmb1mj1k5', '2026-09-17', '08:38:22', '2026-09-17 06:38:22'),
(1999, '::1', '/bahawalcollegeofhealth/examination.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 't4drb27c2v5ef384ddmb1mj1k5', '2026-09-17', '08:38:22', '2026-09-17 06:38:22'),
(2000, '::1', '/bahawalcollegeofhealth/our-networks.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 't4drb27c2v5ef384ddmb1mj1k5', '2026-09-17', '08:38:22', '2026-09-17 06:38:22'),
(2001, '::1', '/bahawalcollegeofhealth/clinical-training.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 't4drb27c2v5ef384ddmb1mj1k5', '2026-09-17', '08:38:22', '2026-09-17 06:38:22'),
(2002, '::1', '/bahawalcollegeofhealth/our-projects.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 't4drb27c2v5ef384ddmb1mj1k5', '2026-09-17', '08:38:22', '2026-09-17 06:38:22'),
(2003, '::1', '/bahawalcollegeofhealth/accreditation.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 't4drb27c2v5ef384ddmb1mj1k5', '2026-09-17', '08:38:22', '2026-09-17 06:38:22'),
(2004, '::1', '/bahawalcollegeofhealth/foundation.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 't4drb27c2v5ef384ddmb1mj1k5', '2026-09-17', '08:38:23', '2026-09-17 06:38:23'),
(2005, '::1', '/bahawalcollegeofhealth/admission.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 't4drb27c2v5ef384ddmb1mj1k5', '2026-09-17', '08:38:23', '2026-09-17 06:38:23'),
(2006, '::1', '/bahawalcollegeofhealth/downloads.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 't4drb27c2v5ef384ddmb1mj1k5', '2026-09-17', '08:38:23', '2026-09-17 06:38:23'),
(2007, '::1', '/bahawalcollegeofhealth/notifications.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 't4drb27c2v5ef384ddmb1mj1k5', '2026-09-17', '08:38:23', '2026-09-17 06:38:23'),
(2008, '::1', '/bahawalcollegeofhealth/fee-calculator.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 't4drb27c2v5ef384ddmb1mj1k5', '2026-09-17', '08:38:23', '2026-09-17 06:38:23'),
(2009, '::1', '/bahawalcollegeofhealth/scholarships.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 't4drb27c2v5ef384ddmb1mj1k5', '2026-09-17', '08:38:23', '2026-09-17 06:38:23'),
(2010, '::1', '/bahawalcollegeofhealth/eligibility-checker.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 't4drb27c2v5ef384ddmb1mj1k5', '2026-09-17', '08:38:23', '2026-09-17 06:38:23'),
(2011, '::1', '/bahawalcollegeofhealth/campuses.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 't4drb27c2v5ef384ddmb1mj1k5', '2026-09-17', '08:38:24', '2026-09-17 06:38:24'),
(2012, '::1', '/bahawalcollegeofhealth/events.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 't4drb27c2v5ef384ddmb1mj1k5', '2026-09-17', '08:38:24', '2026-09-17 06:38:24'),
(2013, '::1', '/bahawalcollegeofhealth/news.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 't4drb27c2v5ef384ddmb1mj1k5', '2026-09-17', '08:38:24', '2026-09-17 06:38:24'),
(2014, '::1', '/bahawalcollegeofhealth/activities.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 't4drb27c2v5ef384ddmb1mj1k5', '2026-09-17', '08:38:24', '2026-09-17 06:38:24'),
(2015, '::1', '/bahawalcollegeofhealth/gallery.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 't4drb27c2v5ef384ddmb1mj1k5', '2026-09-17', '08:38:24', '2026-09-17 06:38:24'),
(2016, '::1', '/bahawalcollegeofhealth/contact.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 't4drb27c2v5ef384ddmb1mj1k5', '2026-09-17', '08:38:24', '2026-09-17 06:38:24'),
(2017, '::1', '/bahawalcollegeofhealth/admission.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 't4drb27c2v5ef384ddmb1mj1k5', '2026-09-17', '08:38:24', '2026-09-17 06:38:24'),
(2018, '::1', '/bahawalcollegeofhealth/admission.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 't4drb27c2v5ef384ddmb1mj1k5', '2026-09-17', '08:38:24', '2026-09-17 06:38:24'),
(2019, '::1', '/bahawalcollegeofhealth/admission.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 't4drb27c2v5ef384ddmb1mj1k5', '2026-09-17', '08:38:25', '2026-09-17 06:38:25'),
(2020, '::1', '/bahawalcollegeofhealth/admission.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 't4drb27c2v5ef384ddmb1mj1k5', '2026-09-17', '08:38:25', '2026-09-17 06:38:25'),
(2021, '::1', '/bahawalcollegeofhealth/admission.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 't4drb27c2v5ef384ddmb1mj1k5', '2026-09-17', '08:38:25', '2026-09-17 06:38:25'),
(2022, '::1', '/bahawalcollegeofhealth/admission.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 't4drb27c2v5ef384ddmb1mj1k5', '2026-09-17', '08:38:25', '2026-09-17 06:38:25'),
(2023, '::1', '/bahawalcollegeofhealth/admission.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 't4drb27c2v5ef384ddmb1mj1k5', '2026-09-17', '08:38:25', '2026-09-17 06:38:25'),
(2024, '::1', '/bahawalcollegeofhealth/admission.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 't4drb27c2v5ef384ddmb1mj1k5', '2026-09-17', '08:38:25', '2026-09-17 06:38:25'),
(2025, '::1', '/bahawalcollegeofhealth/admission.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 't4drb27c2v5ef384ddmb1mj1k5', '2026-09-17', '08:38:25', '2026-09-17 06:38:25'),
(2026, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 's0vdneeci9qjbahci632d08tln', '2026-09-17', '08:39:37', '2026-09-17 06:39:37'),
(2027, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '0nf6d3p0c6dpgsmv2bsjbg7tk8', '2026-09-17', '08:39:46', '2026-09-17 06:39:46'),
(2028, '::1', '/bahawalcollegeofhealth/contact.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '2q3a6q81u89k2t7p1aar65g8fj', '2026-09-17', '08:40:47', '2026-09-17 06:40:47'),
(2029, '::1', '/bahawalcollegeofhealth/contact.php', '', 'http://localhost/bahawalcollegeofhealth/contact.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '2q3a6q81u89k2t7p1aar65g8fj', '2026-09-17', '08:41:02', '2026-09-17 06:41:02'),
(2030, '::1', '/bahawalcollegeofhealth/contact.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '932es6tq3vjfbq2tabtvh5t6ku', '2026-09-17', '08:41:38', '2026-09-17 06:41:38'),
(2031, '::1', '/bahawalcollegeofhealth/contact.php', '', 'http://localhost/bahawalcollegeofhealth/contact.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '932es6tq3vjfbq2tabtvh5t6ku', '2026-09-17', '08:41:54', '2026-09-17 06:41:54'),
(2032, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'abbq2krajv280id0qns4i4u2au', '2026-09-17', '08:44:17', '2026-09-17 06:44:17'),
(2033, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'abbq2krajv280id0qns4i4u2au', '2026-09-17', '08:44:24', '2026-09-17 06:44:24'),
(2034, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'abbq2krajv280id0qns4i4u2au', '2026-09-17', '08:44:34', '2026-09-17 06:44:34'),
(2035, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'abbq2krajv280id0qns4i4u2au', '2026-09-17', '08:44:38', '2026-09-17 06:44:38'),
(2036, '::1', '/bahawalcollegeofhealth/about.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'abbq2krajv280id0qns4i4u2au', '2026-09-17', '08:44:41', '2026-09-17 06:44:41'),
(2037, '::1', '/bahawalcollegeofhealth/about.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'abbq2krajv280id0qns4i4u2au', '2026-09-17', '08:44:43', '2026-09-17 06:44:43'),
(2038, '::1', '/bahawalcollegeofhealth/about.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'abbq2krajv280id0qns4i4u2au', '2026-09-17', '08:44:45', '2026-09-17 06:44:45'),
(2039, '::1', '/bahawalcollegeofhealth/about.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'abbq2krajv280id0qns4i4u2au', '2026-09-17', '08:44:49', '2026-09-17 06:44:49'),
(2040, '::1', '/bahawalcollegeofhealth/mission-vision.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'abbq2krajv280id0qns4i4u2au', '2026-09-17', '08:44:51', '2026-09-17 06:44:51'),
(2041, '::1', '/bahawalcollegeofhealth/mission-vision.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'abbq2krajv280id0qns4i4u2au', '2026-09-17', '08:44:52', '2026-09-17 06:44:52'),
(2042, '::1', '/bahawalcollegeofhealth/mission-vision.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'abbq2krajv280id0qns4i4u2au', '2026-09-17', '08:44:56', '2026-09-17 06:44:56'),
(2043, '::1', '/bahawalcollegeofhealth/mission-vision.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'abbq2krajv280id0qns4i4u2au', '2026-09-17', '08:44:58', '2026-09-17 06:44:58'),
(2044, '::1', '/bahawalcollegeofhealth/core-values.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'abbq2krajv280id0qns4i4u2au', '2026-09-17', '08:45:00', '2026-09-17 06:45:00'),
(2045, '::1', '/bahawalcollegeofhealth/core-values.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'abbq2krajv280id0qns4i4u2au', '2026-09-17', '08:45:01', '2026-09-17 06:45:01'),
(2046, '::1', '/bahawalcollegeofhealth/core-values.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'abbq2krajv280id0qns4i4u2au', '2026-09-17', '08:45:03', '2026-09-17 06:45:03'),
(2047, '::1', '/bahawalcollegeofhealth/core-values.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'abbq2krajv280id0qns4i4u2au', '2026-09-17', '08:45:07', '2026-09-17 06:45:07'),
(2048, '::1', '/bahawalcollegeofhealth/leadership.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'abbq2krajv280id0qns4i4u2au', '2026-09-17', '08:45:10', '2026-09-17 06:45:10'),
(2049, '::1', '/bahawalcollegeofhealth/leadership.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'abbq2krajv280id0qns4i4u2au', '2026-09-17', '08:45:16', '2026-09-17 06:45:16'),
(2050, '::1', '/bahawalcollegeofhealth/leadership.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'abbq2krajv280id0qns4i4u2au', '2026-09-17', '08:45:19', '2026-09-17 06:45:19'),
(2051, '::1', '/bahawalcollegeofhealth/leadership.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'abbq2krajv280id0qns4i4u2au', '2026-09-17', '08:45:22', '2026-09-17 06:45:22'),
(2052, '::1', '/bahawalcollegeofhealth/chairman-message.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'abbq2krajv280id0qns4i4u2au', '2026-09-17', '08:45:25', '2026-09-17 06:45:25'),
(2053, '::1', '/bahawalcollegeofhealth/chairman-message.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'abbq2krajv280id0qns4i4u2au', '2026-09-17', '08:45:26', '2026-09-17 06:45:26'),
(2054, '::1', '/bahawalcollegeofhealth/chairman-message.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'abbq2krajv280id0qns4i4u2au', '2026-09-17', '08:45:28', '2026-09-17 06:45:28'),
(2055, '::1', '/bahawalcollegeofhealth/chairman-message.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'abbq2krajv280id0qns4i4u2au', '2026-09-17', '08:45:29', '2026-09-17 06:45:29'),
(2056, '::1', '/bahawalcollegeofhealth/principal-message.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'abbq2krajv280id0qns4i4u2au', '2026-09-17', '08:45:31', '2026-09-17 06:45:31'),
(2057, '::1', '/bahawalcollegeofhealth/principal-message.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'abbq2krajv280id0qns4i4u2au', '2026-09-17', '08:45:33', '2026-09-17 06:45:33'),
(2058, '::1', '/bahawalcollegeofhealth/principal-message.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'abbq2krajv280id0qns4i4u2au', '2026-09-17', '08:45:34', '2026-09-17 06:45:34'),
(2059, '::1', '/bahawalcollegeofhealth/principal-message.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'abbq2krajv280id0qns4i4u2au', '2026-09-17', '08:45:37', '2026-09-17 06:45:37'),
(2060, '::1', '/bahawalcollegeofhealth/accreditation.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'abbq2krajv280id0qns4i4u2au', '2026-09-17', '08:45:39', '2026-09-17 06:45:39'),
(2061, '::1', '/bahawalcollegeofhealth/accreditation.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'abbq2krajv280id0qns4i4u2au', '2026-09-17', '08:45:41', '2026-09-17 06:45:41'),
(2062, '::1', '/bahawalcollegeofhealth/accreditation.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'abbq2krajv280id0qns4i4u2au', '2026-09-17', '08:45:42', '2026-09-17 06:45:42'),
(2063, '::1', '/bahawalcollegeofhealth/accreditation.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'abbq2krajv280id0qns4i4u2au', '2026-09-17', '08:45:44', '2026-09-17 06:45:44'),
(2064, '::1', '/bahawalcollegeofhealth/foundation.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'abbq2krajv280id0qns4i4u2au', '2026-09-17', '08:45:46', '2026-09-17 06:45:46'),
(2065, '::1', '/bahawalcollegeofhealth/foundation.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'abbq2krajv280id0qns4i4u2au', '2026-09-17', '08:45:47', '2026-09-17 06:45:47'),
(2066, '::1', '/bahawalcollegeofhealth/foundation.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'abbq2krajv280id0qns4i4u2au', '2026-09-17', '08:45:48', '2026-09-17 06:45:48'),
(2067, '::1', '/bahawalcollegeofhealth/foundation.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'abbq2krajv280id0qns4i4u2au', '2026-09-17', '08:45:50', '2026-09-17 06:45:50'),
(2068, '::1', '/bahawalcollegeofhealth/our-projects.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'abbq2krajv280id0qns4i4u2au', '2026-09-17', '08:45:52', '2026-09-17 06:45:52'),
(2069, '::1', '/bahawalcollegeofhealth/our-projects.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'abbq2krajv280id0qns4i4u2au', '2026-09-17', '08:45:53', '2026-09-17 06:45:53'),
(2070, '::1', '/bahawalcollegeofhealth/our-projects.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'abbq2krajv280id0qns4i4u2au', '2026-09-17', '08:45:55', '2026-09-17 06:45:55'),
(2071, '::1', '/bahawalcollegeofhealth/our-projects.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'abbq2krajv280id0qns4i4u2au', '2026-09-17', '08:45:56', '2026-09-17 06:45:56'),
(2072, '::1', '/bahawalcollegeofhealth/our-networks.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'abbq2krajv280id0qns4i4u2au', '2026-09-17', '08:45:58', '2026-09-17 06:45:58'),
(2073, '::1', '/bahawalcollegeofhealth/our-networks.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'abbq2krajv280id0qns4i4u2au', '2026-09-17', '08:45:59', '2026-09-17 06:45:59'),
(2074, '::1', '/bahawalcollegeofhealth/our-networks.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'abbq2krajv280id0qns4i4u2au', '2026-09-17', '08:46:01', '2026-09-17 06:46:01'),
(2075, '::1', '/bahawalcollegeofhealth/our-networks.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'abbq2krajv280id0qns4i4u2au', '2026-09-17', '08:46:03', '2026-09-17 06:46:03'),
(2076, '::1', '/bahawalcollegeofhealth/courses.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'abbq2krajv280id0qns4i4u2au', '2026-09-17', '08:46:05', '2026-09-17 06:46:05'),
(2077, '::1', '/bahawalcollegeofhealth/courses.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'abbq2krajv280id0qns4i4u2au', '2026-09-17', '08:46:08', '2026-09-17 06:46:08'),
(2078, '::1', '/bahawalcollegeofhealth/courses.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'abbq2krajv280id0qns4i4u2au', '2026-09-17', '08:46:11', '2026-09-17 06:46:11'),
(2079, '::1', '/bahawalcollegeofhealth/courses.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'abbq2krajv280id0qns4i4u2au', '2026-09-17', '08:46:15', '2026-09-17 06:46:15'),
(2080, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'abbq2krajv280id0qns4i4u2au', '2026-09-17', '08:46:20', '2026-09-17 06:46:20'),
(2081, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'abbq2krajv280id0qns4i4u2au', '2026-09-17', '08:46:23', '2026-09-17 06:46:23'),
(2082, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'abbq2krajv280id0qns4i4u2au', '2026-09-17', '08:46:30', '2026-09-17 06:46:30'),
(2083, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'abbq2krajv280id0qns4i4u2au', '2026-09-17', '08:46:33', '2026-09-17 06:46:33');
INSERT INTO `website_analytics` (`id`, `visitor_ip`, `page_url`, `page_title`, `referrer`, `user_agent`, `device_type`, `browser`, `operating_system`, `country`, `city`, `session_id`, `visit_date`, `visit_time`, `created_at`) VALUES
(2084, '::1', '/bahawalcollegeofhealth/clinical-training.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'abbq2krajv280id0qns4i4u2au', '2026-09-17', '08:46:36', '2026-09-17 06:46:36'),
(2085, '::1', '/bahawalcollegeofhealth/clinical-training.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'abbq2krajv280id0qns4i4u2au', '2026-09-17', '08:46:38', '2026-09-17 06:46:38'),
(2086, '::1', '/bahawalcollegeofhealth/clinical-training.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'abbq2krajv280id0qns4i4u2au', '2026-09-17', '08:46:40', '2026-09-17 06:46:40'),
(2087, '::1', '/bahawalcollegeofhealth/clinical-training.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'abbq2krajv280id0qns4i4u2au', '2026-09-17', '08:46:42', '2026-09-17 06:46:42'),
(2088, '::1', '/bahawalcollegeofhealth/examination.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'abbq2krajv280id0qns4i4u2au', '2026-09-17', '08:46:43', '2026-09-17 06:46:43'),
(2089, '::1', '/bahawalcollegeofhealth/examination.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'abbq2krajv280id0qns4i4u2au', '2026-09-17', '08:46:45', '2026-09-17 06:46:45'),
(2090, '::1', '/bahawalcollegeofhealth/examination.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'abbq2krajv280id0qns4i4u2au', '2026-09-17', '08:46:47', '2026-09-17 06:46:47'),
(2091, '::1', '/bahawalcollegeofhealth/examination.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'abbq2krajv280id0qns4i4u2au', '2026-09-17', '08:46:49', '2026-09-17 06:46:49'),
(2092, '::1', '/bahawalcollegeofhealth/campuses.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'abbq2krajv280id0qns4i4u2au', '2026-09-17', '08:46:53', '2026-09-17 06:46:53'),
(2093, '::1', '/bahawalcollegeofhealth/campuses.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'abbq2krajv280id0qns4i4u2au', '2026-09-17', '08:46:56', '2026-09-17 06:46:56'),
(2094, '::1', '/bahawalcollegeofhealth/eligibility-checker.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'ienvolk7l2pibo2l6mpqbdr5sl', '2026-09-17', '08:46:57', '2026-09-17 06:46:57'),
(2095, '::1', '/bahawalcollegeofhealth/campuses.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'abbq2krajv280id0qns4i4u2au', '2026-09-17', '08:46:59', '2026-09-17 06:46:59'),
(2096, '::1', '/bahawalcollegeofhealth/campuses.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'abbq2krajv280id0qns4i4u2au', '2026-09-17', '08:47:01', '2026-09-17 06:47:02'),
(2097, '::1', '/bahawalcollegeofhealth/admission.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'abbq2krajv280id0qns4i4u2au', '2026-09-17', '08:47:04', '2026-09-17 06:47:04'),
(2098, '::1', '/bahawalcollegeofhealth/admission.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'abbq2krajv280id0qns4i4u2au', '2026-09-17', '08:47:05', '2026-09-17 06:47:05'),
(2099, '::1', '/bahawalcollegeofhealth/admission.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'abbq2krajv280id0qns4i4u2au', '2026-09-17', '08:47:07', '2026-09-17 06:47:07'),
(2100, '::1', '/bahawalcollegeofhealth/admission.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'abbq2krajv280id0qns4i4u2au', '2026-09-17', '08:47:09', '2026-09-17 06:47:09'),
(2101, '::1', '/bahawalcollegeofhealth/scholarships.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'abbq2krajv280id0qns4i4u2au', '2026-09-17', '08:47:12', '2026-09-17 06:47:12'),
(2102, '::1', '/bahawalcollegeofhealth/scholarships.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'abbq2krajv280id0qns4i4u2au', '2026-09-17', '08:47:14', '2026-09-17 06:47:14'),
(2103, '::1', '/bahawalcollegeofhealth/scholarships.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'abbq2krajv280id0qns4i4u2au', '2026-09-17', '08:47:16', '2026-09-17 06:47:16'),
(2104, '::1', '/bahawalcollegeofhealth/scholarships.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'abbq2krajv280id0qns4i4u2au', '2026-09-17', '08:47:18', '2026-09-17 06:47:18'),
(2105, '::1', '/bahawalcollegeofhealth/fee-calculator.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'abbq2krajv280id0qns4i4u2au', '2026-09-17', '08:47:20', '2026-09-17 06:47:20'),
(2106, '::1', '/bahawalcollegeofhealth/fee-calculator.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'abbq2krajv280id0qns4i4u2au', '2026-09-17', '08:47:22', '2026-09-17 06:47:22'),
(2107, '::1', '/bahawalcollegeofhealth/fee-calculator.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'abbq2krajv280id0qns4i4u2au', '2026-09-17', '08:47:24', '2026-09-17 06:47:24'),
(2108, '::1', '/bahawalcollegeofhealth/fee-calculator.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'abbq2krajv280id0qns4i4u2au', '2026-09-17', '08:47:25', '2026-09-17 06:47:25'),
(2109, '::1', '/bahawalcollegeofhealth/eligibility-checker.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'abbq2krajv280id0qns4i4u2au', '2026-09-17', '08:47:27', '2026-09-17 06:47:27'),
(2110, '::1', '/bahawalcollegeofhealth/eligibility-checker.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'abbq2krajv280id0qns4i4u2au', '2026-09-17', '08:47:29', '2026-09-17 06:47:29'),
(2111, '::1', '/bahawalcollegeofhealth/eligibility-checker.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'abbq2krajv280id0qns4i4u2au', '2026-09-17', '08:47:30', '2026-09-17 06:47:30'),
(2112, '::1', '/bahawalcollegeofhealth/eligibility-checker.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'abbq2krajv280id0qns4i4u2au', '2026-09-17', '08:47:32', '2026-09-17 06:47:32'),
(2113, '::1', '/bahawalcollegeofhealth/downloads.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'abbq2krajv280id0qns4i4u2au', '2026-09-17', '08:47:34', '2026-09-17 06:47:34'),
(2114, '::1', '/bahawalcollegeofhealth/downloads.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'abbq2krajv280id0qns4i4u2au', '2026-09-17', '08:47:35', '2026-09-17 06:47:35'),
(2115, '::1', '/bahawalcollegeofhealth/downloads.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'abbq2krajv280id0qns4i4u2au', '2026-09-17', '08:47:36', '2026-09-17 06:47:36'),
(2116, '::1', '/bahawalcollegeofhealth/downloads.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'abbq2krajv280id0qns4i4u2au', '2026-09-17', '08:47:38', '2026-09-17 06:47:38'),
(2117, '::1', '/bahawalcollegeofhealth/activities.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'abbq2krajv280id0qns4i4u2au', '2026-09-17', '08:47:39', '2026-09-17 06:47:39'),
(2118, '::1', '/bahawalcollegeofhealth/activities.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'abbq2krajv280id0qns4i4u2au', '2026-09-17', '08:47:41', '2026-09-17 06:47:41'),
(2119, '::1', '/bahawalcollegeofhealth/activities.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'abbq2krajv280id0qns4i4u2au', '2026-09-17', '08:47:43', '2026-09-17 06:47:43'),
(2120, '::1', '/bahawalcollegeofhealth/activities.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'abbq2krajv280id0qns4i4u2au', '2026-09-17', '08:47:45', '2026-09-17 06:47:45'),
(2121, '::1', '/bahawalcollegeofhealth/events.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'abbq2krajv280id0qns4i4u2au', '2026-09-17', '08:47:47', '2026-09-17 06:47:47'),
(2122, '::1', '/bahawalcollegeofhealth/events.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'abbq2krajv280id0qns4i4u2au', '2026-09-17', '08:47:50', '2026-09-17 06:47:50'),
(2123, '::1', '/bahawalcollegeofhealth/events.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'abbq2krajv280id0qns4i4u2au', '2026-09-17', '08:47:52', '2026-09-17 06:47:52'),
(2124, '::1', '/bahawalcollegeofhealth/events.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'abbq2krajv280id0qns4i4u2au', '2026-09-17', '08:47:53', '2026-09-17 06:47:53'),
(2125, '::1', '/bahawalcollegeofhealth/news.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'abbq2krajv280id0qns4i4u2au', '2026-09-17', '08:47:55', '2026-09-17 06:47:55'),
(2126, '::1', '/bahawalcollegeofhealth/news.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'abbq2krajv280id0qns4i4u2au', '2026-09-17', '08:47:58', '2026-09-17 06:47:58'),
(2127, '::1', '/bahawalcollegeofhealth/news.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'abbq2krajv280id0qns4i4u2au', '2026-09-17', '08:48:00', '2026-09-17 06:48:00'),
(2128, '::1', '/bahawalcollegeofhealth/news.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'abbq2krajv280id0qns4i4u2au', '2026-09-17', '08:48:03', '2026-09-17 06:48:03'),
(2129, '::1', '/bahawalcollegeofhealth/notifications.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'abbq2krajv280id0qns4i4u2au', '2026-09-17', '08:48:06', '2026-09-17 06:48:06'),
(2130, '::1', '/bahawalcollegeofhealth/notifications.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'abbq2krajv280id0qns4i4u2au', '2026-09-17', '08:48:08', '2026-09-17 06:48:08'),
(2131, '::1', '/bahawalcollegeofhealth/notifications.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'abbq2krajv280id0qns4i4u2au', '2026-09-17', '08:48:10', '2026-09-17 06:48:10'),
(2132, '::1', '/bahawalcollegeofhealth/notifications.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'abbq2krajv280id0qns4i4u2au', '2026-09-17', '08:48:12', '2026-09-17 06:48:12'),
(2133, '::1', '/bahawalcollegeofhealth/alumni.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'abbq2krajv280id0qns4i4u2au', '2026-09-17', '08:48:15', '2026-09-17 06:48:15'),
(2134, '::1', '/bahawalcollegeofhealth/alumni.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'abbq2krajv280id0qns4i4u2au', '2026-09-17', '08:48:24', '2026-09-17 06:48:24'),
(2135, '::1', '/bahawalcollegeofhealth/alumni.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'abbq2krajv280id0qns4i4u2au', '2026-09-17', '08:48:29', '2026-09-17 06:48:29'),
(2136, '::1', '/bahawalcollegeofhealth/alumni.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'abbq2krajv280id0qns4i4u2au', '2026-09-17', '08:48:32', '2026-09-17 06:48:32'),
(2137, '::1', '/bahawalcollegeofhealth/gallery.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'abbq2krajv280id0qns4i4u2au', '2026-09-17', '08:48:34', '2026-09-17 06:48:34'),
(2138, '::1', '/bahawalcollegeofhealth/gallery.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'abbq2krajv280id0qns4i4u2au', '2026-09-17', '08:48:36', '2026-09-17 06:48:36'),
(2139, '::1', '/bahawalcollegeofhealth/gallery.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'abbq2krajv280id0qns4i4u2au', '2026-09-17', '08:48:38', '2026-09-17 06:48:38'),
(2140, '::1', '/bahawalcollegeofhealth/gallery.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'abbq2krajv280id0qns4i4u2au', '2026-09-17', '08:48:40', '2026-09-17 06:48:40'),
(2141, '::1', '/bahawalcollegeofhealth/contact.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'abbq2krajv280id0qns4i4u2au', '2026-09-17', '08:48:42', '2026-09-17 06:48:42'),
(2142, '::1', '/bahawalcollegeofhealth/contact.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'abbq2krajv280id0qns4i4u2au', '2026-09-17', '08:48:44', '2026-09-17 06:48:44'),
(2143, '::1', '/bahawalcollegeofhealth/contact.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'abbq2krajv280id0qns4i4u2au', '2026-09-17', '08:48:47', '2026-09-17 06:48:47'),
(2144, '::1', '/bahawalcollegeofhealth/contact.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'abbq2krajv280id0qns4i4u2au', '2026-09-17', '08:48:49', '2026-09-17 06:48:49'),
(2145, '::1', '/bahawalcollegeofhealth/campus-portal.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'abbq2krajv280id0qns4i4u2au', '2026-09-17', '08:48:54', '2026-09-17 06:48:54'),
(2146, '::1', '/bahawalcollegeofhealth/campus-portal.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'abbq2krajv280id0qns4i4u2au', '2026-09-17', '08:48:57', '2026-09-17 06:48:57'),
(2147, '::1', '/bahawalcollegeofhealth/campus-portal.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'abbq2krajv280id0qns4i4u2au', '2026-09-17', '08:48:59', '2026-09-17 06:48:59'),
(2148, '::1', '/bahawalcollegeofhealth/campus-portal.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'abbq2krajv280id0qns4i4u2au', '2026-09-17', '08:49:02', '2026-09-17 06:49:02'),
(2149, '::1', '/bahawalcollegeofhealth/fee-calculator.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'ktv9s8km9ak51jh4j03aekocah', '2026-09-17', '08:49:24', '2026-09-17 06:49:24'),
(2150, '::1', '/bahawalcollegeofhealth/fee-calculator.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '32mstiaikvtl6imu5tuehrj3c6', '2026-09-17', '08:51:04', '2026-09-17 06:51:04'),
(2151, '::1', '/bahawalcollegeofhealth/campus-portal.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'a0lf1f38cgtrnhfpgs7796squi', '2026-09-17', '08:51:37', '2026-09-17 06:51:37'),
(2152, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'n4k8ho39n0koujoee4o936ndld', '2026-09-17', '08:52:12', '2026-09-17 06:52:12'),
(2153, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'n4k8ho39n0koujoee4o936ndld', '2026-09-17', '08:52:17', '2026-09-17 06:52:17'),
(2154, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'n4k8ho39n0koujoee4o936ndld', '2026-09-17', '08:52:19', '2026-09-17 06:52:19'),
(2155, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'n4k8ho39n0koujoee4o936ndld', '2026-09-17', '08:52:23', '2026-09-17 06:52:23'),
(2156, '::1', '/bahawalcollegeofhealth/about.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'n4k8ho39n0koujoee4o936ndld', '2026-09-17', '08:52:26', '2026-09-17 06:52:26'),
(2157, '::1', '/bahawalcollegeofhealth/about.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'n4k8ho39n0koujoee4o936ndld', '2026-09-17', '08:52:29', '2026-09-17 06:52:29'),
(2158, '::1', '/bahawalcollegeofhealth/about.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'n4k8ho39n0koujoee4o936ndld', '2026-09-17', '08:52:34', '2026-09-17 06:52:34'),
(2159, '::1', '/bahawalcollegeofhealth/about.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'n4k8ho39n0koujoee4o936ndld', '2026-09-17', '08:52:36', '2026-09-17 06:52:36'),
(2160, '::1', '/bahawalcollegeofhealth/mission-vision.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'n4k8ho39n0koujoee4o936ndld', '2026-09-17', '08:52:39', '2026-09-17 06:52:39'),
(2161, '::1', '/bahawalcollegeofhealth/mission-vision.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'n4k8ho39n0koujoee4o936ndld', '2026-09-17', '08:52:40', '2026-09-17 06:52:40'),
(2162, '::1', '/bahawalcollegeofhealth/mission-vision.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'n4k8ho39n0koujoee4o936ndld', '2026-09-17', '08:52:42', '2026-09-17 06:52:42'),
(2163, '::1', '/bahawalcollegeofhealth/mission-vision.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'n4k8ho39n0koujoee4o936ndld', '2026-09-17', '08:52:44', '2026-09-17 06:52:44'),
(2164, '::1', '/bahawalcollegeofhealth/core-values.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'n4k8ho39n0koujoee4o936ndld', '2026-09-17', '08:52:46', '2026-09-17 06:52:46'),
(2165, '::1', '/bahawalcollegeofhealth/core-values.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'n4k8ho39n0koujoee4o936ndld', '2026-09-17', '08:52:47', '2026-09-17 06:52:47'),
(2166, '::1', '/bahawalcollegeofhealth/core-values.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'n4k8ho39n0koujoee4o936ndld', '2026-09-17', '08:52:50', '2026-09-17 06:52:50'),
(2167, '::1', '/bahawalcollegeofhealth/core-values.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'n4k8ho39n0koujoee4o936ndld', '2026-09-17', '08:52:55', '2026-09-17 06:52:55'),
(2168, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '6g67n24ncpck0o9eubgnvcn7b9', '2026-09-17', '08:52:56', '2026-09-17 06:52:56'),
(2169, '::1', '/bahawalcollegeofhealth/leadership.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'n4k8ho39n0koujoee4o936ndld', '2026-09-17', '08:53:01', '2026-09-17 06:53:01'),
(2170, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '6g67n24ncpck0o9eubgnvcn7b9', '2026-09-17', '08:53:02', '2026-09-17 06:53:02'),
(2171, '::1', '/bahawalcollegeofhealth/gallery.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '6g67n24ncpck0o9eubgnvcn7b9', '2026-09-17', '08:53:06', '2026-09-17 06:53:06'),
(2172, '::1', '/bahawalcollegeofhealth/admission.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '6g67n24ncpck0o9eubgnvcn7b9', '2026-09-17', '08:53:09', '2026-09-17 06:53:09'),
(2173, '::1', '/bahawalcollegeofhealth/courses.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '6g67n24ncpck0o9eubgnvcn7b9', '2026-09-17', '08:53:13', '2026-09-17 06:53:13'),
(2174, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'e81u6p8cpof2ik3k84uckkhem6', '2026-09-17', '10:01:52', '2026-09-17 08:01:52'),
(2175, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'e81u6p8cpof2ik3k84uckkhem6', '2026-09-17', '10:02:00', '2026-09-17 08:02:00'),
(2176, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'e81u6p8cpof2ik3k84uckkhem6', '2026-09-17', '10:02:03', '2026-09-17 08:02:03'),
(2177, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'e81u6p8cpof2ik3k84uckkhem6', '2026-09-17', '10:02:07', '2026-09-17 08:02:07'),
(2178, '::1', '/bahawalcollegeofhealth/about.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'e81u6p8cpof2ik3k84uckkhem6', '2026-09-17', '10:02:11', '2026-09-17 08:02:11'),
(2179, '::1', '/bahawalcollegeofhealth/about.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'e81u6p8cpof2ik3k84uckkhem6', '2026-09-17', '10:02:13', '2026-09-17 08:02:13'),
(2180, '::1', '/bahawalcollegeofhealth/about.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'e81u6p8cpof2ik3k84uckkhem6', '2026-09-17', '10:02:15', '2026-09-17 08:02:15'),
(2181, '::1', '/bahawalcollegeofhealth/about.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'e81u6p8cpof2ik3k84uckkhem6', '2026-09-17', '10:02:17', '2026-09-17 08:02:17'),
(2182, '::1', '/bahawalcollegeofhealth/mission-vision.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'e81u6p8cpof2ik3k84uckkhem6', '2026-09-17', '10:02:19', '2026-09-17 08:02:19'),
(2183, '::1', '/bahawalcollegeofhealth/mission-vision.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'e81u6p8cpof2ik3k84uckkhem6', '2026-09-17', '10:02:20', '2026-09-17 08:02:20'),
(2184, '::1', '/bahawalcollegeofhealth/mission-vision.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'e81u6p8cpof2ik3k84uckkhem6', '2026-09-17', '10:02:22', '2026-09-17 08:02:22'),
(2185, '::1', '/bahawalcollegeofhealth/mission-vision.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'e81u6p8cpof2ik3k84uckkhem6', '2026-09-17', '10:02:23', '2026-09-17 08:02:23'),
(2186, '::1', '/bahawalcollegeofhealth/core-values.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'e81u6p8cpof2ik3k84uckkhem6', '2026-09-17', '10:02:25', '2026-09-17 08:02:25'),
(2187, '::1', '/bahawalcollegeofhealth/core-values.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'e81u6p8cpof2ik3k84uckkhem6', '2026-09-17', '10:02:26', '2026-09-17 08:02:26'),
(2188, '::1', '/bahawalcollegeofhealth/core-values.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'e81u6p8cpof2ik3k84uckkhem6', '2026-09-17', '10:02:29', '2026-09-17 08:02:29'),
(2189, '::1', '/bahawalcollegeofhealth/core-values.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'e81u6p8cpof2ik3k84uckkhem6', '2026-09-17', '10:02:30', '2026-09-17 08:02:30'),
(2190, '::1', '/bahawalcollegeofhealth/leadership.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'e81u6p8cpof2ik3k84uckkhem6', '2026-09-17', '10:02:32', '2026-09-17 08:02:32'),
(2191, '::1', '/bahawalcollegeofhealth/leadership.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'e81u6p8cpof2ik3k84uckkhem6', '2026-09-17', '10:02:34', '2026-09-17 08:02:34'),
(2192, '::1', '/bahawalcollegeofhealth/leadership.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'e81u6p8cpof2ik3k84uckkhem6', '2026-09-17', '10:02:36', '2026-09-17 08:02:36'),
(2193, '::1', '/bahawalcollegeofhealth/leadership.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'e81u6p8cpof2ik3k84uckkhem6', '2026-09-17', '10:02:38', '2026-09-17 08:02:38'),
(2194, '::1', '/bahawalcollegeofhealth/chairman-message.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'e81u6p8cpof2ik3k84uckkhem6', '2026-09-17', '10:02:41', '2026-09-17 08:02:41'),
(2195, '::1', '/bahawalcollegeofhealth/chairman-message.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'e81u6p8cpof2ik3k84uckkhem6', '2026-09-17', '10:02:43', '2026-09-17 08:02:43'),
(2196, '::1', '/bahawalcollegeofhealth/chairman-message.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'e81u6p8cpof2ik3k84uckkhem6', '2026-09-17', '10:02:45', '2026-09-17 08:02:45'),
(2197, '::1', '/bahawalcollegeofhealth/chairman-message.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'e81u6p8cpof2ik3k84uckkhem6', '2026-09-17', '10:02:47', '2026-09-17 08:02:47'),
(2198, '::1', '/bahawalcollegeofhealth/principal-message.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'e81u6p8cpof2ik3k84uckkhem6', '2026-09-17', '10:02:49', '2026-09-17 08:02:49'),
(2199, '::1', '/bahawalcollegeofhealth/principal-message.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'e81u6p8cpof2ik3k84uckkhem6', '2026-09-17', '10:02:50', '2026-09-17 08:02:50'),
(2200, '::1', '/bahawalcollegeofhealth/principal-message.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'e81u6p8cpof2ik3k84uckkhem6', '2026-09-17', '10:02:52', '2026-09-17 08:02:52'),
(2201, '::1', '/bahawalcollegeofhealth/principal-message.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'e81u6p8cpof2ik3k84uckkhem6', '2026-09-17', '10:02:54', '2026-09-17 08:02:54'),
(2202, '::1', '/bahawalcollegeofhealth/accreditation.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'e81u6p8cpof2ik3k84uckkhem6', '2026-09-17', '10:02:56', '2026-09-17 08:02:56'),
(2203, '::1', '/bahawalcollegeofhealth/accreditation.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'e81u6p8cpof2ik3k84uckkhem6', '2026-09-17', '10:02:58', '2026-09-17 08:02:58'),
(2204, '::1', '/bahawalcollegeofhealth/accreditation.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'e81u6p8cpof2ik3k84uckkhem6', '2026-09-17', '10:03:01', '2026-09-17 08:03:01'),
(2205, '::1', '/bahawalcollegeofhealth/accreditation.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'e81u6p8cpof2ik3k84uckkhem6', '2026-09-17', '10:03:06', '2026-09-17 08:03:06'),
(2206, '::1', '/bahawalcollegeofhealth/foundation.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'e81u6p8cpof2ik3k84uckkhem6', '2026-09-17', '10:03:08', '2026-09-17 08:03:08'),
(2207, '::1', '/bahawalcollegeofhealth/foundation.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'e81u6p8cpof2ik3k84uckkhem6', '2026-09-17', '10:03:10', '2026-09-17 08:03:10'),
(2208, '::1', '/bahawalcollegeofhealth/foundation.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'e81u6p8cpof2ik3k84uckkhem6', '2026-09-17', '10:03:12', '2026-09-17 08:03:12'),
(2209, '::1', '/bahawalcollegeofhealth/foundation.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'e81u6p8cpof2ik3k84uckkhem6', '2026-09-17', '10:03:14', '2026-09-17 08:03:14'),
(2210, '::1', '/bahawalcollegeofhealth/our-projects.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'e81u6p8cpof2ik3k84uckkhem6', '2026-09-17', '10:03:16', '2026-09-17 08:03:16'),
(2211, '::1', '/bahawalcollegeofhealth/our-projects.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'e81u6p8cpof2ik3k84uckkhem6', '2026-09-17', '10:03:18', '2026-09-17 08:03:18'),
(2212, '::1', '/bahawalcollegeofhealth/our-projects.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'e81u6p8cpof2ik3k84uckkhem6', '2026-09-17', '10:03:20', '2026-09-17 08:03:20'),
(2213, '::1', '/bahawalcollegeofhealth/our-projects.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'e81u6p8cpof2ik3k84uckkhem6', '2026-09-17', '10:03:22', '2026-09-17 08:03:22'),
(2214, '::1', '/bahawalcollegeofhealth/our-networks.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'e81u6p8cpof2ik3k84uckkhem6', '2026-09-17', '10:03:24', '2026-09-17 08:03:24'),
(2215, '::1', '/bahawalcollegeofhealth/our-networks.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'e81u6p8cpof2ik3k84uckkhem6', '2026-09-17', '10:03:26', '2026-09-17 08:03:26'),
(2216, '::1', '/bahawalcollegeofhealth/our-networks.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'e81u6p8cpof2ik3k84uckkhem6', '2026-09-17', '10:03:28', '2026-09-17 08:03:28'),
(2217, '::1', '/bahawalcollegeofhealth/our-networks.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'e81u6p8cpof2ik3k84uckkhem6', '2026-09-17', '10:03:29', '2026-09-17 08:03:29'),
(2218, '::1', '/bahawalcollegeofhealth/courses.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'e81u6p8cpof2ik3k84uckkhem6', '2026-09-17', '10:03:31', '2026-09-17 08:03:31'),
(2219, '::1', '/bahawalcollegeofhealth/courses.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'e81u6p8cpof2ik3k84uckkhem6', '2026-09-17', '10:03:36', '2026-09-17 08:03:37'),
(2220, '::1', '/bahawalcollegeofhealth/courses.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'e81u6p8cpof2ik3k84uckkhem6', '2026-09-17', '10:03:39', '2026-09-17 08:03:39'),
(2221, '::1', '/bahawalcollegeofhealth/courses.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'e81u6p8cpof2ik3k84uckkhem6', '2026-09-17', '10:03:41', '2026-09-17 08:03:41'),
(2222, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'e81u6p8cpof2ik3k84uckkhem6', '2026-09-17', '10:03:44', '2026-09-17 08:03:44'),
(2223, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'e81u6p8cpof2ik3k84uckkhem6', '2026-09-17', '10:03:45', '2026-09-17 08:03:45'),
(2224, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'e81u6p8cpof2ik3k84uckkhem6', '2026-09-17', '10:03:47', '2026-09-17 08:03:47'),
(2225, '::1', '/bahawalcollegeofhealth/faculty.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'e81u6p8cpof2ik3k84uckkhem6', '2026-09-17', '10:03:49', '2026-09-17 08:03:49'),
(2226, '::1', '/bahawalcollegeofhealth/clinical-training.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'e81u6p8cpof2ik3k84uckkhem6', '2026-09-17', '10:03:51', '2026-09-17 08:03:51'),
(2227, '::1', '/bahawalcollegeofhealth/clinical-training.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'e81u6p8cpof2ik3k84uckkhem6', '2026-09-17', '10:03:53', '2026-09-17 08:03:53'),
(2228, '::1', '/bahawalcollegeofhealth/clinical-training.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'e81u6p8cpof2ik3k84uckkhem6', '2026-09-17', '10:03:54', '2026-09-17 08:03:54'),
(2229, '::1', '/bahawalcollegeofhealth/clinical-training.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'e81u6p8cpof2ik3k84uckkhem6', '2026-09-17', '10:03:56', '2026-09-17 08:03:56'),
(2230, '::1', '/bahawalcollegeofhealth/examination.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'e81u6p8cpof2ik3k84uckkhem6', '2026-09-17', '10:03:57', '2026-09-17 08:03:57'),
(2231, '::1', '/bahawalcollegeofhealth/examination.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'e81u6p8cpof2ik3k84uckkhem6', '2026-09-17', '10:03:59', '2026-09-17 08:03:59'),
(2232, '::1', '/bahawalcollegeofhealth/examination.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'e81u6p8cpof2ik3k84uckkhem6', '2026-09-17', '10:04:03', '2026-09-17 08:04:03'),
(2233, '::1', '/bahawalcollegeofhealth/examination.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'e81u6p8cpof2ik3k84uckkhem6', '2026-09-17', '10:04:05', '2026-09-17 08:04:05'),
(2234, '::1', '/bahawalcollegeofhealth/campuses.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'e81u6p8cpof2ik3k84uckkhem6', '2026-09-17', '10:04:07', '2026-09-17 08:04:07'),
(2235, '::1', '/bahawalcollegeofhealth/campuses.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'e81u6p8cpof2ik3k84uckkhem6', '2026-09-17', '10:04:09', '2026-09-17 08:04:09'),
(2236, '::1', '/bahawalcollegeofhealth/campuses.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'e81u6p8cpof2ik3k84uckkhem6', '2026-09-17', '10:04:11', '2026-09-17 08:04:11'),
(2237, '::1', '/bahawalcollegeofhealth/campuses.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'e81u6p8cpof2ik3k84uckkhem6', '2026-09-17', '10:04:13', '2026-09-17 08:04:13');
INSERT INTO `website_analytics` (`id`, `visitor_ip`, `page_url`, `page_title`, `referrer`, `user_agent`, `device_type`, `browser`, `operating_system`, `country`, `city`, `session_id`, `visit_date`, `visit_time`, `created_at`) VALUES
(2238, '::1', '/bahawalcollegeofhealth/admission.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'e81u6p8cpof2ik3k84uckkhem6', '2026-09-17', '10:04:15', '2026-09-17 08:04:15'),
(2239, '::1', '/bahawalcollegeofhealth/admission.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'e81u6p8cpof2ik3k84uckkhem6', '2026-09-17', '10:04:19', '2026-09-17 08:04:19'),
(2240, '::1', '/bahawalcollegeofhealth/admission.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'e81u6p8cpof2ik3k84uckkhem6', '2026-09-17', '10:04:22', '2026-09-17 08:04:22'),
(2241, '::1', '/bahawalcollegeofhealth/admission.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'e81u6p8cpof2ik3k84uckkhem6', '2026-09-17', '10:04:25', '2026-09-17 08:04:25'),
(2242, '::1', '/bahawalcollegeofhealth/scholarships.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'e81u6p8cpof2ik3k84uckkhem6', '2026-09-17', '10:04:26', '2026-09-17 08:04:26'),
(2243, '::1', '/bahawalcollegeofhealth/scholarships.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'e81u6p8cpof2ik3k84uckkhem6', '2026-09-17', '10:04:28', '2026-09-17 08:04:28'),
(2244, '::1', '/bahawalcollegeofhealth/scholarships.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'e81u6p8cpof2ik3k84uckkhem6', '2026-09-17', '10:04:29', '2026-09-17 08:04:29'),
(2245, '::1', '/bahawalcollegeofhealth/scholarships.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'e81u6p8cpof2ik3k84uckkhem6', '2026-09-17', '10:04:32', '2026-09-17 08:04:32'),
(2246, '::1', '/bahawalcollegeofhealth/fee-calculator.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'e81u6p8cpof2ik3k84uckkhem6', '2026-09-17', '10:04:34', '2026-09-17 08:04:34'),
(2247, '::1', '/bahawalcollegeofhealth/fee-calculator.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'e81u6p8cpof2ik3k84uckkhem6', '2026-09-17', '10:04:36', '2026-09-17 08:04:36'),
(2248, '::1', '/bahawalcollegeofhealth/fee-calculator.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'e81u6p8cpof2ik3k84uckkhem6', '2026-09-17', '10:04:37', '2026-09-17 08:04:37'),
(2249, '::1', '/bahawalcollegeofhealth/fee-calculator.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'e81u6p8cpof2ik3k84uckkhem6', '2026-09-17', '10:04:39', '2026-09-17 08:04:39'),
(2250, '::1', '/bahawalcollegeofhealth/eligibility-checker.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'e81u6p8cpof2ik3k84uckkhem6', '2026-09-17', '10:04:41', '2026-09-17 08:04:41'),
(2251, '::1', '/bahawalcollegeofhealth/eligibility-checker.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'e81u6p8cpof2ik3k84uckkhem6', '2026-09-17', '10:04:42', '2026-09-17 08:04:42'),
(2252, '::1', '/bahawalcollegeofhealth/eligibility-checker.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'e81u6p8cpof2ik3k84uckkhem6', '2026-09-17', '10:04:45', '2026-09-17 08:04:45'),
(2253, '::1', '/bahawalcollegeofhealth/eligibility-checker.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'e81u6p8cpof2ik3k84uckkhem6', '2026-09-17', '10:04:47', '2026-09-17 08:04:47'),
(2254, '::1', '/bahawalcollegeofhealth/downloads.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'e81u6p8cpof2ik3k84uckkhem6', '2026-09-17', '10:04:49', '2026-09-17 08:04:49'),
(2255, '::1', '/bahawalcollegeofhealth/downloads.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'e81u6p8cpof2ik3k84uckkhem6', '2026-09-17', '10:04:51', '2026-09-17 08:04:51'),
(2256, '::1', '/bahawalcollegeofhealth/downloads.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'e81u6p8cpof2ik3k84uckkhem6', '2026-09-17', '10:04:53', '2026-09-17 08:04:53'),
(2257, '::1', '/bahawalcollegeofhealth/downloads.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'e81u6p8cpof2ik3k84uckkhem6', '2026-09-17', '10:04:59', '2026-09-17 08:04:59'),
(2258, '::1', '/bahawalcollegeofhealth/activities.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'e81u6p8cpof2ik3k84uckkhem6', '2026-09-17', '10:05:01', '2026-09-17 08:05:01'),
(2259, '::1', '/bahawalcollegeofhealth/activities.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'e81u6p8cpof2ik3k84uckkhem6', '2026-09-17', '10:05:04', '2026-09-17 08:05:04'),
(2260, '::1', '/bahawalcollegeofhealth/activities.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'e81u6p8cpof2ik3k84uckkhem6', '2026-09-17', '10:05:09', '2026-09-17 08:05:09'),
(2261, '::1', '/bahawalcollegeofhealth/activities.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'e81u6p8cpof2ik3k84uckkhem6', '2026-09-17', '10:05:13', '2026-09-17 08:05:13'),
(2262, '::1', '/bahawalcollegeofhealth/events.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'e81u6p8cpof2ik3k84uckkhem6', '2026-09-17', '10:05:16', '2026-09-17 08:05:16'),
(2263, '::1', '/bahawalcollegeofhealth/events.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'e81u6p8cpof2ik3k84uckkhem6', '2026-09-17', '10:05:19', '2026-09-17 08:05:19'),
(2264, '::1', '/bahawalcollegeofhealth/events.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'e81u6p8cpof2ik3k84uckkhem6', '2026-09-17', '10:05:21', '2026-09-17 08:05:21'),
(2265, '::1', '/bahawalcollegeofhealth/events.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'e81u6p8cpof2ik3k84uckkhem6', '2026-09-17', '10:05:24', '2026-09-17 08:05:24'),
(2266, '::1', '/bahawalcollegeofhealth/news.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'e81u6p8cpof2ik3k84uckkhem6', '2026-09-17', '10:05:29', '2026-09-17 08:05:29'),
(2267, '::1', '/bahawalcollegeofhealth/news.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'e81u6p8cpof2ik3k84uckkhem6', '2026-09-17', '10:05:31', '2026-09-17 08:05:31'),
(2268, '::1', '/bahawalcollegeofhealth/news.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'e81u6p8cpof2ik3k84uckkhem6', '2026-09-17', '10:05:33', '2026-09-17 08:05:33'),
(2269, '::1', '/bahawalcollegeofhealth/news.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'e81u6p8cpof2ik3k84uckkhem6', '2026-09-17', '10:05:35', '2026-09-17 08:05:35'),
(2270, '::1', '/bahawalcollegeofhealth/notifications.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'e81u6p8cpof2ik3k84uckkhem6', '2026-09-17', '10:05:37', '2026-09-17 08:05:37'),
(2271, '::1', '/bahawalcollegeofhealth/notifications.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'e81u6p8cpof2ik3k84uckkhem6', '2026-09-17', '10:05:39', '2026-09-17 08:05:39'),
(2272, '::1', '/bahawalcollegeofhealth/notifications.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'e81u6p8cpof2ik3k84uckkhem6', '2026-09-17', '10:05:40', '2026-09-17 08:05:40'),
(2273, '::1', '/bahawalcollegeofhealth/notifications.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'e81u6p8cpof2ik3k84uckkhem6', '2026-09-17', '10:05:43', '2026-09-17 08:05:43'),
(2274, '::1', '/bahawalcollegeofhealth/alumni.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'e81u6p8cpof2ik3k84uckkhem6', '2026-09-17', '10:05:44', '2026-09-17 08:05:44'),
(2275, '::1', '/bahawalcollegeofhealth/alumni.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'e81u6p8cpof2ik3k84uckkhem6', '2026-09-17', '10:05:47', '2026-09-17 08:05:47'),
(2276, '::1', '/bahawalcollegeofhealth/alumni.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'e81u6p8cpof2ik3k84uckkhem6', '2026-09-17', '10:05:49', '2026-09-17 08:05:49'),
(2277, '::1', '/bahawalcollegeofhealth/alumni.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'e81u6p8cpof2ik3k84uckkhem6', '2026-09-17', '10:05:50', '2026-09-17 08:05:50'),
(2278, '::1', '/bahawalcollegeofhealth/gallery.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'e81u6p8cpof2ik3k84uckkhem6', '2026-09-17', '10:05:53', '2026-09-17 08:05:53'),
(2279, '::1', '/bahawalcollegeofhealth/gallery.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'e81u6p8cpof2ik3k84uckkhem6', '2026-09-17', '10:05:55', '2026-09-17 08:05:55'),
(2280, '::1', '/bahawalcollegeofhealth/gallery.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'e81u6p8cpof2ik3k84uckkhem6', '2026-09-17', '10:05:58', '2026-09-17 08:05:58'),
(2281, '::1', '/bahawalcollegeofhealth/gallery.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'e81u6p8cpof2ik3k84uckkhem6', '2026-09-17', '10:06:03', '2026-09-17 08:06:03'),
(2282, '::1', '/bahawalcollegeofhealth/contact.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'e81u6p8cpof2ik3k84uckkhem6', '2026-09-17', '10:06:06', '2026-09-17 08:06:06'),
(2283, '::1', '/bahawalcollegeofhealth/contact.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'e81u6p8cpof2ik3k84uckkhem6', '2026-09-17', '10:06:10', '2026-09-17 08:06:10'),
(2284, '::1', '/bahawalcollegeofhealth/contact.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'e81u6p8cpof2ik3k84uckkhem6', '2026-09-17', '10:06:13', '2026-09-17 08:06:13'),
(2285, '::1', '/bahawalcollegeofhealth/contact.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'e81u6p8cpof2ik3k84uckkhem6', '2026-09-17', '10:06:16', '2026-09-17 08:06:16'),
(2286, '::1', '/bahawalcollegeofhealth/campus-portal.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'e81u6p8cpof2ik3k84uckkhem6', '2026-09-17', '10:06:19', '2026-09-17 08:06:19'),
(2287, '::1', '/bahawalcollegeofhealth/campus-portal.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'e81u6p8cpof2ik3k84uckkhem6', '2026-09-17', '10:06:28', '2026-09-17 08:06:28'),
(2288, '::1', '/bahawalcollegeofhealth/campus-portal.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'e81u6p8cpof2ik3k84uckkhem6', '2026-09-17', '10:06:34', '2026-09-17 08:06:34'),
(2289, '::1', '/bahawalcollegeofhealth/campus-portal.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'e81u6p8cpof2ik3k84uckkhem6', '2026-09-17', '10:06:48', '2026-09-17 08:06:48'),
(2290, '127.0.0.1', '/bahawalcollegeofhealth/index.php', '', 'http://localhost/bahawalcollegeofhealth/faculty.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '688h0ui10atto936mlhea6vii2', '2026-09-17', '10:33:11', '2026-09-17 08:33:11'),
(2291, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456', 'Desktop', 'Unknown', 'Windows 10', NULL, NULL, 'me2t6n282rbihopo875t0v667e', '2026-09-17', '10:37:59', '2026-09-17 08:37:59'),
(2292, '::1', '/bahawalcollegeofhealth/alumni.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'lo4bo4q2gqo8ccbheo6h844vah', '2026-09-17', '10:43:58', '2026-09-17 08:43:58'),
(2293, '::1', '/bahawalcollegeofhealth/alumni.php', '', 'http://localhost/bahawalcollegeofhealth/alumni.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/153.0.8010.12 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'lo4bo4q2gqo8ccbheo6h844vah', '2026-09-17', '10:44:13', '2026-09-17 08:44:13'),
(2294, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456', 'Desktop', 'Unknown', 'Windows 10', NULL, NULL, '3kbekit2dnivnl40sgr4cn63uu', '2026-09-17', '10:45:13', '2026-09-17 08:45:13'),
(2295, '::1', '/bahawalcollegeofhealth/alumni.php', '', 'Direct', 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456', 'Desktop', 'Unknown', 'Windows 10', NULL, NULL, '3i4r8ipt4ltehamc86gioqpucc', '2026-09-17', '10:45:14', '2026-09-17 08:45:14'),
(2296, '::1', '/bahawalcollegeofhealth/admission.php', '', 'Direct', 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456', 'Desktop', 'Unknown', 'Windows 10', NULL, NULL, 'ao5ov9o5ncbvomd2nbj3ag27bm', '2026-09-17', '10:45:14', '2026-09-17 08:45:14'),
(2297, '::1', '/bahawalcollegeofhealth/about.php', '', 'Direct', 'Mozilla/5.0 (Windows NT; Windows NT 10.0; en-US) WindowsPowerShell/5.1.19041.6456', 'Desktop', 'Unknown', 'Windows 10', NULL, NULL, 'rfqtd73v6rijh0hgihql5pn18d', '2026-09-17', '10:45:14', '2026-09-17 08:45:14'),
(2298, '::1', '/bahawalcollegeofhealth/index.php', '', 'http://localhost/bahawalcollegeofhealth/faculty.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, '688h0ui10atto936mlhea6vii2', '2026-09-17', '11:30:24', '2026-09-17 09:30:24'),
(2299, '::1', '/bahawalcollegeofhealth/index.php', '', 'http://localhost/bahawalcollegeofhealth/gallery.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'jjd0b1l50mrb44m57fd471q456', '2026-09-17', '11:47:51', '2026-09-17 09:47:51'),
(2300, '::1', '/bahawalcollegeofhealth/index.php', '', 'http://localhost/bahawalcollegeofhealth/gallery.php', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'jjd0b1l50mrb44m57fd471q456', '2026-09-17', '11:48:06', '2026-09-17 09:48:06'),
(2301, '::1', '/bahawalcollegeofhealth/index.php', '', 'Direct', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'Desktop', 'Chrome', 'Windows 10', NULL, NULL, 'jjd0b1l50mrb44m57fd471q456', '2026-09-17', '11:48:12', '2026-09-17 09:48:12');

-- --------------------------------------------------------

--
-- Table structure for table `why_choose_us`
--

CREATE TABLE `why_choose_us` (
  `id` int(11) NOT NULL,
  `title` varchar(100) NOT NULL,
  `description` varchar(255) NOT NULL,
  `icon` varchar(50) DEFAULT 'fas fa-star' COMMENT 'Font Awesome class, e.g. fas fa-star',
  `color` varchar(20) DEFAULT '#0B7275' COMMENT 'Hex color for icon and accent bar',
  `display_order` int(11) DEFAULT 0,
  `status` enum('active','inactive') DEFAULT 'active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `why_choose_us`
--

INSERT INTO `why_choose_us` (`id`, `title`, `description`, `icon`, `color`, `display_order`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Expert Faculty', 'Highly qualified teachers dedicated to your success', 'fas fa-chalkboard-teacher', '#17165B', 1, 'active', '2026-08-18 09:27:11', '2026-09-16 11:42:19'),
(2, 'Modern Facilities', 'State-of-the-art classrooms & labs', 'fas fa-building', '#09A9D9', 2, 'active', '2026-08-18 09:27:11', '2026-09-16 11:42:19'),
(3, 'Small Classes', 'Personalized attention for every student', 'fas fa-users', '#0D1048', 3, 'active', '2026-08-18 09:27:11', '2026-09-16 11:42:19'),
(4, 'Quality Education', 'Board-aligned curriculum & standards', 'fas fa-certificate', '#18B9E8', 4, 'active', '2026-08-18 09:27:11', '2026-09-16 11:42:19'),
(5, 'Proven Results', 'Outstanding board exam track record', 'fas fa-chart-line', '#17165B', 5, 'active', '2026-08-18 09:27:11', '2026-09-16 11:42:19'),
(6, 'Affordable Fees', 'Scholarships & easy installments', 'fas fa-hand-holding-heart', '#09A9D9', 6, 'active', '2026-08-18 09:27:11', '2026-09-16 11:42:19');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `accreditations`
--
ALTER TABLE `accreditations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `active_users`
--
ALTER TABLE `active_users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_session` (`session_id`),
  ADD KEY `idx_last_activity` (`last_activity`);

--
-- Indexes for table `admin_users`
--
ALTER TABLE `admin_users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `admissions`
--
ALTER TABLE `admissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `application_number` (`application_number`);

--
-- Indexes for table `alumni`
--
ALTER TABLE `alumni`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `alumni_reviews`
--
ALTER TABLE `alumni_reviews`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `board_results`
--
ALTER TABLE `board_results`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `campuses`
--
ALTER TABLE `campuses`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `clinical_partners`
--
ALTER TABLE `clinical_partners`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `contacts`
--
ALTER TABLE `contacts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `contact_faqs`
--
ALTER TABLE `contact_faqs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `core_values`
--
ALTER TABLE `core_values`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `courses`
--
ALTER TABLE `courses`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `datesheet_details`
--
ALTER TABLE `datesheet_details`
  ADD PRIMARY KEY (`id`),
  ADD KEY `datesheet_id` (`datesheet_id`);

--
-- Indexes for table `dms_features`
--
ALTER TABLE `dms_features`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `downloads`
--
ALTER TABLE `downloads`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `eligibility_rules`
--
ALTER TABLE `eligibility_rules`
  ADD PRIMARY KEY (`id`),
  ADD KEY `course_id` (`course_id`);

--
-- Indexes for table `events`
--
ALTER TABLE `events`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `exams`
--
ALTER TABLE `exams`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `exam_datesheets`
--
ALTER TABLE `exam_datesheets`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `faculty`
--
ALTER TABLE `faculty`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `fee_structure`
--
ALTER TABLE `fee_structure`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `foundation_activities`
--
ALTER TABLE `foundation_activities`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `gallery`
--
ALTER TABLE `gallery`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `gallery_categories`
--
ALTER TABLE `gallery_categories`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slug` (`slug`);

--
-- Indexes for table `hero_carousel`
--
ALTER TABLE `hero_carousel`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `leadership`
--
ALTER TABLE `leadership`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `menu_items`
--
ALTER TABLE `menu_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `parent_id` (`parent_id`);

--
-- Indexes for table `merit_scholarship_tiers`
--
ALTER TABLE `merit_scholarship_tiers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `network_partners`
--
ALTER TABLE `network_partners`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `news`
--
ALTER TABLE `news`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `projects`
--
ALTER TABLE `projects`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `scholarships`
--
ALTER TABLE `scholarships`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `settings`
--
ALTER TABLE `settings`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `setting_key` (`setting_key`);

--
-- Indexes for table `students`
--
ALTER TABLE `students`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `registration_no` (`registration_no`);

--
-- Indexes for table `student_exams`
--
ALTER TABLE `student_exams`
  ADD PRIMARY KEY (`id`),
  ADD KEY `exam_id` (`exam_id`);

--
-- Indexes for table `student_societies`
--
ALTER TABLE `student_societies`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `themes`
--
ALTER TABLE `themes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `unique_visitors`
--
ALTER TABLE `unique_visitors`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_session` (`session_id`),
  ADD KEY `idx_visitor_ip` (`visitor_ip`),
  ADD KEY `idx_last_visit` (`last_visit`);

--
-- Indexes for table `website_analytics`
--
ALTER TABLE `website_analytics`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_visitor_ip` (`visitor_ip`),
  ADD KEY `idx_page_url` (`page_url`),
  ADD KEY `idx_visit_date` (`visit_date`),
  ADD KEY `idx_session_id` (`session_id`),
  ADD KEY `idx_created_at` (`created_at`);

--
-- Indexes for table `why_choose_us`
--
ALTER TABLE `why_choose_us`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `accreditations`
--
ALTER TABLE `accreditations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `active_users`
--
ALTER TABLE `active_users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1996;

--
-- AUTO_INCREMENT for table `admin_users`
--
ALTER TABLE `admin_users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `admissions`
--
ALTER TABLE `admissions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `alumni`
--
ALTER TABLE `alumni`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `alumni_reviews`
--
ALTER TABLE `alumni_reviews`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `board_results`
--
ALTER TABLE `board_results`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `campuses`
--
ALTER TABLE `campuses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `clinical_partners`
--
ALTER TABLE `clinical_partners`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `contacts`
--
ALTER TABLE `contacts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `contact_faqs`
--
ALTER TABLE `contact_faqs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `core_values`
--
ALTER TABLE `core_values`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `courses`
--
ALTER TABLE `courses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `datesheet_details`
--
ALTER TABLE `datesheet_details`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `dms_features`
--
ALTER TABLE `dms_features`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `downloads`
--
ALTER TABLE `downloads`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `eligibility_rules`
--
ALTER TABLE `eligibility_rules`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `events`
--
ALTER TABLE `events`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `exams`
--
ALTER TABLE `exams`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `exam_datesheets`
--
ALTER TABLE `exam_datesheets`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `faculty`
--
ALTER TABLE `faculty`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `fee_structure`
--
ALTER TABLE `fee_structure`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `foundation_activities`
--
ALTER TABLE `foundation_activities`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `gallery`
--
ALTER TABLE `gallery`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=83;

--
-- AUTO_INCREMENT for table `gallery_categories`
--
ALTER TABLE `gallery_categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `hero_carousel`
--
ALTER TABLE `hero_carousel`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `leadership`
--
ALTER TABLE `leadership`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `menu_items`
--
ALTER TABLE `menu_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=45;

--
-- AUTO_INCREMENT for table `merit_scholarship_tiers`
--
ALTER TABLE `merit_scholarship_tiers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `network_partners`
--
ALTER TABLE `network_partners`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `news`
--
ALTER TABLE `news`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `projects`
--
ALTER TABLE `projects`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `scholarships`
--
ALTER TABLE `scholarships`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `settings`
--
ALTER TABLE `settings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=106;

--
-- AUTO_INCREMENT for table `students`
--
ALTER TABLE `students`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `student_exams`
--
ALTER TABLE `student_exams`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `student_societies`
--
ALTER TABLE `student_societies`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `themes`
--
ALTER TABLE `themes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `unique_visitors`
--
ALTER TABLE `unique_visitors`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2008;

--
-- AUTO_INCREMENT for table `website_analytics`
--
ALTER TABLE `website_analytics`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2302;

--
-- AUTO_INCREMENT for table `why_choose_us`
--
ALTER TABLE `why_choose_us`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `datesheet_details`
--
ALTER TABLE `datesheet_details`
  ADD CONSTRAINT `datesheet_details_ibfk_1` FOREIGN KEY (`datesheet_id`) REFERENCES `exam_datesheets` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `student_exams`
--
ALTER TABLE `student_exams`
  ADD CONSTRAINT `student_exams_ibfk_1` FOREIGN KEY (`exam_id`) REFERENCES `exams` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
