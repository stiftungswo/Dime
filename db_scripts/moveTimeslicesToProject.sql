/* This script can be used to move timeslices in a certain time range from one project to another */

/* Define Project id's, start and end date */
SET @currentProjectId=1, @newProjectId=2, @startDate:='2017-01-01', @endDate:='2017-10-01';

/* TODO JOIN activities */
UPDATE timeslices 
SET activity = @newActivity 
WHERE activity = @currentActivity
AND started_at >= @startDate AND stopped_at < @endDate;
