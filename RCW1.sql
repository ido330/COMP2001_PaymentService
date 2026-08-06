CREATE SCHEMA RCW1;
GO
CREATE TABLE RCW1.[User]
(
    UserID INT IDENTITY(1,1) PRIMARY KEY,
    Username VARCHAR(50) NOT NULL UNIQUE,
    Email VARCHAR(100) NOT NULL UNIQUE,
    Password VARCHAR(100) NOT NULL
);
GO

CREATE TABLE RCW1.SubscriptionPlan
(
    PlanID INT IDENTITY(1,1) PRIMARY KEY,
    PlanName VARCHAR(50) NOT NULL UNIQUE,
    PlanPrice DECIMAL(10,2) NOT NULL,
    BillingCycle VARCHAR(20) NOT NULL
);
GO

CREATE TABLE RCW1.Subscription
(
    SubscriptionID INT IDENTITY(1,1) PRIMARY KEY,

    UserID INT NOT NULL,
    PlanID INT NOT NULL,

    StartDate DATE NOT NULL,
    EndDate DATE NOT NULL,

    CONSTRAINT FK_Subscription_User
    FOREIGN KEY(UserID)
    REFERENCES RCW1.[User](UserID),

    CONSTRAINT FK_Subscription_Plan
    FOREIGN KEY(PlanID)
    REFERENCES RCW1.SubscriptionPlan(PlanID)

);
GO

CREATE TABLE RCW1.Payment
(
    PaymentID INT IDENTITY(1,1) PRIMARY KEY,

    SubscriptionID INT NOT NULL,

    PaymentDate DATE NOT NULL,

    PaymentMethod VARCHAR(30) NOT NULL,

    TransactionReference VARCHAR(100)
    UNIQUE NOT NULL,

    CONSTRAINT FK_Payment_Subscription
    FOREIGN KEY(SubscriptionID)
    REFERENCES RCW1.Subscription(SubscriptionID)

);
GO

CREATE TABLE RCW1.SubscriptionLog
(
    LogID INT IDENTITY(1,1) PRIMARY KEY,

    PlanID INT NOT NULL,

    PlanName VARCHAR(50) NOT NULL,

    AddedDate DATETIME NOT NULL

);
GO


INSERT INTO RCW1.[User]
(Username, Email, Password)
VALUES
('Grace Hopper', 'grace@plymouth.ac.uk', 'ISAD123!'),
('Tim Berners-Lee', 'tim@plymouth.ac.uk', 'COMP2001!'),
('Ada Lovelace', 'ada@plymouth.ac.uk', 'insecurePassword');
GO

INSERT INTO RCW1.SubscriptionPlan
(PlanName, PlanPrice, BillingCycle)
VALUES
('Basic', 6.99, 'Monthly'),
('Premium', 15.99, 'Monthly'),
('Annual', 100.00, 'Yearly');
GO

INSERT INTO RCW1.Subscription
VALUES
(1,1,'2026-02-01','2026-03-01'),

(2,2,'2026-05-01','2026-06-01'),

(3,3,'2026-07-01','2027-07-01');

GO

INSERT INTO RCW1.Payment
(SubscriptionID, PaymentDate, PaymentMethod, TransactionReference)
VALUES
(1,'2026-02-01','Card','TXN0001'),
(2,'2026-05-01','PayPal','TXN0002'),
(3,'2026-07-01','Card','TXN0003');
GO
CREATE VIEW RCW1.SubscriptionPaymentView
AS

SELECT

S.SubscriptionID,
U.Username,
SP.PlanName,
SP.PlanPrice,
P.PaymentDate,

P.PaymentMethod,

P.TransactionReference
FROM RCW1.Subscription S
JOIN RCW1.[User] U
ON S.UserID = U.UserID
JOIN RCW1.SubscriptionPlan SP
ON S.PlanID = SP.PlanID
JOIN RCW1.Payment P
ON S.SubscriptionID = P.SubscriptionID;

GO



CREATE PROCEDURE RCW1.CreatePlan

@PlanName VARCHAR(50),
@PlanPrice DECIMAL(10,2),
@BillingCycle VARCHAR(20)

AS

BEGIN

INSERT INTO RCW1.SubscriptionPlan

VALUES
(@PlanName,@PlanPrice,@BillingCycle);

END;

GO

CREATE PROCEDURE RCW1.ReadPlans

AS

BEGIN

SELECT * 
FROM RCW1.SubscriptionPlan;

END;

GO


CREATE PROCEDURE RCW1.UpdatePlan

@PlanID INT,

@PlanPrice DECIMAL(10,2)


AS

BEGIN

UPDATE RCW1.SubscriptionPlan

SET PlanPrice=@PlanPrice

WHERE PlanID=@PlanID;


END;

GO




CREATE PROCEDURE RCW1.DeletePlan

@PlanID INT
AS
BEGIN
DELETE FROM RCW1.SubscriptionPlan
WHERE PlanID=@PlanID;
END;
GO


EXEC RCW1.DeleteSubscriptionPlan
    @PlanID = 5;
GO



CREATE TRIGGER RCW1.Subscription_Insert_Log

ON RCW1.Subscription

AFTER INSERT

AS

BEGIN


INSERT INTO RCW1.SubscriptionLog

(
PlanID,

PlanName,

AddedDate
)


SELECT

I.PlanID,

SP.PlanName,

GETDATE()


FROM INSERTED I


JOIN RCW1.SubscriptionPlan SP

ON I.PlanID = SP.PlanID;


END;

GO
