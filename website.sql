/*
SQLyog Community v12.5.1 (64 bit)
MySQL - 5.7.21-0ubuntu0.16.04.1 : Database - website
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`website` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `website`;

/*Table structure for table `accounts` */

DROP TABLE IF EXISTS `accounts`;

CREATE TABLE `accounts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(64) DEFAULT NULL,
  `pass_hash` varchar(255) DEFAULT NULL,
  `email` varchar(256) DEFAULT NULL,
  `rank` int(10) DEFAULT '1',
  `register_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `last_active` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

/*Data for the table `accounts` */

insert  into `accounts`(`id`,`username`,`pass_hash`,`email`,`rank`,`register_date`,`last_active`) values 
(4,'helvete','$2a$10$ZaVvgXObeeMH6JuT4nDmjOvgJLs7eq2DrZ6yPr7ICrXg6iWJbe.3.','fan@också.com',1,'2018-03-16 13:34:25','2018-03-16 13:34:25'),
(5,'bruh','$2a$10$uWYs/1NDix9ZytuDQNh5c.haN9qq7fnj1lM1oGrQUIyXUz.09qf92','bruh@bruh.bruh',1,'2018-03-16 16:53:52','2018-03-16 16:53:52'),
(6,'fem','$2a$10$zh1jDPI3AxVI22RkAEJGHemgOrpHl1C/Wv0q4WImLZXPPCtbYbeFC','fem@fem.fem',1,'2018-03-19 09:23:57','2018-03-19 09:23:57'),
(7,'t','$2a$10$OGdhyp6nmlNKLqh0/dQ5G.FMj.AllvbjAQgoC1UQkaoIkicLxN6Re','t@t.t',1,'2018-03-26 09:32:39','2018-03-26 09:32:39');

/*Table structure for table `movies` */

DROP TABLE IF EXISTS `movies`;

CREATE TABLE `movies` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `description` text,
  `director` varchar(255) DEFAULT NULL,
  `length` int(11) DEFAULT NULL,
  `rating` float DEFAULT NULL,
  `year` int(11) DEFAULT NULL,
  `genre` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=91 DEFAULT CHARSET=latin1;

/*Data for the table `movies` */

insert  into `movies`(`id`,`title`,`description`,`director`,`length`,`rating`,`year`,`genre`) values 
(1,'The Godfather','The aging patriarch of an organized crime dynasty transfers control of his clandestine empire to his reluctant son.','Francis Ford Coppola',175,9.2,1972,'Crime, Drama'),
(2,'The Lord of the Rings: The Return of the King','Gandalf and Aragorn lead the World of Men against Sauron\'s army to draw his gaze from Frodo and Sam as they approach Mount Doom with the One Ring.','Peter Jackson',201,8.9,2003,'Adventure, Drama, Fantasy'),
(3,'Titanic','A seventeen-year-old aristocrat falls in love with a kind but poor artist aboard the luxurious, ill-fated R.M.S. Titanic.','James Cameron',194,7.8,1997,'Drama, Romance'),
(4,'Moonlight','A chronicle of the childhood, adolescence and burgeoning adulthood of a young, African-American, gay man growing up in a rough neighborhood of Miami.','Barry Jenkins',111,7.5,2016,'Drama'),
(5,'The Godfather: Part II','The early life and career of Vito Corleone in 1920s New York City is portrayed, while his son, Michael, expands and tightens his grip on the family crime syndicate.','Francis Ford Coppola',202,9,1974,'Crime, Drama'),
(6,'Schindler\'s List','In German-occupied Poland during World War II, Oskar Schindler gradually becomes concerned for his Jewish workforce after witnessing their persecution by the Nazi Germans.','Steven Spielberg',195,8.9,1993,'Biography, Drama, History'),
(7,'The Departed','An undercover cop and a mole in the police attempt to identify each other while infiltrating an Irish gang in South Boston.','Martin Scorsese',151,8.5,2006,'Crime, Drama, Thriller'),
(8,'Forrest Gump','The presidencies of Kennedy and Johnson, Vietnam, Watergate, and other history unfold through the perspective of an Alabama man with an IQ of 75.','Robert Zemeckis',142,8.8,1994,'Drama, Romance'),
(9,'Spotlight','The true story of how the Boston Globe uncovered the massive scandal of child molestation and cover-up within the local Catholic Archdiocese, shaking the entire Catholic Church to its core.','Tom McCarthy',128,8.1,2015,'Crime, Drama, History'),
(10,'The Silence of the Lambs','A young F.B.I. cadet must receive the help of an incarcerated and manipulative cannibal killer to help catch another serial killer, a madman who skins his victims.','Jonathan Demme',118,8.6,1991,'Crime, Drama, Thriller'),
(11,'American Beauty','A sexually frustrated suburban father has a mid-life crisis after becoming infatuated with his daughter\'s best friend.','Sam Mendes',122,8.4,1999,'Drama'),
(12,'Gladiator','When a Roman General is betrayed, and his family murdered by an emperor\'s corrupt son, he comes to Rome as a gladiator to seek revenge.','Ridley Scott',155,8.5,2000,'Action, Adventure, Drama'),
(13,'No Country for Old Men','Violence and mayhem ensue after a hunter stumbles upon a drug deal gone wrong and more than two million dollars in cash near the Rio Grande.','Ethan Coen, Joel Coen',122,8.1,2007,'Crime, Drama, Thriller'),
(14,'Braveheart','When his secret bride is executed for assaulting an English soldier who tried to rape her, Sir William Wallace begins a revolt against King Edward I of England.','Mel Gibson',178,8.4,1995,'Biography, Drama, History'),
(15,'One Flew Over the Cuckoo\'s Nest','A criminal pleads insanity after getting into trouble again and once in the mental institution rebels against the oppressive nurse and rallies up the scared patients.','Milos Forman',133,8.7,1975,'Drama'),
(16,'Birdman or (The Unexpected Virtue of Ignorance)','A washed-up actor, who once played an iconic superhero, attempts to revive his career by writing and starring in his very own Broadway play.','Alejandro G. Iñárritu',119,7.8,2014,'Comedy, Drama'),
(17,'The Deer Hunter','An in-depth examination of the ways in which the U.S. Vietnam War impacts and disrupts the lives of people in a small industrial town in Pennsylvania.','Michael Cimino',183,8.2,1978,'Drama, War'),
(18,'The Sound of Music','A woman leaves an Austrian convent to become a governess to the children of a Naval officer widower.','Robert Wise',174,8,1965,'Biography, Drama, Family'),
(19,'A Beautiful Mind','After John Nash, a brilliant but asocial mathematician, accepts secret work in cryptography, his life takes a turn for the nightmarish.','Ron Howard',135,8.2,2001,'Biography, Drama'),
(20,'12 Years a Slave','In the antebellum United States, Solomon Northup, a free black man from upstate New York, is abducted and sold into slavery.','Steve McQueen',134,8.1,2013,'Biography, Drama, History'),
(21,'Rocky','Rocky Balboa, a small-time boxer, gets a supremely rare chance to fight heavy-weight champion Apollo Creed in a bout in which he strives to go the distance for his self-respect.','John G. Avildsen',120,8.1,1976,'Drama, Sport'),
(22,'Unforgiven','Retired Old West gunslinger William Munny reluctantly takes on one last job, with the help of his old partner and a young man.','Clint Eastwood',130,8.2,1992,'Drama, Western'),
(23,'Million Dollar Baby','A determined woman works with a hardened boxing trainer to become a professional.','Clint Eastwood',132,8.1,2004,'Drama, Sport'),
(24,'Lawrence of Arabia','The story of T.E. Lawrence, the English officer who successfully united and led the diverse, often warring, Arab tribes during World War I in order to fight the Turks.','David Lean',216,8.3,1962,'Adventure, Biography, Drama'),
(25,'The King\'s Speech','The story of King George VI of the United Kingdom of Great Britain and Northern Ireland, his impromptu ascension to the throne and the speech therapist who helped the unsure monarch become worthy of it.','Tom Hooper',118,8,2010,'Biography, Drama'),
(26,'West Side Story','Two youngsters from rival New York City gangs fall in love, but tensions between their respective friends build toward tragedy.','Jerome Robbins, Robert Wise',153,7.6,1961,'Crime, Drama, Musical'),
(27,'Platoon','A young soldier in Vietnam faces a moral crisis when confronted with the horrors of war and the duality of man.','Oliver Stone',120,8.1,1986,'Drama, War'),
(28,'Casablanca','In Casablanca in December 1941, a cynical American expatriate encounters a former lover, with unforeseen complications.','Michael Curtiz',102,8.5,1942,'Drama, Romance, War'),
(29,'Crash','Los Angeles citizens with vastly separate lives collide in interweaving stories of race, loss and redemption.','Paul Haggis',112,7.8,2004,'Crime, Drama, Thriller'),
(30,'Argo','Acting under the cover of a Hollywood producer scouting a location for a science fiction film, a CIA agent launches a dangerous operation to rescue six Americans in Tehran during the U.S. hostage crisis in Iran in 1979.','Ben Affleck',120,7.7,2012,'Biography, Drama, Thriller'),
(31,'Amadeus','The incredible story of Wolfgang Amadeus Mozart, told by his peer and secret rival Antonio Salieri - now confined to an insane asylum.','Milos Forman',160,8.3,1984,'Biography, Drama, History'),
(32,'The Hurt Locker','During the Iraq War, a Sergeant recently assigned to an army bomb squad is put at odds with his squad mates due to his maverick way of handling his work.','Kathryn Bigelow',131,7.6,2008,'Drama, History, Thriller'),
(33,'Gone with the Wind','A manipulative woman and a roguish man conduct a turbulent romance during the American Civil War and Reconstruction periods.','Victor Fleming, George Cukor, Sam Wood',238,8.2,1939,'Drama, History, Romance'),
(34,'Chicago','Murderesses Velma Kelly and Roxie Hart find themselves on death row together and fight for the fame that will keep them from the gallows in 1920s Chicago.','Rob Marshall',113,7.2,2002,'Comedy, Crime, Musical'),
(35,'Slumdog Millionaire','A Mumbai teen reflects on his upbringing in the slums when he is accused of cheating on the Indian Version of \"Who Wants to be a Millionaire?\"','Danny Boyle, Loveleen Tandan',120,8,2008,'Drama, Romance'),
(36,'Dances with Wolves','Lieutenant John Dunbar, assigned to a remote western Civil War outpost, befriends wolves and Indians, making him an intolerable aberration in the military.','Kevin Costner',181,8,1990,'Adventure, Drama, Western'),
(37,'Rain Man','Selfish yuppie Charlie Babbitt\'s father left a fortune to his savant brother Raymond and a pittance to Charlie; they travel cross-country.','Barry Levinson',133,8,1988,'Drama'),
(38,'The Sting','Two grifters team up to pull off the ultimate con.','George Roy Hill',129,8.3,1973,'Comedy, Crime, Drama'),
(39,'The English Patient','At the close of WWII, a young nurse tends to a badly-burned plane crash victim. His past is shown in flashbacks, revealing an involvement in a fateful love affair.','Anthony Minghella',162,7.4,1996,'Drama, Romance, War'),
(40,'Shakespeare in Love','A young Shakespeare, out of ideas and short of cash, meets his ideal woman and is inspired to write one of his most famous plays.','John Madden',123,7.2,1998,'Comedy, Drama, History'),
(41,'Annie Hall','Neurotic New York comedian Alvy Singer falls in love with the ditzy Annie Hall.','Woody Allen',93,8.1,1977,'Comedy, Romance'),
(42,'Oliver!','Young Oliver Twist runs away from an orphanage and meets a group of boys trained to be pickpockets by an elderly mentor.','Carol Reed',153,7.5,1968,'Drama, Family, Musical'),
(43,'Out of Africa','In 20th-century colonial Kenya, a Danish baroness/plantation owner has a passionate love affair with a free-spirited big-game hunter.','Sydney Pollack',161,7.2,1985,'Biography, Drama, Romance'),
(44,'The Artist','A silent movie star meets a young dancer, but the arrival of talking pictures sends their careers in opposite directions.','Michel Hazanavicius',100,7.9,2011,'Comedy, Drama, Romance'),
(45,'Ben-Hur','When a Jewish prince is betrayed and sent into slavery by a Roman friend, he regains his freedom and comes back for revenge.','William Wyler',212,8.1,1959,'Adventure, Drama, History'),
(46,'Gandhi','Gandhi\'s character is fully explained as a man of nonviolence. Through his patience, he is able to drive the British out of the subcontinent. And the stubborn nature of Jinnah and his commitment towards Pakistan is portrayed.','Richard Attenborough',191,8.1,1982,'Biography, Drama, History'),
(47,'My Fair Lady','A snobbish phonetics professor agrees to a wager that he can take a flower girl and make her presentable in high society.','George Cukor',170,7.9,1964,'Drama, Family, Musical'),
(48,'All About Eve','An ingenue insinuates herself into the company of an established but aging stage actress and her circle of theater friends.','Joseph L. Mankiewicz',138,8.3,1950,'Drama'),
(49,'Patton','The World War II phase of the career of the controversial American general, George S. Patton.','Franklin J. Schaffner',172,8,1970,'Biography, Drama, War'),
(50,'Midnight Cowboy','A naive hustler travels from Texas to New York to seek personal fortune but, in the process, finds himself a new friend.','John Schlesinger',113,7.9,1969,'Drama'),
(51,'The French Connection','A pair of NYC cops in the Narcotics Bureau stumble onto a drug smuggling job with a French connection.','William Friedkin',104,7.8,1971,'Action, Crime, Drama'),
(52,'Kramer vs. Kramer','Ted Kramer\'s wife leaves her husband, allowing for a lost bond to be rediscovered between Ted and his son, Billy. But a heated custody battle ensues over the divorced couple\'s son, deepening the wounds left by the separation.','Robert Benton',105,7.8,1979,'Drama'),
(53,'Driving Miss Daisy','An old Jewish woman and her African-American chauffeur in the American South have a relationship that grows and improves over the years.','Bruce Beresford',99,7.4,1989,'Drama'),
(54,'On the Waterfront','An ex-prize fighter turned longshoreman struggles to stand up to his corrupt union bosses.','Elia Kazan',108,8.2,1954,'Crime, Drama, Thriller'),
(55,'Terms of Endearment','Follows hard-to-please Aurora looking for love, and her daughter\'s family problems.','James L. Brooks',132,7.4,1983,'Comedy, Drama'),
(56,'The Bridge on the River Kwai','After settling his differences with a Japanese PoW camp commander, a British colonel co-operates to oversee his men\'s construction of a railway bridge for their captors - while oblivious to a plan by the Allies to destroy it.','David Lean',161,8.2,1957,'Adventure, Drama, War'),
(57,'Rebecca','A self-conscious bride is tormented by the memory of her husband\'s dead first wife.','Alfred Hitchcock',130,8.2,1940,'Drama, Mystery, Romance'),
(58,'The Apartment','A man tries to rise in his company by letting its executives use his apartment for trysts, but complications and a romance of his own ensue.','Billy Wilder',125,8.3,1960,'Comedy, Drama, Romance'),
(59,'In the Heat of the Night','An African American police detective is asked to investigate a murder in a racially hostile southern town.','Norman Jewison',109,8,1967,'Crime, Drama, Mystery'),
(60,'The Last Emperor','The story of the final Emperor of China.','Bernardo Bertolucci',163,7.8,1987,'Biography, Drama, History'),
(61,'Ordinary People','The accidental death of the older son of an affluent family deeply strains the relationships among the bitter mother, the good-natured father, and the guilt-ridden younger son.','Robert Redford',124,7.8,1980,'Drama'),
(62,'All the King\'s Men','The rise and fall of a corrupt politician, who makes his friends richer and retains power by dint of a populist appeal.','Robert Rossen',110,7.6,1949,'Drama, Film-Noir'),
(63,'Chariots of Fire','Two British track athletes, one a determined Jew, and the other a devout Christian, compete in the 1924 Olympics.','Hugh Hudson',125,7.2,1981,'Biography, Drama, Sport'),
(64,'All Quiet on the Western Front','A young soldier faces profound disillusionment in the soul-destroying horror of World War I.','Lewis Milestone',136,8.1,1930,'Drama, War'),
(65,'From Here to Eternity','In Hawaii in 1941, a private is cruelly punished for not boxing on his unit\'s team, while his captain\'s wife and second-in-command are falling in love.','Fred Zinnemann',118,7.7,1953,'Drama, Romance, War'),
(66,'It Happened One Night','A spoiled heiress running away from her family is helped by a man who is actually a reporter in need of a story.','Frank Capra',105,8.1,1934,'Comedy, Romance'),
(67,'The Greatest Show on Earth','The dramatic lives of trapeze artists, a clown, and an elephant trainer are told against a background of circus spectacle.','Cecil B. DeMille',152,6.7,1952,'Drama, Family, Romance'),
(68,'The Best Years of Our Lives','Three World War II veterans return home to small-town America to discover that they and their families have been irreparably changed.','William Wyler',170,8.1,1946,'Drama, Romance, War'),
(69,'Sunrise','An allegorical tale about a man fighting the good and evil within him. Both sides are made flesh - one a sophisticated woman he is attracted to and the other his wife.','F.W. Murnau',94,8.2,1927,'Drama, Romance'),
(70,'Gigi','Weary of the conventions of Parisian society, a rich playboy and a youthful courtesan-in-training enjoy a platonic friendship, but it may not stay platonic for long.','Vincente Minnelli',115,6.8,1958,'Comedy, Musical, Romance'),
(71,'Around the World in Eighty Days','A Victorian Englishman bets that with the new steamships and railways he can circumnavigate the globe in eighty days.','Michael Anderson, John Farrow',175,6.8,1956,'Adventure, Comedy, Family'),
(72,'A Man for All Seasons','The story of Thomas More, who stood up to King Henry VIII when the King rejected the Roman Catholic Church to obtain a divorce and remarriage.','Fred Zinnemann',120,7.9,1966,'Biography, Drama, History'),
(73,'An American in Paris','Three friends struggle to find work in Paris. Things become more complicated when two of them fall in love with the same woman.','Vincente Minnelli',114,7.2,1951,'Drama, Musical, Romance'),
(74,'Marty','A middle-aged butcher and a school teacher who have given up on the idea of love meet at a dance and fall for each other.','Delbert Mann',90,7.7,1955,'Drama, Romance'),
(75,'Wings','Two young men, one rich, one middle class, who are in love with the same woman, become fighter pilots in World War I.','William A. Wellman, Harry d\'Abbadie d\'Arrast',144,7.7,1927,'Drama, Romance, War'),
(76,'How Green Was My Valley','At the turn of the century in a Welsh mining village, the Morgans, he stern, she gentle, raise coal-mining sons and hope their youngest will find a better life.','John Ford',118,7.8,1941,'Drama, Family'),
(77,'Grand Hotel','A group of very different individuals staying at a luxurious hotel in Berlin deal with each of their respective dramas.','Edmund Goulding',112,7.6,1932,'Drama, Romance'),
(78,'Tom Jones','The romantic and chivalrous adventures of adopted bastard Tom Jones in 18th century England.','Tony Richardson',128,6.7,1963,'Adventure, Comedy, History'),
(79,'Mrs. Miniver','A British family struggles to survive the first months of World War II.','William Wyler',134,7.6,1942,'Drama, Romance, War'),
(80,'You Can\'t Take It with You','A man from a family of rich snobs becomes engaged to a woman from a good-natured but decidedly eccentric family.','Frank Capra',126,8,1938,'Comedy, Drama, Romance'),
(81,'The Lost Weekend','The desperate life of a chronic alcoholic is followed through a four-day drinking bout.','Billy Wilder',101,8,1945,'Drama, Film-Noir'),
(82,'Hamlet','Prince Hamlet struggles over whether or not he should kill his uncle, whom he suspects has murdered his father, the former king.','Laurence Olivier',154,7.8,1948,'Drama'),
(83,'Mutiny on the Bounty','A tyrannical ship captain decides to exact revenge on his abused crew after they form a mutiny against him, but the sailor he targets had no hand in it.','Frank Lloyd',132,7.8,1935,'Adventure, Biography, Drama'),
(84,'Gentleman\'s Agreement','A reporter pretends to be Jewish in order to cover a story on anti-Semitism, and personally discovers the true depths of bigotry and hatred.','Elia Kazan',118,7.4,1947,'Drama, Romance'),
(85,'Going My Way','Father Charles O\'Mailey, a young priest at a financially failing Church in a tough neighborhood, gains support and inspires his superior.','Leo McCarey',126,7.2,1944,'Comedy, Drama, Music'),
(86,'The Great Ziegfeld','The ups and downs of Florenz Ziegfeld Jr., famed producer of extravagant stage revues, are portrayed.','Robert Z. Leonard',176,6.8,1936,'Biography, Drama, Musical'),
(87,'Cimarron','A newspaper editor settles in an Oklahoma boom town with his reluctant wife at the end of the nineteenth century.','Wesley Ruggles',123,6,1931,'Drama, Western'),
(88,'The Broadway Melody','A pair of sisters from the vaudeville circuit try to make it big time on Broadway, but matters of the heart complicate the attempt.','Harry Beaumont',100,6.2,1929,'Drama, Musical, Romance'),
(89,'The Life of Emile Zola','The biopic of the famous French muckraking writer and his involvement in fighting the injustice of the Dreyfuss Affair.','William Dieterle',116,7.3,1937,'Biography, Drama'),
(90,'Cavalcade','The triumps and tragedies of two English families, the upper-crust Marryots and the working-class Bridges, from 1899 to 1933 are portrayed.','Frank Lloyd',112,6,6,'Drama, Romance, War');

/*Table structure for table `salons` */

DROP TABLE IF EXISTS `salons`;

CREATE TABLE `salons` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `capacity` varchar(10) DEFAULT NULL,
  `vip` tinyint(1) DEFAULT '0',
  `handicap` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `salons` */

/*Table structure for table `shows` */

DROP TABLE IF EXISTS `shows`;

CREATE TABLE `shows` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `movie` int(11) DEFAULT NULL,
  `salon` int(11) DEFAULT NULL,
  `air_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=latin1;

/*Data for the table `shows` */

insert  into `shows`(`id`,`movie`,`salon`,`air_date`) values 
(1,1,1,'2018-03-11 18:19:07'),
(2,2,1,'2018-03-11 13:37:00'),
(3,1,2,'2018-03-12 16:20:00'),
(4,20,2,'2018-03-20 16:20:00'),
(7,20,1,'2018-03-13 15:06:00'),
(8,91,3,'2018-03-12 21:00:00'),
(9,11,2,'2018-03-20 22:20:00'),
(10,16,4,'2018-03-14 13:37:00'),
(13,93,2,'2018-03-13 16:00:00'),
(14,94,1,'2018-03-13 18:00:00'),
(15,62,3,'2018-03-15 23:59:00');

/*Table structure for table `test` */

DROP TABLE IF EXISTS `test`;

CREATE TABLE `test` (
  `uno` int(11) DEFAULT NULL,
  `dos` varchar(255) DEFAULT NULL,
  `tres` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `test` */

insert  into `test`(`uno`,`dos`,`tres`) values 
(1,'lol','haha'),
(2,'shiet','bruh');

/*Table structure for table `tickets` */

DROP TABLE IF EXISTS `tickets`;

CREATE TABLE `tickets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `owner` varchar(64) DEFAULT NULL,
  `show` int(11) DEFAULT NULL,
  `seat` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `tickets` */

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
