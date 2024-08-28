CREATE TABLE Users (
users_id INT PRIMARY KEY,
banned VARCHAR(3) CHECK (banned IN ('Yes', 'No')),
role VARCHAR(7) CHECK (role IN ('client', 'driver', 'partner'))
);


INSERT INTO Users (users_id, banned, role) VALUES (1, 'No', 'client');
INSERT INTO Users (users_id, banned, role) VALUES (2, 'Yes', 'client');
INSERT INTO Users (users_id, banned, role) VALUES (3, 'No', 'client');
INSERT INTO Users (users_id, banned, role) VALUES (4, 'No', 'client');
INSERT INTO Users (users_id, banned, role) VALUES (10, 'No', 'driver');
INSERT INTO Users (users_id, banned, role) VALUES (11, 'No', 'driver');
INSERT INTO Users (users_id, banned, role) VALUES (12, 'No', 'driver');
INSERT INTO Users (users_id, banned, role) VALUES (13, 'No', 'driver');


SELECT * FROM USERS

CREATE TABLE Trips (
 id INT PRIMARY KEY,
 client_id INT,
 driver_id INT,
 city_id INT,
 status VARCHAR(20) CHECK (status IN ('completed', 'cancelled_by_driver',
'cancelled_by_client')),
 request_at VARCHAR(50),
 CONSTRAINT FK_Trips_Client FOREIGN KEY (client_id) REFERENCES Users(users_id),
 CONSTRAINT FK_Trips_Driver FOREIGN KEY (driver_id) REFERENCES Users(users_id)
);


INSERT INTO Trips (id, client_id, driver_id, city_id, status, request_at) VALUES (1, 1, 10, 1, 'completed', '2013-10-01');
INSERT INTO Trips (id, client_id, driver_id, city_id, status, request_at) VALUES (2, 2, 11, 1, 'cancelled_by_driver', '2013-10-01');
INSERT INTO Trips (id, client_id, driver_id, city_id, status, request_at) VALUES (3, 3, 12, 6, 'completed', '2013-10-01');
INSERT INTO Trips (id, client_id, driver_id, city_id, status, request_at) VALUES (4, 4, 13, 6, 'cancelled_by_client', '2013-10-01');
INSERT INTO Trips (id, client_id, driver_id, city_id, status, request_at) VALUES (5, 1, 10, 1, 'completed', '2013-10-02');
INSERT INTO Trips (id, client_id, driver_id, city_id, status, request_at) VALUES (6, 2, 11, 6, 'completed', '2013-10-02');
INSERT INTO Trips (id, client_id, driver_id, city_id, status, request_at) VALUES (7, 3, 12, 6, 'completed', '2013-10-02');
INSERT INTO Trips (id, client_id, driver_id, city_id, status, request_at) VALUES (8, 2, 12, 12, 'completed', '2013-10-03');
INSERT INTO Trips (id, client_id, driver_id, city_id, status, request_at) VALUES (9, 3, 10, 12, 'completed', '2013-10-03');
INSERT INTO Trips (id, client_id, driver_id, city_id, status, request_at) VALUES (10, 4, 13, 12, 'cancelled_by_driver', '2013-10-03');



WITH CancelledTrips AS (
  SELECT
    request_at AS dia,
    COUNT(*) as cancelled_count
    
  FROM
    Trips t
    
    
  JOIN 
    Users c ON t.client_id = c.users_id
  JOIN
    Users d ON t.driver_id = d.users.id
    
    
  WHERE 
    t.status IN ('cancelled_by_driver', 'cancelled_by_client')
    AND c.banned = 'No'
    AND d.banned = 'No'
  GROUP BY
    request_at
),








TotalTrips AS (
  SELECT 
    request_at AS dia,
    COUNT as total_count
    
    
  FROM
  
    Trips t
    
  JOIN
    Users c On t.client_id = c.users_id
  JOIN
    Users d On t.driver_id = d.users_id
    
  WHERE
    c.banned = 'No'
    
    
  GROUP BY 
    request_at
)

SELECT
   t.dia
   ROUND(COALESCE(ct.cancelled_count, 0) * 1.0 / t.total_count, 2) as [tasa de cancelacion]
FROM
  TotalTrips t
Left JOIN
  CancelledTrips ct ON t.dia = ct.dia
  
Order by
  t.dia;
)



