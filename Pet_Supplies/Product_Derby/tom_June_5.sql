-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 06, 2024 at 06:33 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `tom`
--

-- --------------------------------------------------------

--
-- Table structure for table `cart`
--

CREATE TABLE `cart` (
  `cart_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `qty` int(11) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `cart`
--

INSERT INTO `cart` (`cart_id`, `product_id`, `qty`, `user_id`) VALUES
(162, 13, 4, 7);

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE `customer` (
  `cust_id` varchar(10) NOT NULL,
  `username` varchar(30) NOT NULL,
  `password` varchar(12) NOT NULL,
  `email` varchar(30) NOT NULL,
  `contact` varchar(12) NOT NULL,
  `address` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `customer`
--

INSERT INTO `customer` (`cust_id`, `username`, `password`, `email`, `contact`, `address`) VALUES
('C0001', 'chin', '1234', 'chin@gmail.com', '...', 'aaa.14400.kedah'),
('C0002', 'Alluka Zoldyck', '1234', 'allukazoldyck@gmail.com', '...', 'pick up'),
('C0003', 'Neferpitou', '1234', 'neferpitou@gmial.com', '...', 'haha.34250.perak'),
('C0004', 'Mrs. Katherine', '1234', 'katherine@gmail.com', '0142538259', '...'),
('C0005', 'KK', '1234', 'kk@gmail.com', '0123456789', 'abc 13100 Penang');

-- --------------------------------------------------------

--
-- Table structure for table `orderdetail`
--

CREATE TABLE `orderdetail` (
  `order_id` varchar(8) NOT NULL,
  `product_id` int(11) NOT NULL,
  `qty` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `orderdetail`
--

INSERT INTO `orderdetail` (`order_id`, `product_id`, `qty`) VALUES
('O158488', 1, 3),
('O177480', 12, 3),
('O185325', 4, 3),
('O185325', 13, 1),
('O189017', 11, 2),
('O189017', 14, 3),
('O189017', 17, 2),
('O201139', 2, 2),
('O214571', 2, 3),
('O271815', 3, 2),
('O284386', 3, 3),
('O289576', 4, 5),
('O290342', 1, 4),
('O290342', 4, 2),
('O296015', 1, 1),
('O318782', 12, 4),
('O320119', 2, 4),
('O320119', 12, 3),
('O320484', 1, 2),
('O320484', 2, 2),
('O348395', 2, 1),
('O354850', 4, 2),
('O400464', 1, 3),
('O404357', 1, 1),
('O421539', 1, 3),
('O421539', 9, 2),
('O424335', 2, 2),
('O424335', 4, 3),
('O428150', 4, 1),
('O428655', 3, 2),
('O436309', 9, 2),
('O450891', 2, 6),
('O450891', 4, 4),
('O459597', 1, 1),
('O473435', 12, 3),
('O485911', 11, 1),
('O489441', 2, 3),
('O492363', 9, 3),
('O492363', 12, 5),
('O497140', 11, 3),
('O532771', 17, 2),
('O568882', 3, 1),
('O569927', 13, 4),
('O570794', 9, 3),
('O579712', 12, 3),
('O599641', 9, 1),
('O601340', 2, 2),
('O601340', 11, 2),
('O636054', 2, 2),
('O640732', 2, 2),
('O640792', 3, 4),
('O642538', 12, 3),
('O658921', 9, 6),
('O666168', 11, 1),
('O682234', 1, 2),
('O682234', 13, 5),
('O682880', 9, 2),
('O695915', 1, 1),
('O727189', 12, 2),
('O753883', 1, 4),
('O753883', 2, 1),
('O779036', 11, 3),
('O783018', 2, 4),
('O783018', 9, 3),
('O790524', 1, 5),
('O802854', 2, 2),
('O802854', 4, 4),
('O828236', 3, 2),
('O833372', 12, 3),
('O833372', 17, 2),
('O843147', 3, 1),
('O843147', 12, 4),
('O852726', 3, 2),
('O852726', 4, 1),
('O854040', 2, 2),
('O869512', 4, 2),
('O869512', 17, 1),
('O872769', 2, 2),
('O872769', 13, 3),
('O875463', 3, 1),
('O886679', 3, 3),
('O899570', 1, 3),
('O900688', 1, 3),
('O916497', 12, 3),
('O916497', 14, 2),
('O949459', 11, 3),
('O951660', 1, 4),
('O956324', 3, 1),
('O957170', 3, 1),
('O960930', 1, 3),
('O960930', 2, 4),
('O965944', 17, 4);

-- --------------------------------------------------------

--
-- Table structure for table `order_`
--

CREATE TABLE `order_` (
  `order_id` varchar(8) NOT NULL,
  `qty` int(11) NOT NULL,
  `amount` decimal(6,2) NOT NULL,
  `createDate` datetime NOT NULL,
  `method` varchar(15) DEFAULT NULL,
  `status` varchar(10) DEFAULT NULL,
  `packing` int(11) DEFAULT NULL,
  `shipping` int(11) DEFAULT NULL,
  `delivered` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `order_`
--

INSERT INTO `order_` (`order_id`, `qty`, `amount`, `createDate`, `method`, `status`, `packing`, `shipping`, `delivered`, `user_id`) VALUES
('O158488', 3, 621.30, '2024-05-01 00:00:00', 'Pickup', '', 1, NULL, NULL, 4),
('O177480', 3, 39.55, '2024-05-04 17:45:19', 'Delivery', 'Paid', 1, 1, 0, 3),
('O185325', 4, 115.55, '2024-05-06 10:34:37', 'Delivery', 'Pending', 0, 0, 0, 2),
('O189017', 7, 890.50, '2024-05-01 00:00:00', 'Delivery', 'Paid', 1, 1, 0, 4),
('O201139', 2, 414.20, '2024-05-01 00:00:00', NULL, '', 1, NULL, NULL, 4),
('O214571', 3, 683.43, '2024-05-01 00:00:00', 'Pickup', 'Paid', 1, 1, 0, 4),
('O271815', 2, 195.51, '2024-05-04 11:40:28', 'Delivery', 'Paid', 1, 1, 0, 1),
('O284386', 3, 284.73, '2024-05-01 00:00:00', 'Delivery', 'Cancel', 0, 0, 0, 4),
('O289576', 5, 82.71, '2024-05-05 11:25:01', 'Delivery', 'Pending', 1, 0, 0, 1),
('O290342', 6, 860.52, '2024-05-01 00:00:00', '', '', 1, NULL, NULL, 4),
('O296015', 1, 217.45, '2024-05-04 12:22:14', 'Delivery', 'Paid', 1, 1, 0, 1),
('O318782', 4, 52.74, '2024-05-02 00:00:00', 'Delivery', 'Pending', 1, NULL, NULL, 4),
('O320119', 7, 953.48, '2024-05-02 13:52:22', 'Delivery', 'Pending', 1, NULL, NULL, 4),
('O320484', 4, 911.24, '2024-05-06 01:42:05', 'Delivery', 'Pending', 0, 0, 0, 1),
('O348395', 1, 217.45, '2024-05-06 10:56:48', 'Delivery', 'Pending', 0, 0, 0, 1),
('O354850', 2, 32.12, '2024-04-21 00:00:00', '', '', 1, NULL, NULL, 4),
('O400464', 3, 683.43, '2024-05-01 00:00:00', 'Delivery', 'Paid', 1, 1, 0, 4),
('O404357', 1, 217.45, '2024-05-05 09:16:03', 'Delivery', 'Pending', 1, 0, 0, 1),
('O421539', 5, 797.06, '2024-04-21 00:00:00', '', '', 1, NULL, NULL, 4),
('O424335', 5, 485.50, '2024-05-04 09:22:24', 'Delivery', 'Paid', 1, 1, 0, 1),
('O428150', 1, 16.54, '2024-05-06 10:58:54', 'Pickup', 'Pending', 0, 0, 0, 2),
('O428655', 2, 195.51, '2024-05-03 17:29:29', 'Pickup', 'Paid', 1, 1, 0, 4),
('O436309', 2, 181.03, '2024-05-06 10:37:02', 'Pickup', 'Pending', 0, 0, 0, 2),
('O450891', 10, 1437.52, '2024-05-03 19:03:40', 'Pickup', 'Pending', 1, NULL, NULL, 1),
('O459597', 1, 217.45, '2024-05-04 12:00:29', 'Delivery', 'Paid', 1, 1, 0, 1),
('O473435', 3, 39.55, '2024-05-03 17:34:07', 'Delivery', 'Paid', 1, 1, 0, 4),
('O485911', 1, 88.35, '2024-05-01 00:00:00', 'Delivery', '', 1, NULL, NULL, 4),
('O489441', 3, 683.43, '2024-05-04 18:32:44', 'Delivery', 'Pending', 1, 0, 0, 3),
('O492363', 8, 344.02, '2024-05-01 00:00:00', 'Pickup', 'Paid', 1, 1, 0, 4),
('O497140', 3, 278.30, '2024-05-02 00:00:00', 'Pickup', 'Paid', 1, 1, 0, 4),
('O532771', 2, 660.00, '2024-05-06 10:55:04', 'Delivery', 'Pending', 0, 0, 0, 1),
('O568882', 1, 97.76, '2024-05-05 10:24:28', 'Delivery', 'Pending', 1, 0, 0, 1),
('O569927', 4, 268.80, '2024-05-02 00:30:59', 'Pickup', 'Pending', 1, NULL, NULL, 4),
('O570794', 3, 276.82, '2024-05-05 10:02:16', 'Delivery', 'Pending', 1, 0, 0, 3),
('O579712', 3, 39.55, '2024-05-02 00:00:00', 'Delivery', 'Paid', 1, 1, 0, 4),
('O599641', 1, 90.52, '2024-05-05 09:20:49', 'Delivery', 'Pending', 1, 0, 0, 3),
('O601340', 4, 649.99, '2024-05-02 00:00:00', 'Delivery', 'Paid', 1, 1, 0, 4),
('O636054', 2, 434.91, '2024-05-04 12:39:45', 'Delivery', 'Paid', 1, 1, 0, 1),
('O640732', 2, 414.20, '2024-04-25 00:00:00', '', '', 1, NULL, NULL, 4),
('O640792', 4, 398.62, '2024-05-02 00:00:00', 'Pickup', 'Paid', 1, 1, 0, 4),
('O642538', 3, 39.55, '2024-05-02 00:00:00', 'Delivery', 'Pending', 1, NULL, NULL, 4),
('O658921', 6, 580.01, '2024-05-01 00:00:00', 'Pickup', 'Paid', 1, 1, 0, 4),
('O666168', 1, 91.00, '2024-05-04 19:40:33', 'Delivery', 'Pending', 1, 0, 0, 3),
('O682234', 7, 734.20, '2024-05-01 00:00:00', 'Pickup', 'Paid', 1, 1, 0, 4),
('O682880', 2, 181.03, '2024-05-04 11:48:43', 'Delivery', 'Paid', 1, 1, 0, 1),
('O695915', 1, 217.45, '2024-05-04 11:53:30', 'Delivery', 'Paid', 1, 1, 0, 1),
('O727189', 2, 25.60, '2024-05-01 00:00:00', 'Delivery', 'Paid', 1, 1, 0, 4),
('O753883', 5, 1035.50, '2024-04-23 00:00:00', 'Delivery', '', 1, NULL, NULL, 4),
('O779036', 3, 278.30, '2024-05-05 11:37:56', 'Delivery', 'Pending', 1, 1, 0, 1),
('O783018', 7, 2006.38, '2024-05-03 19:42:36', 'Delivery', 'Paid', 1, 1, 0, 3),
('O790524', 5, 1139.05, '2024-05-05 11:35:39', 'Delivery', 'Cancel', 0, 0, 0, 1),
('O802854', 6, 502.36, '2024-05-06 10:21:26', 'Delivery', 'Pending', 0, 0, 0, 2),
('O828236', 2, 195.51, '2024-05-03 17:27:54', 'Pickup', 'Paid', 1, 1, 0, 4),
('O833372', 5, 812.24, '2024-05-03 18:05:30', 'Delivery', 'Pending', 1, NULL, NULL, 4),
('O843147', 5, 146.11, '2024-04-21 00:00:00', '', '', 1, NULL, NULL, 4),
('O852726', 3, 216.17, '2024-05-04 16:51:19', 'Delivery', 'Paid', 1, 1, 0, 3),
('O854040', 2, 434.91, '2024-05-05 09:02:30', 'Delivery', 'Pending', 1, 0, 0, 1),
('O869512', 3, 348.73, '2024-05-06 10:41:08', 'Pickup', 'Cancel', 0, 0, 0, 2),
('O872769', 5, 666.82, '2024-05-06 11:24:37', 'Pickup', 'Pending', 0, 0, 0, 2),
('O875463', 1, 97.76, '2024-05-04 11:49:37', 'Pickup', 'Paid', 1, 1, 0, 1),
('O886679', 3, 298.97, '2024-05-03 17:37:07', 'Pickup', 'Paid', 1, 1, 0, 4),
('O899570', 3, 683.43, '2024-05-02 13:33:09', 'Pickup', 'Pending', 1, NULL, NULL, 4),
('O900688', 3, 683.43, '2024-05-02 13:56:23', 'Delivery', 'Paid', 1, 1, 0, 4),
('O916497', 5, 47.60, '2024-04-22 00:00:00', '', '', 1, NULL, NULL, 4),
('O949459', 3, 278.30, '2024-05-02 13:55:49', 'Delivery', 'Paid', 1, 1, 0, 4),
('O951660', 4, 828.40, '2024-04-22 00:00:00', '', '', 1, NULL, NULL, 4),
('O956324', 1, 97.76, '2024-05-06 11:56:00', 'Pickup', 'Pending', 0, 0, 0, 1),
('O957170', 1, 97.76, '2024-05-03 17:38:41', 'Delivery', 'Paid', 1, 1, 0, 4),
('O960930', 7, 1594.67, '2024-05-05 11:36:14', 'Delivery', 'Pending', 1, 1, 1, 1),
('O965944', 4, 1540.00, '2024-05-03 18:12:56', 'Delivery', 'Paid', 1, 1, 0, 4);

-- --------------------------------------------------------

--
-- Table structure for table `payment`
--

CREATE TABLE `payment` (
  `payment_id` int(11) NOT NULL,
  `type` varchar(10) NOT NULL,
  `discount` decimal(6,2) NOT NULL,
  `order_id` varchar(8) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `pet`
--

CREATE TABLE `pet` (
  `pet_id` varchar(10) NOT NULL,
  `animal` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pet`
--

INSERT INTO `pet` (`pet_id`, `animal`) VALUES
('C', 'Cat'),
('D', 'Dog'),
('S', 'Small Animals');

-- --------------------------------------------------------

--
-- Table structure for table `product`
--

CREATE TABLE `product` (
  `product_id` int(11) NOT NULL,
  `type` varchar(30) NOT NULL,
  `name` varchar(70) NOT NULL,
  `qty` int(11) NOT NULL,
  `price` decimal(6,2) NOT NULL,
  `image` varchar(50) DEFAULT NULL,
  `description` varchar(3000) DEFAULT NULL,
  `store` varchar(30) DEFAULT NULL,
  `pet_id` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `product`
--

INSERT INTO `product` (`product_id`, `type`, `name`, `qty`, `price`, `image`, `description`, `store`, `pet_id`) VALUES
(1, 'Food', 'IAMS Cat Dry Food Adult Tuna&Salmon 8kg', 85, 207.10, 'images/cat1.png', 'Key benefits in the recipes: Strong muscles: Real chicken as the 1st ingredient helps maintain strong muscles. Healthy heart: Essential nutrients, including calcium & potassium, help nourish a healthy heart. Healthy digestion: Unique fiber blend with prebiotics & beet pulp support your cat\'s ability to absorb nutrients. Healthy teeth: Crunchy kibble helps reduce plaque build-up. Healthy skin & coat: Optimal Omega 6:3 ratio for a soft & shiny coat. <br><br> Crude Protein (MIN) 32.0%<br><br> Crude Fat (MIN)<br><br> 15.0%<br><br> Crude Fiber (MAX) 3.0%<br><br> Moisture (MAX) 10.0%<br><br> Calcium (MIN) 0.8%<br><br> Potassium (MIN) 0.7%<br><br> Taurine (MIN) 0.15%<br><br> L-Carnitine(MIN) 80 mg/kg*<br><br> Omega-6 Fatty Acids (MIN) 3.0%*<br><br> Omega-3 Fatty Acids, minimum 0.30%*', 'On Stock', 'C'),
(2, 'Food', 'IAMS Cat Dry Food Adult Indoor Weight & Hairball', 84, 207.10, 'images/cat2.png', 'Key benefits in the recipes: Strong muscles: Real chicken as the 1st ingredient helps maintain strong muscles. Healthy heart: Essential nutrients, including calcium & potassium, help nourish a healthy heart. Healthy digestion: Unique fiber blend with prebiotics & beet pulp support your cat\'s ability to absorb nutrients. Healthy teeth: Crunchy kibble helps reduce plaque build-up. Healthy skin & coat: Optimal Omega 6:3 ratio for a soft & shiny coat. <br><br> Crude Protein (MIN) 32.0%<br><br> Crude Fat (MIN)<br><br> 15.0%<br><br> Crude Fiber (MAX) 3.0%<br><br> Moisture (MAX) 10.0%<br><br> Calcium (MIN) 0.8%<br><br> Potassium (MIN) 0.7%<br><br> Taurine (MIN) 0.15%<br><br> L-Carnitine(MIN) 80 mg/kg*<br><br> Omega-6 Fatty Acids (MIN) 3.0%*<br><br> Omega-3 Fatty Acids, minimum 0.30%*', 'Out of Stock', 'C'),
(3, 'Food', 'PURINA ONE - Urinary Care Chicken 2.7kg', 94, 94.91, 'images/cat3.png', 'Features: <br><br> ● Urinary care with omega-3 fatty acids to help support natural anti- inflammatory processes. <br><br> ● Promotes kidney health supported with formulation rich in antioxidants. <br><br> ● Helps maintain urinary tract health supported by balance minerals to help control urine PH. <br><br> ● Made with real chicken as #1 ingredient. <br><br> PURINA ONE® Dry Cat Food is specially formulated to provide your cat Visible Health for Life. Expertly combined with high quality ingredients to deliver a balanced nutrition & a delicious taste that your cat will surely love, you can witness 6 Signs of Visible Health in your cat with differences seen as early as 3 weeks.Now with the all-new IMMUNE DEFENCE PLUS+, PURINA ONE® Urinary Care is specially formulated with beta glucans, vitamin C & E and omega 3 & 6 fatty acids. Working in parallel, this blend helps support first line immune defence to help maintain the visible health of your cat from within. PURINA ONE® Urinary Care is made with real chicken as it\'s first ingredient and is rich in antioxidants and contains balanced minerals to help promote kidney health and control urinary pH. Take the 3-Week Challenge today to see the visible health diffferences in your cat!', 'On Stock', 'C'),
(4, 'Food', 'Whiskas - Cat Dry Food - Senior Mackerel 1.1kg', 85, 16.06, 'images/cat4.png', 'At 7 years old, your cats may not look or act much differently, but their nutritional needs have changed. For example, their digestive system is not as strong as it used to be, so their ability to absorb nutrients weaken. Help them transition to WHISKAS Adult 7+, specially formulated to postpone the effects of old age. <br><br> ● Food that is complete and balanced, with 41 essential nutrients. <br><br> ● Contains antioxidants (vitamin E and selenium) for a healthy immune system. <br><br> ● Contains fibre to ease digestion and promote bowel health. <br><br> ● Enriched with calcium, phosphorus and vitamin D for healthy bones. <br><br> Both WHISKAS dry and wet food are complete and balanced for your cat’s nutritional needs. However for maximum goodness, we encourage you tom provide both to your cat. Wet food contains water to ensure healthy urinary tracts, and has fewer calories. This is especially important for less active cats to prevent unhealthy weight gain. The unique kibble shape of WHISKAS dry food helps to clean teeth and gums, ensuring cat’s oral health. Your cat will surely adore the variety in texture and flavours that you provide to her.', 'On Stock', 'C'),
(9, 'Food', 'ROYAL CANIN Bengal Adult Cat Dry Food 2kg', 93, 87.88, 'images/cat5.png', 'A major advance In the arena of feline nutrition, Royal Canin has always taken into account the parameters which differentiate cats: age, lifestyle, sensitivities… For the past 10 years, Royal Canin has added a new dimension to this vision of excellence by developing a range exclusively dedicated to pure breed cats.Persian, Siamese, Maine Coon,British Shorthair…These are all unique cats and each one deserves a unique food. Thanks to its knowledge and to its close and active partnership with a network of breeders, Royal Canin’s Research & Development has launched tailored foods that are specifically adapted to the characteristics of each breed. <br><br> • ATHLETIC CONDITION <br><br> Full of energy, a healthy Bengal is lively, active, well-muscled and has a sleek appearance that depicts its athleticism. ATHLETIC CONDITION An adapted ratio of a high level of protein (40%) and adapted fat content (18%) to contribute to maintaining muscle mass. <br><br> • HEALTHY GLOSSY COAT <br><br> A defining feature is the Bengal’s distinctive coat with striking patterns and a uniquely soft and silky feel. HEALTHY GLOSSY COAT Specific amino acids, vitamins, Omega 3 and Omega 6 fatty acids to help maintain a healthy skin and shiny coat. <br><br> • URINARY HEALTH <br><br> Formulated with a balance of minerals to help maintain the health of an adult cat’s urinary system. <br><br> • THE “SMALL LEOPARD” <br><br> Striking markings with a look of the wild Sleek and very muscular body Pronounced whisker pads.', 'On Stock', 'C'),
(11, 'Food', 'Pedigree - Chicken & Vegetable 10kg', 92, 88.35, 'images/dog1.png', '• PEDIGREE dog food is made with quality ingredients so your dog will get a COMPLETE AND BALANCED NUTRITION while enjoying his meal <br><br> • This pet dog food is made with a unique blend of Linoleic Acid and Zinc that provides your dog HEALTHY SKIN, LUSTROUS COAT in 6 weeks <br><br> • PEDIGREE dog foods are made with high-quality protein that contains meat and cereal sources, which will help build STRONG MUSCLES for your dog <br><br> • The ingredients in this beef dog food have been scientifically formulated to promote GOOD DIGESTIVE HEALTH, with dietary fiber from vegetables and cereals <br><br> • With this PEDIGREE dog food, you can be sure that your adult dog is getting calcium and phosphorus for STRONG BONES AND TEETH <br><br> • PEDIGREE adult dog food is SUPPORTED BY WALTHAM, the global pet nutrition institute <br><br> PEDIGREE dry dog food for adult dogs provides your dog with a healthy and complete meal packed full of proteins from beef and vitamins from vegetables.', 'Out of Stock', 'D'),
(12, 'Food', 'Pedigree Dentastix Dog Dental Care (120g)\r\n', 95, 12.80, 'images/dog2.png', 'PRODUCT DESCRIPTION <br><br> PEDIGREE® DentaStix®daily chews with TRIPLE ACTION are scientifically proven to: <br><br> - Reduces tartar build-up <br><br> - Cleans hard to reach teeth <br><br> - Supports gum health', 'Out of Stock', 'D'),
(13, 'Food', 'GREENIES - Large Dental Chew 120Z (340g)', 91, 64.00, 'images/dog3.png', 'Features: <br><br> Greenies Dental Treats are mouth-wowing chews that your dog can\'t wait to have! Each chew features a delightfully chewy texture that fights plaque and tartar, made with highly soluble ingredients that are easy to digest. <br><br> They are incredibly tasty and nutritious too! <br><br> - Large chews for dogs between 22 to 45kg <br><br> - Cleans gums and freshens breath <br><br> - Easily digestible <br><br> - Enriched with vitamins, minerals and nutrients. <br><br> Ingredients: <br><br> Wheat Flour, Wheat Gluten, Glycerin, Gelatin, Oat Fiber, Water, Lecithin, Natural Poultry Flavor, Minerals (Di-Calcium Phosphate, Potassium Chloride, Calcium Carbonate, Magnesium Amino Acid Chelate, Zinc Amino Acid Chelate, Iron Amino Acid Chelate, Copper Amino Acid Chelate, Manganese Amino Acid Chelate, Selenium, Potassium Iodide), Dried Apple Pomace, Choline Chloride, Fruit Juice Color, Vitamins (Dl-Alpha Tocopherol Acetate (Source of Vitamin E), Vitamin B12 Supplement, D-Calcium Pantothenate (Vitamin B5), Niacin Supplement, Vitamin A Supplement, Riboflavin Supplement (Vitamin B2), Vitamin D3 Supplement, Biotin, Pyridoxine Hydrochloride (Vitamin B6), Thiamine Mononitrate (Vitamin B1), Folic Acid), Turmeric Color.', 'On Stock', 'D'),
(14, 'Food', 'CESAR - Baked Chicken with Thyme (100g)', 95, 4.60, 'images/dog4.png', '- Prepared using Premium quality ingredients with no added preservatives <br><br> - High quality protein for easy digestion <br><br> - High moisture content helps support a Healthy urinary tract</body> <br><br>', 'On Stock', 'D'),
(17, 'Toys', 'FCN', 92, 300.00, 'images/Screenshot 2024-04-23 074456.png', 'Morning', 'Out of Stock', 'S');

-- --------------------------------------------------------

--
-- Table structure for table `rating`
--

CREATE TABLE `rating` (
  `rating_id` int(11) NOT NULL,
  `comment` varchar(50) DEFAULT NULL,
  `product_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `staff`
--

CREATE TABLE `staff` (
  `staff_id` varchar(10) NOT NULL,
  `username` varchar(30) NOT NULL,
  `password` varchar(12) NOT NULL,
  `email` varchar(30) NOT NULL,
  `contact` varchar(12) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `staff`
--

INSERT INTO `staff` (`staff_id`, `username`, `password`, `email`, `contact`) VALUES
('M0001', 'Mr Manager', '1234', 'manager@gmail.com', '...'),
('S1001', 'Mr Staff', '1234', 'staff@gmail.com', '...');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `user_id` int(11) NOT NULL,
  `position` varchar(15) NOT NULL,
  `staff_id` varchar(10) DEFAULT NULL,
  `cust_id` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`user_id`, `position`, `staff_id`, `cust_id`) VALUES
(1, 'customer', NULL, 'C0001'),
(2, 'customer', NULL, 'C0002'),
(3, 'customer', NULL, 'C0003'),
(4, 'customer', NULL, 'C0004'),
(5, 'staff', 'S1001', NULL),
(6, 'manager', 'M0001', NULL),
(7, 'customer', NULL, 'C0005');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cart`
--
ALTER TABLE `cart`
  ADD PRIMARY KEY (`cart_id`,`product_id`),
  ADD KEY `product_id` (`product_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`cust_id`);

--
-- Indexes for table `orderdetail`
--
ALTER TABLE `orderdetail`
  ADD PRIMARY KEY (`order_id`,`product_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `order_`
--
ALTER TABLE `order_`
  ADD PRIMARY KEY (`order_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `payment`
--
ALTER TABLE `payment`
  ADD PRIMARY KEY (`payment_id`),
  ADD KEY `order_id` (`order_id`);

--
-- Indexes for table `pet`
--
ALTER TABLE `pet`
  ADD PRIMARY KEY (`pet_id`);

--
-- Indexes for table `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`product_id`),
  ADD KEY `pet_id` (`pet_id`);

--
-- Indexes for table `rating`
--
ALTER TABLE `rating`
  ADD PRIMARY KEY (`rating_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `staff`
--
ALTER TABLE `staff`
  ADD PRIMARY KEY (`staff_id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`user_id`),
  ADD KEY `staff_id` (`staff_id`),
  ADD KEY `cust_id` (`cust_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `cart`
--
ALTER TABLE `cart`
  MODIFY `cart_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=210;

--
-- AUTO_INCREMENT for table `payment`
--
ALTER TABLE `payment`
  MODIFY `payment_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `product`
--
ALTER TABLE `product`
  MODIFY `product_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=52;

--
-- AUTO_INCREMENT for table `rating`
--
ALTER TABLE `rating`
  MODIFY `rating_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `cart`
--
ALTER TABLE `cart`
  ADD CONSTRAINT `cart_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`),
  ADD CONSTRAINT `cart_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`);

--
-- Constraints for table `orderdetail`
--
ALTER TABLE `orderdetail`
  ADD CONSTRAINT `orderdetail_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `order_` (`order_id`),
  ADD CONSTRAINT `orderdetail_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`);

--
-- Constraints for table `order_`
--
ALTER TABLE `order_`
  ADD CONSTRAINT `order__ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`);

--
-- Constraints for table `payment`
--
ALTER TABLE `payment`
  ADD CONSTRAINT `payment_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `order_` (`order_id`);

--
-- Constraints for table `product`
--
ALTER TABLE `product`
  ADD CONSTRAINT `product_ibfk_1` FOREIGN KEY (`pet_id`) REFERENCES `pet` (`pet_id`);

--
-- Constraints for table `rating`
--
ALTER TABLE `rating`
  ADD CONSTRAINT `rating_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`);

--
-- Constraints for table `user`
--
ALTER TABLE `user`
  ADD CONSTRAINT `user_ibfk_1` FOREIGN KEY (`staff_id`) REFERENCES `staff` (`staff_id`),
  ADD CONSTRAINT `user_ibfk_2` FOREIGN KEY (`cust_id`) REFERENCES `customer` (`cust_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
