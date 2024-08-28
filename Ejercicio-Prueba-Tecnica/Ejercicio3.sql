CREATE TYPE LogTable AS TABLE
(
    Id INT NOT NULL,
    Num VARCHAR(50) NOT NULL
);
GO

CREATE PROCEDURE FindConsecutiveNumbers
    @LogData LogTable READONLY
AS
BEGIN
    CREATE TABLE #ConsecutiveNums (ConsecutiveNum VARCHAR(50));

    INSERT INTO #ConsecutiveNums (ConsecutiveNum)
    SELECT DISTINCT l1.Num
    FROM @LogData l1
    JOIN @LogData l2 ON l1.Id = l2.Id - 1 AND l1.Num = l2.Num
    JOIN @LogData l3 ON l2.Id = l3.Id - 1 AND l2.Num = l3.Num;

    SELECT DISTINCT ConsecutiveNum AS ConsecutiveNums FROM #ConsecutiveNums;

    DROP TABLE #ConsecutiveNums;
END;
GO

DECLARE @Logs LogTable;

INSERT INTO @Logs (Id, Num)
VALUES 
    (1, '1'),
    (2, '1'),
    (3, '1'),
    (4, '2'),
    (5, '1'),
    (6, '2'),
    (7, '2');

EXEC FindConsecutiveNumbers @Logs;
