-----CHECKING IF DATA IS LOADED CORRECLTY

select * from `workspace`.`default`.`viewership_2` limit 1000;
----------------------------------------------------------------
---JOINING TABLE 1 AS USERPROFILE AND TABLE 2 AS VIERSHIP
select *
FROM `workspace`.`default`.`viewership_2` AS VIEWERSHIP
FULL OUTER JOIN `workspace`.`default`.`userprofile_bright_tv_dataset_1`AS USERPROFILE
ON VIEWERSHIP.UserID0 = USERPROFILE.UserID;
------------------------------------------------------------------------------------

---CHECKING IF WE HAVE NULL VALUES IN THE DATABASE
SELECT *
FROM `workspace`.`default`.`viewership_2` AS VIEWERSHIP
FULL OUTER JOIN `workspace`.`default`.`userprofile_bright_tv_dataset_1`AS USERPROFILE
ON VIEWERSHIP.UserID0 = USERPROFILE.UserID
WHERE RACE IS NULL;

SELECT 
        IFNULL(UserID0, 0) AS USER_ID,
        IFNULL(Channel2, 'NO_CHANNEL') AS CHANNEL,
        IFNULL(CAST(Record AS STRING), 'NO_RECORD') AS RECORD,
        IFNULL(GENDER, 'NO_GENDER') AS GENDER,
        IFNULL(RACE, 'NO_RACE') AS RACE,
        IFNULL(Age, 0) AS AGE,
        IFNULL(PROVINCE, 'NO_PROVINCE') AS PROVINCE
 FROM  `workspace`.`default`.`viewership_2` AS VIEWERSHIP
 FULL OUTER JOIN `workspace`.`default`.`userprofile_bright_tv_dataset_1`AS USERPROFILE
ON VIEWERSHIP.UserID0 = USERPROFILE.UserID;

SELECT 
        IFNULL (RACE, 'NO RACE') AS RACE
 from `workspace`.`default`.`userprofile_bright_tv_dataset_1` limit 1000;

 ----------------------------------------------------------------------------
  ---COUNTING VIEWERS BY EACH PROVINCE    
SELECT 
      COUNT(VIEWERSHIP.UserID0) AS USER_COUNT_PROVINCE,
      USERPROFILE.PROVINCE
FROM  `workspace`.`default`.`viewership_2` AS VIEWERSHIP
 FULL OUTER JOIN `workspace`.`default`.`userprofile_bright_tv_dataset_1`AS USERPROFILE
ON VIEWERSHIP.UserID0 = USERPROFILE.UserID
GROUP BY USERPROFILE.PROVINCE
ORDER BY USER_COUNT_PROVINCE DESC;
--------------------------------------------------------------------------------------

---COUNTING VIEWERS BY GENDER IN THE DATASET
SELECT GENDER,
      COUNT(UserID) AS MALE_FEMALE_SPLIT
 FROM  `workspace`.`default`.`viewership_2` AS VIEWERSHIP
 FULL OUTER JOIN `workspace`.`default`.`userprofile_bright_tv_dataset_1`AS USERPROFILE
ON VIEWERSHIP.UserID0 = USERPROFILE.UserID  
GROUP BY GENDER
ORDER BY MALE_FEMALE_SPLIT DESC;

---COUNTING VIEWERS BY EACH CHANNEL
SELECT Channel2,
      COUNT(USERPROFILE.UserID) AS CHANNEL2_VIEWERSHIP
FROM  `workspace`.`default`.`viewership_2` AS VIEWERSHIP
 FULL OUTER JOIN `workspace`.`default`.`userprofile_bright_tv_dataset_1`AS USERPROFILE
ON VIEWERSHIP.UserID0 = USERPROFILE.UserID
GROUP BY Channel2
ORDER BY CHANNEL2_VIEWERSHIP DESC;
-------------------------------------------------------------------------------------

---COUNTING VIEWERS BY RACE
SELECT race,
      COUNT(USERPROFILE.UserID) AS race_VIEWERSHIP
FROM  `workspace`.`default`.`viewership_2` AS VIEWERSHIP
 FULL OUTER JOIN `workspace`.`default`.`userprofile_bright_tv_dataset_1`AS USERPROFILE
ON VIEWERSHIP.UserID0 = USERPROFILE.UserID
GROUP BY race
ORDER BY race_VIEWERSHIP DESC;

----COUNTING THE TOTAL NUMBER OF VIEWERS
SELECT  UserID0,
COUNT (*) AS VIEWS
FROM  `workspace`.`default`.`viewership_2` AS VIEWERSHIP
 FULL OUTER JOIN `workspace`.`default`.`userprofile_bright_tv_dataset_1`AS USERPROFILE
ON VIEWERSHIP.UserID0 = USERPROFILE.UserID
GROUP BY UserID0
ORDER BY VIEWS DESC;

---HOURS SPENT ON EACH CHANNEL
SELECT HOUR(RECORD) AS HOUR,
COUNT (*) AS VIEWS
FROM  `workspace`.`default`.`viewership_2` AS VIEWERSHIP
 FULL OUTER JOIN `workspace`.`default`.`userprofile_bright_tv_dataset_1`AS USERPROFILE
ON VIEWERSHIP.UserID0 = USERPROFILE.UserID
GROUP BY HOUR(RECORD)
ORDER BY VIEWS DESC;

----TOTAL HOURS OF VIEWERSHIP
SELECT HOUR(RECORD) AS HOUR ,
       COUNT(*) AS TOTAL_VIEWS
FROM  `workspace`.`default`.`viewership_2` AS VIEWERSHIP
 FULL OUTER JOIN `workspace`.`default`.`userprofile_bright_tv_dataset_1`AS USERPROFILE
ON VIEWERSHIP.UserID0 = USERPROFILE.UserID
GROUP BY HOUR;

SELECT  
      CASE 
          WHEN AGE <13 THEN 'CHILD'
          WHEN AGE>= 13 AND AGE <18 THEN 'TEEN'
          WHEN AGE>= 18 AND AGE <35 THEN 'YOUNG ADULT'
          WHEN AGE>= 35 AND AGE <63 THEN 'ADULT'
          ELSE 'SENIOR'
     END AS AGE_GROUP,
     HOUR(RECORD) AS HOUR,
     COUNT(*) AS VIEWS
FROM  `workspace`.`default`.`viewership_2` AS VIEWERSHIP
 FULL OUTER JOIN `workspace`.`default`.`userprofile_bright_tv_dataset_1`AS USERPROFILE
ON VIEWERSHIP.UserID0 = USERPROFILE.UserID
GROUP BY AGE_GROUP,HOUR(RECORD)     
ORDER BY AGE_GROUP,HOUR;

SELECT  
      CASE 
          WHEN AGE <13 THEN 'CHILD'
          WHEN AGE>= 13 AND AGE <18 THEN 'TEEN'
          WHEN AGE>= 18 AND AGE <35 THEN 'YOUNG ADULT'
          WHEN AGE>= 35 AND AGE <63 THEN 'ADULT'
          ELSE 'SENIOR'
     END AS AGE_GROUP,
     COUNT(*) AS TOTAL_VIEWS
FROM  `workspace`.`default`.`viewership_2` AS VIEWERSHIP
 FULL OUTER JOIN `workspace`.`default`.`userprofile_bright_tv_dataset_1`AS USERPROFILE
ON VIEWERSHIP.UserID0 = USERPROFILE.UserID
GROUP BY AGE_GROUP;

SELECT  
      CASE 
          WHEN AGE <13 THEN 'CHILD'
          WHEN AGE>= 13 AND AGE <18 THEN 'TEEN'
          WHEN AGE>= 18 AND AGE <35 THEN 'YOUNG ADULT'
          WHEN AGE>= 35 AND AGE <63 THEN 'ADULT'
          ELSE 'SENIOR'
     END AS AGE_GROUP,
     HOUR(RECORD) AS HOUR,
     COUNT(*) AS VIEWS
FROM  `workspace`.`default`.`viewership_2` AS VIEWERSHIP
 FULL OUTER JOIN `workspace`.`default`.`userprofile_bright_tv_dataset_1`AS USERPROFILE
ON VIEWERSHIP.UserID0 = USERPROFILE.UserID
GROUP BY AGE_GROUP,HOUR(RECORD)     
ORDER BY AGE_GROUP,HOUR;
