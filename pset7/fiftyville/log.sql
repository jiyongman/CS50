-- Keep a log of any SQL queries you execute as you solve the mystery.

-- +-----+------+-------+-----+-----------------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
-- | id  | year | month | day |     street      |                                                                                                       description                                                                                                        |
-- +-----+------+-------+-----+-----------------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
-- | 295 | 2021 | 7     | 28  | Humphrey Street | Theft of the CS50 duck took place at 10:15am at the Humphrey Street bakery. Interviews were conducted today with three witnesses who were present at the time – each of their interview transcripts mentions the bakery. |                                                                                                                                                                      |
-- +-----+------+-------+-----+-----------------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
SELECT *
  FROM crime_scene_reports
 WHERE year = 2021
   AND month = 7
   AND day = 28
   AND street = 'Humphrey Street';

-- +-----+---------+------+-------+-----+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
-- | id  |  name   | year | month | day |                                                                                                                                                     transcript                                                                                                                                                      |
-- +-----+---------+------+-------+-----+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
-- | 161 | Ruth    | 2021 | 7     | 28  | Sometime within ten minutes of the theft, I saw the thief get into a car in the bakery parking lot and drive away. If you have security footage from the bakery parking lot, you might want to look for cars that left the parking lot in that time frame.                                                          |
-- | 162 | Eugene  | 2021 | 7     | 28  | I don't know the thief's name, but it was someone I recognized. Earlier this morning, before I arrived at Emma's bakery, I was walking by the ATM on Leggett Street and saw the thief there withdrawing some money.                                                                                                 |
-- | 163 | Raymond | 2021 | 7     | 28  | As the thief was leaving the bakery, they called someone who talked to them for less than a minute. In the call, I heard the thief say that they were planning to take the earliest flight out of Fiftyville tomorrow. The thief then asked the person on the other end of the phone to purchase the flight ticket. |
-- +-----+---------+------+-------+-----+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
SELECT *
  FROM interviews
 WHERE month = 7
   AND day = 28
   AND transcript
  LIKE '%bakery%';

-- +--------+---------+----------------+-----------------+---------------+
-- |   id   |  name   |  phone_number  | passport_number | license_plate |
-- +--------+---------+----------------+-----------------+---------------+
-- | 221103 | Vanessa | (725) 555-4692 | 2963008352      | 5P2BI95       |
-- | 243696 | Barry   | (301) 555-4174 | 7526138472      | 6P58WS2       |
-- | 396669 | Iman    | (829) 555-5269 | 7049073643      | L93JTIZ       |
-- | 398010 | Sofia   | (130) 555-0289 | 1695452385      | G412CB7       |
-- | 467400 | Luca    | (389) 555-5198 | 8496433585      | 4328GD8       |
-- | 514354 | Diana   | (770) 555-1861 | 3592750733      | 322W7JE       |
-- | 560886 | Kelsey  | (499) 555-9472 | 8294398571      | 0NTHK55       |
-- | 686048 | Bruce   | (367) 555-5533 | 5773159633      | 94KL13X       |
-- +--------+---------+----------------+-----------------+---------------+
SELECT *
  FROM people
 WHERE license_plate IN
       (SELECT license_plate
          FROM bakery_security_logs
         WHERE year = 2021
           AND month = 7
           AND day = 28
           AND hour = 10
           AND minute BETWEEN 15 AND 25
           AND activity = 'exit');

-- +--------+-------+----------------+-----------------+---------------+
-- |   id   | name  |  phone_number  | passport_number | license_plate |
-- +--------+-------+----------------+-----------------+---------------+
-- | 396669 | Iman  | (829) 555-5269 | 7049073643      | L93JTIZ       |
-- | 467400 | Luca  | (389) 555-5198 | 8496433585      | 4328GD8       |
-- | 514354 | Diana | (770) 555-1861 | 3592750733      | 322W7JE       |
-- | 686048 | Bruce | (367) 555-5533 | 5773159633      | 94KL13X       |
-- +--------+-------+----------------+-----------------+---------------+
SELECT *
  FROM people
 WHERE license_plate IN
       (SELECT license_plate
          FROM bakery_security_logs
         WHERE year = 2021
           AND month = 7
           AND day = 28
           AND hour = 10
           AND minute BETWEEN 15 AND 25
           AND activity = 'exit')
   AND id IN
       (SELECT person_id
          FROM bank_accounts
         WHERE account_number IN
               (SELECT account_number
                  FROM atm_transactions
                 WHERE year = 2021
                   AND month = 7
                   AND day = 28
                   AND atm_location = 'Leggett Street'
                   AND transaction_type = 'withdraw'));

-- +--------+-------+----------------+-----------------+---------------+
-- |   id   | name  |  phone_number  | passport_number | license_plate |
-- +--------+-------+----------------+-----------------+---------------+
-- | 514354 | Diana | (770) 555-1861 | 3592750733      | 322W7JE       |
-- | 686048 | Bruce | (367) 555-5533 | 5773159633      | 94KL13X       |
-- +--------+-------+----------------+-----------------+---------------+
SELECT *
  FROM people
 WHERE license_plate IN
       (SELECT license_plate
          FROM bakery_security_logs
         WHERE year = 2021
           AND month = 7
           AND day = 28
           AND hour = 10
           AND minute BETWEEN 15 AND 25
           AND activity = 'exit')
   AND id IN
       (SELECT person_id
          FROM bank_accounts
         WHERE account_number IN
               (SELECT account_number
                  FROM atm_transactions
                 WHERE year = 2021
                   AND month = 7
                   AND day = 28
                   AND atm_location = 'Leggett Street'
                   AND transaction_type = 'withdraw'))
   AND phone_number IN
       (SELECT caller
          FROM phone_calls
         WHERE year = 2021
           AND month = 7
           AND day = 28
           AND duration <= 60);

-- +----+-------------------+------------------------+------+-------+-----+------+--------+
-- | id | origin_airport_id | destination_airport_id | year | month | day | hour | minute |
-- +----+-------------------+------------------------+------+-------+-----+------+--------+
-- | 36 | 8                 | 4                      | 2021 | 7     | 29  | 8    | 20     |
-- +----+-------------------+------------------------+------+-------+-----+------+--------+
SELECT *
  FROM flights
 WHERE day = 29
 ORDER BY hour
 LIMIT 1;

-- +--------+-------+----------------+-----------------+---------------+
-- |   id   | name  |  phone_number  | passport_number | license_plate |
-- +--------+-------+----------------+-----------------+---------------+
-- | 686048 | Bruce | (367) 555-5533 | 5773159633      | 94KL13X       |
-- +--------+-------+----------------+-----------------+---------------+
SELECT *
  FROM people
 WHERE license_plate IN
       (SELECT license_plate
          FROM bakery_security_logs
         WHERE year = 2021
           AND month = 7
           AND day = 28
           AND hour = 10
           AND minute BETWEEN 15 AND 25
           AND activity = 'exit')
   AND id IN
       (SELECT person_id
          FROM bank_accounts
         WHERE account_number IN
               (SELECT account_number
                  FROM atm_transactions
                 WHERE year = 2021
                   AND month = 7
                   AND day = 28
                   AND atm_location = 'Leggett Street'
                   AND transaction_type = 'withdraw'))
   AND phone_number IN
       (SELECT caller
          FROM phone_calls
         WHERE year = 2021
           AND month = 7
           AND day = 28
           AND duration <= 60)
   AND passport_number IN
       (SELECT passport_number
          FROM passengers
         WHERE flight_id = 36);

-- +----+--------------+-------------------+---------------+
-- | id | abbreviation |     full_name     |     city      |
-- +----+--------------+-------------------+---------------+
-- | 4  | LGA          | LaGuardia Airport | New York City |
-- +----+--------------+-------------------+---------------+
SELECT *
  FROM airports
 WHERE id = 4;

-- +--------+-------+----------------+-----------------+---------------+
-- |   id   | name  |  phone_number  | passport_number | license_plate |
-- +--------+-------+----------------+-----------------+---------------+
-- | 864400 | Robin | (375) 555-8161 |                 | 4V16VO0       |
-- +--------+-------+----------------+-----------------+---------------+
SELECT *
  FROM people
 WHERE phone_number IN
       (SELECT receiver
          FROM phone_calls
         WHERE caller = '(367) 555-5533'
           AND year = 2021
           AND month = 7
           AND day = 28
           AND duration <= 60);
