use ram_mandir;

CREATE TABLE Deity (DeityID INT PRIMARY KEY,
					`Name` VARCHAR(255) NOT NULL,
					`Description` TEXT);
			
INSERT INTO Deity VALUES (1, 'Rama', 'An incarnation of Vishnu, a principal deity of Hinduism born in Ayodhya.'),
                         (2, 'Ram Lalla Virajman', 'The infant form of Rama, the presiding deity of the Ram Mandir temple.');
    
CREATE TABLE Temple (TempleID INT PRIMARY KEY,
					 Name VARCHAR(255) NOT NULL,
					 Location VARCHAR(255),
					 ConstructionStartDate DATE,
					 ExpectedCompletionDate DATE);
                     
INSERT INTO Temple VALUES (1, 'Ram Mandir', 'Ayodhya, Uttar Pradesh, India', '2020-03-01', '2024-01-22');                     
                     
CREATE TABLE ConstructionPhase (PhaseID INT PRIMARY KEY,
                                TempleID INT,
                                PhaseName VARCHAR(255) NOT NULL,
                                StartDate DATE,
                                CompletionDate DATE,
                                CONSTRAINT fk_temple FOREIGN KEY (TempleID) REFERENCES Temple(TempleID)); 

INSERT INTO ConstructionPhase VALUES (1, 1, 'Phase 1', '2020-03-01', '2020-05-15'),
                                     (2, 1, 'Phase 2', '2020-06-01', '2020-08-30'),
                                     (3, 1, 'Phase 3', '2021-01-10', '2021-03-25'),
                                     (4, 1, 'Phase 4', '2021-06-15', '2022-02-28'); 
                                     
                                     
CREATE TABLE Architecture (ArchitectureID INT PRIMARY KEY,
							TempleID INT,
							ArchitectName VARCHAR(255) NOT NULL,
							Description TEXT,
							CONSTRAINT fk_temple_architecture FOREIGN KEY (TempleID) REFERENCES Temple(TempleID));
                            
INSERT INTO Architecture VALUES (1, 1, 'Chandrakant Sompura', 'Chief architect of the temple'),
                                (2, 1, 'Nikhil Sompura', 'Assistant architect'),
                                (3, 1, 'Ashish Sompura', 'Assistant architect');
                                
CREATE TABLE Donations (DonationID INT PRIMARY KEY,
						DonorName VARCHAR(255) NOT NULL,
						Amount DECIMAL(10, 2) NOT NULL,
						DonationDate DATE,
						TempleID INT,
						CONSTRAINT fk_temple_donations FOREIGN KEY (TempleID) REFERENCES Temple(TempleID));  
                        
 INSERT INTO Donations VALUES (1, 'Ram Nath Kovind', 501000.00, '2021-01-15', 1), 
                              (2, 'Anonymous Donor', 100.00, '2021-02-01', 1),
                              (3, 'Leadership Council', 1000000.00, '2021-03-10', 1),
                              (4, 'H.D. Kumaraswamy', 5000.00, '2021-05-01', 1),
                              (5, 'Siddaramaiah', 20000.00, '2021-05-15', 1),
                              (6, 'VHP Activist 1', 50.00, '2021-06-01', 1),
							  (7, 'VHP Activist 2', 75.00, '2021-06-15', 1),
                              (8, 'Muslim Community Member', 1000.00, '2021-07-01', 1),
                              (9, 'Christian Community Member', 500.00, '2021-07-15', 1),
                              (10, 'Anonymous Supporter', 200.00, '2021-08-01', 1);
                            
                            
CREATE TABLE Events(EventID INT PRIMARY KEY,
					EventName VARCHAR(255) NOT NULL,
					EventDate DATE,
					Description TEXT);  
                    
INSERT INTO Events VALUES (1, 'Commencement Ceremony', '2020-08-05', 'Ceremony celebrating the commencement of Ram Mandir construction by PM Narendra Modi'),
						  (2, 'Bhoomi Pujan Ceremony', '2020-08-05', 'Ground-breaking ceremony with Vedic rituals and foundation stone laying by PM Narendra Modi'),
						  (3, 'Vijay Mahamantra Jaap Anushthan', '2020-04-06', 'Chanting of Vijay Mahamantra for victory over hurdles in temple construction'),
						  (4, 'Pran Pratishtha Ceremony', '2024-01-22', 'Consecration ceremony scheduled for the installation of Lord Ram idol in the garbhagriha');                            

CREATE TABLE TempleEvents (	TempleID INT,
							EventID INT,
							CONSTRAINT fk_temple_events_temple FOREIGN KEY (TempleID) REFERENCES Temple(TempleID),
							CONSTRAINT fk_temple_events_event FOREIGN KEY (EventID) REFERENCES Events(EventID),
							PRIMARY KEY (TempleID, EventID));   
                            
INSERT INTO TempleEvents  VALUES (1, 1), 
                                 (1, 2), 
                                 (1, 3), 
                                 (1, 4);						
                            
-- 1)Retrieve information about the Ram Mandir?
select * from Temple;

-- 2)List all construction phases for the Ram Mandir?
select * from ConstructionPhase;

-- 3)Find the total amount of donations received for the Ram Mandir?
select sum(amount) as Total_Donation_Amount from donations;

-- 4)Get details about the architecture of the Ram Mandir?
select * from architecture;
 
-- 5)Retrieve events associated with the Ram Mandir?
select * from events;

-- 6)Find donors who contributed more than 50000 towards the Ram Mandir?
select * from donations 
where amount >50000 ;

-- 7)Retrieve details about a specific deity (e.g., Rama) ?
select * from deity 
where Name = 'rama';

-- 8)Find the start and end dates of the construction phases for the Ram Mandir?
select PhaseName,StartDate,CompletionDate from constructionphase;

-- 9)Count the number of events associated with each temple?
select count(Eventname) from events e inner join templeevents t on e.EventID = t.TempleId ;

-- 10)Find the donors who made contributions on or after 2021-06-01'?                            
select * from donations
where DonationDate >= '2021-06-01' ;                            
                            
                            
                            
                            